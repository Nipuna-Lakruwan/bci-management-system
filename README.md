# BCI Integrated Management System

> A professional Flutter mobile application for managing students, courses,
> and enrolment — built with MVC architecture and clean engineering practices.

## Features
- Student CRUD with search and profile view
- Course CRUD with credit management  
- Student ↔ Course enrolment system
- Role-based dashboard
- Data persistence (offline-first)

## Architecture
This project follows a clean MVC (Model-View-Controller) architecture using the Provider pattern for state management. 

- **Model:** Pure Dart classes, immutable, JSON serializable.
- **Repository:** Interfaces for data access (currently local SharedPreferences).
- **Controller:** ChangeNotifier classes to hold state and interact with repositories.
- **View:** Flutter UI widgets that listen to controllers via Consumer. No business logic in the UI.

## Folder Structure
```
lib/
├── app/          # App initialization, routing, theme
├── core/         # Reusable widgets, constants, storage services
├── features/     # Feature modules (auth, students, courses, enrolment, etc.)
└── shared/       # Shared models and widgets across features
```

## Getting Started
1. Clone this repository: `git clone <repo-url>`
2. Fetch dependencies: `flutter pub get`
3. Run the app: `flutter run`

## Tech Stack
Flutter · Dart · Provider (ChangeNotifier) · SharedPreferences

## Author
Nipuna Lakruwan | BCI Campus
