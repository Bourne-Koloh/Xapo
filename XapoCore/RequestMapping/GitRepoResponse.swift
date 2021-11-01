//
//  GitRepoResponse.swift
//  XapoCore
//
//  Created by Bourne K on 10/30/21.
//  Copyright © 2021 Bourne Koloh. All rights reserved.
//

import Foundation

public class GitRepoResponse:NSObject,Identifiable,Codable {
    public var totalRecords = 0
    public var incompleteResults = false
    public var items = [GitRepoItem]()
    
    private enum CodingKeys: String, CodingKey {
        case totalRecords = "total_count"
        case incompleteResults = "incomplete_results"
        case items = "items"
    }
    public override init() {
        //
        super.init()
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let count = try? container.decodeIfPresent(Int.self, forKey: .totalRecords){
            totalRecords = count
        }
        if let list = try? container.decodeIfPresent([GitRepoItem].self, forKey: .items){
            items = list
        }
        if let incomplete = try? container.decodeIfPresent(Bool.self, forKey: .incompleteResults){
            incompleteResults = incomplete
        }
        
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try? container.encode(totalRecords, forKey: .totalRecords)
        //
    }
}
