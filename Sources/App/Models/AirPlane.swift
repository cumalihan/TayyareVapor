import Foundation
import FluentMySQL
import Vapor

final class AirPlane: Codable {
    var id: Int?
    var brand: String
    var model: String
    var detail: String
    var aircompanyID : AirCompany.ID
    
    init(brand: String,model: String,detail: String,aircompanyID : AirCompany.ID) {
        self.brand = brand
        self.model = model
        self.detail = detail
        self.aircompanyID = aircompanyID
    }
}

extension AirPlane: MySQLModel {}
extension AirPlane: Content {}
extension AirPlane: Migration {}
extension AirPlane: Parameter {}


extension AirPlane {
    var aircompany: Parent <AirPlane, AirCompany> {
        return parent(\.aircompanyID)
    }
}
