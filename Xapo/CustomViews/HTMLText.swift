//
//  HTMLText.swift
//  Xapo
//
//  Created by Bourne K on 10/31/21.
//  Copyright © 2021 Bourne Koloh. All rights reserved.
//

import Foundation
import SwiftUI
import WebKit

struct WebView: View {

    var htmlText:String
    
    @State private var height: CGFloat = .zero

    var body: some View {
        HtmlTextView(htmlContent: htmlText, dynamicHeight: $height)
            .frame(minHeight: height)
    }
}

struct HtmlTextView: UIViewRepresentable {

    var htmlContent: String = ""
    @Binding var dynamicHeight: CGFloat

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.isUserInteractionEnabled = true
        webView.backgroundColor = .clear
        webView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        webView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.loadHTMLString("<head><meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no'></head>\(htmlContent)", baseURL: nil)
        DispatchQueue.main.async {
            dynamicHeight = uiView.sizeThatFits(CGSize(width: uiView.bounds.width,
                                                       height: CGFloat.greatestFiniteMagnitude)).height
        }
    }
}
