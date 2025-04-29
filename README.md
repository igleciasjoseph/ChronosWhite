# Chronos

Chronos is a modern, elegant task management application built with SwiftUI for macOS. It helps users organize their tasks and manage their time effectively with a beautiful and intuitive interface.

## Features

- **Task Management**: Create, edit, and organize tasks with ease
- **Custom Date Picker**: Intuitive date selection interface
- **Tab-Based Navigation**: Easy access to different sections of the app
- **Home Dashboard**: Quick overview of your tasks and schedule
- **Modern UI**: Clean, beautiful interface built with SwiftUI
- **Font Customization**: Support for custom fonts to match your style

## Project Structure

```
Chronos/
├── Core/                  # Core application components
│   ├── CustomDatePicker/  # Custom date picker implementation
│   ├── Tasks/            # Task management functionality
│   ├── TabBar/           # Tab navigation system
│   ├── Home/             # Home screen components
│   └── DateValue.swift   # Date handling utilities
├── Extensions/           # Swift extensions
├── Helpers/              # Helper utilities and functions
├── Assets.xcassets/      # Application assets and images
├── Fonts/                # Custom font resources
└── Preview Content/      # SwiftUI preview content
```

## Requirements

- macOS 12.0 or later
- Xcode 14.0 or later
- Swift 5.7 or later

## Installation

1. Clone the repository:
```bash
git clone https://github.com/yourusername/Chronos.git
```

2. Open the project in Xcode:
```bash
cd Chronos
open Chronos.xcodeproj
```

3. Build and run the project in Xcode

## Development

The project is built using SwiftUI and follows modern Swift development practices. Key architectural components include:

- **MVVM Architecture**: The app follows the Model-View-ViewModel pattern
- **SwiftUI Views**: Modern, declarative UI implementation
- **Extensions**: Reusable Swift extensions for common functionality
- **Helpers**: Utility functions and shared code

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgments

- SwiftUI for the modern UI framework
- Apple for providing the development tools and platform 