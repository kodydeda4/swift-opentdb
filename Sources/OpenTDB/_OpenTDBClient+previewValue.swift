import Foundation

// MARK: - PreviewValue + Client

extension OpenTDBClient {
  static let previewValue = Self(
    _fetchAllCategories: { .previewValue },
    _fetchQuestions: { _, _, _ in .previewValue }
  )
}

// MARK: - PreviewValue + Models

public extension OpenTDBClient.FetchQuestionsResponse {
  static let previewValue = Self(
    responseCode: 0,
    results: .previewValue
  )
}

public extension OpenTDBClient.FetchAllCategoriesResponse {
  static let previewValue = Self(
    triviaCategories: .previewValue
  )
}

public extension OpenTDBClient.Category {
  static let previewValue = Self(
    id: 9,
    name: "General Knowledge"
  )
}

public extension Array where Element == OpenTDBClient.Category {
  static let previewValue: Self = [
    Element(id: 9, name: "General Knowledge"),
    Element(id: 10, name: "Entertainment: Books"),
    Element(id: 11, name: "Entertainment: Film"),
    Element(id: 12, name: "Entertainment: Music"),
    Element(id: 13, name: "Entertainment: Musicals & Theatres"),
    Element(id: 14, name: "Entertainment: Television")
  ]
}

public extension Dictionary where Key == OpenTDBClient.Question.ID, Value == String {
  static let previewValue: Self = [OpenTDBClient.Question]
    .previewValue
    .reduce(into: Self()) { answers, question in
      answers[question.question] = answers.count < 7
      ? question.correctAnswer
      : question.incorrectAnswers.randomElement()!
    }
}

public extension Array where Element == OpenTDBClient.Question {
  static let previewValue = [
    OpenTDBClient.Question(
      type: "multiple",
      difficulty: "medium",
      category: "General Knowledge",
      question: "Which of these companies does NOT manufacture automobiles?",
      correctAnswer: "Ducati",
      incorrectAnswers: [
        "Nissan",
        "GMC",
        "Fiat"
      ]
    ),
    OpenTDBClient.Question(
      type: "multiple",
      difficulty: "easy",
      category: "General Knowledge",
      question: "Earth is located in which galaxy?",
      correctAnswer: "The Milky Way Galaxy",
      incorrectAnswers: [
        "The Mars Galaxy",
        "The Galaxy Note",
        "The Black Hole"
      ]
    ),
    OpenTDBClient.Question(
      type: "multiple",
      difficulty: "hard",
      category: "General Knowledge",
      question: "Nephelococcygia is the practice of doing what?",
      correctAnswer: "Finding shapes in clouds",
      incorrectAnswers: [
        "Sleeping with your eyes open",
        "Breaking glass with your voice",
        "Swimming in freezing water"
      ]
    ),
    OpenTDBClient.Question(
      type: "multiple",
      difficulty: "easy",
      category: "General Knowledge",
      question: "What is the Spanish word for &quot;donkey&quot;?",
      correctAnswer: "Burro",
      incorrectAnswers: [
        "Caballo",
        "Toro",
        "Perro"
      ]
    ),
    OpenTDBClient.Question(
      type: "multiple",
      difficulty: "medium",
      category: "General Knowledge",
      question: "When was Hubba Bubba first introduced?",
      correctAnswer: "1979",
      incorrectAnswers: [
        "1984",
        "1972",
        "1980"
      ]
    ),
    OpenTDBClient.Question(
      type: "multiple",
      difficulty: "hard",
      category: "General Knowledge",
      question: "The word &quot;abulia&quot; means which of the following?",
      correctAnswer: "The inability to make decisions",
      incorrectAnswers: [
        "The inability to stand up",
        "The inability to concentrate on anything",
        "A feverish desire to rip one&#039;s clothes off"
      ]
    ),
    OpenTDBClient.Question(
      type: "multiple",
      difficulty: "easy",
      category: "General Knowledge",
      question: "What is the profession of Elon Musk&#039;s mom, Maye Musk?",
      correctAnswer: "Model",
      incorrectAnswers: [
        "Professor",
        "Biologist",
        "Musician"
      ]
    ),
    OpenTDBClient.Question(
      type: "multiple",
      difficulty: "easy",
      category: "General Knowledge",
      question: "What alcoholic drink is made from molasses?",
      correctAnswer: "Rum",
      incorrectAnswers: [
        "Gin",
        "Vodka",
        "Whisky"
      ]
    ),
    OpenTDBClient.Question(
      type: "multiple",
      difficulty: "easy",
      category: "General Knowledge",
      question: "In aerodynamics, which force pushes an object upwards?",
      correctAnswer: "Lift",
      incorrectAnswers: [
        "Drag",
        "Weight",
        "Thrust"
      ]
    ),
    OpenTDBClient.Question(
      type: "multiple",
      difficulty: "hard",
      category: "General Knowledge",
      question: "Which of the following languages does NOT use gender as a part of its grammar?",
      correctAnswer: "Turkish",
      incorrectAnswers: [
        "German",
        "Danish",
        "Polish"
      ]
    )
  ]
}
