import Foundation
import RxSwift
import RxCocoa

final class RecipeModel: NavigationNode {
    
    let categories = CategoriesRandomRecipe()
    let loadRandomRecipe = PublishSubject<Void>()
    let cellModels = BehaviorRelay(value: [CellModel]())
    let detailButtonAction = PublishSubject<Void>()
    let saveAction = PublishSubject<Void>()
    let deleteAction = PublishSubject<Void>()
    private let downloader: RecipeDownloader
    private let storage: RecipeStorage
    private let disposeBag = DisposeBag()
    private let recipe = BehaviorRelay(value: Recipe())
    
    init(
        parent: NavigationNode,
        downloader: RecipeDownloader = RecipeDownloaderManager(),
        storage: RecipeStorage = RecipeStorageManager()
    ) {
        self.downloader = downloader
        self.storage = storage
        
        super.init(parent: parent)
        
        initializeBindings()
    }
    
    private func initializeBindings() {
        loadRandomRecipe.subscribe(onNext: { [weak self] in
            self?.getRandomRecipe()
        }).disposed(by: disposeBag)
        
        detailButtonAction.subscribe(onNext: { [weak self] in
            self?.raise(event: RecipeEvent.openDetailRandomRecipe)
        }).disposed(by: disposeBag)
        
        saveAction.withLatestFrom(recipe)
            .subscribe(onNext: { [weak self] recipe in
                guard let self = self else { return }
                
                self.saveToFavouriteRecipe(recipe)
            }).disposed(by: disposeBag)

        deleteAction.withLatestFrom(recipe)
            .subscribe(onNext: { [weak self] recipe in
                guard let self = self else { return }
                
                self.deleteFavouriteRecipe(recipe)
            }).disposed(by: disposeBag)
    }
    
    private func prepareCellModels(recipe: Recipe) {
        let imageNameCellModel = ImageNameCellModel()
        imageNameCellModel.name.accept(recipe.title)
        imageNameCellModel.imageStringUrl.accept(recipe.image)
        
        let categoriesTableCellModel = CategoriesTableCellModel(categories: categories.categoriesNameStatusRecipe(recipe: recipe))
        
        let timeButtonsCellModel = TimeButtonsCellModel()
        timeButtonsCellModel.time.accept(recipe.readyInMinutes)
        
        let summaryCellModel = SummaryCellModel()
        summaryCellModel.summary.accept(recipe.summary)
        
        cellModels.accept([imageNameCellModel, categoriesTableCellModel, timeButtonsCellModel, summaryCellModel])
    }
    
    func getRandomRecipe() {
        downloader.fetchRandomRecipe().compactMap{ $0 }.subscribe(onNext: { [weak self] recipe in
            self?.prepareCellModels(recipe: recipe)
        }).disposed(by: disposeBag)
    }
    
    func saveToFavouriteRecipe(_ recipe: Recipe) {
        storage.saveRecipe(recipe).subscribe()
            .disposed(by: disposeBag)
    }
    
    func deleteFavouriteRecipe(_ recipe: Recipe) {
        storage.deleteRecipe(recipe).subscribe()
            .disposed(by: disposeBag)
    }
    
}
