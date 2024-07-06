import HTMLDSL
import NotionParsing

public func htmlBody(for page: Page) -> some HTMLBodyContentView {
    Div {
        Headings(richTexts: page.properties.title.richTexts, type: .h1)
            .identifyBy(cssClass: .notion(.title))

        for block in page.content?.blocks ?? [] {
            AnyView(htmlBlock(for: block))
        }
    }
    .identifyBy(cssClass: .notion(.page))
}
