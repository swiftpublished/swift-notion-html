import HTMLDSL
import NotionParsing

@ViewBuilder
func htmlBlock(for block: Block) throws -> some HTMLBodyContentView {
    switch block.type {
    case .bulletedListItem:
        preconditionFailure("Not Handled")
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
        switch image.type {
        case .file:
            try ThrowingView(
                throwing: NotionHTMLError.message("Don't use Notion Hosted Files")
            )
        case .external(let file):
            if let alternateText = image.alternateText {
                Image(file.url.absoluteString, alternateText: alternateText)
                    .identifyBy(cssClass: .notion(.image))
            } else {
                try ThrowingView(
                    throwing: NotionHTMLError.message("Don't use an Image without an alternate text")
                )
            }
        }
    case .paragraph(let paragraph):
        Paragraphs(richTexts: paragraph.richTexts)
            .identifyBy(cssClass: .notion(.paragraph))
    }
}
