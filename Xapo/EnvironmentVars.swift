//
//  EnvironmentVars.swift
//  Xapo
//
//  Created by Bourne K on 10/30/21.
//  Copyright © 2021 Bourne Koloh. All rights reserved.
//

import Foundation
import SwiftUI
import XapoCore

struct ApiServiceKey: EnvironmentKey {
    static let defaultValue: GitHubWorker = RequestManager.Shared
}

@available(iOS 13.0, *)
extension EnvironmentValues {
    var apiService: GitHubWorker {
        get {
            return self[ApiServiceKey.self]
        }
        set {
            self[ApiServiceKey.self] = newValue
        }
    }
}
