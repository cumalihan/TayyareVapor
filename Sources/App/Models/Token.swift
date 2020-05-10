import Foundation
import Vapor
import FluentMySQL
import Crypto


final class Token: Codable {
    var id: UUID?
    var token: String
    var airCompanyID: AirCompany.ID
    
    init(token: String,airCompanyID: AirCompany.ID) {
        self.token = token
        self.airCompanyID = airCompanyID
    }
}

extension Token: MySQLUUIDModel {}
extension Token: Content {}
extension Token: Migration {}

extension Token {
    var aircompany : Parent<Token, AirCompany> {
        return parent(\.airCompanyID)
        
    }
}

extension Token {
    static func generate(for aircompany: AirCompany) throws -> Token {
        let random = try CryptoRandom().generateData(count: 16)
        return try Token(token: random.base64URLEncodedString(),airCompanyID: aircompany.requireID())
    }
}
