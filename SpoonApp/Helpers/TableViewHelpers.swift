import UIKit

public protocol CellModel {
    var viewModel: CellAnyViewModel { get }
    var id: Int { get }
}

public extension CellModel {
    var id: Int {
        return 0
    }
}

public protocol CellAnyViewModel {
    static var cellAnyType: UIView.Type { get }
    func setupAny(cell: UIView)
    var height: CGFloat { get }
    var width: CGFloat { get }
}

public protocol CellViewModel: CellAnyViewModel {
    associatedtype CellType: UIView
    func setup(cell: CellType)
}

public extension CellViewModel {
    
    var width: CGFloat {
        return 0.0
    }
    
    var height: CGFloat {
        // By default cell uses Autolayout to determine its height
        UITableView.automaticDimension
    }
    
    static var cellAnyType: UIView.Type {
        return CellType.self
    }
    
    func setupAny(cell: UIView) {
        if let cell = cell as? CellType {
            setup(cell: cell)
        } else {
            assertionFailure("Wrong usage")
        }
    }
    
}

public extension UITableView {
    
    func dequeueReusableCell(withModel model: CellAnyViewModel, for indexPath: IndexPath) -> UITableViewCell {
        let indetifier = String(describing: type(of: model).cellAnyType)
        let cell = dequeueReusableCell(withIdentifier: indetifier, for: indexPath)
        
        model.setupAny(cell: cell)
        
        return cell
    }
    
    func registerClass(cellTypes: [UITableViewCell.Type]) {
        for item in cellTypes {
            let cellIdentifier = String(describing: item)
            register(item, forCellReuseIdentifier: cellIdentifier)
        }
    }
    
}

public extension UICollectionView {
    
    func dequeueReusableCell(withModel model: CellAnyViewModel, for indexPath: IndexPath) -> UICollectionViewCell {
        let indetifier = String(describing: type(of: model).cellAnyType)
        let cell = dequeueReusableCell(withReuseIdentifier: indetifier, for: indexPath)
        model.setupAny(cell: cell)
        
        return cell
    }
    
    func registerClass(cellTypes: [UICollectionViewCell.Type]) {
        for item in cellTypes {
            let cellIdentifier = String(describing: item)
            register(item, forCellWithReuseIdentifier: cellIdentifier)
        }
    }
    
}
