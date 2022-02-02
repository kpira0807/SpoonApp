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
        let detailModel = DetailsRecipeInformationModel(parent: self)
        let detailViewModel = DetailsRecipeInformationViewModel(model: detailModel)
        let detailViewController = DetailsRecipeInformationViewController(detailViewModel)
        root = detailViewController
        
        return detailViewController
    }

}
