import Foundation

class RecipeViewModel {
    
    private let model: RecipeModel
    
    init(model: RecipeModel) {
        self.model = model
    }
    
    var updateRecipeData: ((RecipesDetail) -> Void)?
    
    func userDidShake() {
        
        model.getRandomRecipe { recipe in
            self.updateRecipeData?(recipe)
        }
    }
}
