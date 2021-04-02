import Fluent

struct CreateGoods: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("goods")
            .id()
            .field("name", .string, .required)
            .field("details", .string, .required)
            .field("shop_id", .uuid, .required)
            .foreignKey("shop_id", references: Shop.schema, .id, onDelete: .cascade, onUpdate: .noAction)
            .create()
        
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("goods").delete()
    }
}
