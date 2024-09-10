import HTMLDSL
import NotionParsing

extension HTMLDSL.Code {
    init(code: NotionParsing.Block.Code) {
        let text: String

        switch code.language {
        case .css:
            text = code.richTexts.plainTexts
        case .html:
            text = code.richTexts.plainTexts.replacingOccurrences(of: "<", with: "&lt;")
        case .swift:
            text = code.richTexts.plainTexts
        }

        self.init(text)
    }
}
