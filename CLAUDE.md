# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is an iOS educational app demonstrating all 23 Gang of Four (GoF) design patterns with practical Swift/SwiftUI implementations. The app is organized into three pattern categories: Creational, Structural, and Behavioral. Each pattern includes working code examples, visual demonstrations, and detailed markdown documentation.

## Architecture

### Layer Structure

The project follows a strict layered architecture:

**DataLayer**: Repository pattern for data access
- `Models/`: Domain models (DesignPatternModel, DesignPatternCategory)
- `Repositories/`: Data access logic (DesignPatternsRepository)
- `Responses/`: Data transfer objects for JSON decoding

**PresentationLayer**: MVVM + Routing
- `App/`: App entry point with dependency injection setup
- `General/`: Shared utilities, extensions, routing infrastructure
- `Stories/`: Feature modules organized by screen
  - Each story contains ViewModels, Views, and DisplayModels
  - Mock implementations provided for previews

**SupportingFiles**: Generated code, assets, and data
- `Generated/`: SwiftGen outputs (JSON+Generated.swift)
- `Data/`: JSON files (GOFPatterns.json)

### Routing System

Custom Router implementation supporting:
- `NavigationType`: push, sheet, fullScreenCover
- `Routable` protocol: Each screen conforms and provides its view
- `Router<Destination>`: Generic router managing NavigationPath and presentation state
- Usage: Define routes as enums conforming to `Routable`

### Dependency Injection

Uses NerdzInject for simple DI:
- Dependencies registered in `DesignPatternsApp.init()`
- Inject via `@Injected` or `NerdzInject.shared.getObject()`
- Register protocols with concrete implementations

### Pattern Samples Organization

Pattern implementations live in `PresentationLayer/Stories/Samples/`:
- `Creational/`: AbstractFactory, Builder, FactoryMethod, Prototype, Singleton
- `Behavioral/`: ChainOfResponsibility, Command, Interpreter, Iterator, Mediator, Memento, Observer, State, Strategy, TemplateMethod, Visitor
- `Structural/`: Adapter, Bridge, Composite, Decorator, Facade, Flyweight, Proxy

Each sample is a self-contained Swift file demonstrating the pattern with SwiftUI views.

## Build and Development

### Code Generation

SwiftGen generates type-safe accessors from JSON data:
```bash
swiftgen config run
```
Configuration: `swiftgen.yml`
- Inputs: `DesignPatterns/SupportingFiles/Data/`
- Output: `DesignPatterns/SupportingFiles/Generated/JSON+Generated.swift`

### Linting

SwiftLint enforces strict code style (see `swiftlint.yml`):
```bash
swiftlint
```

Key rules:
- 4-space indentation
- Explicit `self` required
- Force unwrapping forbidden
- No `print` statements (custom rule)
- UIKit forbidden in Repository/Request files
- Image/color naming conventions enforced

### Building

Standard Xcode build:
```bash
xcodebuild -scheme DesignPatterns -configuration Debug build
```

Or build via Xcode (Cmd+B).

### Testing

Write tests following TDD principles with XCTest. Mock ViewModels already exist for preview purposes (e.g., MockPatternsListViewModel, MockPatternDetailsViewModel).

## Dependencies (Swift Package Manager)

- **NerdzInject**: Lightweight dependency injection
- **NerdzUtils**: Utility extensions
- **SwiftMessages**: Toast/message presentation
- **SFSafeSymbols**: Type-safe SF Symbols
- **KeychainAccess**: Secure storage
- **xcstrings-tool-plugin**: Localization tooling

## Key Patterns and Conventions

### ViewModel Protocol Pattern

ViewModels follow a protocol-based approach:
```swift
protocol PatternsListViewModelType: ObservableObject {
    var state: ViewState { get }
    func loadPatterns()
}

final class PatternsListViewModel: PatternsListViewModelType {
    // Implementation
}
```

### Display Models

UI-specific models separate from domain models:
- `PatternsListDisplayModel`
- `PatternsListSectionDisplayModel`
- `PatternsListCategoryDisplayModel`

### Messaging System

App-wide message display using `AppMessagableViewModelType`:
- ViewModels conforming to this protocol can show error/success messages
- Uses SwiftMessages library for toast notifications

### Localization

Uses String Catalog (.xcstrings). Generated accessors via:
```swift
String.localizable(.someKey)
```

## Documentation

Markdown files in `MDFiles/`:
- `Main.md`: Complete guide to all 23 patterns with pros/cons/examples
- Individual pattern docs (AbstractFactory.md, Builder.md, etc.)

Reference these when implementing or explaining patterns.

## Common Tasks

### Adding a New Pattern Sample

1. Create Swift file in appropriate category folder under `PresentationLayer/Stories/Samples/`
2. Implement the pattern with protocols and concrete classes
3. Add SwiftUI view demonstrating the pattern
4. Update `GOFPatterns.json` with pattern metadata
5. Run `swiftgen config run` to regenerate accessors
6. Update routing if pattern needs dedicated screen

### Adding New Routes

1. Add case to route enum (e.g., `RootRoute`)
2. Implement `Routable` protocol (specify `navigationType` and `viewToDisplay`)
3. Use `router.routeTo(.yourRoute)` to navigate

### Working with JSON Data

Data source: `DesignPatterns/SupportingFiles/Data/GOFPatterns.json`
- Modify JSON
- Run SwiftGen: `swiftgen config run`
- Access via type-safe generated code

### Respecting SwiftLint Rules

- Never use `print()` (use proper logging)
- Avoid `public`/`open` unless necessary (prefer internal)
- Use `-` not `_` in asset names
- Image names must end with `-icon` or `-image`
- Color names must end with `-color`
- Keep closure bodies under 100 lines
- Follow MARK comment format: `// MARK: - Section`
