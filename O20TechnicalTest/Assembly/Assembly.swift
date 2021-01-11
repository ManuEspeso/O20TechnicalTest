
final class Assembly {
    fileprivate static let shared = Assembly()
}

var container: Assembly {
    .shared
}
