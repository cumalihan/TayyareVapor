
import FluentMySQL
import Vapor
import Foundation


final class Flight: Codable {
    var id: Int?
    var flightNumber: String
    var departureTime: String
    var arrivalTime: String
    var deparuteCountry: String
    var arrivalCountry: String
   
    
   
    init(flightNumber: String,departureTime: String,arrivalTime: String,deparuteCountry: String,arrivalCountry: String) {
        self.flightNumber = flightNumber
        self.departureTime = departureTime
        self.arrivalTime = arrivalTime
        self.deparuteCountry = deparuteCountry
        self.arrivalCountry = arrivalCountry
    }
    
}

extension Flight : MySQLModel {}
extension Flight : Content {}
extension Flight : Migration {}
extension Flight : Parameter {}

extension Flight {
    var airport: Children<Flight, AirPort> {
        return children(\.airPortID)
    }
}

