//
//  AddUpdateTodoViewModel.swift
//  Todo-App
//
//  Created by Martin Peth on 20.06.22.
//

import SwiftUI

final class AddUpdateTodoViewModel: ObservableObject {
    @Published
    var todoTitle = ""
    
    @Published
    var todoDescription = ""
   
    @Published
    var todoDeleted = false
    
    @Published
    var todoCompleted = false
    
    var todoCreatedAt = ""
    var todoCompletedAt = ""
    var todoModifiedAt = ""
    
    var todoID: UUID?
    
    var isUpdating: Bool {
        todoID != nil
    }
    
    var buttonText: String {
        todoID != nil ? "Aktualisieren" : "Hinzufügen" 
    }
    
    init() {}
    
    init(currentTodo: Todo){
        self.todoTitle = currentTodo.title
        self.todoID = currentTodo.id
    }
    
    func addTodo() async throws{
        let urlConcat = Constants.baseURL + Endpoints.todo
        
        guard let url = URL(string: urlConcat) else {
            throw HttpError.badURL
        }
        
        let todo = Todo(id: todoID, title: todoTitle, description: todoDescription, deleted: todoDeleted, completed: todoCompleted, creationDate: "", completionDate: "", modificationDate: "")
        
        print("=====")
        print(todo)
        
        try await HttpClient.instance.sendData(to: url, object: todo, httpMethod: HttpMethods.POST.rawValue)
        
    }
    
    func addUpdateAction(completion: @escaping () -> Void) {
        Task{
            do {
                if isUpdating{
                    // update
                } else {
                    try await addTodo()
                }
            }catch {
                print("Error: \(error)")
            }
            completion()
        }
    }
}
