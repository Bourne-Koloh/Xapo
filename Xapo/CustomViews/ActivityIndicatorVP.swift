//
//  ActivityIndicatorVP.swift
//  Xapo
//
//  Created by Bourne K on 10/30/21.
//  Copyright © 2021 Bourne Koloh. All rights reserved.
//

import SwiftUI
import UIKit

@available(iOS 13.0, *)
struct ActivityIndicator: UIViewRepresentable {

    @Binding var isAnimating: Bool
    let style: UIActivityIndicatorView.Style

    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: style)
    }

    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
}


@available(iOS 13.0, *)
struct LoadingView<Content>: View where Content: View {

    @Binding var isShowing: Bool
    var content: () -> Content

    var body: some View {
        GeometryReader { geometry in
            
            ZStack(alignment: .center) {

                self.content()
                    .disabled(self.isShowing)
                    .blur(radius: self.isShowing ? 3 : 0)
                    .animation(.default)
                
                withAnimation(.easeInOut(duration: 500)) {
                    VStack {
                        //
                        Text("Please Wait ..")
                            .foregroundColor(.white)
                        //
                        ActivityIndicator(isAnimating: .constant(true), style: .large)
                            .foregroundColor(Color.white)
                    }
                    //.frame(width: geometry.size.width / 2, height: geometry.size.height / 5)
                        .frame(width: 140, height: 140)
                        .background(Color.orange)
                    .foregroundColor(Color.primary)
                    .cornerRadius(20)
                    .opacity(self.isShowing ? 1 : 0)
                }
                

            }
        }
    }

}

struct ActivityIndicator_Previews: PreviewProvider {
    static var previews: some View {
        ActivityIndicator(isAnimating: .constant(true), style: .large)
    }
}
