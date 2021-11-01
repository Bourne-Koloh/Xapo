//
//  GithubError.swift
//  XapoCore
//
//  Created by Bourne K on 10/30/21.
//  Copyright © 2021 Bourne Koloh. All rights reserved.
//

import Foundation

public enum XapoError:Error {
    case parsing(description: String)
    case network(description: String)
    case other(description:String?)
}
