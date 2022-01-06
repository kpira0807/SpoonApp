import UIKit

enum TabBarEvent: NavigationEvent {
    
}

class TabBarCoordinator: NavigationNode {

    weak var containerViewController: UIViewController?
    
    override init(parent: NavigationNode?) {
        super.init(parent: parent)
        
        addHandlers()
    }
    
    private func addHandlers() {
        // add Settings flow event handlers
    }
    
}

extension TabBarCoordinator: Coordinator {
    
    func createFlow() -> UIViewController {
        
        let randomCoordinator = RecipeCoordinator(parent: self)
        let randomViewController = randomCoordinator.createFlow()
        randomCoordinator.containerViewController = randomViewController
        
        
        let favouriteCoordinator = FavouriteCoordinator(parent: self)
        let favouriteViewController = favouriteCoordinator.createFlow()
        favouriteCoordinator.containerViewController = favouriteViewController
        
        
        let menuCoordinator = MenuCoordinator(parent: self)
        let menuViewController = menuCoordinator.createFlow()
        menuCoordinator.containerViewController = menuViewController
        
        
        let tabBarController = TabBarViewController()
        tabBarController.viewControllers = [randomViewController,
                                            favouriteViewController,
                                            menuViewController]

        return tabBarController
    }
}
