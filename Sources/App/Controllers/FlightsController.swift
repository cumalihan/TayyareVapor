import Vapor


struct FlightsController: RouteCollection {
    func boot(router: Router) throws {
        let flightsRoute = router.grouped("api","flights")
        flightsRoute.get(use: getAllHandler)
        flightsRoute.post(Flight.self, use: createHandler)
        flightsRoute.get(Flight.parameter, use: getHandler)
        flightsRoute.delete(Flight.parameter, use: deleteHandler)
      
    }
    
    
    func getAllHandler(_ req: Request) throws -> Future<[Flight]> {
        return Flight.query(on: req).all()
    }
    func createHandler(_ req: Request,flight: Flight) throws -> Future<Flight> {
        return flight.save(on: req)
    }
    func getHandler(_ req: Request) throws -> Future<Flight> {
        return try req.parameters.next(Flight.self)
    }
    func deleteHandler(_ req: Request) throws -> Future<HTTPStatus> {
        return try req.parameters.next(Flight.self).flatMap(to:HTTPStatus.self) { flight in return flight.delete(on: req).transform(to: .noContent)
            
        }
    }
     
    
    
}
