import SwiftUI

protocol Routable: Hashable, Identifiable {
    
    associatedtype ViewType: View
    
    var navigationType: NavigationType { get }
    
    @MainActor
    func viewToDisplay(router: Router<Self>) -> ViewType
}

extension Routable {
    var id: Self { self }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
