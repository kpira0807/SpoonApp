import UIKit
import Swinject
import RxSwift

final class RecipeCoordinator: NavigationNode {
    
    private var container: Container!
    weak var containerViewController: UIViewController?
    
    override init(parent: NavigationNode?) {
        
        super.init(parent: parent)
        
        registerFlow()
        addHandlers()
    }
    
    private func registerFlow() {
        container = Container()
        RandomRecipeAssembly(self).assemble(container: container)
    }
    
    private func addHandlers() {
        // add Settings flow event handlers
    }
}

extension RecipeCoordinator: Coordinator {
    
    func createFlow() -> UIViewController {
        
        let recipeViewController = container.resolve(RandomRecipeViewController.self)
        
        let recipeTitle = L10n.recipeTitleVC
        let recipeImage = UIImage(systemName: "book")
        let recipeSelectedImage = UIImage(systemName: "book.fill")
        
        let recipeTabBarItem = UITabBarItem(title: recipeTitle,
                                            image: recipeImage,
                                            selectedImage: recipeSelectedImage)
        recipeViewController?.tabBarItem = recipeTabBarItem
        
        return recipeViewController!
    }
}
