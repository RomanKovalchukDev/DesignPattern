//
//  ObserverSample.swift
//  DesignPatterns
//
//  Created by Roman Kovalchuk on 27.01.2025.
//

/*
 It's quite popular pattern within ios
 NotifictionCenter, whole combine framework, rx swift framework.
 Use it when u need to observe changes that were made on another screen.
 */

import SwiftUI
import Combine
import SFSafeSymbols

struct Book {
    let id: String
    let name: String
    let author: String
    var isFavorite: Bool
}

protocol BookRepositoryType {
    var bookFavoriteStatusChangedPublisher: AnyPublisher<Book, Never> { get }
    
    func addToFavorites(book: Book)
    func removeFromFavorites(book: Book)
}

final class BookRepository: ObservableObject, BookRepositoryType {
    var bookFavoriteStatusChangedPublisher: AnyPublisher<Book, Never> {
        rawBookFavoriteStatusChangedPublisher.eraseToAnyPublisher()
    }
    
    private let rawBookFavoriteStatusChangedPublisher: PassthroughSubject<Book, Never> = .init()
    
    func addToFavorites(book: Book) {
        var mutatingBook = book
        mutatingBook.isFavorite = true
        rawBookFavoriteStatusChangedPublisher.send(mutatingBook)
    }
    
    func removeFromFavorites(book: Book) {
        var mutatingBook = book
        mutatingBook.isFavorite = false
        rawBookFavoriteStatusChangedPublisher.send(mutatingBook)
    }
}

class BookListViewModel: ObservableObject {
    @Published var books: [Book] = [
        Book(id: "1", name: "Book One", author: "Author A", isFavorite: false),
        Book(id: "2", name: "Book Two", author: "Author B", isFavorite: false),
        Book(id: "3", name: "Book Three", author: "Author C", isFavorite: false)
    ]
    
    private var cancellables: Set<AnyCancellable> = []
    private let repository: BookRepositoryType

    init(repository: BookRepositoryType) {
        self.repository = repository
        
        repository.bookFavoriteStatusChangedPublisher
            .sink { [weak self] updatedBook in
                guard let self = self else {
                    return
                }
                
                if let index = self.books.firstIndex(where: { $0.id == updatedBook.id }) {
                    self.books[index] = updatedBook
                }
            }
            .store(in: &cancellables)
    }
    
    func toggleFavorite(for book: Book) {
        if book.isFavorite {
            repository.removeFromFavorites(book: book)
        } else {
            repository.addToFavorites(book: book)
        }
    }
}

// MARK: - Views
struct BookListView: View {
    @StateObject private var viewModel = BookListViewModel(repository: BookRepository())
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.books, id: \.id) { book in
                    NavigationLink(destination: BookDetailView(book: book, viewModel: viewModel)) {
                        HStack {
                            Text(book.name)
                            
                            Spacer()
                            
                            Image(systemSymbol: book.isFavorite ? SFSymbol.starFill : SFSymbol.star)
                                .foregroundColor(.yellow)
                        }
                    }
                }
            }
            .navigationTitle("Books")
        }
    }
}

struct BookDetailView: View {
    let book: Book
    @ObservedObject var viewModel: BookListViewModel

    var body: some View {
        VStack(spacing: 16) {
            Text(book.name)
                .font(.largeTitle)
            Text("By \(book.author)")
                .font(.title2)
                .foregroundColor(.gray)

            Button(
                action: {
                    viewModel.toggleFavorite(for: book)
                },
                label: {
                    Text(book.isFavorite ? "Remove from Favorites" : "Add to Favorites")
                        .padding()
                        .background(book.isFavorite ? Color.red : Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            )
        }
        .padding()
        .navigationTitle("Details")
    }
}

// MARK: - Preview
struct BookListView_Previews: PreviewProvider {
    static var previews: some View {
        BookListView()
    }
}
