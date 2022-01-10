import UIKit
import Swinject

class FavouriteCoordinator: NavigationNode {
    
    private var container: Container!
    weak var containerViewController: UIViewController?
    
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
        
        let favouriteTitle = L10n.favouritesTitleVC
        let favouriteImage = UIImage(systemName: "heart")
        let favouriteSelectedImage = UIImage(systemName: "heart.fill")
        
        let favouriteTabBarItem = UITabBarItem(title: favouriteTitle,
                                               image: favouriteImage,
                                               selectedImage: favouriteSelectedImage)
        
        favouriteViewController?.tabBarItem = favouriteTabBarItem
        
        return favouriteViewController!
    }
}
