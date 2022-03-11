import UIKit
import Swinject

final class MenuCoordinator: NavigationNode {
   
    private weak var root: UIViewController?
    private var container: Container!
    
    override init(parent: NavigationNode?) {
        super.init(parent: parent)
        
        addHandlers()
        registerFlow()
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
        let menuViewController = container.resolve(MenuViewController.self)
        root = menuViewController
        
        return menuViewController!
    }
    
}
