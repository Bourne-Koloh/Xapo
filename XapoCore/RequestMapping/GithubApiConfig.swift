//
//  GithubApiConfig.swift
//  XapoCore
//
//  Created by Bourne K on 10/30/21.
//  Copyright © 2021 Bourne Koloh. All rights reserved.
//

import Foundation

internal struct GithubApiConfig {
  static let scheme = "https"
  static let host = "api.github.com"
  static let path = ""
  static let key = "<your key>"
    
  static func makeGithubRepoApiComponents() -> URLComponents {
      var components = URLComponents()
      components.scheme = GithubApiConfig.scheme
      components.host = GithubApiConfig.host
      components.path = GithubApiConfig.path + "/search/repositories"
      
      components.queryItems = [
        URLQueryItem(name: "sort", value: "stars"),
        URLQueryItem(name: "order", value: "desc"),
        URLQueryItem(name: "per_page", value: "100")
      ]
      
      return components
    }
    
    static func makeGithubRepoDetailsApiComponents(_ author:String,_ repoName:String) -> URLComponents {
        var components = URLComponents()
        components.scheme = GithubApiConfig.scheme
        components.host = GithubApiConfig.host
        components.path = GithubApiConfig.path + "/repos/\(author)/\(repoName)/readme"
        
        
        return components
      }
}
