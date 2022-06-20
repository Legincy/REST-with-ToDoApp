//
//  TodoListViewModel.swift
//  Todo-App
//
//  Created by Martin Peth on 20.06.22.
//

import SwiftUI

class TodoListViewModel: ObservableObject {
    @Published
    var todos = [Todo]()
    
    func fetchTodos() async throws{
        let urlConcat = Constants.baseURL + Endpoints.todo
        
        guard let url = URL(string: urlConcat) else {
            throw HttpError.badURL
        }
        
        let todoResponse: [Todo] = try await HttpClient.instance.fetch(url: url)
        
        DispatchQueue.main.async {
            self.todos = todoResponse
        }
    }
}
