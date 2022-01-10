import Swinject

final class MenuAssembly: Assembly {
    
    private let parent: NavigationNode
    
    init(_ parent: NavigationNode) {
        self.parent = parent
    }
    
    func assemble(container: Container) {
        container.register(MenuViewController.self) { [unowned parent] _ in
            let model = MenuModel(parent: parent)
            let viewModel = MenuViewModel(model: model)
            let controller = MenuViewController(viewModel)
            
            return controller!
        }.inObjectScope(.transient)
    }
}
