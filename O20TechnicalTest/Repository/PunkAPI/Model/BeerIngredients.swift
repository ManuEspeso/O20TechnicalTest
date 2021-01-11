
struct BeerIngredients: Decodable {
    let malt: [BeerIngredientsName]
    let hops: [BeerIngredientsName]
}

struct BeerIngredientsName: Decodable {
    let name: String
}
