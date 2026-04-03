# Design Patterns

An educational iOS application demonstrating all 23 Gang of Four (GoF) design patterns with practical Swift and SwiftUI implementations.

## Overview

This project serves as a comprehensive reference and learning tool for software design patterns. Each pattern includes working code examples, visual demonstrations, and detailed explanations to help developers understand when and how to apply these patterns in real-world iOS development.

## Features

- **Complete Pattern Coverage**: All 23 GoF design patterns implemented in Swift
- **Interactive Examples**: Each pattern includes a working SwiftUI demonstration
- **UML Diagrams**: PlantUML-generated class diagrams for visual understanding
- **Code Samples**: Comprehensive Swift implementations with explanations
- **Categorized Organization**: Patterns grouped by type (Creational, Structural, Behavioral)
- **Clean Architecture**: MVVM + Repository pattern with custom routing
- **Detailed Documentation**: Comprehensive markdown guides for each pattern
- **Type-Safe Code Generation**: SwiftGen integration for JSON data access

## Design Patterns Included

### Creational Patterns (5)
Object creation mechanisms that increase flexibility and reuse of existing code.

- **Abstract Factory**: Create families of related objects without specifying concrete classes
- **Builder**: Construct complex objects step by step
- **Factory Method**: Provide an interface for creating objects in a superclass
- **Prototype**: Clone existing objects without coupling to their classes
- **Singleton**: Ensure a class has only one instance with global access

### Structural Patterns (7)
How to assemble objects and classes into larger structures while keeping them flexible and efficient.

- **Adapter**: Make incompatible interfaces work together
- **Bridge**: Split large classes into separate hierarchies (abstraction and implementation)
- **Composite**: Compose objects into tree structures for part-whole hierarchies
- **Decorator**: Attach new behaviors to objects by wrapping them
- **Facade**: Provide a simplified interface to complex subsystems
- **Flyweight**: Share common state between multiple objects efficiently
- **Proxy**: Provide a substitute or placeholder for another object

### Behavioral Patterns (11)
Algorithms and the assignment of responsibilities between objects.

- **Chain of Responsibility**: Pass requests along a chain of handlers
- **Command**: Turn requests into stand-alone objects
- **Interpreter**: Define a language grammar and interpret statements
- **Iterator**: Traverse elements without exposing underlying representation
- **Mediator**: Reduce chaotic dependencies between objects
- **Memento**: Save and restore object state without violating encapsulation
- **Observer**: Define a subscription mechanism for event notifications
- **State**: Alter object behavior when internal state changes
- **Strategy**: Define a family of interchangeable algorithms
- **Template Method**: Define algorithm skeleton, let subclasses override steps
- **Visitor**: Separate algorithms from objects they operate on

## Requirements

- iOS 17.0+
- Xcode 15.0+
- Swift 5.9+
- macOS 14.0+ (for development)

## Installation

1. Clone the repository:
```bash
git clone https://github.com/yourusername/DesignPattern.git
cd DesignPattern
```

2. Open the project in Xcode:
```bash
open DesignPatterns.xcodeproj
```

3. Wait for Swift Package Manager to resolve dependencies

4. Build and run (⌘R)

## Project Structure

```
DesignPatterns/
├── DataLayer/
│   ├── Models/              # Domain models
│   ├── Repositories/        # Data access layer
│   └── Responses/           # JSON response DTOs
├── PresentationLayer/
│   ├── App/                 # App entry point
│   ├── General/             # Shared utilities, routing, extensions
│   └── Stories/
│       ├── PatternsList/    # Main patterns list screen
│       ├── PatternDetails/  # Pattern detail view
│       └── Samples/         # Pattern implementations
│           ├── Creational/
│           ├── Structural/
│           └── Behavioral/
├── SupportingFiles/
│   ├── Assets/              # Images and color assets
│   ├── CodeSamples/
│   │   └── Markdown/        # Pattern code samples (23 .md files)
│   ├── Data/                # JSON data files
│   ├── Diagrams/
│   │   ├── PlantUML/        # UML diagram sources (23 .puml files)
│   │   └── Images/          # Generated UML diagrams (23 .png files)
│   ├── Generated/           # SwiftGen outputs
│   └── Localization/        # String catalogs
└── MDFiles/                 # Pattern documentation
```

## Technologies & Frameworks

### Core
- **SwiftUI**: Modern declarative UI framework
- **Combine**: Reactive programming framework

### Dependencies (Swift Package Manager)
- **NerdzInject**: Lightweight dependency injection
- **NerdzUtils**: Utility extensions and helpers
- **SwiftMessages**: Toast message presentation
- **SFSafeSymbols**: Type-safe SF Symbols access
- **KeychainAccess**: Secure storage wrapper

### Development Tools
- **SwiftGen**: Code generation for type-safe resource access
- **SwiftLint**: Enforce Swift style and conventions

## Architecture

The app follows a layered architecture with clear separation of concerns:

### MVVM Pattern
- ViewModels are protocol-based for testability
- Mock implementations provided for SwiftUI previews
- Display models separate UI concerns from domain logic

### Custom Routing System
Type-safe navigation using generic Router with support for:
- Push navigation
- Sheet presentation
- Full screen covers

### Repository Pattern
Data access abstraction layer separating business logic from data sources.

### Dependency Injection
NerdzInject manages dependencies with compile-time safety.

## Code Generation

The project uses SwiftGen for type-safe code generation:

```bash
# Generate type-safe accessors
swiftgen config run
```

Configuration is defined in `swiftgen.yml`.

## Code Quality

### SwiftLint

Strict linting rules enforce consistent code style:

```bash
# Run linting
swiftlint

# Auto-fix violations
swiftlint --fix
```

Key conventions:
- 4-space indentation
- Explicit `self` required
- Force unwrapping forbidden
- Custom rules for naming conventions

## Learning Resources

### In-App Documentation
- Each pattern includes detailed markdown documentation
- UML class diagrams generated from PlantUML sources
- Full Swift code samples with explanations
- Practical use cases specific to iOS/mobile development
- Real-world iOS framework examples (UIKit, SwiftUI, Combine)
- Pros and cons for each pattern

### External Resources
Pattern documentation references:
- [Refactoring Guru](https://refactoring.guru/design-patterns)
- [Digital Ocean GoF Guide](https://www.digitalocean.com/community/tutorials/gangs-of-four-gof-design-patterns)
- Original "Design Patterns: Elements of Reusable Object-Oriented Software" by Gang of Four

## Usage

1. Launch the app
2. Browse patterns by category (Creational, Structural, Behavioral)
3. Tap any pattern to view:
   - **Overview**: Pattern purpose, applicability, and when to use
   - **Structure**: Participants, collaborations, and structural details
   - **Diagram**: UML class diagram with relationships
   - **Code**: Full Swift implementation with explanations
4. Explore the code in `PresentationLayer/Stories/Samples/` to see real Swift examples

## Contributing

When adding new patterns or examples:

1. Follow the existing pattern structure in `Samples/`
2. Create PlantUML diagram in `SupportingFiles/Diagrams/PlantUML/`
3. Generate PNG image and add to `SupportingFiles/Diagrams/Images/`
4. Create markdown code sample in `SupportingFiles/CodeSamples/Markdown/`
5. Update `GOFPatterns.json` with pattern metadata
6. Run SwiftGen to regenerate type-safe accessors
7. Ensure SwiftLint compliance
8. Add corresponding documentation in `MDFiles/`

## License

This project is available for educational purposes.

## Acknowledgments

- Gang of Four for the original design patterns book
- [Refactoring Guru](https://refactoring.guru) for excellent pattern explanations
- Swift and iOS developer community for modern Swift implementations

---

**Note**: This is an educational project intended to demonstrate design patterns. Real-world applications should apply patterns judiciously based on specific requirements rather than using them everywhere.
