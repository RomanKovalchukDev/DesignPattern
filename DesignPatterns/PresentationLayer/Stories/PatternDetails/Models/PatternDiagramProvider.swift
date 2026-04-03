//
//  PatternDiagramProvider.swift
//  DesignPatterns
//
//  Created by Claude Code on 03.04.2026.
//

import Foundation

enum PatternDiagramProvider {
    static func getDiagram(for patternName: String) -> String? {
        patternDiagrams[patternName]
    }

    private static let patternDiagrams: [String: String] = [
        // Creational Patterns
        "Singleton": """
        @startuml
        class Singleton {
            - {static} instance: Singleton
            - Singleton()
            + {static} shared: Singleton
            + someMethod()
        }
        note right of Singleton
            Private initializer ensures
            only one instance exists
        end note
        @enduml
        """,

        "Factory Method": """
        @startuml
        interface Creator {
            + factoryMethod(): Product
            + someOperation()
        }

        class ConcreteCreatorA {
            + factoryMethod(): Product
        }

        class ConcreteCreatorB {
            + factoryMethod(): Product
        }

        interface Product {
            + operation()
        }

        class ConcreteProductA {
            + operation()
        }

        class ConcreteProductB {
            + operation()
        }

        Creator <|.. ConcreteCreatorA
        Creator <|.. ConcreteCreatorB
        Product <|.. ConcreteProductA
        Product <|.. ConcreteProductB
        ConcreteCreatorA ..> ConcreteProductA : creates
        ConcreteCreatorB ..> ConcreteProductB : creates
        @enduml
        """,

        "Abstract Factory": """
        @startuml
        interface AbstractFactory {
            + createProductA(): ProductA
            + createProductB(): ProductB
        }

        class ConcreteFactory1 {
            + createProductA(): ProductA
            + createProductB(): ProductB
        }

        class ConcreteFactory2 {
            + createProductA(): ProductA
            + createProductB(): ProductB
        }

        interface ProductA
        interface ProductB

        class ProductA1
        class ProductA2
        class ProductB1
        class ProductB2

        AbstractFactory <|.. ConcreteFactory1
        AbstractFactory <|.. ConcreteFactory2
        ProductA <|.. ProductA1
        ProductA <|.. ProductA2
        ProductB <|.. ProductB1
        ProductB <|.. ProductB2
        ConcreteFactory1 ..> ProductA1 : creates
        ConcreteFactory1 ..> ProductB1 : creates
        ConcreteFactory2 ..> ProductA2 : creates
        ConcreteFactory2 ..> ProductB2 : creates
        @enduml
        """,

        "Builder": """
        @startuml
        class Director {
            - builder: Builder
            + construct()
        }

        interface Builder {
            + buildPartA()
            + buildPartB()
            + buildPartC()
            + getResult(): Product
        }

        class ConcreteBuilder {
            - product: Product
            + buildPartA()
            + buildPartB()
            + buildPartC()
            + getResult(): Product
        }

        class Product {
            - partA
            - partB
            - partC
        }

        Director o--> Builder
        Builder <|.. ConcreteBuilder
        ConcreteBuilder ..> Product : builds
        @enduml
        """,

        "Prototype": """
        @startuml
        interface Prototype {
            + clone(): Prototype
        }

        class ConcretePrototype1 {
            - field1
            - field2
            + clone(): Prototype
        }

        class ConcretePrototype2 {
            - field3
            - field4
            + clone(): Prototype
        }

        class Client {
            - prototype: Prototype
            + operation()
        }

        Prototype <|.. ConcretePrototype1
        Prototype <|.. ConcretePrototype2
        Client o--> Prototype
        @enduml
        """,

        // Structural Patterns
        "Adapter": """
        @startuml
        interface Target {
            + request()
        }

        class Adapter {
            - adaptee: Adaptee
            + request()
        }

        class Adaptee {
            + specificRequest()
        }

        class Client

        Target <|.. Adapter
        Adapter o--> Adaptee
        Client --> Target
        @enduml
        """,

        "Decorator": """
        @startuml
        interface Component {
            + operation()
        }

        class ConcreteComponent {
            + operation()
        }

        abstract class Decorator {
            - component: Component
            + operation()
        }

        class ConcreteDecoratorA {
            - addedState
            + operation()
        }

        class ConcreteDecoratorB {
            - addedBehavior()
            + operation()
        }

        Component <|.. ConcreteComponent
        Component <|.. Decorator
        Decorator o--> Component
        Decorator <|-- ConcreteDecoratorA
        Decorator <|-- ConcreteDecoratorB
        @enduml
        """,

        "Proxy": """
        @startuml
        interface Subject {
            + request()
        }

        class RealSubject {
            + request()
        }

        class Proxy {
            - realSubject: RealSubject
            + request()
        }

        class Client

        Subject <|.. RealSubject
        Subject <|.. Proxy
        Proxy o--> RealSubject
        Client --> Subject
        @enduml
        """,

        // Behavioral Patterns
        "Observer": """
        @startuml
        interface Subject {
            + attach(Observer)
            + detach(Observer)
            + notify()
        }

        class ConcreteSubject {
            - state
            + attach(Observer)
            + detach(Observer)
            + notify()
            + getState()
            + setState()
        }

        interface Observer {
            + update()
        }

        class ConcreteObserver {
            - observerState
            + update()
        }

        Subject <|.. ConcreteSubject
        Observer <|.. ConcreteObserver
        ConcreteSubject o--> Observer
        ConcreteObserver --> ConcreteSubject
        @enduml
        """,

        "Strategy": """
        @startuml
        class Context {
            - strategy: Strategy
            + setStrategy(Strategy)
            + executeStrategy()
        }

        interface Strategy {
            + execute()
        }

        class ConcreteStrategyA {
            + execute()
        }

        class ConcreteStrategyB {
            + execute()
        }

        class ConcreteStrategyC {
            + execute()
        }

        Context o--> Strategy
        Strategy <|.. ConcreteStrategyA
        Strategy <|.. ConcreteStrategyB
        Strategy <|.. ConcreteStrategyC
        @enduml
        """,

        "Command": """
        @startuml
        class Invoker {
            - command: Command
            + setCommand(Command)
            + executeCommand()
        }

        interface Command {
            + execute()
        }

        class ConcreteCommand {
            - receiver: Receiver
            + execute()
        }

        class Receiver {
            + action()
        }

        class Client

        Invoker o--> Command
        Command <|.. ConcreteCommand
        ConcreteCommand o--> Receiver
        Client ..> Receiver
        Client ..> ConcreteCommand
        @enduml
        """,

        "State": """
        @startuml
        class Context {
            - state: State
            + request()
            + setState(State)
        }

        interface State {
            + handle(Context)
        }

        class ConcreteStateA {
            + handle(Context)
        }

        class ConcreteStateB {
            + handle(Context)
        }

        Context o--> State
        State <|.. ConcreteStateA
        State <|.. ConcreteStateB
        ConcreteStateA ..> Context
        ConcreteStateB ..> Context
        @enduml
        """
    ]
}
