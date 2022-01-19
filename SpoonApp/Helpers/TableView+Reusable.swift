import UIKit

public extension UITableView {
    
    // MARK: UITableViewCell

    /** Register a Class-Based `UITableViewCell` subclass (conforming to `Reusable`) */
    final func registerReusableCell<T: UITableViewCell>(cellType: T.Type) where T: Reusable {
        register(cellType.self, forCellReuseIdentifier: cellType.reuseIdentifier)
    }
    
    /** Returns a reusable `UITableViewCell` object for the class inferred by the return-type */
    final func dequeueReusableCell<T: UITableViewCell>(_ indexPath: IndexPath, cellType: T.Type = T.self) -> T
        where T: Reusable {
            guard let cell = dequeueReusableCell(withIdentifier: cellType.reuseIdentifier, for: indexPath) as? T else {
                fatalError(
                    "Failed to dequeue a cell with identifier \(cellType.reuseIdentifier) "
                        + "matching type \(cellType.self). "
                        + "Check that the reuseIdentifier is set properly in your XIB/Storyboard "
                        + "and that you registered the cell beforehand"
                )
                
            }
            return cell
    }

}
