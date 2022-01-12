import UIKit
import Swinject

final class DetailsRecipeInformationCoordinator: NavigationNode {
    
    private weak var root: UIViewController?
    private var container: Container!
    
    override init(parent: NavigationNode?) {
        super.init(parent: parent)
        
        addHandlers()
    }
    
    private func registerFlow() {
        container = Container()
        
        DetailsRecipeInformationAssembly(self).assemble(container: container)
    }
    
    private func addHandlers() {
        // add Settings flow event handlers
    }
    
}

extension DetailsRecipeInformationCoordinator: Coordinator {
    
    func createFlow() -> UIViewController {
        let detailsRecipeInformationViewController = container.resolve(DetailsRecipeInformationViewController.self)
        root = detailsRecipeInformationViewController
        
        return detailsRecipeInformationViewController!
    }

}
