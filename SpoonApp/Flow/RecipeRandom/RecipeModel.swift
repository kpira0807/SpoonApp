import Foundation
import RxSwift
import RxCocoa

final class RecipeModel: NavigationNode {
    
    let cellModels = BehaviorRelay(value: [CellModel]())
    private let downloader: ProtocolRecipeDownloader
    private let storage: ProtocolRecipeStorage
    private let disposeBag = DisposeBag()
    
    init(
        parent: NavigationNode,
        downloader: ProtocolRecipeDownloader = RecipeDownloaderManager(),
        storage: ProtocolRecipeStorage = RecipeStorageManager()
    ) {
        self.downloader = downloader
        self.storage = storage
        
        super.init(parent: parent)

    }
    
    private func prepareCellModels(recipt: Recipe) {
        let imageNameCellModel = ImageNameCellModel.init(name: recipt.title ?? "", imageUrl: recipt.image ?? "")
        let categoriesTableCellModel = CategoriesTableCellModel(parent: self)
        let timeButtonsCellModel = TimeButtonsCellModel.init(time: "\(recipt.readyInMinutes ?? 0) minutes")
        let summaryCellModel = SummaryCellModel.init(summary: recipt.summary ?? "")

        cellModels.accept([imageNameCellModel, categoriesTableCellModel, timeButtonsCellModel, summaryCellModel])
    }
    
    func getRandomRecipe() {
        downloader.getResponseRandomRecipe().compactMap{$0}.subscribe(onNext: { [weak self] recept in
            self?.prepareCellModels(recipt: recept)
        }).disposed(by: self.disposeBag)
    }
    
    func saveFavouriteRecipe(_ recipe: RecipeSaveModel) {
        storage.saveRecipe(recipe)
    }

}
