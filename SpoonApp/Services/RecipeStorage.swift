import Foundation
import RealmSwift
import RxCocoa
import RxSwift

protocol RecipeStorage {
    
    func saveRecipe(_ recipe: RecipeSaveModel) -> Observable<Void>
    func getRecipe() -> Observable<[RecipeSaveModel]>
    func deleteRecipe(_ recipe: RecipeSaveModel) -> Observable<Void>
    
}

final class RecipeStorageManager: RecipeStorage {
    
    var results: Results<RecipeSaveModel>!
    
    func saveRecipe(_ recipe: RecipeSaveModel) -> Observable<Void> {
        return Observable.create { observer -> Disposable in
            do {
                let realm = try Realm()
                try realm.write {
                    realm.add(recipe)
                    print("RECIPE -- \(recipe)")
                }
                observer.onNext(())
            } catch let error {
                observer.onError(error)
            }
            return Disposables.create()
        }
    }
    
    func deleteRecipe(_ recipe: RecipeSaveModel) -> Observable<Void> {
        return Observable.create { observer -> Disposable in
            do {
                let realm = try Realm()
                realm.delete(recipe)
                observer.onNext(())
            } catch let error {
                observer.onError(error)
            }
            return Disposables.create()
        }
    }
    
    func getRecipe() -> Observable<[RecipeSaveModel]> {
        return Observable.create { observer -> Disposable in
            do {
                let realm = try Realm()
                let objects = realm.objects(RecipeSaveModel.self)
                observer.onNext(Array(objects))
            } catch let error {
                observer.onError(error)
            }
            return Disposables.create()
        }
    }
    
}
