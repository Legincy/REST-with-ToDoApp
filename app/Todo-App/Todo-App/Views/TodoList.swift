//
//  TodoList.swift
//  Todo-App
//
//  Created by Martin Peth on 20.06.22.
//

import SwiftUI

struct TodoList: View {
    @StateObject
    var viewModel = TodoListViewModel()
    
    @State
    var modal: ModalType? = nil
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.todos) {
                    todo in Button {
                        modal = .update(todo)
                    }label: {
                        HStack {
                            VStack (alignment: .leading, spacing: 5){
                                HStack{
                                    Text(todo.title)
                                        .font(.headline)
                                        .foregroundColor(Color(.label))
                                    
                                    Spacer()
                                    Text(todo.creationDate!.prefix(10))
                                        .font(.subheadline.monospacedDigit())
                                        .foregroundColor(.secondary)
                                }
    
                                Text(todo.description)
                                    .font(.subheadline)
                                    .foregroundColor(Color(.label))
                                
                            }
                        }
                    }
                    }
            }
            .navigationTitle(Text("Offene Aufgaben"))
            .toolbar{
                Button {
                    modal = .add
                } label: {
                    Label("Todo hinzufügen", systemImage:"plus.circle")
                }
            }
        }
        .sheet(item: $modal, onDismiss: {
            Task {
                do{
                    try await viewModel.fetchTodos()
                } catch {
                    print("Error: \(error)")
                }
            }
        }) { modal in
            switch modal {
            case .add:
                AddUpdateTodo(viewModel: AddUpdateTodoViewModel())
            case .update(let todo):
                AddUpdateTodo(viewModel: AddUpdateTodoViewModel(currentTodo: todo))
            }
        }
        .onAppear{
            Task{
                do{
                    try await viewModel.fetchTodos()
                } catch {
                    print("Error: \(error)")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TodoList()
    }
}
