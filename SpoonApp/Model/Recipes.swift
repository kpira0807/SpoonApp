import Foundation

struct RecipesDetail: Codable {
    
    var recipes: [Recipes]
    
}

struct Recipes: Codable {
    
    var vegetarian: Bool?
    var vegan: Bool?
    var glutenFree: Bool?
    var dairyFree: Bool?
    var veryHealthy: Bool?
    var cheap: Bool?
    var veryPopular: Bool?
    var sustainable: Bool?
    //  var weightWatcherSmartPoints: Int
    //    var gaps: String
    // var lowFodmap: Bool
    //    var aggregateLikes: Int
    //   var spoonacularScore: Int
    //var healthScore: Int
    var creditsText: String?
    //  var license: String
    var sourceName: String?
    //  var pricePerServing: Float
    var extendedIngredients: [ExtendedIngredients]
    var id: Int?
    var title: String?
    var readyInMinutes: Int?
    //  var servings: Int
    var image: String?
    //   var imageType: String
    var sourceUrl: String?
    var summary: String?
    //  var dishTypes: [String]
    //  var cuisines: [String]
    var instructions: String?
    
}

struct ExtendedIngredients: Codable {
    
    var id: Int?
    var aisle: String?
    var image: String?
    var consistency: String?
    var name: String?
    //   var nameClean: String
    var original: String?
    //   var originalString: String
    //  var originalName: String
    var amount: Double?
    var unit: String?
    var measures: Measures
    
}

struct Measures: Codable {
    
    var metric: Metric
    
}

struct Metric: Codable {
    
    var amount: Double?
    var unitShort: String?
    var unitLong: String?
    
}

