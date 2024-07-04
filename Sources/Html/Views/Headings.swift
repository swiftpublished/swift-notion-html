import HTMLDSL
import NotionParsing

extension Headings {
    init(richTexts: [NotionParsing.RichText], type: HeadingTag) {
        let richTextsElement = richTexts.map(NotionHTML.RichText.init).map(\.body).joined()
        self.init(richTextsElement, type: type)
    }
}
