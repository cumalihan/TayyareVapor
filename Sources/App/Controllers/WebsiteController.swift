import Vapor

struct WebsiteController: RouteCollection {
    func boot(router: Router) throws {
        router.get(use: indexHandler)
        router.get("/airports",use: airportHandler)
        
        
        
     
        
    }
    func indexHandler(_ req: Request) throws -> Future<View> {
        return City.query(on: req).all().flatMap(to: View.self) { cities in
            let context = IndexContext(title: "Homepage",cities: cities.isEmpty ? nil : cities)
            return try req.view().render("index",context)
        }
        
    }
    func airportHandler(_ req: Request) throws -> Future<View> {
        return AirPort.query(on: req).all().flatMap(to: View.self) { airport in
            let context = AirportContext(title: "Airports", airport: airport.isEmpty ? nil : airport)
            return try req.view().render("airports",context)
            
        }
    }
    
}

struct IndexContext : Encodable {
    let title: String
    let cities: [City]?
    
}


struct AirportContext : Encodable {
    let title: String
    let airport: [AirPort]?
}



