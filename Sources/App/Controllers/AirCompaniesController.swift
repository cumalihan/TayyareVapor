import Vapor
import Crypto

struct AirCompaniesController: RouteCollection {
    func boot(router: Router) throws {
        let aircompaniesRoute = router.grouped("api","aircompanies")
        aircompaniesRoute.get(use: getAllHandler)
        aircompaniesRoute.post(AirCompany.self,use: createHandler)
        aircompaniesRoute.get(AirCompany.parameter, use: getHandler)
        aircompaniesRoute.delete(AirCompany.parameter, use: deleteHandler)
        aircompaniesRoute.get(AirCompany.parameter,"airplanes",use: getPlaneHandler)
        
    }
    
    func getAllHandler(_ req: Request) throws -> Future<[AirCompany.Public]> {
        return AirCompany.query(on: req).decode(data: AirCompany.Public.self).all()
    }
    func createHandler(_ req: Request,aircompany: AirCompany) throws -> Future<AirCompany.Public> {
        aircompany.password = try BCrypt.hash(aircompany.password)
        return aircompany.save(on: req).convertToPublic()
    }
    
    func getHandler(_ req: Request) throws -> Future<AirCompany.Public> {
        return try req.parameters.next(AirCompany.self).convertToPublic()
    }
    func deleteHandler(_ req: Request) throws -> Future<HTTPStatus> {
        return try req.parameters.next(AirCompany.self).flatMap(to: HTTPStatus.self) { aircompany in
            return aircompany.delete(on: req).transform(to: .noContent)
            
        }
    }
    func getPlaneHandler(_ req: Request) throws -> Future<[AirPlane]> {
        return try req.parameters.next(AirCompany.self).flatMap(to: [AirPlane].self) { aircompany in
            return try aircompany.airplane.query(on: req).all()
        }
    }
    
  
}
