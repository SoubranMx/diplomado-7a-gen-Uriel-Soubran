//
//  TabBarController.swift
//  UserDefaults
//
//  Created by Diplomado on 03/11/23.
//

import UIKit

class TabBarController: UITabBarController {
    
    let firstView = FirstViewController()
    let secondView = SecondViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
//        el orden en que estan puestos en el array, es como se ven en el tab bar
        self.setViewControllers([firstView, secondView], animated: true)
        self.tabBar.backgroundColor = .white
        self.tabBar.tintColor = .black
    }

}
