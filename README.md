# PokerstarsTrains

## Architecture

This example app uses MVVM + Coordinator pattern as a flavor.
The UI/UX is basic and aims to only expose a way for the user to call the API of the project.
All UI can be extended and developed further more, but will take much longer so i choose to keep it as simple as possible.

At the top level of the app is **AppDelegate.swift** as usual.

The **AppDIContainer.swift** is the main Dependency Manager container for the app which provides / injects all object instances. 
It can be improved a lot from its current state, but again its aim is to show a possible implementation for current project needs.

The **AppInitialiser.swift** receives an instance of main app DI container and manages initialisation of all third party dependancies as well as
internal and external frameworks, services etc. It also manages the main coordinator of the app, called **MainCoordinator**. This is the initial 
UI point of the app. **MainCoordinator.swift** manages all its children coordinators and scenes.

Every *ViewController* in the app is called *Scene*. All UIViewControllers has its own ViewModel class which manages all business logic and digests all Entities,
to feed them to its View e.g. UIViewController. The ViewModel is responsible to handle all UseCases and/or Services to make network calls or calls to 
the apps persistance stores (UserDefaults, CoreData, Keychain etc.).

Everything communicates trough abstractions (protocols) which makes these objects easily testable.
All dependencies are injected trough the constructor, although its possible to be done trough properties as well.
This is the case of setting the ViewModel and Style for every ViewController upon its creation.

Every UseCase has its own repository pattern which makes it easy to be mocked if needed. This also helps writing unit tests for every UseCase.

## Dependencies and Dependency Managers

The project uses Cocoapods.
The only dependency that is used is pod 'XMLParsing' to ease the parsing of XML responses.

## Other Notes

There is multiple places trough the code marked with // TODO: - 
These TODOs show where improvement can be made. The reason to be placed is to safe time on development and show the main architecture implementation.
