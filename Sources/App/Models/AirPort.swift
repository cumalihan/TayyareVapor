
import FluentMySQL
import Vapor
import Foundation


final class AirPort: Codable {
    var id: Int?
    var airname: String
    var airPortID : AirPort.ID
    
    init(airname: String,airPortID: AirPort.ID) {
        self.airname = airname
        self.airPortID = airPortID
       
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
   var flight: Parent <AirPort, Flight> {
       return parent(\.airPortID)
   }

}
