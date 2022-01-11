import UIKit

final class DetailsRecipeInformationViewController: UIViewController {

    private let viewModel: DetailsRecipeInformationViewModel
    
    init(_ viewModel: DetailsRecipeInformationViewModel) {
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
