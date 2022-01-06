import UIKit

class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.tabBar.tintColor = Asset.tabBarTintColor.color
        self.tabBar.unselectedItemTintColor = Asset.tabBarTintColor.color

        self.customTabBar()
    }
}

extension TabBarViewController {
   
    func customTabBar() {
        self.tabBar.layer.masksToBounds = true
        self.tabBar.isTranslucent = true
        self.tabBar.layer.cornerRadius = 20
        self.tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
}
