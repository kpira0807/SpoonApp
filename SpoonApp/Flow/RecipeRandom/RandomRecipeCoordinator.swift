import UIKit
import Swinject
import RxSwift

final class RecipeCoordinator: NavigationNode {
    
    private weak var root: UIViewController?
    private var container: Container!
    
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
        let recipeViewController = container.resolve(RandomRecipesViewController.self)
        root = recipeViewController
        
        let navigationController = UINavigationController(rootViewController: recipeViewController!)
        
        return navigationController
    }
    
}
