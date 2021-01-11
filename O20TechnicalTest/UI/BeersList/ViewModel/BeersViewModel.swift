
class BeersViewModel {
    
    var localBeers: [Beers] = []
    
    func map(_ beers: [BeersResponse]) -> [Beers] {
        let beersMapped = beers.map { beer in
            Beers(name: beer.name,
                  firstBrewed: beer.firstBrewed,
                  image: beer.image,
                  description: beer.description,
                  malt: beer.ingredients.malt.map { $0.name },
                  hops: beer.ingredients.hops.map { $0.name })
        }
        
        beersMapped.forEach {
            if !self.localBeers.contains($0) {
             self.localBeers.append($0)
            }
        }
        return self.localBeers
    }
    
    func mapBeersFilter(_ beers: [BeersResponse]) -> [Beers] {
        beers.map { beer in
            Beers(name: beer.name,
                  firstBrewed: beer.firstBrewed,
                  image: beer.image,
                  description: beer.description,
                  malt: beer.ingredients.malt.map { $0.name },
                  hops: beer.ingredients.hops.map { $0.name })
        }
    }
}
