//
//  GitRepoDetailsItem.swift
//  XapoCore
//
//  Created by Bourne K on 10/30/21.
//  Copyright © 2021 Bourne Koloh. All rights reserved.
//

import Foundation

public class GitRepoDetailsItem:NSObject,Codable {
    public var size = 0
    public var readmeUrl = ""
    
    private enum CodingKeys: String, CodingKey {
        case size
        case readmeUrl = "download_url"
    }
    
    public override init() {
        //
        super.init()
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        size = try container.decode(Int.self, forKey: .size)
        readmeUrl = try container.decode(String.self, forKey: .readmeUrl)
        
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        //
    }
}
