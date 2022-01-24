import UIKit

public protocol Reusable: AnyObject {
    
    static var reuseIdentifier: String { get }
    
}

public protocol CellResizable: AnyObject {
    
    var sizeRecharging: (() -> Void)? { get set }
    
}

public extension Reusable {
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
}
