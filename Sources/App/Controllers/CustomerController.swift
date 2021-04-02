import Fluent
import Vapor

struct CustomerController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let customer = routes.grouped("customers")
        customer.get(use: index)
        customer.post(use: create)
        customer.group(":customerID") { customers in
            customers.delete(use: delete)
        }
    }

    func index(req: Request) throws -> EventLoopFuture<[Customer]> {
        return Customer.query(on: req.db).all()
    }

    func create(req: Request) throws -> EventLoopFuture<Customer> {
        let customers = try req.content.decode(Customer.self)
        return customers.save(on: req.db).map { customers }
    }

    func delete(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        return Customer.find(req.parameters.get("todoID"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { $0.delete(on: req.db) }
            .transform(to: .ok)
    }
}
