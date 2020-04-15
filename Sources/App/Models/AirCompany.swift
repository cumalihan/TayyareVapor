
import FluentMySQL
import Vapor

final class AirCompany: Codable {
    var id: UUID?
    var company: String
    var companyCountry: String
    var airPlaneCount: Int?
    
    
    init(company:String, companyCountry: String, airPlaneCount: Int) {
        self.company = company
        self.companyCountry = companyCountry
        self.airPlaneCount = airPlaneCount
        
    }
}


extension AirCompany: MySQLUUIDModel {}
extension AirCompany : Content {}
extension AirCompany: Migration {}
extension AirCompany: Parameter {}


extension AirCompany {
    var airplane: Children<AirCompany, AirPlane> {
        return children(\.aircompanyID)
    }
}
