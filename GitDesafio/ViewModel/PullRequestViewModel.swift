//
//  RepositorioObserver.swift
//  DesafioGitUi (iOS)
//
//  Created by FRANCISCO SAMUEL DA SILVA MARTINS on 14/12/21.
//

import SwiftUI
import Alamofire
class PullRequestViewModel: ObservableObject{
    @Published var pullRequests = [PullRequestDto]()
    @Published var isLoadingPage = false
    private var repositorioPath : String
    private var currentPage = 1
    private let listThreshold = -1
    private var endedPages = false
    private let perPage = 20
    
    init(forkPath : String) {
        self.repositorioPath = forkPath
    }
    
    func firstLoad(){
        loadPullRequests()
    }

    func loadMoreRepositorios(currentItem item: PullRequestDto){
        if endedPages {
            return
        }
        
        let thresholdIndex = pullRequests.index(pullRequests.endIndex, offsetBy: listThreshold)
        if pullRequests.firstIndex(where: { $0.id == item.id }) == thresholdIndex {
            loadPullRequests()
        }
    }

    private func loadPullRequests(){
        if isLoadingPage { return }

        isLoadingPage = true
        let parameters : [String:Any] = ["page": currentPage, "per_page" : perPage]
        let bodyEncoder = JSONDecoder()
        bodyEncoder.keyDecodingStrategy = .convertFromSnakeCase
        bodyEncoder.dateDecodingStrategy = .iso8601
        AF.request("\(repositorioPath)/pulls", parameters: parameters)
            .validate(statusCode: 200..<300)
            .responseDecodable(of : [PullRequestDto].self, decoder: bodyEncoder,completionHandler: {[weak self] response in
                guard let data = response.value else {return}
                if data.count != self?.perPage {
                    self?.endedPages = true
                }
                self?.pullRequests += data
                self?.currentPage += 1
                self?.isLoadingPage = false
            })
    }
}
