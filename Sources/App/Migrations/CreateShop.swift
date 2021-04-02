import Fluent

struct CreateShop: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("shops")
            .id()
            .field("title", .string, .required)
            .field("description", .string, .required)
            .field("location", .string, .required)
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("shops").delete()
    }
}
