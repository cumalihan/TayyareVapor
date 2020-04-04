
import FluentSQLite
import Vapor


final class AirPort: Codable {
    var id: Int?
    var airname: String
    
    init(airname: String) {
        self.airname = airname
       
    }
    
    
}

extension AirPort: SQLiteModel {}
extension AirPort : Content {}
extension AirPort: Migration {}
extension AirPort: Parameter {}

