//
//  CustomTabBar.swift
//  CashRegister
//
//  Created by Elchın on 26.03.26.
//

import UIKit

class CustomTabBar: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
    }
    
    private func setupUI() {
        let cashPage = UINavigationController(rootViewController: CashViewController())
        cashPage.tabBarItem = UITabBarItem(title: "Kassa", image: UIImage(systemName: "text.pad.header"), selectedImage: UIImage(systemName: "text.pad.header"))
        cashPage.title = "Kassa"
        
        let historyPage = UINavigationController(rootViewController: HistoryViewController())
        historyPage.tabBarItem = UITabBarItem(title: "Tarixçə", image: UIImage(systemName: "calendar"), selectedImage: UIImage(systemName: "calendar"))
        historyPage.title = "Tarixçə"
        
        viewControllers = [cashPage, historyPage]
    }
}
