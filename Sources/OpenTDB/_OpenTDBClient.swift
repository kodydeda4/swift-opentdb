import Foundation

public struct OpenTDBClient: Sendable {
  
  // Internal
  
  internal var _fetchAllCategories: @Sendable () async throws -> FetchAllCategoriesResponse
  internal var _fetchQuestions: @Sendable (_ amount: Int, _ categoryId: Int, _ type: QuestionType) async throws -> FetchQuestionsResponse
  
  // Public
  
  @Sendable public func fetchAllCategories() async throws -> FetchAllCategoriesResponse {
    try await self._fetchAllCategories()
  }
  
  @Sendable public func fetchQuestions(amount: Int = 10, categoryId: Int, type: QuestionType = .mulipleChoice) async throws -> FetchQuestionsResponse {
    try await self._fetchQuestions(amount, categoryId, type)
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
