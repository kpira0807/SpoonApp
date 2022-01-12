import Foundation
import RealmSwift

protocol ReciperStorageProtocol {
    
    func saveRecipe(_ recipe: RecipeSaveModel)
    func getGivenRecipe() -> [RecipeSaveModel]
    
}

final class ReciperStorage: ReciperStorageProtocol {

    var results: Results<RecipeSaveModel>!
    
    func saveRecipe(_ recipe: RecipeSaveModel) {
        DispatchQueue.global(qos: .background).async {
            autoreleasepool {
                do {
                    let realm = try Realm()
                    try realm.write {
                        realm.add(recipe)
                        realm.refresh()
                    }
                } catch {
                    print("save Error")
                }
            }
        }
    }
    
    func getGivenRecipe() -> [RecipeSaveModel] {
        DispatchQueue(label: "background").sync {
            do {
                let realm = try Realm()
                let answers = realm.objects(RecipeSaveModel.self)
                realm.refresh()
                let arrayAnswers = Array(answers)
                
                return arrayAnswers
            } catch {
                print(L10n.errorAlert)
            }
            return []
        }
    }
    
}
