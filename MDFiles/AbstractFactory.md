# Abstract factory

## Introduction

The Abstract Factory design pattern is a creational pattern that provides a protocol for creating families of related or dependent objects without specifying their concrete classes.

It allows clients to create objects without knowing the specific classes they belong to, promoting loose coupling and enhancing flexibility in the codebase.

The main idea behind the Abstract Factory pattern is to define a Abstract Factory protocol as a blueprint that will be used for creating different types of related objects.

Concrete Factory classes are then responsible for implementing these methods and producing concrete instances of the objects.

This approach allows clients to work with the abstract factory and its product protocols, without being tightly coupled to specific implementations.

✅ Positive aspects
1. Encourages modularity and extensibility: The Abstract Factory pattern provides a structured approach to creating families of related objects. It allows for the easy addition of new concrete factories and products without modifying the existing codebase.

2. Promotes loose coupling: The client code depends only on the Abstract Factory and Abstract Product protocols, ensuring low coupling between the client and the concrete implementations. This facilitates easier maintenance and testing.

3. Supports consistent object creation: The Abstract Factory pattern ensures that the created objects within a family are consistent and compatible with each other.

❌ Negative aspects
1. Increased complexity: As the number of families of related objects and concrete factories grows, the complexity of the codebase can increase.

2. Limited flexibility: The Abstract Factory pattern is best suited when there are well-defined families of objects with limited variation. If the object creation logic varies significantly or they are created dynamically, other design patterns may be more suitable.