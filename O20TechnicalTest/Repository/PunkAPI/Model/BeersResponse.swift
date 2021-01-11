
struct BeersResponse: Decodable {
    let name: String
    let firstBrewed: String
    let image: String?
    let description: String
    let ingredients: BeerIngredients
    
    private enum CodingKeys: String, CodingKey {
        case name = "name"
        case firstBrewed = "first_brewed"
        case image = "image_url"
        case description = "description"
        case ingredients = "ingredients"
    }
}
