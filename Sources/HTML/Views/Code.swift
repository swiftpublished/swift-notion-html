import HTMLDSL
import NotionParsing

extension HTMLDSL.Code {
    init(code: NotionParsing.Block.Code) {
        let text: String = code.richTexts.plainTexts
            .replacingOccurrences(of: "<", with: "&lt;")
        self.init(text)
    }
}
