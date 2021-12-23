import Foundation

protocol ReciperStorageProtocol {
    func saveRecipe(_ recipe: [Recipes])
    func getRecipe() -> [Recipes]?
}

final class ReciperStorage: ReciperStorageProtocol {
    
    private let userDefaultsAnswerKey = "recipe"
    
    func saveRecipe(_ recipe: [Recipes]) {
        UserDefaults.standard.set(recipe, forKey: userDefaultsAnswerKey)
    }
    
    func getRecipe() -> [Recipes]? {
        guard let recipe = UserDefaults.standard.array(forKey: userDefaultsAnswerKey) as? [Recipes] else {
            return nil
        }
        print("recipe \(recipe)")
        return recipe
    }
}
