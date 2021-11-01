//
//  RequestManager.swift
//  XapoCore
//
//  Created by Bourne K on 10/30/21.
//  Copyright © 2021 Bourne Koloh. All rights reserved.
//

import Foundation
import Combine

let dateFormatter = DateFormatter()

public protocol GitHubWorker {
    /// Load all repositories, an optional filter for repo title
    /// - Warning: -
    /// - Parameter serahcTitle: optional `String` ther report title
    /// - Returns: alist of `GitRepoItem` objects.
    func loadTrendingRepos(withTitle searchTitle: String?) -> AnyPublisher<(Int,[GitRepoItem]), XapoError>
    /// Load details of a git repository
    /// - Warning: -
    /// - Parameter repo: The `GitRepoItem` to be loaded.
    /// - Returns: The repository details, if the request failed, a nil is returned
    func loadRepoDetails(forRepo repo: GitRepoItem) -> AnyPublisher<GitRepoDetailsItem?, XapoError>
}

///The class f=managing all requests in this app
public class RequestManager :NSObject, GitHubWorker {
    //MARK: Local queue for managing local tasks
    internal let dispatchQueue = DispatchQueue(label: "xapocore.queue.dispatcheueuq")
    //Shared Instance
    fileprivate static var _inst:RequestManager? = nil
    //
    public static var Shared:GitHubWorker{
        get{
            if _inst == nil {
                _inst = RequestManager()
            }
            return _inst!
        }
        set{}
    }
    //
    internal lazy var requestsSession: URLSession = {
        //
        let configuration = URLSessionConfiguration.default
        configuration.tlsMinimumSupportedProtocol = .tlsProtocol13
        //
        return URLSession(configuration: configuration,delegate: self,delegateQueue: nil)
    }()
    
    private override init(){
        //
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
    }
}

///MARK:-
///Hook for handling SSL pinning
extension RequestManager: URLSessionDelegate{
    //MARK: Hook SSL Pinning Module
    public func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Swift.Void) {
        //
        completionHandler(URLSession.AuthChallengeDisposition.useCredential, URLCredential(trust: challenge.protectionSpace.serverTrust!))
    }
}


extension RequestManager {
    
    //MARK:-
    public func loadTrendingRepos(withTitle searchTitle: String?) -> AnyPublisher<(Int,[GitRepoItem]), XapoError> {
        //
        var urlComponents = GithubApiConfig.makeGithubRepoApiComponents()
        urlComponents.queryItems?.append(URLQueryItem(name: "q", value: searchTitle?.lengthOfBytes(using: .utf8) ?? 0 > 0 ? searchTitle : "all"))
        //
        guard let url = urlComponents.url else {
          let error = XapoError.network(description: "Couldn't create URL")
          return Fail(error: error).eraseToAnyPublisher()
        }
        //
         return requestsSession.dataTaskPublisher(for: URLRequest(url: url))
          .mapError { error in
            return .network(description: error.localizedDescription)
          }
          .flatMap(maxPublishers: .max(1)) { pair in
              ResponseDecoder.decode(pair.data) as AnyPublisher<GitRepoResponse, XapoError>
          }
          .map({ response in
              (response.totalRecords,response.items)
          })
          .map({ (totalRecords, list) in
              //Remove Dulpicate items
              let filtered = Array.removeDuplicates(list)
              //
              return (totalRecords,filtered)
          })
          //.map(Array.removeDuplicates)
          .eraseToAnyPublisher()
        //
    }
    
    //MARK:-
    public func loadRepoDetails(forRepo repo: GitRepoItem) -> AnyPublisher<GitRepoDetailsItem?, XapoError>{
        //
        let urlComponents = GithubApiConfig.makeGithubRepoDetailsApiComponents(repo.owner?.name ?? "",repo.name)
        //
        print("Repo URL => ")
        print(urlComponents.url?.absoluteString)
        //
        guard let url = urlComponents.url else {
          let error = XapoError.network(description: "Couldn't create URL")
          return Fail(error: error).eraseToAnyPublisher()
        }
        //
        return requestsSession.dataTaskPublisher(for: URLRequest(url: url))
          .mapError { error in
            .network(description: error.localizedDescription)
          }
          .flatMap(maxPublishers: .max(1)) { pair in
              ResponseDecoder.decode(pair.data)
          }
          .eraseToAnyPublisher()
    }
}
