import Foundation
import RxSwift
import RxCocoa

final class RecipeModel: NavigationNode {

    let cellModels = BehaviorRelay(value: [CellModel]())
    private let downloader: RecipeDownloader
    private let storage: RecipeStorage
    private let disposeBag = DisposeBag()
    
    init(
        parent: NavigationNode,
        downloader: RecipeDownloader = RecipeDownloaderManager(),
        storage: RecipeStorage = RecipeStorageManager()
    ) {
        self.downloader = downloader
        self.storage = storage
        
        super.init(parent: parent)
        
    }

    private func prepareCellModels(recipe: Recipe) {
        let imageNameCellModel = ImageNameCellModel()
        imageNameCellModel.name.accept(recipe.title ?? "")
        imageNameCellModel.imageUrl.accept(recipe.image ?? "")

        let categories = [
            CategoryRecipe(
                name: L10n.vegetarian,
                status: recipe.vegetarian ?? false
            ),
            CategoryRecipe(
                name: L10n.vegan,
                status: recipe.vegan ?? false
            ),
            CategoryRecipe(
                name: L10n.glutenFree,
                status: recipe.glutenFree ?? false
            ),
            CategoryRecipe(
                name: L10n.dairyFree,
                status: recipe.dairyFree ?? false
            ),
            CategoryRecipe(
                name: L10n.veryHealthy,
                status: recipe.veryHealthy ?? false
            ),
            CategoryRecipe(
                name: L10n.cheap,
                status: recipe.cheap ?? false
            ),
            CategoryRecipe(
                name: L10n.veryPopular,
                status: recipe.veryPopular ?? false
            ),
            CategoryRecipe(
                name: L10n.sustainable,
                status: recipe.sustainable ?? false
            )
        ]
        
        let categoriesTableCellModel = CategoriesTableCellModel(parent: self, categories: categories)
        
        let timeButtonsCellModel = TimeButtonsCellModel()
        timeButtonsCellModel.time.accept(recipe.readyInMinutes ?? 0)
        
        let summaryCellModel = SummaryCellModel()
        summaryCellModel.summary.accept(recipe.summary ?? "")
        
        cellModels.accept([imageNameCellModel, categoriesTableCellModel, timeButtonsCellModel, summaryCellModel])
    }

    func getRandomRecipe() {
        downloader.loadingRandomRecipe().compactMap{ $0 }.subscribe(onNext: { [weak self] recipe in
            self?.prepareCellModels(recipe: recipe)
        }).disposed(by: self.disposeBag)
    }
    
    func saveFavouriteRecipe(_ recipe: RecipeSaveModel) {
        storage.saveRecipe(recipe)
    }
    
}
