//
//  ContentView.swift
//  Shared
//
//  Created by FRANCISCO SAMUEL DA SILVA MARTINS on 14/12/21.
//

import SwiftUI

struct RepositorioListView: View {
    @ObservedObject var data = RepositorioViewModel()
        
    var body: some View {
        NavigationView {
            List(data.repositorios) { repositorio in
                NavigationLink(destination: PullRequestsView(path: repositorio.url)
                ) {
                    RepositorioCell(repositorio: repositorio).onAppear {
                        data.loadMoreRepositorios(currentItem: repositorio)
                    }
                }
            }.navigationBarTitle("Repositorios", displayMode: .inline)
        }.navigationViewStyle(.stack)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RepositorioListView()
    }
}
