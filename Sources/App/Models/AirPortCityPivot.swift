import FluentSQLite
import Vapor
import Foundation

final class AirPortCityPivot : SQLiteUUIDPivot {
    var id: UUID?
    var airportID: AirPort.ID
    var cityID: City.ID
    
    typealias Left = AirPort
    typealias Right = City
    
    static var leftIDKey: LeftIDKey = \AirPortCityPivot.airportID
    static var rightIDKey: RightIDKey = \AirPortCityPivot.cityID
    
    init(_ airportID: AirPort.ID,_ cityID: City.ID) {
        self.airportID = cityID
        self.cityID = airportID
    }
    
}


extension AirPortCityPivot: Migration {}
