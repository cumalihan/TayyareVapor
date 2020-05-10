import Vapor


struct AirplaneController: RouteCollection {
    func boot(router: Router) throws {
        let airplanesRoute = router.grouped("api","airplanes")
        airplanesRoute.get(use: getAllHandler)
        airplanesRoute.post(AirPlane.self, use: createHandler)
        airplanesRoute.get(AirPlane.parameter, use: getHandler)
        airplanesRoute.delete(AirPlane.parameter, use: deleteHandler)
        airplanesRoute.put(AirPlane.parameter, use: updateHandler)
        airplanesRoute.get(AirPlane.parameter,"aircompanies",use: getCompanyHandler)
    }
    
    
    func getAllHandler(_ req: Request) throws -> Future<[AirPlane]> {
        return AirPlane.query(on: req).all()
    }
    func createHandler(_ req: Request,airplane: AirPlane) throws -> Future<AirPlane> {
        return airplane.save(on: req)
    }
    func getHandler(_ req: Request) throws -> Future<AirPlane> {
        return try req.parameters.next(AirPlane.self)
    }
    func deleteHandler(_ req: Request) throws -> Future<HTTPStatus> {
        return try req.parameters.next(AirPlane.self).flatMap(to: HTTPStatus.self) { airplane in
            return airplane.delete(on: req).transform(to: .noContent)
        }
    }
    func updateHandler(_ req: Request) throws -> Future<AirPlane> {
        return try flatMap(to: AirPlane.self, req.parameters.next(AirPlane.self),req.content.decode(AirPlane.self)) { airplane, updatedAirplane in
            
            airplane.brand = updatedAirplane.brand
            airplane.detail = updatedAirplane.detail
            airplane.model = updatedAirplane.model
            return airplane.save(on: req)
   
        }
    }

    func getCompanyHandler(_ req: Request) throws -> Future<AirCompany.Public> {
        return try req.parameters.next(AirPlane.self).flatMap(to: AirCompany.Public.self) { airplane in
            return airplane.aircompany.get(on: req).convertToPublic()
            
        }
    }
    
    
    
}
