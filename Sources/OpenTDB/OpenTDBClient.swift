import Foundation

public struct OpenTDBClient: Sendable {
  public var verbose = false
  
  public init(verbose: Bool = false) {
    self.verbose = verbose
  }
  
  @Sendable public func fetchAllCategories() async throws -> FetchAllCategoriesResponse {
    try await request(
      "https://opentdb.com/api_category.php"
    )
  }
  
  @Sendable public func fetchQuestions(
    amount: Int = 10,
    categoryId: Int,
    type: QuestionType = .mulipleChoice
  ) async throws -> FetchQuestionsResponse {
    try await request(
      "https://opentdb.com/api.php?amount=\(amount)&category=\(categoryId)&type=\(type.rawValue)"
    )
  }
  
  public struct FetchAllCategoriesResponse: Sendable, Equatable, Codable, Hashable {
    public let triviaCategories: [Category]
  }
  
  public struct FetchQuestionsResponse: Sendable, Equatable, Codable, Hashable {
    public let responseCode: Int
    public let results: [Question]
  }
  
  public enum QuestionType: String, Sendable, Equatable, Codable, Hashable {
    case mulipleChoice = "multiple"
    case trueFalse = "boolean"
  }
  
  public struct Category: Sendable, Identifiable, Equatable, Codable, Hashable {
    public let id: Int
    public let name: String
  }
  
  public struct Question: Sendable, Identifiable, Equatable, Codable, Hashable {
    public var id: String { question }
    public let type: String
    public let difficulty: String
    public let category: String
    public let question: String
    public let correctAnswer: String
    public let incorrectAnswers: [String]
  }
}

// MARK: - Extensions

extension OpenTDBClient.Question {
  public var answers: [String] { incorrectAnswers + [correctAnswer] }
  
  public var formattedQuestion: String {
    self.question.stringByDecodingHTMLEntities
  }
}

extension OpenTDBClient.Category {
  public var formattedName: String {
    self.name
      .replacingOccurrences(of: "Entertainment: ", with: "")
      .replacingOccurrences(of: "Science: ", with: "")
  }
  
  public var emoji: String {
    switch id {
    case 9:  return "🧠"  // General Knowledge
    case 10: return "📚"  // Entertainment: Books
    case 11: return "🎬"  // Entertainment: Film
    case 12: return "🎵"  // Entertainment: Music
    case 13: return "🎭"  // Entertainment: Musicals & Theatres
    case 14: return "📺"  // Entertainment: Television
    case 15: return "🎮"  // Entertainment: Video Games
    case 16: return "🎲"  // Entertainment: Board Games
    case 17: return "🌿"  // Science & Nature
    case 18: return "💻"  // Science: Computers
    case 19: return "➗"  // Science: Mathematics
    case 20: return "🏛"  // Mythology
    case 21: return "⚽️"  // Sports
    case 22: return "🌍"  // Geography
    case 23: return "📜"  // History
    case 24: return "🏛"  // Politics
    case 25: return "🎨"  // Art
    case 26: return "🌟"  // Celebrities
    case 27: return "🐾"  // Animals
    case 28: return "🚗"  // Vehicles
    case 29: return "🦸‍♂️" // Entertainment: Comics
    case 30: return "📱"  // Science: Gadgets
    case 31: return "🇯🇵" // Entertainment: Japanese Anime & Manga
    case 32: return "🖼"  // Entertainment: Cartoon & Animations
    default: return "📁"  // Unknown Category
    }
  }
}

extension OpenTDBClient {
  private func request<T: Decodable>(_ urlString: String) async throws -> T {
    guard let url = URL(string: urlString) else {
      throw URLError(.badURL)
    }
    
    let (data, _) = try await URLSession.shared.data(from: url)
    
    if verbose {
      if let jsonObject = try? JSONSerialization.jsonObject(with: data, options: []),
         let jsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted),
         let jsonString = String(data: jsonData, encoding: .utf8) {
        print("""
    ----------------------------------------------------------------------------------------------
    📡 JSON Response from: \(urlString)
    ----------------------------------------------------------------------------------------------
    \(jsonString)
    ----------------------------------------------------------------------------------------------
    """)
      }
    }
    
    let jsonDecoder = JSONDecoder()
    jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
    
    return try jsonDecoder.decode(T.self, from: data)
  }
}
