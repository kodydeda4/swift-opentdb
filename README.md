# Swift OpenTDB

A lightweight Swift package for fetching trivia questions from the [Open Trivia Database (OpenTDB)](https://opentdb.com/).

## Features
- Fetch trivia questions with customizable categories, difficulty levels, and question types.
- Decodes JSON responses into Swift models.
- Simple and intuitive API for seamless integration into your iOS, macOS, watchOS, or tvOS projects.

## Installation

### Swift Package Manager (SPM)
1. Open your Xcode project.
2. Navigate to **File > Add Packages**.
3. Enter the repository URL:
   ```
   https://github.com/kodydeda4/swift-opentdb.git
   ```
4. Select the latest version and add the package to your project.

## Usage

### Import the Package

```swift
import OpenTDB
```

### Fetch Categories

You can fetch 

```swift
let api = Api.shared

let categories: [Api.Category] try await self.api.fetchAllCategories().triviaCategories
```

### Fetch Questions

You can fetch [Api.Question] with async/await.

```swift
let api = Api.shared

let questions: [Api.Question] = try await Api.shared.fetchQuestions(
  amount: 10, 
  categoryId: 0, 
  type: .mulipleChoice
)
.results
```

## License

This project is licensed under the MIT License. See [LICENSE](LICENSE) for details.