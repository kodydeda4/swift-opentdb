import Foundation

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

