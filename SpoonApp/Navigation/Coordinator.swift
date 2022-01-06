import UIKit

public protocol Coordinator {
    
    var containerViewController: UIViewController? { get set }

    @discardableResult
    func createFlow() -> UIViewController
}
