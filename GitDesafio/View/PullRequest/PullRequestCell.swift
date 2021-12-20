//
//  PullRequestCell.swift
//  DesafioGitUi (iOS)
//
//  Created by FRANCISCO SAMUEL DA SILVA MARTINS on 14/12/21.
//

import SwiftUI
import Kingfisher
struct PullRequestCell: View {
    var pullRequest : PullRequestDto
    var body: some View {
        
        VStack{
            
            HStack {
                KFImage(pullRequest.user.avatarUrl).resizable().scaledToFit().frame( height: 70).cornerRadius(4)
                VStack(alignment: .leading, spacing: 5) {
                    Text(pullRequest.title).fontWeight(.semibold).lineLimit(2)
                    Text(pullRequest.user.login)
                    Text("Data: \(pullRequest.createdAt)")
                }
            }
            
            if let description = pullRequest.body {
                Text(description).lineLimit(4)
            }
            
        }.onTapGesture {
            UIApplication.shared.open(pullRequest.htmlUrl)
        }
    }
    
}

