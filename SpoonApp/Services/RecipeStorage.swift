import Foundation
import RealmSwift

protocol RecipeStorage {
    
    func saveRecipe(_ recipe: RecipeSaveModel)
    func fetchRecipe(completion: @escaping (_ recipeArray: [RecipeSaveModel]?) -> Void)

}

final class RecipeStorageManager: RecipeStorage {

    var results: Results<RecipeSaveModel>!
    
    func saveRecipe(_ recipe: RecipeSaveModel) {
        DispatchQueue.global(qos: .background).async {
            autoreleasepool {
                do {
                    let realm = try Realm()
                    try realm.write {
                        realm.add(recipe)
                    }
                } catch {
                    print("save Error")
                }
            }
        }
    }

    func fetchRecipe(completion: @escaping (_ recipeArray: [RecipeSaveModel]?) -> Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                let realm = try Realm()
                let recipeArray = realm.objects(RecipeSaveModel.self)
                completion(Array(recipeArray))
            } catch {
                print("fetchRecipe error")
            }
        }
    }
    
}
