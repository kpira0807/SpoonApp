import UIKit
import Swinject
import RxSwift

enum Event: NavigationEvent {
  
  case openDetailRandomRecipe
    
}

final class RecipeCoordinator: NavigationNode {
    
    private weak var root: UIViewController?
    private var container: Container!
    
    override init(parent: NavigationNode?) {
        super.init(parent: parent)
        
        registerFlow()
        handlers()
    }
    
    private func registerFlow() {
        container = Container()
        RandomRecipeAssembly(self).assemble(container: container)
    }
    
    private func handlers() {
        addHandler { [weak self] (event: Event) in
            guard let self = self else { return }
            
            switch event {
            case .openDetailRandomRecipe:
                let coordinator = DetailsRecipeInformationCoordinator(parent: self)
                let controller = coordinator.createFlow()
                self.root?.navigationController?.pushViewController(controller, animated: true)
            }
        }
    }
    
    private func addHandlers() {
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
