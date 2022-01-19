import Foundation
import RxSwift
import RxCocoa

final class RecipeModel: NavigationNode {
    
    let cellModels = BehaviorRelay(value: [CellModel]())
    private let downloader: ReciperDownloaderProtocol
    private let storage: ReciperStorageProtocol
    private let disposeBag = DisposeBag()
    
    init(parent: NavigationNode,
         downloader: ReciperDownloaderProtocol = ReciperDownloader(),
         storage: ReciperStorageProtocol = ReciperStorage()
    ) {
        self.downloader = downloader
        self.storage = storage
        
        super.init(parent: parent)
        
        prepareCellModels()
    }
    
    private func prepareCellModels() {
        let imageNameCellModel = ImageNameCellModel()
        let categoriesTableCellModel = CategoriesTableCellModel()
        let timeButtonsCellModel = TimeButtonsCellModel()
        let summuryCellModel = SummuryCellModel()
        
        cellModels.accept([imageNameCellModel, categoriesTableCellModel, timeButtonsCellModel, summuryCellModel])
    }
    
    func getRandomRecipe() -> Observable<RecipesDetail?> {
        
        return Observable.create { observer in
            self.downloader.getResponseRecipe()
                .subscribe { recipe in
                    if let answer = recipe {
                        observer.onNext(answer)
                      
                        print("ANSWER -- \(answer)")
                    }
                } onError: { error in
                    print(error)
                } .disposed(by: self.disposeBag)
            
            return Disposables.create()
        }
    }
   
    func saveFavouriteRecipe(_ recipe: RecipeSaveModel) {
        storage.saveRecipe(recipe)
    }
    
    func detailButton() -> UIViewController {
        let vc = DetailsRecipeInformationViewController(DetailsRecipeInformationViewModel(model: DetailsRecipeInformationModel(parent: self)))
        
        return vc
    }
    
}
