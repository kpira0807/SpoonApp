import UIKit
import Swinject

class DetailsCoordinator: NavigationNode {
    
    private var container: Container!
    weak var containerViewController: UIViewController?
    
    override init(parent: NavigationNode?) {
        super.init(parent: parent)
        
        addHandlers()
    }
    
    private func registerFlow() {
        container = Container()
        
        DetailsAssembly(self).assemble(container: container)
    }
    
    private func addHandlers() {
        // add Settings flow event handlers
    }
    
}

extension DetailsCoordinator: Coordinator {
    
    func createFlow() -> UIViewController {
        let detailsViewController = container.resolve(DetailsViewController.self)
        
        return detailsViewController!
    }
}
