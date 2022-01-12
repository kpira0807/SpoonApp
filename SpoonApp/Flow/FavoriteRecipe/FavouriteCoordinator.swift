import UIKit
import Swinject

final class FavouriteCoordinator: NavigationNode {
    
    private weak var root: UIViewController?
    private var container: Container!
    
    override init(parent: NavigationNode?) {
        super.init(parent: parent)
        
        registerFlow()
        addHandlers()
    }
    
    private func registerFlow() {
        container = Container()
        
        FavouriteRecipeAssembly(self).assemble(container: container)
    }
    
    private func addHandlers() {
        // add Settings flow event handlers
    }
    
}

extension FavouriteCoordinator: Coordinator {
    
    func createFlow() -> UIViewController {
        let favouriteViewController = container.resolve(FavoriteRecipeTableViewController.self)
        root = favouriteViewController
        
        return favouriteViewController!
    }
    
}
