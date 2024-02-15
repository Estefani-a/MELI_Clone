//
//  EntryPointViewController.swift
//  AppIosW6CodePatroll_Example
//
//  Created by Estefania Sassone on 30/09/2022.
//  Copyright © 2022 MercadoLibre. All rights reserved.
//

import UIKit

class EntryPointViewController: UITabBarController {
    let nc1 = UINavigationController(rootViewController: HomeViewController())
    let vc2 = GenericListViewController(isFavorite: true)
    let nc2 = UINavigationController(rootViewController: GenericListViewController(isFavorite: true))
    let vc3 = EmptyListViewController()
    let vc4 = EmptyListViewController()
    let vc5 = EmptyListViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        setControllers()
    }
    
    private func setupTabBar() {
        tabBar.isTranslucent = false
        tabBar.backgroundColor = .white
    }
    
    func setControllers() {
        let icon1 = UIImage(named: "Home")?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        nc1.tabBarItem = UITabBarItem(title: "Inicio",
                                      image: icon1,
                                      selectedImage: icon1)
        nc1.tabBarItem.image?.withTintColor(UIColor(red: 153, green: 155, blue: 156, alpha: 1))
        
        let icon2 = UIImage(named: "Favorites")?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        nc2.tabBarItem = UITabBarItem(title: "Favoritos",
                                      image: icon2,
                                      selectedImage: icon2)
        nc2.tabBarItem.selectedImage?.withTintColor(UIColor(red: 58, green: 134, blue: 247, alpha: 1))
        
        let icon3 = UIImage(named: "Shopping")?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        vc3.tabBarItem = UITabBarItem(title: "Mis Compras",
                                      image: icon3,
                                      selectedImage: icon3)
        vc3.tabBarItem.selectedImage?.withTintColor(UIColor(red: 58, green: 134, blue: 247, alpha: 1))
        
        let icon4 = UIImage(named: "Notifications")?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        vc4.tabBarItem = UITabBarItem(title: "Notificaciones",
                                      image: icon4,
                                      selectedImage: icon4)
        vc4.tabBarItem.selectedImage?.withTintColor(UIColor(red: 58, green: 134, blue: 247, alpha: 1))
        
        let icon5 = UIImage(named: "More")?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        vc5.tabBarItem = UITabBarItem(title: "Más",
                                      image: icon5,
                                      selectedImage: icon5)
        vc5.tabBarItem.image?.withTintColor(UIColor(red: 153, green: 155, blue: 156, alpha: 1))

        self.setViewControllers([nc1, nc2, vc3, vc4, vc5], animated: true)
    }
}
