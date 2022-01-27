import Foundation
import RealmSwift
import RxCocoa
import RxSwift

protocol RecipeStorage {
    
    func saveRecipe(_ recipe: RecipeSaveModel) -> Observable<Void>
    func getRecipe() -> Observable<[RecipeSaveModel]>
    
}

final class RecipeStorageManager: RecipeStorage {
    
    var results: Results<RecipeSaveModel>!
    
    func saveRecipe(_ recipe: RecipeSaveModel) -> Observable<Void> {
        return Observable.create { observer -> Disposable in
            do {
                let realm = try Realm()
                try realm.write {
                    realm.add(recipe)
                }
                observer.onNext(())
            } catch let error {
                observer.onError(error)
            }
            return Disposables.create()
        }
    }
    
    func getRecipe() -> Observable<[RecipeSaveModel]> {
        let realm = try! Realm()
        let objects = realm.objects(RecipeSaveModel.self)
        
        return Observable.create { observer -> Disposable in
            observer.onNext(Array(objects))
            
            return Disposables.create()
        }
    }
    
}
