//
//  ContentView.swift
//  Xapo
//
//  Created by Bourne K on 13/08/2019.
//  Copyright © 2019 Eclectics Int. All rights reserved.
//

import SwiftUI

struct LandingView: View {
    
    @State var showRepos = false
    
    var body: some View {
        //
        GeometryReader { geometry in
            //
            ZStack{
                //
                Image("bg-gray").resizable().scaledToFill()
                    .frame(width: geometry.size.width, height: nil, alignment: .center)
                //
                VStack(alignment: .leading, spacing: 5 ){
                    //
                    Spacer()
                    //
                    Button(action: {
                        withAnimation {
                            //TODO:Add Action ..
                        }
                    }) {
                    Text("Go to Xapo")
                        .foregroundColor(.white).font(.system(size: 17))
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                    .padding(EdgeInsets(top: 40, leading: 20, bottom: 20, trailing: 30))
                    //
                    ScrollView(.vertical) {
                        //
                        Spacer()
                            .frame(minHeight: 10, idealHeight: 50, maxHeight: 100)
                          //
                      Image("logo").resizable().scaledToFit()
                            .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 6))
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 114, alignment: .center)
                        //
                        Text("Welcome to iOS\nTest").foregroundColor(.white).font(.system(size: 30))
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: .infinity, alignment: .center)
                        //
                        Text("iOS Test for Xapo Bank\n\nLorem Ipsum dolor sit amet, consectetur \nadipiscing elit, sed do eiusmod tempor \nincididunt ut labore et dolore magna aliqua")
                            .foregroundColor(.white).font(.system(size: 17))
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                        //
                        Spacer()
                            .frame(minHeight: 50, idealHeight: geometry.size.height * 0.26, maxHeight: geometry.size.height * 0.5)
                        //
                        Group{
                            Button(action: {
                                self.showRepos = true
                            }) {
                                ZStack{
                                    Image("btn-bg").resizable().scaledToFit()
                                        .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
                                    
                                    Text("Enter the App").foregroundColor(.white)
                                }
                            }
                            .frame(width: geometry.size.width * 3/4, height: nil, alignment: .center)
                            
                            HStack(spacing: 8){
                                //
                                Button(action: {
                                    withAnimation {
                                        //TODO:Add Action ..
                                    }
                                }) {
                                    Text("Privacy Policy").foregroundColor(.white).font(.system(size: 12))
                                        .underline()
                                    
                                }
                                //
                                Text("and").foregroundColor(.white).font(.system(size: 12))
                                //
                                Button(action: {
                                    withAnimation {
                                        //TODO:Add Action ..
                                    }
                                }) {
                                    Text("Terms of Use").foregroundColor(.white).font(.system(size: 12))
                                        .underline()
                                    
                                }
                                
                            }
                        }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: Alignment.bottom)
                        //
                    }.frame(maxHeight: geometry.size.height)
                }
            }
            .edgesIgnoringSafeArea(.all)
            .onAppear {
                //
            }.sheet(isPresented: self.$showRepos,
                    onDismiss: {
                //
             },content: {
                 //
                 ReposView()
             })

        }
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach([ "iPhone 11 Pro Max", "iPhone SE (2nd generation)"], id: \.self) { deviceName in
            LandingView()
        }
    }
}
#endif
