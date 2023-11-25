//
//  NavigationTabBarViewController.swift
//  PokedexJSON
//
//  Created by Diplomado on 24/11/23.
//

import UIKit

class NavigationTabBarViewController: UITabBarController {

    init() {
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewControllers()
    }
    
    private func setupViewControllers() {
        let pokemonListViewController = PokemonListTableViewController(style: .insetGrouped)
        pokemonListViewController.tabBarItem.image = UIImage(systemName: "dog")
        pokemonListViewController.tabBarItem.title = "Pokedex"
        
        let pokemonListNavigationController = UINavigationController(rootViewController: pokemonListViewController)
        viewControllers = [pokemonListNavigationController]
    }

}
