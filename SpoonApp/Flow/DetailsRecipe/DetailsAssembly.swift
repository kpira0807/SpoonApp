import Swinject

final class DetailsAssembly: Assembly {
    
    private let parent: NavigationNode
    
    init(_ parent: NavigationNode) {
        self.parent = parent
    }
    
    func assemble(container: Container) {
        container.register(DetailsViewController.self) { [unowned parent] _ in
            let model = DetailsModel(parent: parent)
            let viewModel = DetailsViewModel(model: model)
            let controller = DetailsViewController(viewModel)
            
            return controller!
        }.inObjectScope(.transient)
    }
}
