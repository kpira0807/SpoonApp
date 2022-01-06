import UIKit

enum FavouriteEvent: NavigationEvent {
    
}

class FavouriteCoordinator: NavigationNode {
    
    weak var containerViewController: UIViewController?
    
    override init(parent: NavigationNode?) {
        super.init(parent: parent)
        
        addHandlers()
    }
    
    private func addHandlers() {
        // add Settings flow event handlers
    }
    
}

extension FavouriteCoordinator: Coordinator {
    
    func createFlow() -> UIViewController {
        let favouriteModel = FavouriteModel(parent: self)
        
        let favouriteViewModel = FavoutireViewModel(model: favouriteModel)
        let favouriteViewController = FavoriteRecipeTableViewController(favouriteViewModel)
        
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
