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
        todo.put(use: update)
        todo.group(":todoID"){todo in todo.delete(use:delete)}
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
    
    // PUT localhost:8080/todo
    func update(req: Request) throws -> EventLoopFuture<HTTPStatus>{
        let todo = try req.content.decode(Todo.self)
        return Todo.find(todo.id, on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap{
                $0.title = todo.title ?? $0.title
                $0.description = todo.description ?? $0.description
                $0.deleted = todo.deleted ?? $0.deleted
                $0.completed = todo.completed ?? $0.completed
                return $0.update(on:req.db).transform(to: .ok)
            }
    }
    
    // DELETE localhost:8080/todo/{id}
    func delete(req: Request) throws -> EventLoopFuture<HTTPStatus>{
        Todo.find(req.parameters.get("todoID"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap{$0.delete(on: req.db)}
            .transform(to: .ok)
    }
}
