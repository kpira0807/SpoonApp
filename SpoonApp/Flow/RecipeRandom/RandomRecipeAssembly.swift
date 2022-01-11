import Swinject

final class RandomRecipeAssembly: Assembly {
    
    private let parent: NavigationNode
    
    init(_ parent: NavigationNode) {
        self.parent = parent
    }
    
    func assemble(container: Container) {
        container.register(RandomRecipeViewController.self) {
            [unowned parent] _ in
            let model = RecipeModel(
                parent: parent,
                downloader: ReciperDownloader(),
                storage: ReciperStorage()
            )
            let viewModel = RecipeViewModel(model: model)
            let controller = RandomRecipeViewController(viewModel)
            
            return controller
        }.inObjectScope(.transient)
    }
    
}
