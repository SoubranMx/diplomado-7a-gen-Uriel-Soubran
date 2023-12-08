//
//  ContentView.swift
//  RickAndMortySUI
//
//  Created by Diplomado on 08/12/23.
//

import SwiftUI

struct ContentView: View {
    let client = RESTClient<PaginatedResponse<Character>>(client: Client.rickAndMorty)
    @State var characters: [Character] = []
    var body: some View {
        NavigationView{
            List[characters] { character in
                CharacterRow(character: character)
            }
            .listStyle(.plain)
            .navigationTitle("Characters")
        }.task {
            do {
                let response = try await client.show(path: "/api/character")
                self.characters = response?.results ?? []
            } catch let err {
                debugPrint(err)
            }
        }
    }
}

#Preview {
    ContentView()
}
