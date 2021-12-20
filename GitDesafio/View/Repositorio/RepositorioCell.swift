//
//  RepositorioCell.swift
//  DesafioGitUi (iOS)
//
//  Created by FRANCISCO SAMUEL DA SILVA MARTINS on 14/12/21.
//

import SwiftUI
import Kingfisher
struct RepositorioCell : View {
    var repositorio : RepositorioDto
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5){
            HStack{
                KFImage( repositorio.owner.avatarUrl).resizable().scaledToFit().frame( height: 70).cornerRadius(4)
                VStack(alignment: .leading, spacing: 5) {
                    Text(repositorio.name).fontWeight(.semibold).lineLimit(2)
                    Text("Autor: \(repositorio.owner.login)").font(.subheadline).foregroundColor(.secondary)
                    Text("Estrelas: \(repositorio.stargazersCount)")
                    Text("Forks: \(repositorio.forksCount)")
                }
            }
            if let description = repositorio.description{
                Text(description)
            }
        }
    }
}
