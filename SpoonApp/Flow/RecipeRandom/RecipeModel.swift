import Foundation

final class RecipeModel {

    private let downloader: ReciperDownloaderProtocol
    private let storage: ReciperStorageProtocol
    
    init(_ downloader: ReciperDownloaderProtocol = ReciperDownloader(),
         storage: ReciperStorageProtocol = ReciperStorage()) {
        self.downloader = downloader
        self.storage = storage
    }

    func getRandomRecipe(_ completion: @escaping (RecipesDetail) -> Void) {
        downloader.getResponseRecipe(success: { recipe in completion(recipe)
        })
    }
}
