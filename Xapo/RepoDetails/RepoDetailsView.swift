//
//  RepoDetailsView.swift
//  Xapo
//
//  Created by Bourne K on 10/30/21.
//  Copyright © 2021 Bourne Koloh. All rights reserved.
//

import SwiftUI
import XapoCore

struct RepoDetailsView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    //
    @ObservedObject var viewModel: RepoDetailsViewModel
    let dateFormatter = DateFormatter()
    
    var loadErrorActionSheet: ActionSheet{
        
        ActionSheet(title: Text("Error").font(.title), message: Text("\(viewModel.errorMessage)"), buttons: [
            .default(Text("Try Again"), action: {
                //
                viewModel.fetchRepoDetails()
            }),.cancel()])
    }
    //
    init(repo:GitRepoItem){
        viewModel = RepoDetailsViewModel(repo: repo)
        dateFormatter.dateFormat = "EEE, dd MMM yyyy\nhh:mm a"
        //
        print("Repo Owner URL =>")
        print(repo.owner?.photo)
    }
    
    var body: some View {
        
        GeometryReader { geometry in
            
            //
            LoadingView(isShowing: $viewModel.isLoading) {
                
                ScrollView{
                    //
                    VStack{
                        //
                        Spacer()
                        //
                        if let repoUrl = viewModel.gitRepo.owner?.photo {
                            //
                            AsyncImage(url: URL(string: repoUrl)!,
                                           placeholder: {
                                Image("ic-store")
                                    .resizable().scaledToFit()

                            }, image: {
                                Image(uiImage: $0)
                                    .resizable()

                            })
                                .scaledToFit()
                                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 80, maxHeight: 160, alignment: .center)
                        }else{
                            Image("ic-store")
                                .resizable().scaledToFit()
                                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 80, maxHeight: 160, alignment: .center)
                        }
                        //
                        Text("\(viewModel.gitRepo.fullName)")
                          .font(.title)
                          .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .leading)
                          .padding(EdgeInsets(top: 2, leading: 0, bottom: 2, trailing: 0))
                        //
                        Text("\(viewModel.gitRepo.desc)")
                          .font(.body)
                          .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .leading)
                          .padding(EdgeInsets(top: 2, leading: 0, bottom: 2, trailing: 0))
                        //ROW 1
                        HStack(alignment: .bottom) {
                            
                            //
                            HStack(spacing: 5){
                                //
                              Image("ic-star").resizable().scaledToFit()
                                    .frame(minWidth: 0, maxWidth: 24, minHeight: 0, maxHeight: 24, alignment: .center)
                                //
                                Text("\(numberFormatter.string(from: NSNumber(value: viewModel.gitRepo.stars)) ?? "0")")
                                    .font(.footnote)
                                    .minimumScaleFactor(0.01)
                                    .padding(EdgeInsets(top: 2, leading: 4, bottom: 2, trailing: 4)).lineLimit(1)
                            }
                            //
                            HStack(spacing: 5){
                                //
                                Image("ic-fork").resizable().scaledToFit()
                                    .frame(minWidth: 0, maxWidth: 24, minHeight: 0, maxHeight: 24, alignment: .center)
                                //
                                Text("\(numberFormatter.string(from: NSNumber(value: viewModel.gitRepo.forks)) ?? "0")")
                                    .font(.footnote)
                                    .minimumScaleFactor(0.01)
                                    .padding(EdgeInsets(top: 2, leading: 4, bottom: 2, trailing: 4)).lineLimit(1)
                            }
                            //
                            HStack(spacing: 5){
                                //
                              Image("ic-issues").resizable().scaledToFit()
                                    .frame(minWidth: 0, maxWidth: 24, minHeight: 0, maxHeight: 24, alignment: .center)
                                //
                                Text("\(numberFormatter.string(from: NSNumber(value: viewModel.gitRepo.openIssues)) ?? "0")")
                                    .font(.footnote)
                                    .minimumScaleFactor(0.01)
                                    .padding(EdgeInsets(top: 2, leading: 4, bottom: 2, trailing: 4)).lineLimit(1)
                            }
                            //
                            HStack(spacing: 5){
                                //
                              Image("ic-eye").resizable().scaledToFit()
                                    .frame(minWidth: 0, maxWidth: 24, minHeight: 0, maxHeight: 24, alignment: .center)
                                //
                                Text("\(numberFormatter.string(from: NSNumber(value: viewModel.gitRepo.watchers)) ?? "0")")
                                    .font(.footnote)
                                    .minimumScaleFactor(0.01)
                                    .padding(EdgeInsets(top: 2, leading: 4, bottom: 2, trailing: 4)).lineLimit(1)
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        //ROW 2
                        HStack(alignment: .bottom) {
                            //
                            HStack(spacing: 5){
                                //
                              Image("ic-status").resizable().scaledToFit()
                                    .frame(minWidth: 0, maxWidth: 24, minHeight: 0, maxHeight: 24, alignment: .center)
                                //
                                Text("\(viewModel.gitRepo.archived ? "Archived" :"Active")")
                                    .font(.footnote)
                                    .minimumScaleFactor(0.01)
                                    .padding(EdgeInsets(top: 2, leading: 4, bottom: 2, trailing: 4)).lineLimit(1)
                            }
                            //
                            HStack(spacing: 5){
                                //
                                Image("ic-lang").resizable().scaledToFit()
                                        .frame(minWidth: 0, maxWidth: 24, minHeight: 0, maxHeight: 24, alignment: .center)
                                    //
                                Text("\(viewModel.gitRepo.language.lengthOfBytes(using: .utf8) > 0 ? viewModel.gitRepo.language : "???")")
                                        .font(.footnote)
                                        .minimumScaleFactor(0.01)
                                        .padding(EdgeInsets(top: 2, leading: 4, bottom: 2, trailing: 4)).lineLimit(1)
                            }
                                
                            //
                            HStack(spacing: 5){
                                //
                                Image("ic-lic").resizable().scaledToFit()
                                    .frame(minWidth: 0, maxWidth: 24, minHeight: 0, maxHeight: 24, alignment: .center)
                                //
                                Text("\(viewModel.gitRepo.lic?.name.lengthOfBytes(using: .utf8) ?? 0 > 0 ? viewModel.gitRepo.lic!.name : "Not Available")")
                                    .font(.footnote)
                                    .minimumScaleFactor(0.01)
                                    .padding(EdgeInsets(top: 2, leading: 4, bottom: 2, trailing: 4))
                                    .lineLimit(1)
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        //ROW 3
                        HStack(alignment: .bottom) {
                            
                            //
                            HStack(spacing: 5){
                                //
                              Image("ic-cal").resizable().scaledToFit()
                                    .frame(minWidth: 0, maxWidth: 20, minHeight: 0, maxHeight: 20, alignment: .center)
                                //
                                Text("Created : ")
                                      .font(.footnote)
                                      .minimumScaleFactor(0.01)
                                      .padding(EdgeInsets(top: 2, leading: 4, bottom: 2, trailing: 4))
                                      .lineLimit(1)
                                //
                                Group{
                                    if let date = viewModel.gitRepo.createdAt {
                                        Text(dateFormatter.string(from: date))
                                            .lineLimit(2)
                                            .multilineTextAlignment(.trailing)
                                    }else{
                                        Text("Not Available").lineLimit(1)
                                    }
                                }
                                .font(.footnote)
                                .minimumScaleFactor(0.01)
                                .padding(EdgeInsets(top: 2, leading: 4, bottom: 2, trailing: 4))
                                .frame(maxWidth: .infinity)
                            }
                            
                            //
                            HStack(spacing: 5){
                                Image("ic-clock").resizable().scaledToFit()
                                      .frame(minWidth: 0, maxWidth: 20, minHeight: 0, maxHeight: 20, alignment: .center)
                                  //
                                  Text("Last Push : ")
                                        .font(.footnote)
                                        .minimumScaleFactor(0.01)
                                        .padding(EdgeInsets(top: 2, leading: 4, bottom: 2, trailing: 4))
                                        .lineLimit(1)
                                  //
                                  Group{
                                      if let date = viewModel.gitRepo.pushedAt {
                                          Text(dateFormatter.string(from: date))
                                              .lineLimit(2)
                                              .multilineTextAlignment(.trailing)
                                      }else{
                                          Text("Not Available").lineLimit(1)
                                      }
                                  }
                                  .font(.footnote)
                                  .minimumScaleFactor(0.01)
                                  .padding(EdgeInsets(top: 2, leading: 4, bottom: 2, trailing: 4))
                                  .frame(maxWidth: .infinity)
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        //
                        Rectangle()
                            .fill(Color.clear)
                            .background(Color.init(UIColor.lightGray))
                            .frame(width: geometry.size.width * 9/10,  height: 3, alignment: .trailing)
                        //
                        Text("READ ME")
                        .underline(true, color: Color.gray)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.title)
                        
                        //
                        if let readmeUrl = viewModel.repoDetails?.readmeUrl {
                            //
                            HTMLTextView(withURL: readmeUrl)
                                .frame(maxWidth: .infinity,minHeight: 480, maxHeight: .infinity)
                        }else{
                            //
                            Text("ReadMe link is not available for this repository")
                                .font(.footnote)
                                .minimumScaleFactor(0.01)
                                .padding(EdgeInsets(top: 2, leading: 4, bottom: 2, trailing: 4))
                                .frame(maxWidth: .infinity)
                        }
                    }
                }
                .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
            }
            .navigationBarItems(leading: HStack{
                //
            }, trailing: HStack {
                
                Button(action: {
                    //
                    if let url = URL(string: viewModel.gitRepo.webLink) {
                       UIApplication.shared.open(url)
                   }
                }, label: {
                    Text("Open ..")
                })
            })
            .navigationBarTitle(Text("Repository Details"))
            .onAppear(){
                viewModel.fetchRepoDetails()
            }
            .actionSheet(isPresented: $viewModel.showErrorAlert) {
                loadErrorActionSheet
            }
            
        }
    }
}

struct RepoDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        RepoDetailsView(repo: GitRepoItem())
    }
}
