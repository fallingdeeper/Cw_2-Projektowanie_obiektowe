import Fluent

struct CreateCustomer: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("customers")
            .id()
            .field("c_name", .string, .required)
            .field("phone", .string, .required)
            .field("shop_id", .uuid, .required)
            .foreignKey("shop_id", references: Shop.schema, .id, onDelete: .cascade, onUpdate: .noAction)
            .create()
        
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("customers").delete()
    }
}
