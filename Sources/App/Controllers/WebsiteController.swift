import Vapor

struct WebsiteController: RouteCollection {
    func boot(router: Router) throws {
        router.get(use: indexHandler)
        
    }
    func indexHandler(_ req: Request) throws -> Future<View> {
        let context = IndexContext(title: "Homepage")
        return try req.view().render("index",context)
    }
}

struct IndexContext : Encodable {
    let title: String
}
