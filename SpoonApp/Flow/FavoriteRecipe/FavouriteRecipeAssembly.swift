import Swinject

final class FavouriteRecipeAssembly: Assembly {
    
    private let parent: NavigationNode
    
    init(_ parent: NavigationNode) {
        self.parent = parent
    }
    
    func assemble(container: Container) {
        container.register(FavoriteRecipeTableViewController.self) {
            [unowned parent] _ in
            let model = FavouriteModel(parent: parent)
            let viewModel = FavouriteViewModel(model: model)
            let controller = FavoriteRecipeTableViewController(viewModel)
            
            return controller
        }.inObjectScope(.transient)
    }
    
}
