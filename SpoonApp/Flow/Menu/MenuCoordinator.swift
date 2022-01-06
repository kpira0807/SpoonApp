import UIKit

enum MenuEvent: NavigationEvent {
    
}

class MenuCoordinator: NavigationNode {
    
    weak var containerViewController: UIViewController?
    
    override init(parent: NavigationNode?) {
        super.init(parent: parent)
        
        addHandlers()
    }
    
    private func addHandlers() {
        // add Settings flow event handlers
    }
    
}

extension MenuCoordinator: Coordinator {
    
    func createFlow() -> UIViewController {
        let menuModel = MenuModel(parent: self)
        
        let menuViewModel = MenuViewModel(model: menuModel)
        let menuViewController = MenuViewController(menuViewModel)
        
        let menuTitle = L10n.menuTitleVC
        let menuImage = UIImage(systemName: "menucard")
        let menuSelectedImage = UIImage(systemName: "menucard.fill")
        
        let menuTabBarItem = UITabBarItem(title: menuTitle,
                                            image: menuImage,
                                            selectedImage: menuSelectedImage)
        
        menuViewController?.tabBarItem = menuTabBarItem
        
        return menuViewController!
        
    }
    
}
