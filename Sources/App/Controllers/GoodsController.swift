import Fluent
import Vapor

struct GoodsController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let good = routes.grouped("goods")
        good.get(use: index)
        good.post(use: create)
        good.group(":goodID") { goods in
            goods.delete(use: delete)
        }
    }

    func index(req: Request) throws -> EventLoopFuture<[Goods]> {
        return Goods.query(on: req.db).all()
    }

    func create(req: Request) throws -> EventLoopFuture<Goods> {
        let goods = try req.content.decode(Goods.self)
        return goods.save(on: req.db).map { goods }
    }

    func delete(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        return Goods.find(req.parameters.get("todoID"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { $0.delete(on: req.db) }
            .transform(to: .ok)
    }
}
