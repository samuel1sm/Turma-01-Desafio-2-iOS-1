//
//  RepositoryDTO.swift
//  DesafioGitUi (iOS)
//
//  Created by FRANCISCO SAMUEL DA SILVA MARTINS on 14/12/21.
//

import Foundation

struct RepositorioList: Decodable {
    let items : [RepositorioDto]
}

struct RepositorioDto : Identifiable, Decodable{
    let id : Int
    let fullName : String
    let name : String
    let description: String?
    let owner: PersonInformations
    let stargazersCount: Int
    let forksCount: Int
    let url : String
}


