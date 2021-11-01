//
//  XapoCoreTests.swift
//  XapoCoreTests
//
//  Created by Bourne K on 10/30/21.
//  Copyright © 2021 Bourne Koloh. All rights reserved.
//

import XCTest
import Combine
@testable import XapoCore

class XapoCoreTests: XCTestCase {
    private var cancellables: Set<AnyCancellable>!
    private var gitWorker:GitHubWorker!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        cancellables = []
        gitWorker = RequestManager.Shared
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        for cancellable in cancellables {
            cancellable.cancel()
        }
        cancellables = nil
        gitWorker = nil
    }

    func testLoadRepos() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        var repos:[GitRepoItem] = []
        var error: Error?
        let expectation = self.expectation(description: "GitRepos")
        
        // Setting up our Combine pipeline:
        gitWorker
        .loadTrendingRepos(withTitle: "ios")
        .sink(receiveCompletion: { completion in
            switch completion {
            case .finished:
                break
            case .failure(let encounteredError):
                error = encounteredError
            }

            // Fullfilling our expectation to unblock
            // our test execution:
            expectation.fulfill()
        }, receiveValue: { (total,value) in
            repos.append(contentsOf: value)
        })
        .store(in: &cancellables)

        // Awaiting fulfilment of our expecation before
        // performing our asserts:
        waitForExpectations(timeout: 10)

        // Asserting that our Combine pipeline yielded the
        // correct output:
        XCTAssertNil(error)
        XCTAssertEqual(repos.first?.id, 31792824)

    }
    
    func testLoadRepoDetails() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        //Test Repo
        let repo = GitRepoItem()
        repo.name = "mkcert"
        repo.owner = RepoOwner()
        repo.owner?.name = "FiloSottile"
        
        //
        var repoInfo:GitRepoDetailsItem?
        
        var error: Error?
        let expectation = self.expectation(description: "GitRepoDetails")
        
        // Setting up our Combine pipeline:
        gitWorker
            .loadRepoDetails(forRepo: repo)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let faluireError):
                    error = faluireError
                }

                // Fullfilling our expectation to unblock
                // our test execution:
                expectation.fulfill()
            }, receiveValue: { (value) in
                repoInfo = value
            })
            .store(in: &cancellables)

        // Awaiting fulfilment of our expecation before
        // performing our asserts:
        waitForExpectations(timeout: 10)

        // Asserting that our Combine pipeline yielded the
        // correct output:
        XCTAssertNil(error)
        XCTAssertEqual(repoInfo?.size, 6359)

    }

    func testPerformanceLoadRepos() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
