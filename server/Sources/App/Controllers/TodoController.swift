//
//  TodoController.swift
//  
//
//  Created by Martin Peth on 20.06.22.
//

import Vapor
import Fluent

struct TodoController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        //eq. to an init() function
        let todo = routes.grouped("todo")
        todo.get(use: index)
        todo.post(use: create)
    }

    // GET localhost:8080/todo
    func index(req: Request) throws -> EventLoopFuture<[Todo]> {
        return Todo.query(on: req.db).all()
    }
    
    // POST localhost:8080/todo
    func create(req: Request) throws -> EventLoopFuture<HTTPStatus>{
        let todo = try req.content.decode(Todo.self)
        return todo.save(on: req.db).transform(to: .ok)
    }
}
