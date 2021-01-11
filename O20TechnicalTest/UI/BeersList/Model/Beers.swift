
struct Beers {
    let name: String
    let firstBrewed: String
    let image: String?
    let description: String
    let malt: [String]
    let hops: [String]
}

extension Beers: Equatable {
    static func == (lhs: Beers, rhs: Beers) -> Bool {
        return
            lhs.name == rhs.name &&
                lhs.firstBrewed == rhs.firstBrewed &&
                lhs.image == rhs.image &&
                lhs.description == rhs.description &&
                lhs.malt == rhs.malt &&
                lhs.hops == rhs.hops 
    }
}
