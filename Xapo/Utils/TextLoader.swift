//
//  TextLoader.swift
//  Xapo
//
//  Created by Bourne K on 10/31/21.
//  Copyright © 2021 Eclectics Int. All rights reserved.
//

import Foundation
import Combine
import SwiftUI
import UIKit

class TextLoader: ObservableObject {
    var didChange = PassthroughSubject<Data, Never>()
    var data = Data() {
        didSet {
            didChange.send(data)
        }
    }

    init(urlString:String) {
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.data = data
            }
        }
        task.resume()
    }
}

struct HTMLTextView: View {
    @ObservedObject var textLoader:TextLoader
    @State var text:String = ""

    init(withURL url:String) {
        textLoader = TextLoader(urlString:url)
    }

    var body: some View {
        //
        WebView(htmlText: text)
            .onReceive(textLoader.didChange) {data in
                //
                let decode = String(decoding:data, as: UTF8.self)
                //
                if decode.lengthOfBytes(using: .utf8) > 0 {
                    self.text = decode
                }else{
                    self.text = "~~"
                }
        }
    }
}
