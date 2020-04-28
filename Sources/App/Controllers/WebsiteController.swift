import Vapor

struct WebsiteController: RouteCollection {
    func boot(router: Router) throws {
        router.get(use: indexHandler)
        router.get("airplanes",AirPlane.parameter, use: airplaneHandler)
        router.get("aircompanies",AirCompany.parameter,use: aircompanyHandler)
        router.get("aircompanies", use: allAircompanyHandler)
        router.get("cities", use: AllCityHandler)
        router.get("airplanes","create",use: createAirplaneHandler)
        router.post(AirPlane.self,at: "airplanes","create", use: createAirplanePostHandler)
        router.get("airplanes",AirPlane.parameter,"edit",use: editAirplaneHandler)
        router.post("airplanes",AirPlane.parameter,"edit", use: editAirplanePostHandler)
        
        
     
        
    }
    func indexHandler(_ req: Request) throws -> Future<View> {
        return AirPlane.query(on: req).all().flatMap(to: View.self) { airplanes in
            let context = IndexContext(title: "Homepage", airplanes: airplanes.isEmpty ? nil : airplanes)
            return try req.view().render("index",context)
        }
        
    }

   
    func airplaneHandler(_ req: Request) throws -> Future<View> {
        return try req.parameters.next(AirPlane.self).flatMap(to: View.self) { airplane in
            return airplane.aircompany.get(on: req).flatMap(to: View.self) { aircompany in
                let context = AirplaneContext(title: airplane.brand, airplane: airplane, aircompany: aircompany)
                return try req.view().render("airplanes",context)
            }
        }
    }
    func aircompanyHandler(_ req: Request) throws -> Future<View> {
        return try req.parameters.next(AirCompany.self).flatMap(to: View.self) { aircompany in
            let context = try AircompanyContext(title: aircompany.companyCountry, aircompany: aircompany, airplanes: aircompany.airplane.query(on: req).all())
            return try req.view().render("aircompany",context)
        }
        
    }
    func allAircompanyHandler(_ req: Request) throws -> Future<View> {
        let context = AllAircompanyContext(aircompanies: AirCompany.query(on: req).all())
        return try req.view().render("allAircompanies", context)
    }

    func createAirplaneHandler(_ req: Request) throws -> Future<View> {
        let context = CreateAirplaneContext(aircompanies: AirCompany.query(on: req).all())
        return try req.view().render("createAirplane", context)
    }
    func createAirplanePostHandler(_ req: Request, airplane: AirPlane) throws -> Future<Response> {
        return airplane.save(on: req).map(to: Response.self) { airplane in
            guard let id = airplane.id else {
                return req.redirect(to: "/")
            }
            return req.redirect(to: "/airplanes/\(id)")
            
        }
    }
    
    func editAirplaneHandler(_ req: Request) throws -> Future<View> {
        return try flatMap(to: View.self, req.parameters.next(AirPlane.self), AirCompany.query(on: req).all()) { airplane, aircompanies in
            let context = EditAirplaneContext(title: "Edit Airplane", airplane: airplane, aircompanies: aircompanies)
            return try req.view().render("createAirplane", context)
        }
    }
    
    func editAirplanePostHandler(_ req: Request) throws -> Future<Response> {
        return try req.parameters.next(AirPlane.self).flatMap(to: Response.self) { airplane in
            let updatedAirplane = try req.content.syncDecode(AirPlane.self)
            airplane.brand = updatedAirplane.brand
            airplane.detail = updatedAirplane.detail
            airplane.model = updatedAirplane.model
            airplane.aircompanyID = updatedAirplane.aircompanyID
            
            return airplane.save(on: req).map(to: Response.self) { savedAirplane in
                guard let id = savedAirplane.id else {
                    return req.redirect(to: "/")
                }
                return req.redirect(to: "/airplanes/\(id)")
            }
        }
    }
    
    func AllCityHandler(_ req: Request) throws -> Future<View> {
          let context = AllCityContext( cities : City.query(on: req).all())
          return try req.view().render("cities", context)
      }
   
    
}

struct IndexContext : Encodable {
    let title: String
    let airplanes: [AirPlane]?
    
}

struct AirplaneContext: Encodable {
    let title: String
    let airplane: AirPlane
    let aircompany: AirCompany
}

struct AircompanyContext : Encodable {
    let title: String
    let aircompany : AirCompany
    let airplanes : Future<[AirPlane]>
}

struct AllAircompanyContext : Encodable {
    let title = "All AirCompany"
    let aircompanies: Future<[AirCompany]>
}


struct CreateAirplaneContext: Encodable {
    let title = "Create An Airplane"
    let aircompanies : Future<[AirCompany]>
}

struct EditAirplaneContext: Encodable {
    let title: String
    let airplane: AirPlane
    let aircompanies : [AirCompany]
    let editing = true
}


struct AllCityContext : Encodable {
    let title = "All City"
    let cities: Future<[City]>
}
