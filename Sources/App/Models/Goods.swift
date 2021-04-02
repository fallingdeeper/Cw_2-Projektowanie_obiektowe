import Fluent
import Vapor

final class Goods: Model, Content {
    static let schema = "goods"
    
    @ID(key: .id)
    var id: UUID?

    @Field(key: "name")
    var name: String

    @Field(key: "details")
    var details: String

    @Parent(key: "shop_id")
    var shop_id: Shop  

    init() { }

    init(id: UUID? = nil, shop_id: String, name: String, details: String) {
        self.id = id
        self.name = name
        self.details = details
    }
}
