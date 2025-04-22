import Foundation

public extension OpenTDBClient {
  static let liveValue = Self(
    _fetchAllCategories: {
      try await Self.request(
        "https://opentdb.com/api_category.php"
      )
    },
    _fetchQuestions: { amount, categoryId, type in
      try await Self.request(
        "https://opentdb.com/api.php?amount=\(amount)&category=\(categoryId)&type=\(type.rawValue)"
      )
    }
  )
}

extension OpenTDBClient {
  private static func request<T: Decodable>(_ urlString: String) async throws -> T {
    guard let url = URL(string: urlString) else {
      throw URLError(.badURL)
    }
    
    let (data, _) = try await URLSession.shared.data(from: url)
    
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
    
    let jsonDecoder = JSONDecoder()
    jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
    
    return try jsonDecoder.decode(T.self, from: data)
  }
}
