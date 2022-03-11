import Foundation
import RealmSwift

struct RecipeJSON: Codable {
    
    var recipes: [Recipe]
    
}

final class Recipe: Object, Codable {
    
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
    
    var extendedIngredients = List<ExtendedIngredients>()

    private enum CodingKeys: String, CodingKey {
        
        case vegetarian
        case vegan
        case glutenFree
        case dairyFree
        case veryHealthy
        case cheap
        case veryPopular
        case sustainable
        case creditsText
        case sourceName
        case id
        case title
        case readyInMinutes
        case image
        case sourceUrl
        case summary
        case instructions
        case extendedIngredients = "extendedIngredients"
        
    }
    
    public required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.vegetarian = try container.decode(Bool.self, forKey: .vegetarian)
        self.vegan = try container.decode(Bool.self, forKey: .vegan)
        self.glutenFree = try container.decode(Bool.self, forKey: .glutenFree)
        self.dairyFree = try container.decode(Bool.self, forKey: .dairyFree)
        self.veryHealthy = try container.decode(Bool.self, forKey: .veryHealthy)
        self.cheap = try container.decode(Bool.self, forKey: .cheap)
        self.veryPopular = try container.decode(Bool.self, forKey: .veryPopular)
        self.sustainable = try container.decode(Bool.self, forKey: .sustainable)
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
        case measures = "measures"
        
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
        
       case metric = "metric"
        
    }
    
    public required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.metric = try container.decode(Metric.self, forKey: .metric)
     //   self.metric.append(objectsIn: metrics)
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
