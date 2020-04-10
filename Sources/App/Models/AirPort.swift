
import FluentMySQL
import Vapor
import Foundation


final class AirPort: Codable {
    var id: Int?
    var airname: String
    
    init(airname: String) {
        self.airname = airname
       
    }
    
    
}

extension AirPort: MySQLModel {}
extension AirPort : Content {}
extension AirPort: Migration {}
extension AirPort: Parameter {}


extension AirPort {
    
    var cities: Siblings<AirPort,City,AirPortCityPivot> {
        return siblings()
    }
    
    
}

