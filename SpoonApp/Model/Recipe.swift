import Foundation
import RealmSwift

struct RecipeJSON: Codable {
    
    var recipes: [Recipe]
    
}

final class Recipe: Object, Codable {
    
    @objc dynamic var isVegetarian: Bool = false
    @objc dynamic var isVegan: Bool = false
    @objc dynamic var isGlutenFree: Bool = false
    @objc dynamic var isDairyFree: Bool = false
    @objc dynamic var isVeryHealthy: Bool = false
    @objc dynamic var isCheap: Bool = false
    @objc dynamic var isVeryPopular: Bool = false
    @objc dynamic var isSustainable: Bool = false
    @objc dynamic var creditsText: String = ""
    @objc dynamic var sourceName: String = ""
    @objc dynamic var id: Int = 0
    @objc dynamic var title: String = ""
    @objc dynamic var readyInMinutes: Int = 0
    @objc dynamic var image: String = ""
    @objc dynamic var sourceUrl: String = ""
    @objc dynamic var summary: String = ""
    @objc dynamic var instructions: String = ""
    
    var extendedIngredients = List<ExtendedIngredients>()
    
    private enum CodingKeys: String, CodingKey {
        
        case isVegetarian = "vegetarian"
        case isVegan = "vegan"
        case isGlutenFree = "glutenFree"
        case isDairyFree = "dairyFree"
        case isVeryHealthy = "veryHealthy"
        case isCheap = "cheap"
        case isVeryPopular = "veryPopular"
        case isSustainable = "sustainable"
        case creditsText
        case sourceName
        case id
        case title
        case readyInMinutes
        case image
        case sourceUrl
        case summary
        case instructions
        case extendedIngredients
        
    }
    
    public required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.isVegetarian = try container.decode(Bool.self, forKey: .isVegetarian)
        self.isVegan = try container.decode(Bool.self, forKey: .isVegan)
        self.isGlutenFree = try container.decode(Bool.self, forKey: .isGlutenFree)
        self.isDairyFree = try container.decode(Bool.self, forKey: .isDairyFree)
        self.isVeryHealthy = try container.decode(Bool.self, forKey: .isVeryHealthy)
        self.isCheap = try container.decode(Bool.self, forKey: .isCheap)
        self.isVeryPopular = try container.decode(Bool.self, forKey: .isVeryPopular)
        self.isSustainable = try container.decode(Bool.self, forKey: .isSustainable)
        self.creditsText = try container.decode(String.self, forKey: .creditsText)
        self.sourceName = try container.decode(String.self, forKey: .sourceName)
        self.id = try container.decode(Int.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        self.readyInMinutes = try container.decode(Int.self, forKey: .readyInMinutes)
        self.image = try container.decode(String.self, forKey: .image)
        self.sourceUrl = try container.decode(String.self, forKey: .sourceUrl)
        self.summary = try container.decode(String.self, forKey: .summary)
        self.instructions = try container.decode(String.self, forKey: .instructions)
        
        let extendedIngredient = try container.decode([ExtendedIngredients].self, forKey: .extendedIngredients)
        self.extendedIngredients.append(objectsIn: extendedIngredient)
    }
}

final class ExtendedIngredients: Object, Codable {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var aisle: String = ""
    @objc dynamic var image: String = ""
    @objc dynamic var consistency: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var original: String = ""
    @objc dynamic var amount: Double = 0.0
    @objc dynamic var unit: String = ""
    
    @objc dynamic var measures: Measures?
    
    private enum CodingKeys: String, CodingKey {
        
        case id
        case aisle
        case image
        case consistency
        case name
        case original
        case amount
        case unit
        case measures
        
    }
    
    public required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.aisle = try container.decode(String.self, forKey: .aisle)
        self.image = try container.decode(String.self, forKey: .image)
        self.consistency = try container.decode(String.self, forKey: .consistency)
        self.name = try container.decode(String.self, forKey: .name)
        self.original = try container.decode(String.self, forKey: .original)
        self.amount = try container.decode(Double.self, forKey: .amount)
        self.unit = try container.decode(String.self, forKey: .unit)
        self.measures = try container.decode(Measures.self, forKey: .measures)
    }
    
}

final class Measures: Object, Codable {
    
    @objc dynamic var metric: Metric?
    
    private enum CodingKeys: String, CodingKey {
        
        case metric
        
    }
    
    public required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.metric = try container.decode(Metric.self, forKey: .metric)
    }
    
}

final class Metric: Object, Codable {
    
    @objc dynamic var amount: Double = 0.0
    @objc dynamic var unitShort: String = ""
    @objc dynamic var unitLong: String = ""
    
    private enum CodingKeys: String, CodingKey {
        
        case amount
        case unitShort
        case unitLong
        
    }
    
    public required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.amount = try container.decode(Double.self, forKey: .amount)
        self.unitShort = try container.decode(String.self, forKey: .unitShort)
        self.unitLong = try container.decode(String.self, forKey: .unitLong)
    }
    
}


extension CategoriesName {
    
    func statusForRecipe(_ recipe: Recipe) -> Bool {
        switch self {
        case .vegetarian:
            return recipe.isVegetarian
        case .vegan:
            return recipe.isVegan
        case .glutenFree:
            return recipe.isGlutenFree
        case .dairyFree:
            return recipe.isDairyFree
        case .veryHealthy:
            return recipe.isVeryHealthy
        case .cheap:
            return recipe.isCheap
        case .veryPopular:
            return recipe.isVeryPopular
        case .sustainable:
            return recipe.isSustainable
        }
    }
    
}
