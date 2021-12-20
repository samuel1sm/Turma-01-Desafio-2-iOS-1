//
//  PullRequestsView.swift
//  DesafioGitUi (iOS)
//
//  Created by FRANCISCO SAMUEL DA SILVA MARTINS on 14/12/21.
//

import SwiftUI

struct PullRequestsView: View {
    @ObservedObject var data : PullRequestViewModel
    
    init(path: String){
        data = PullRequestViewModel(forkPath: path)
    }
    
    var body: some View {
        NavigationView {
            List(data.pullRequests, id: \.id){ pullRequest in
                PullRequestCell(pullRequest: pullRequest).onAppear {
                    data.loadMoreRepositorios(currentItem: pullRequest)
                }
                .navigationBarTitle("Pull Requests")
            }
        }.onAppear {
            data.firstLoad()
        }
    }
}

struct PullRequestsView_Previews: PreviewProvider {
    static var previews: some View {
        PullRequestsView(path: "https://api.github.com/repos/vsouza/awesome-ios/pulls")
    }
}
