import FluentMySQL
import Vapor
import Foundation

final class City: Codable {
    var id: Int?
    var cityName: String
    var cityCountry: String
    
    init(cityName: String,cityCountry: String) {
        self.cityName = cityName
        self.cityCountry = cityCountry
    }
    
}


extension City: MySQLModel {}
extension City: Content {}
extension City: Migration {}
extension City: Parameter {}


extension City {
    var airports : Siblings<City,AirPort,AirPortCityPivot> {
        return siblings()
    }
}
