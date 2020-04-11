import Vapor

struct WebsiteController: RouteCollection {
    func boot(router: Router) throws {
        router.get(use: indexHandler)
        
    }
    func indexHandler(_ req: Request) throws -> Future<View> {
        return City.query(on: req).all().flatMap(to: View.self) { cities in
            let context = IndexContext(title: "Homepage",cities: cities.isEmpty ? nil : cities)
            return try req.view().render("index",context)
        }
        
    }
}

struct IndexContext : Encodable {
    let title: String
    let cities: [City]?
}
