import UIKit
import Swinject

final class MenuCoordinator: NavigationNode {
   
    private weak var root: UIViewController?
    private var container: Container!
    
    override init(parent: NavigationNode?) {
        super.init(parent: parent)
        
        addHandlers()
    }
    
    private func registerFlow() {
        container = Container()
        
        MenuAssembly(self).assemble(container: container)
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
        root = menuViewController
        
        return menuViewController
    }
    
}
