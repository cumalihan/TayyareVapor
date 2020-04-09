import Vapor


struct CitiesController: RouteCollection {
    func boot(router: Router) throws {
        let citiesRoute = router.grouped("api","cities")
        citiesRoute.get(use: getAllHandler)
        citiesRoute.post(City.self, use: createHandler)
        citiesRoute.get(City.parameter, use: getHandler)
        citiesRoute.delete(City.parameter, use: deleteHandler)
        citiesRoute.get(City.parameter,"airports", use: getAirPortsHandler)
    }
    
    
    func getAllHandler(_ req: Request) throws -> Future<[City]> {
        return City.query(on: req).all()
    }
    func createHandler(_ req: Request,city: City) throws -> Future<City> {
        return city.save(on: req)
    }
    func getHandler(_ req: Request) throws -> Future<City> {
        return try req.parameters.next(City.self)
    }
    func deleteHandler(_ req: Request) throws -> Future<HTTPStatus> {
        return try req.parameters.next(City.self).flatMap(to:HTTPStatus.self) { city in return city.delete(on: req).transform(to: .noContent)
            
        }
    }
    func getAirPortsHandler(_ req: Request) throws -> Future<[AirPort]> {
        return try req.parameters.next(City.self).flatMap(to: [AirPort].self) { city in
            return try city.airports.query(on: req).all()
            
        }
    }
}
