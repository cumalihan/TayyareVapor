
import FluentSQLite
import Vapor

final class AirCompany: Codable {
    var id: Int?
    var company: String
    var companyCountry: String
    var airPlaneCount: Int?
    
    
    init(company:String, companyCountry: String, airPlaneCount: Int) {
        self.company = company
        self.companyCountry = companyCountry
        self.airPlaneCount = airPlaneCount
        
    }
}


extension AirCompany:  SQLiteModel {}
extension AirCompany : Content {}
extension AirCompany: Migration {}
extension AirCompany: Parameter {}
