import Swinject
import UIKit

final class TabBarAssembly: Assembly {
    
    private let parent: NavigationNode
    
    init(_ parent: NavigationNode) {
        self.parent = parent
    }
    
    func assemble(container: Container) {
        container.register(TabBarViewController.self) { _ in
            let controller = TabBarViewController()
            
            return controller
        }.inObjectScope(.transient)
    }

}
