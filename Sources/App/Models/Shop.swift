import Fluent
import Vapor

final class Shop: Model, Content {
    static let schema = "shops"
    
    @ID(key: .id)
    var id: UUID?

    @Field(key: "title")
    var title: String

    @Field(key: "description")
    var description: String

    @Field(key: "location")
    var location: String
    
    init() { }

    init(id: UUID? = nil, title: String, description: String, location:String) {
        self.id = id
        self.title = title
        self.description = description
	self.location = location
    }
}
