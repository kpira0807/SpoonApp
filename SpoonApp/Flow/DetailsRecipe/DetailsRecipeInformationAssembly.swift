import Swinject

final class DetailsRecipeInformationAssembly: Assembly {
    
    private let parent: NavigationNode
    
    init(_ parent: NavigationNode) {
        self.parent = parent
    }
    
    func assemble(container: Container) {
        container.register(DetailsRecipeInformationViewController.self) { [unowned parent] _ in
            let model = DetailsRecipeInformationModel(parent: parent)
            let viewModel = DetailsRecipeInformationViewModel(model: model)
            let controller = DetailsRecipeInformationViewController(viewModel)
            
            return controller
        }.inObjectScope(.transient)
    }

}
