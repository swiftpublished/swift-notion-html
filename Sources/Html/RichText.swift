import HTMLDSL
import NotionParsing

struct RichText: HTMLBodyTextContentView {
    let body: String

    var attributes = [Attribute]()

    let text: String

    init(_ richText: NotionParsing.RichText) {
        self.text = richText.type.description

        var body = text
        if richText.annotations.bold {
            body = body.bold
        }
        if richText.annotations.italic {
            body = body.italic
        }
        if richText.annotations.strikethrough {
            body = body.delete
        }
        if richText.annotations.underline {
            body = body.underline
        }

        self.body = body
    }
}
