//
//  RepositorioObserver.swift
//  DesafioGitUi (iOS)
//
//  Created by FRANCISCO SAMUEL DA SILVA MARTINS on 14/12/21.
//

import SwiftUI
import Alamofire
class RepositorioViewModel: ObservableObject{
    @Published var repositorios = [RepositorioDto]()
    @Published var isLoadingPage = false
    private var currentPage = 1
    private let listThreshold = -10
    private let perPage = 100
    private let sortType = "Stars"

    init() {
        loadRepositorios()
    }
    
    func loadMoreRepositorios(currentItem item: RepositorioDto){
        let thresholdIndex = repositorios.index(repositorios.endIndex, offsetBy: listThreshold)
        if repositorios.firstIndex(where: { $0.id == item.id }) == thresholdIndex {
            loadRepositorios()
        }
    }
    
    private func loadRepositorios(){
        if isLoadingPage {
            return
        }
        
        isLoadingPage = true
        let parameters : [String:Any] = ["sort" : sortType, "page": currentPage, "per_page" : perPage]
        let bodyEncoder = JSONDecoder()
        bodyEncoder.keyDecodingStrategy = .convertFromSnakeCase
        bodyEncoder.dateDecodingStrategy = .iso8601
        
        AF.request("https://api.github.com/search/repositories?q=language:Swift&sort=\(sortType)&page=\(currentPage)&per_page=\(perPage)", parameters: parameters)
            .validate(statusCode: 200..<300)
            .responseDecodable(of : RepositorioList.self, decoder: bodyEncoder,completionHandler: {[weak self] response in
                guard let data = response.value else {return}
                self?.repositorios += data.items
                self?.currentPage += 1
                self?.isLoadingPage = false
            })
    }
}
