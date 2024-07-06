import HTMLDSL
import NotionParsing

@ViewBuilder
func htmlBlock(for block: Block) -> some HTMLBodyContentView {
    switch block.type {
    case .bulletedListItem:
        preconditionFailure("Not Handled")
    case .code(let code):
        Pre(Code(code.plainText).element)
            .identifyBy(cssClass: CSSClass(stringLiteral: "language-\(code.language.rawValue)"))
    case .heading1(let heading):
        Headings(richTexts: heading.richTexts, type: .h2)
            .identifyBy(cssClass: .notion(.heading1))
    case .heading2(let heading):
        Headings(richTexts: heading.richTexts, type: .h3)
            .identifyBy(cssClass: .notion(.heading2))
    case .heading3(let heading):
        Headings(richTexts: heading.richTexts, type: .h4)
            .identifyBy(cssClass: .notion(.heading3))
    case .image(let image):
        Div {
            Image(image.file.type.url.absoluteString, alternateText: image.file.alternateText ?? .empty)
                .identifyBy(cssClass: .notion(.image))
            Paragraphs(richTexts: image.file.caption ?? [])
                .identifyBy(cssClass: .notion(.caption))
        }
    case .paragraph(let paragraph):
        Paragraphs(richTexts: paragraph.richTexts)
            .identifyBy(cssClass: .notion(.paragraph))
    case .quote:
        preconditionFailure("Not Handled")
    }
}
