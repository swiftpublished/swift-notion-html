import HTMLDSL
import NotionParsing

struct RichText: HTMLBodyTextContentView {
    let body: String

    var attributes = [Attribute]()

    let text: String

    init(_ richText: NotionParsing.RichText) {
        self.text = richText.type.description.replacingOccurrences(of: "\n", with: "<br>")

        var body = text
        if richText.annotations.bold {
            body = body.bold
        }
        if richText.annotations.italic {
            body = body.italic
        }
        if richText.annotations.code {
            body = body.code(cssClass: .notion(.code_inline))
        }
        if richText.annotations.strikethrough {
            body = body.delete
        }
        if richText.annotations.underline {
            body = body.underline
        }

        switch richText.type {
        case .text(let text):
            if let link = text.link {
                body = Link(text: body, url: link.url.absoluteString)
                    .identifyBy(cssClass: .notion(.link))
                    .element
            }

        case .mention:
            break
        }

        self.body = body
    }
}
