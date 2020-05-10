
import FluentMySQL
import Vapor

final class AirCompany: Codable {
    var id: UUID?
    var company: String
    var companyCountry: String
    var airPlaneCount: Int?
    var password: String
    
    
    init(company:String, companyCountry: String, airPlaneCount: Int,password: String) {
        self.company = company
        self.companyCountry = companyCountry
        self.airPlaneCount = airPlaneCount
        self.password = password
        
    }
    
    final class Public: Codable {
        var id: UUID?
        var company: String
        var companyCountry: String
        init(id: UUID?,company: String,companyCountry: String) {
            self.id = id
            self.company = company
            self.companyCountry = companyCountry
        }
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


extension AirCompany.Public: Content {}

extension AirCompany {
    func convertToPublic() -> AirCompany.Public{
        return AirCompany.Public(id: self.id, company: self.company, companyCountry: self.companyCountry)
    }
}


extension Future where T: AirCompany {
    func convertToPublic() -> Future<AirCompany.Public> {
        return self.map(to: AirCompany.Public.self) { aircompany in
            return aircompany.convertToPublic()
            
        }
    }
}
