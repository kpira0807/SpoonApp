import Foundation
import RealmSwift

class RecipeSaveModel: Object {
    
    @objc dynamic var vegetarian: Bool = false
    @objc dynamic var vegan: Bool = false
    @objc dynamic var glutenFree: Bool = false
    @objc dynamic var dairyFree: Bool = false
    @objc dynamic var veryHealthy: Bool = false
    @objc dynamic var cheap: Bool = false
    @objc dynamic var veryPopular: Bool = false
    @objc dynamic var sustainable: Bool = false
    @objc dynamic var creditsText: String = ""
    @objc dynamic var sourceName: String = ""
    @objc dynamic var id: Int = 0
    @objc dynamic var title: String = ""
    @objc dynamic var readyInMinutes: Int = 0
    @objc dynamic var image: String = ""
    @objc dynamic var sourceUrl: String = ""
    @objc dynamic var summary: String = ""
    @objc dynamic var instructions: String = ""

    var extendedIngredients = List<ExtendedIngredient>()
    
}

class ExtendedIngredient: Object {
    
    @objc dynamic var  id: Int = 0
    @objc dynamic var  aisle: String = ""
    @objc dynamic var  image: String = ""
    @objc dynamic var  consistency: String = ""
    @objc dynamic var  name: String = ""
    @objc dynamic var  original: String = ""
    @objc dynamic var  amount: Double = 0.0
    @objc dynamic var  unit: String = ""
    
    var  measures = List<Measure>()
    
}

class Measure: Object {
    
    var metric = List<Metrics>()
}

class Metrics: Object {
    
    @objc dynamic var amount: Double = 0.0
    @objc dynamic var unitShort: String = ""
    @objc dynamic var unitLong: String = ""
}

