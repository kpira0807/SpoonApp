import UIKit

final class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        tabBar.tintColor = Asset.tabBarTintColor.color
        tabBar.unselectedItemTintColor = Asset.tabBarTintColor.color
        
        setupTabBar()
    }
    
}

extension TabBarViewController {
    
    func setupTabBar() {
        tabBar.layer.masksToBounds = true
        tabBar.isTranslucent = true
        tabBar.layer.cornerRadius = 20
        tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
}
