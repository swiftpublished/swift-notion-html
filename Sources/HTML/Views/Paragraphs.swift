import HTMLDSL
import NotionParsing

public extension Paragraphs {
    init(richTexts: [NotionParsing.RichText]) {
        let richTextsElement = richTexts.map(NotionHTML.RichText.init).map(\.body).joined()
        self.init(richTextsElement)
    }
}
