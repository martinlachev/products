# Products

A sample Flutter app built in “Lego-style” layers: utilities, features, and application.

## Table of Contents

- [Architecture Overview](#architecture-overview)  
- [Getting Started](#getting-started)

## Architecture Overview

I have structure the codebase into three main layers:

1. **Utilities**  
   Reusable packages of helpers and common tools.  
   - Depend only on other utilities.  
   - Promote DRY, ease of discovery, and maintainability.

2. **Features**  
   Self-contained modules implementing business logic.  
   - Each feature (e.g. products, product details) lives in its own package.  
   - Depends only on utilities.  
   - Changes are isolated, reducing cross-feature impact. 

3. **Application**  
   The top-level Flutter apps that “glues” features together into a cohesive product.  
   - Can depend on utilities and features.  
   - Defines global configuration, theming, routing, and ties feature UI into one experience.
   - In this case particularly, divides the app into desktop and mobile for easy of platform-specific development.
    - Can be extended to support web or other platforms as needed.


## Directory Structure

```text
products/
├── utils/           # Dart packages for shared helpers
├── features/           # Dart packages for each business feature
└── apps/
    └── mobile/        # The Flutter application
    └── desktop/
```

## Getting Started
1. Locally I have used flutter `3.29.3` so you may need to update your flutter version or use fvm (Flutter Version Management) to manage versions.
2 . Run `flutter pub get` to install dependencies in all modules.
3. There is a .vscode folder with recommended settings for the project.
4. Open the project in your IDE and run the app on your desired platform (mobile or desktop).
5. Explore the `utils`, `features`, and `apps` directories to see how the architecture is organized.