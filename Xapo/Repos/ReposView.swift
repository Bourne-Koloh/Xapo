//
//  ReposView.swift
//  Xapo
//
//  Created by Bourne K on 10/30/21.
//  Copyright © 2021 Bourne Koloh. All rights reserved.
//

import SwiftUI


let numberFormatter = NumberFormatter()

struct ReposView: View {
    //
    @ObservedObject var viewModel: ReposViewModel
    //
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var loadErrorActionSheet: ActionSheet{
        
        ActionSheet(title: Text("Error").font(.system(size: 22)), message: Text("\(viewModel.errorMessage)"), buttons: [
            .default(Text("Try Again"), action: {
                //
                viewModel.fetchRepos(withTitle: viewModel.searchTerm)
            }),.cancel()])
    }
    //Init
    init(viewModel: ReposViewModel = ReposViewModel()) {
        self.viewModel = viewModel
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        numberFormatter.usesGroupingSeparator = true
    }
    //
    var body: some View {
        
        NavigationView {
            //
            LoadingView(isShowing: $viewModel.isLoading) {
                //
                List {
                    //
                    if viewModel.dataSource.isEmpty && !viewModel.isLoading {
                        //Place holder for empty list
                        if viewModel.errorMessage.lengthOfBytes(using: .utf8) > 0 {
                            Section {
                                Text("Loaded Repos Failed \n\n\(viewModel.errorMessage)")
                                    .foregroundColor(.gray)
                            }
                        }else{
                            Section {
                                Text("No Repos Loaded ...")
                                    .foregroundColor(.gray)
                            }
                        }
                    } else if !viewModel.dataSource.isEmpty {
                        //Show count ..
                        Section {
                            HStack{
                                Text("Showing : ")
                                Text("\(numberFormatter.string(from: NSNumber(value: viewModel.dataSource.count)) ?? "0") of \(numberFormatter.string(from: NSNumber(value: viewModel.totalRecords)) ?? "0") Repositories")
                            }
                          .foregroundColor(.gray)
                        }
                        //Show the repos
                        Section {
                            ForEach(viewModel.dataSource) {item in
                                //
                                NavigationLink(destination: RepoDetailsView(repo: item)){
                                    //
                                    RepoRowView.init(gitRepo:item)
                                        .onAppear {
                                            
                                        }
                                }
                            }
                        }
                    }
                }
                .listStyle(GroupedListStyle())
                .environment(\.horizontalSizeClass, .regular)
                .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                .navigationBarSearch($viewModel.searchTerm)
                .animation(.easeIn)
            }
            .navigationBarItems(leading: HStack{
                
                Button(action: {
                    //
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text("Close")
                    
                })
            }, trailing: HStack {
                Button(action: {
                    //
                    self.viewModel.fetchRepos(withTitle:nil)
                },label: {
                    Image(systemName: "arrow.counterclockwise")
                })
            })
            .navigationBarTitle(Text("Trending Github Repos"))
        }
//        .actionSheet(isPresented: $viewModel.showErrorAlert) {
//            loadErrorActionSheet
//        }


    }
}

struct ReposView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach([ "iPhone 11 Pro Max", "iPhone SE"], id: \.self) { deviceName in
            ReposView()
        }
    }
}
