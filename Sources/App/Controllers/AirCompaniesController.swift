import Vapor

struct AirCompaniesController: RouteCollection {
    func boot(router: Router) throws {
        let aircompaniesRoute = router.grouped("api","aircompanies")
        aircompaniesRoute.get(use: getAllHandler)
        aircompaniesRoute.post(AirCompany.self, use: createHandler)
        aircompaniesRoute.get(AirCompany.parameter, use: getHandler)
    
    }
    
    func getAllHandler(_ req: Request) throws -> Future<[AirCompany]> {
        return AirCompany.query(on: req).all()
    }
    func createHandler(_ req: Request, aircompany: AirCompany) throws -> Future<AirCompany> {
        return aircompany.save(on: req)
    }
    func getHandler(_ req: Request) throws -> Future<AirCompany> {
        return try req.parameters.next(AirCompany.self)
    }
    
    
  
}
