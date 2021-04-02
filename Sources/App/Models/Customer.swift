import Fluent
import Vapor

final class Customer: Model, Content {
    static let schema = "customers"
    
    @ID(key: .id)
    var id: UUID?

    @Field(key: "c_name")
    var c_name: String

    @Field(key: "phone")
    var phone: String

    @Parent(key: "shop_id")
    var shop_id: Shop

    init() { }

    init(id: UUID? = nil, c_name: String, phone: String) {
        self.id = id
        self.c_name = c_name
        self.phone = phone
    }
}
