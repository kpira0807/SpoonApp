import Foundation
import RealmSwift
import RxCocoa
import RxSwift

protocol RecipeStorage {
    
    func saveRecipe(_ recipe: Recipe) -> Observable<Void>
    func getRecipe() -> Observable<[Recipe]>
    func deleteRecipe(_ recipe: Recipe) -> Observable<Void>
    
}

final class RecipeStorageManager: RecipeStorage {
    
    var results: Results<Recipe>!
    
    func saveRecipe(_ recipe: Recipe) -> Observable<Void> {
        Observable.create { observer -> Disposable in
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
    
    func deleteRecipe(_ recipe: Recipe) -> Observable<Void> {
        Observable.create { observer -> Disposable in
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
    
    func getRecipe() -> Observable<[Recipe]> {
        Observable.create { observer -> Disposable in
            do {
                let realm = try Realm()
                let objects = realm.objects(Recipe.self)
                observer.onNext(Array(objects))
            } catch let error {
                observer.onError(error)
            }
            return Disposables.create()
        }
    }
    
}
