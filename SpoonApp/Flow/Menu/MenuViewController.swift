//
//  MenuViewController.swift
//  SpoonApp
//
//  Created by Iryna Didkovska on 21.12.2021.
//

import UIKit

class MenuViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        self.navigationItem.title = L10n.menuTitleVC
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: Asset.tabBarTintColor.color]
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
