import Vapor


struct AirPortsController: RouteCollection {
    func boot(router: Router) throws {
        let airportsRoute = router.grouped("api","airports")
        airportsRoute.get(use:getAllHandler)
        airportsRoute.post(AirPort.self, use: createHandler)
        airportsRoute.get(AirPort.parameter, use: getHandler)
        airportsRoute.delete(AirPort.parameter, use: deleteHandler)
        airportsRoute.put(AirPort.parameter, use: updateHandler)
    }
    func getAllHandler(_ req: Request) throws -> Future<[AirPort]> {
        return AirPort.query(on: req).all()
    }
    func createHandler(_ req: Request,airport: AirPort) throws -> Future<AirPort> {
        return airport.save(on: req)
    }
    func getHandler(_ req: Request) throws -> Future<AirPort> {
        return try req.parameters.next(AirPort.self)
    }
    func deleteHandler(_ req: Request) throws -> Future<HTTPStatus> {
        return try req.parameters.next(AirPort.self).flatMap(to: HTTPStatus.self) { airport in
            return airport.delete(on: req).transform(to: .noContent)
        }
    }
    func updateHandler(_ req: Request) throws -> Future<AirPort> {
        return try flatMap(to: AirPort.self, req.parameters.next(AirPort.self),req.content.decode(AirPort.self)) { airport, updatedAirport in
            airport.airname = updatedAirport.airname
            
            return airport.save(on: req)
        }
    }
}
