import UIKit

final class MenuViewController: UIViewController {
    
    private let viewModel: MenuViewModel
    
    init?(_ viewModel: MenuViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
    }
}
