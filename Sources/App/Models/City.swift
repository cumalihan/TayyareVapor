import FluentSQLite
import Vapor


final class City: Codable {
    var id: Int?
    var cityName: String
    var cityCountry: String
    
    init(cityName: String,cityCountry: String) {
        self.cityName = cityName
        self.cityCountry = cityCountry
    }
    
}


extension City: SQLiteModel {}
extension City: Content {}
extension City: Migration {}
extension City: Parameter {}
