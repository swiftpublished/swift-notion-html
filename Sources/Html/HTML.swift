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

func htmlBlock(for block: Block) -> some HTMLBodyContentView {
    switch block.type {
    case .paragraph(let paragraph):
        Paragraphs(richTexts: paragraph.richTexts)
            .identifyBy(cssClass: .notion(.paragraph))
    case .bulletedListItem, .heading1:
        preconditionFailure("Not Handled")
    }
}
