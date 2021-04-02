import Fluent
import Vapor

struct ShopController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let shop = routes.grouped("shops")
        shop.get(use: index)
        shop.post(use: create)
        shop.group(":shopID") { shops in
            shops.delete(use: delete)
        }
    }

    func index(req: Request) throws -> EventLoopFuture<[Shop]> {
        return Shop.query(on: req.db).all()
    }

    func create(req: Request) throws -> EventLoopFuture<Shop> {
        let shops = try req.content.decode(Shop.self)
        return shops.save(on: req.db).map { shops }
    }

    func delete(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        return Shop.find(req.parameters.get("todoID"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { $0.delete(on: req.db) }
            .transform(to: .ok)
    }
}
