//
//  HostingViewController.swift
//  Xapo
//
//  Created by Bourne K on 10/30/21.
//  Copyright © 2021 Bourne Koloh. All rights reserved.
//

import UIKit
import SwiftUI

@available(iOS 13.0, *)
class HostingViewController<C> : UIHostingController<C> where C : View  {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
