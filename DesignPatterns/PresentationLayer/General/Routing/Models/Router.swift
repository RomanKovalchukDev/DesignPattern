import SwiftUI

class Router<Destination: Routable>: ObservableObject {
    
    // MARK: - Properties(public)
    
    /// Used to programatically control a navigation stack
    @Published var path: NavigationPath = NavigationPath()
    
    /// Used to present a view using a sheet
    @Published var presentingSheet: Destination?
    
    /// Used to present a view using a full screen cover
    @Published var presentingFullScreenCover: Destination?
    
    /// Used by presented Router instances to dismiss themselves
    @Published var isPresented: Binding<Destination?>
    
    var isPresenting: Bool {
        presentingSheet != nil || presentingFullScreenCover != nil
    }
    
    // MARK: - Life cycle
    
    init(isPresented: Binding<Destination?>) {
        self.isPresented = isPresented
    }
    
    // MARK: - Methods(public)
    
    /// Returns the view associated with the specified `Routable`
    @ViewBuilder
    @MainActor
    func view(for route: Destination) -> some View {
        route.viewToDisplay(router: router(routeType: route.navigationType))
    }
    
    /// Routes to the specified `Routable`.
    func routeTo(_ route: Destination) {
        switch route.navigationType {
        case .push:
            push(route)
            
        case .sheet:
            presentSheet(route)
            
        case .fullScreenCover:
            presentFullScreen(route)
        }
    }
    
    // Pop to the root screen in our hierarchy
    func popToRoot() {
        path.removeLast(path.count)
    }
    
    // Dismisses presented screen or self
    func dismiss() {
        if !path.isEmpty {
            path.removeLast()
        }
        else if presentingSheet != nil {
            presentingSheet = nil
        }
        else if presentingFullScreenCover != nil {
            presentingFullScreenCover = nil
        }
        else {
            isPresented.wrappedValue = nil
        }
    }
    
    // MARK: - Methods(private)
    
    private func push(_ route: Destination) {
        path.append(route)
    }
    
    private func presentSheet(_ route: Destination) {
        self.presentingSheet = route
    }
    
    private func presentFullScreen(_ route: Destination) {
        self.presentingFullScreenCover = route
    }
    
    // Return the appropriate Router instance based
    // on `NavigationType`
    private func router(routeType: NavigationType) -> Router {
        switch routeType {
        case .push:
            return self
            
        case .sheet:
            return Router(
                isPresented: Binding(
                    get: { self.presentingSheet },
                    set: { self.presentingSheet = $0 }
                )
            )
            
        case .fullScreenCover:
            return Router(
                isPresented: Binding(
                    get: { self.presentingFullScreenCover },
                    set: { self.presentingFullScreenCover = $0 }
                )
            )
        }
    }
}
