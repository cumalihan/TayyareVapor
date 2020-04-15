import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    
    
    let acronymsController = AcronymsController()
    try router.register(collection: acronymsController)
    
    let airPlanesController = AirplaneController()
    try router.register(collection: airPlanesController)
    
    let airPortsController = AirPortsController()
    try router.register(collection: airPortsController)
    
    let airCompaniesController = AirCompaniesController()
    try router.register(collection: airCompaniesController)
    
    let citiesController = CitiesController()
    try router.register(collection: citiesController)
    
    let websiteController = WebsiteController()
    try router.register(collection: websiteController)
    
   
    
}

