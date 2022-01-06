import UIKit

enum RecipeEvent: NavigationEvent {
    
}

class RecipeCoordinator: NavigationNode {
    
    weak var containerViewController: UIViewController?
    
    override init(parent: NavigationNode?) {
        super.init(parent: parent)
        
        addHandlers()
    }
    
    private func addHandlers() {
        // add Settings flow event handlers
    }
    
}

extension RecipeCoordinator: Coordinator {
    
    func createFlow() -> UIViewController {
        let recipeModel = RecipeModel(parent: self)
        
        let recipeViewModel = RecipeViewModel(model: recipeModel)
        let recipeViewController = RandomRecipeViewController(recipeViewModel)
                
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
