//
//  PullRequestDTO.swift
//  DesafioGitUi (iOS)
//
//  Created by FRANCISCO SAMUEL DA SILVA MARTINS on 14/12/21.
//

import Foundation

struct PullRequestDto: Identifiable, Decodable {
    let id : Int
    let htmlUrl: URL
    let number: Int
    let title : String
    let user : PersonInformations
    let createdAt : Date
    let body: String?
}
