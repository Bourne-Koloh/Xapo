//
//  GitRepoItem.swift
//  XapoCore
//
//  Created by Bourne K on 10/30/21.
//  Copyright © 2021 Bourne Koloh. All rights reserved.
//

import Foundation

public class GitRepoItem:NSObject,Identifiable,Codable {
    public var id = 0
    public var name = ""
    public var fullName = ""
    public var isPrivate = false
    public var archived = false
    public var owner:RepoOwner?
    public var webLink = ""
    public var desc = ""
    public var forks = 0
    public var watchers = 0
    public var openIssues = 0
    public var language = ""
    public var pushedAt:Date?
    public var createdAt:Date?
    public var stars = 0
    public var lic:RepoLisence?
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case name
        case fullName = "full_name"
        case isPrivate = "private"
        case owner
        case webLink = "html_url"
        case desc = "description"
        case forks = "forks_count"
        case watchers = "watchers"
        case openIssues = "open_issues"
        case language
        case createdAt = "created_at"
        case pushedAt = "pushed_at"
        case stars = "stargazers_count"
        case lic = "license"
        case archived = "archived"
    }
    
    public override init() {
        //
        super.init()
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let value = try? container.decodeIfPresent(Int.self, forKey: .id){
            id = value
        }
        if let value = try? container.decodeIfPresent(String.self, forKey: .name){
            name = value
        }
        if let value = try? container.decodeIfPresent(String.self, forKey: .fullName){
            fullName = value
        }
        if let value = try? container.decodeIfPresent(Bool.self, forKey: .isPrivate){
            isPrivate = value
        }
        if let value = try? container.decodeIfPresent(RepoOwner.self, forKey: .owner){
            owner = value
        }
        if let value = try? container.decodeIfPresent(String.self, forKey: .webLink){
            webLink = value
        }
        if let value = try? container.decodeIfPresent(String.self, forKey: .desc){
            desc = value
        }
        if let value = try? container.decodeIfPresent(Int.self, forKey: .forks){
            forks = value
        }
        if let value = try? container.decodeIfPresent(Int.self, forKey: .watchers){
            watchers = value
        }
        if let value = try? container.decodeIfPresent(Int.self, forKey: .openIssues){
            openIssues = value
        }
        if let value = try? container.decodeIfPresent(Int.self, forKey: .stars){
            stars = value
        }
        if let value = try? container.decodeIfPresent(String.self, forKey: .language){
            language = value
        }
        if let value = try? container.decodeIfPresent(RepoLisence.self, forKey: .lic){
            lic = value
        }
        //
        if let d = try? container.decodeIfPresent(String.self, forKey: .createdAt){
            createdAt = dateFormatter.date(from: d)
        }
        //
        if let d = try? container.decodeIfPresent(String.self, forKey: .pushedAt){
            pushedAt = dateFormatter.date(from: d)
        }
        
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try? container.encode(id, forKey: .id)
        //
    }
}

public class RepoOwner:NSObject,Identifiable,Codable {
    public var id = 0
    public var name = ""
    public var photo = ""
    public var url = ""
    public var userType = ""
    public var isAdmin = false
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "login"
        case photo = "avatar_url"
        case url
        case userType = "type"
        case isAdmin = "site_admin"
    }
    
    public override init() {
        //
        super.init()
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let value = try? container.decodeIfPresent(Int.self, forKey: .id){
            id = value
        }
        if let value = try? container.decodeIfPresent(String.self, forKey: .name){
            name = value
        }
        if let value = try? container.decodeIfPresent(String.self, forKey: .photo){
            photo = value
        }
        if let value = try? container.decodeIfPresent(String.self, forKey: .url){
            url = value
        }
        if let value = try? container.decodeIfPresent(String.self, forKey: .userType){
            userType = value
        }
        if let value = try? container.decodeIfPresent(Bool.self, forKey: .isAdmin){
            isAdmin = value
        }
        
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try? container.encode(id, forKey: .id)
        //
    }
}

public class RepoLisence:NSObject,Identifiable,Codable {
    public var id = ""
    public var name = ""
    public var link = ""
    
    private enum CodingKeys: String, CodingKey {
        case id = "key"
        case name
        case link = "url"
    }
    
    public override init() {
        //
        super.init()
    }
    
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let value = try? container.decodeIfPresent(String.self, forKey: .id){
            id = value
        }
        if let value = try? container.decodeIfPresent(String.self, forKey: .name){
            name = value
        }
        if let value = try? container.decodeIfPresent(String.self, forKey: .link){
            link = value
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try? container.encode(id, forKey: .id)
        //
    }
}
