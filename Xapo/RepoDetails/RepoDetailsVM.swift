//
//  RepoDetailsVM.swift
//  Xapo
//
//  Created by Bourne K on 10/30/21.
//  Copyright © 2021 Bourne Koloh. All rights reserved.
//

import Foundation
import Combine
import SwiftUI
import XapoCore

class RepoDetailsViewModel:ObservableObject{
    
    //Error reporting
    @Published var showErrorAlert = false
    @Published var errorMessage: String = ""
    //
    @Published var isLoading = false
    
    @Published var gitRepo:GitRepoItem
    
    @Published var repoDetails:GitRepoDetailsItem?
    //Git API service
    @Environment(\.apiService) var service: GitHubWorker
    //Cache for tasks
    private var disposables = Set<AnyCancellable>()
    
    init(repo:GitRepoItem,scheduler: DispatchQueue = DispatchQueue(label: "RopesViewModel")){
        gitRepo = repo
    }
    
    
    ///Call to fetch all repositories fron github API
    /// - Warning: -
    /// - Parameter withTitle: optional `String` ther report title
    /// - Returns: alist of `GitRepoItem` objects.
    internal func fetchRepoDetails() {
        //Update on main thread
        DispatchQueue.main.async {
            self.isLoading = true
        }
        //
        service.loadRepoDetails(forRepo: gitRepo)
        //
        .receive(on: DispatchQueue.main)
        //
        .sink(
          receiveCompletion: { [weak self] apiError in
              //
              guard let self = self else { return }
              //
              switch apiError {
              case .failure(let value):
                    self.errorMessage = value.localizedDescription
                    self.showErrorAlert = true
                    self.repoDetails = nil
                case .finished:
                  break
              }
          },
          receiveValue: { [weak self] (repoInfo) in
              //
              guard let self = self else { return }
              //
              self.repoDetails = repoInfo
              //
              self.isLoading = false
        })
        //
        .store(in: &disposables)
    }
}
