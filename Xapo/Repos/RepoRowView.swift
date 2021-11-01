//
//  RepoRowView.swift
//  Xapo
//
//  Created by Bourne K on 10/30/21.
//  Copyright © 2021 Bourne Koloh. All rights reserved.
//

import SwiftUI
import XapoCore

struct RepoRowView: View {
  private let gitRepo: GitRepoItem
  
  init(gitRepo: GitRepoItem) {
    self.gitRepo = gitRepo
  }
  
  var body: some View {
    VStack {
        HStack (spacing: 20){
          Image("ic-store")
                .frame(minWidth: 0, maxWidth: 22, minHeight: 0, maxHeight: 22, alignment: .center)
            Text("\(gitRepo.fullName)")
                .font(.system(size: 24))
                .lineLimit(2)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        //
        Text("\(gitRepo.desc)")
            .lineLimit(5)
          .font(.body)
        //
        Spacer()
        //
        HStack(alignment: .bottom) {
            
            //
            HStack(spacing: 5){
                //
              Image("ic-star").resizable().scaledToFit()
                    .frame(minWidth: 0, maxWidth: 24, minHeight: 0, maxHeight: 24, alignment: .center)
                //
              Text("\(numberFormatter.string(from: NSNumber(value: gitRepo.stars)) ?? "0")")
                    .font(.footnote)
                    .minimumScaleFactor(0.01)
                    .padding(EdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2))
            }.background(Color.orange)
                .cornerRadius(5)
            //
            HStack(spacing: 5){
                //
                Image("ic-fork").resizable().scaledToFit()
                    .frame(minWidth: 0, maxWidth: 24, minHeight: 0, maxHeight: 24, alignment: .center)
                //
                Text("\(numberFormatter.string(from: NSNumber(value: gitRepo.forks)) ?? "0")")
                    .font(.footnote)
                    .minimumScaleFactor(0.01)
                    .padding(EdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2))
            }.background(Color.gray)
                .cornerRadius(5)
            //
            HStack(spacing: 5){
                //
              Image("ic-issues").resizable().scaledToFit()
                    .frame(minWidth: 0, maxWidth: 24, minHeight: 0, maxHeight: 24, alignment: .center)
                //
              Text("\(numberFormatter.string(from: NSNumber(value: gitRepo.openIssues)) ?? "0")")
                    .font(.footnote)
                    .minimumScaleFactor(0.01)
                    .padding(EdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2))
            }.background(Color.orange)
                .cornerRadius(5)
            //
            HStack(spacing: 5){
                //
              Image("ic-lang").resizable().scaledToFit()
                    .frame(minWidth: 0, maxWidth: 24, minHeight: 0, maxHeight: 24, alignment: .center)
                //
                Text("\(gitRepo.language.lengthOfBytes(using: .utf8) > 0 ? gitRepo.language : "???")")
                    .font(.footnote)
                    .minimumScaleFactor(0.01)
                    .padding(EdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2))
            }.background(Color.gray)
                .cornerRadius(5)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        
    }
  }
}

#if DEBUG
struct RepoRowView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach([ "iPhone 11 Pro Max", "iPhone SE (2nd generation)"], id: \.self) { deviceName in
            RepoRowView(gitRepo: GitRepoItem())
        }
    }
}
#endif
