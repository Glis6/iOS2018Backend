class Drawing: Codable {
    
    var author: String
    var description: String
    var base64String: String
    
    init(author: String, description: String, base64String: String) {
        self.author = author
        self.description = description
        self.base64String = base64String
    }
}

import BSON

extension Drawing {
    
    convenience init?(from bson: Document) {
        guard let author = String(bson["author"]),
        let description = String(bson["description"]),
        let base64String = String(bson["base64String"]) else {
            return nil
        }
        self.init(author: author, description: description, base64String: base64String)
    }
    
    func toBSON() -> Document {
        return [
            "author": author,
            "description": description,
            "base64String": base64String
        ]
    }
}
