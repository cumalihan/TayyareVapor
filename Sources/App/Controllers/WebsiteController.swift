import Vapor

struct WebsiteController: RouteCollection {
    func boot(router: Router) throws {
        router.get(use: indexHandler)
        
        router.get("airplanes",AirPlane.parameter, use: airplaneHandler)
        
        
     
        
    }
    func indexHandler(_ req: Request) throws -> Future<View> {
        return AirPlane.query(on: req).all().flatMap(to: View.self) { airplanes in
            let context = IndexContext(title: "Homepage", airplanes: airplanes.isEmpty ? nil : airplanes)
            return try req.view().render("index",context)
        }
        
    }
//    func airportHandler(_ req: Request) throws -> Future<View> {
//        return AirPort.query(on: req).all().flatMap(to: View.self) { airport in
//            let context = AirportContext(title: "Airports", airport: airport.isEmpty ? nil : airport)
//            return try req.view().render("airports",context)
//            
//        }
//    }
   
    func airplaneHandler(_ req: Request) throws -> Future<View> {
        return try req.parameters.next(AirPlane.self).flatMap(to: View.self) { airplane in
            return airplane.aircompany.get(on: req).flatMap(to: View.self) { aircompany in
                let context = AirplaneContext(title: airplane.brand, airplane: airplane, aircompany: aircompany)
                return try req.view().render("airplanes",context)
            }
        }
    }
    
}

struct IndexContext : Encodable {
    let title: String
    let airplanes: [AirPlane]?
    
}


//struct AirportContext : Encodable {
//    let title: String
//    let airport: [AirPort]?
//}

struct AirplaneContext: Encodable {
    let title: String
    let airplane: AirPlane
    let aircompany: AirCompany
}



