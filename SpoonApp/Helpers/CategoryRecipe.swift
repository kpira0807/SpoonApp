import Foundation

struct CategoryRecipe {
    
    let name: String
    let status: Bool
    
    init(name: String = "", status: Bool = false) {
      self.name = name
      self.status = status
    }
    
}

enum CategotiesName: String {
    
    case vegetarian = "Vegetarian"
    case vegan = "Vegan"
    case glutenFree = "Gluten Free"
    case dairyFree = "Dairy Free"
    case veryHealthy = "Very Healthy"
    case cheap = "Cheap"
    case veryPopular = "Very Popular"
    case sustainable = "Sustainable"
    
}


class CategoriesRandomRecipe {
    
    func categoriesNameStatusRecipe(recipe: Recipe) -> [CategoryRecipe] {
        let recipeCategories = [
            CategoryRecipe(name: CategotiesName.vegan.rawValue, status: recipe.vegan),
            CategoryRecipe(name: CategotiesName.vegetarian.rawValue, status: recipe.vegetarian),
            CategoryRecipe(name: CategotiesName.sustainable.rawValue, status: recipe.sustainable),
            CategoryRecipe(name: CategotiesName.veryPopular.rawValue, status: recipe.veryPopular),
            CategoryRecipe(name: CategotiesName.cheap.rawValue, status: recipe.cheap),
            CategoryRecipe(name: CategotiesName.veryHealthy.rawValue, status: recipe.veryHealthy),
            CategoryRecipe(name: CategotiesName.dairyFree.rawValue, status: recipe.dairyFree),
            CategoryRecipe(name: CategotiesName.glutenFree.rawValue, status: recipe.glutenFree)
        ]
        
        return recipeCategories
    }
    
}
