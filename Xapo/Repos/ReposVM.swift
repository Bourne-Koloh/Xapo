//
//  ReposVM.swift
//  Xapo
//
//  Created by Bourne K on 10/30/21.
//  Copyright © 2021 Bourne Koloh. All rights reserved.
//

import Foundation
import Combine
import SwiftUI
import XapoCore

internal class ReposViewModel : ObservableObject{
    //Repo filter ,...
    @Published var searchTerm: String = ""
    //Error reporting
    @Published var showErrorAlert = false
    @Published var errorMessage: String = ""
    //
    @Published var isLoading = false
    //In-Memory repo persistance
    @Published var dataSource: [GitRepoItem] = []
    var totalRecords = 0
    //Git API service
    @Environment(\.apiService) var service: GitHubWorker
    //Cache for tasks
    private var disposables = Set<AnyCancellable>()
    
    //MARK:- Initializer
    init(scheduler: DispatchQueue = DispatchQueue(label: "RopesViewModel")) {
        //
        $searchTerm.dropFirst(1)//Ignore first event
        //
        .debounce(for: .seconds(0.5), scheduler: scheduler)//Add a d search delay
        //
//        .map({ chain in
//            return chain
//        })
        //
        .sink(receiveValue: fetchRepos(withTitle:))
        //
        .store(in: &disposables)
    }

    ///Call to fetch all repositories fron github API
    /// - Warning: -
    /// - Parameter withTitle: optional `String` ther report title
    /// - Returns: alist of `GitRepoItem` objects.
    internal func fetchRepos(withTitle query: String?) {
        //Update on main thread
        DispatchQueue.main.async {
            self.isLoading = true
        }
        //
        service.loadTrendingRepos(withTitle: query)
        //
        .receive(on: DispatchQueue.main)
        //
        .sink(
          receiveCompletion: { [weak self] apiError in
              //
              guard let self = self else { return }
              //
              self.isLoading = false
              //
              switch apiError {
              case .failure(let value):
                    self.errorMessage = value.localizedDescription
                    self.showErrorAlert = true
                    self.dataSource = []
                  self.totalRecords = 0
                case .finished:
                  break
              }
          },
          receiveValue: { [weak self] (count,list) in
              //
              guard let self = self else { return }
              //
              self.dataSource = list
              self.totalRecords = count
        })
        //
        .store(in: &disposables)
    }
}
