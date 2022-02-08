import Foundation

struct CategoryRecipe {
    
    let name: String
    let status: Bool
    
    init(name: String = "", status: Bool = false) {
        self.name = name
        self.status = status
    }
    
}

enum CategotiesName: String, CaseIterable {
    
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
        let recipeCategories = CategotiesName.allCases.map { CategoryRecipe(name: $0.rawValue, status: $0.statusForRecipe(recipe)) }
        
        return recipeCategories
    }
    
}
