//
//  PokemonListViewModel.swift
//  pokedex2
//
//  Created by Alejandro Mendoza on 17/11/23.
//

import Foundation

protocol PokemonListViewModelDelegate: AnyObject {
    func shouldReloadTableData()
}

class PokemonListViewModel {
    private let fileName = "pokemon_list"
    private let fileExtension = "json"
    
    private var pokemonList: [Pokemon] = []
    private var filterPokemonList: [Pokemon] = []
    private var favoritePokemonList: Set<Pokemon> = []
    
    let pokemonCellIdentifier = "pokemonCell"
    
    let searchBarPlaceholder = "Search"
    let viewTitle = "Pokedex"
    
    let numberOfSections: Int = 1
    var numberOfRows: Int { filterPokemonList.count }
    
    weak var delegate: PokemonListViewModelDelegate?
    
    init() {
        loadData()
    }
    
    func pokemon(at indexPath: IndexPath) -> Pokemon {
        filterPokemonList[indexPath.row]
    }
    
    private func loadData() {
        guard let fileURL = Bundle.main.url(forResource: fileName,
                                            withExtension: fileExtension),
              let pokemonData = try? Data(contentsOf: fileURL),
              let pokemonList = try? JSONDecoder().decode([Pokemon].self,
                                                          from: pokemonData)
        else {
            assertionFailure("Cannot find or read file: \(fileName)")
            return
        }
        
        self.pokemonList = pokemonList
        self.filterPokemonList = pokemonList
        
    }
    
    func filterPokemon(with searchText: String) {
        defer {
            delegate?.shouldReloadTableData()
        }
        
        guard !searchText.isEmpty else {
            filterPokemonList = pokemonList
            return
        }
        
        filterPokemonList = pokemonList.filter {
            $0.name.lowercased().contains(searchText.lowercased()) ||
            $0.number.lowercased().contains(searchText.lowercased())
        }
    }
    
    func addPokemonToFavorites(index: IndexPath) {
        let favoritePokemon = filterPokemonList[index.row]
        favoritePokemonList.insert(favoritePokemon) //insert es append pero para Set
    }
}




