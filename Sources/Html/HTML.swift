import HTMLDSL
import NotionParsing

public func htmlBody(for page: Page) -> some HTMLBodyContentView {
    Div {
        Headings(richTexts: page.properties.title.richTexts, type: .h1)
            .identifyBy(cssClass: .notion(.heading1))

        for block in page.content?.blocks ?? [] {
            AnyView(htmlBlock(for: block))
        }
    }
    .identifyBy(cssClass: .notion(.page))
}

@ViewBuilder
func htmlBlock(for block: Block) -> some HTMLBodyContentView {
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
    case .paragraph(let paragraph):
        Paragraphs(richTexts: paragraph.richTexts)
            .identifyBy(cssClass: .notion(.paragraph))
    }
}
