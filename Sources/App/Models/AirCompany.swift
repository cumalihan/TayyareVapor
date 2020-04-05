import Foundation
import FluentSQLite
import Vapor

final class AirCompany: Codable {
    var id: UUID?
    var flightNumber: String
    var company: String
    var maxSeat: Int?
    
    
    init(flightNumber:String,company:String,maxSeat: Int) {
        self.flightNumber = flightNumber
        self.company = company
        self.maxSeat = maxSeat
    }
}


extension AirCompany: SQLiteUUIDModel {}
extension AirCompany : Content {}
extension AirCompany: Migration {}
extension AirCompany: Parameter {}
