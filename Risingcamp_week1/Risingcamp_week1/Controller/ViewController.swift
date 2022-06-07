//
//  ViewController.swift
//  Risingcamp_week1
//
//  Created by 서원지 on 2022/06/06.
//

import UIKit

final class ViewController: UIViewController {
    
  
    @IBOutlet weak var imagview: UIImageView!
    
    @IBOutlet weak var tabbar: UITabBarItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.barTintColor = .black
    }
}


