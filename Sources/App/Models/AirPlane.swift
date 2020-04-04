import Foundation
import FluentSQLite
import Vapor

final class AirPlane: Codable {
    var id: UUID?
    var brand: String
    var model: String
    var detail: String
    
    init(brand: String,model: String,detail: String) {
        self.brand = brand
        self.model = model
        self.detail = detail
    }
}

extension AirPlane: SQLiteUUIDModel {}
extension AirPlane: Content {}
extension AirPlane: Migration {}
extension AirPlane: Parameter {}
