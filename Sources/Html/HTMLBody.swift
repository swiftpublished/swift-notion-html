import HTMLDSL
import NotionParsing

public func htmlBody(for page: Page) throws -> some HTMLBodyContentView {
    try ThrowingView {
        Div {
            Headings(richTexts: page.properties.title.richTexts, type: .h1)
                .identifyBy(cssClass: .notion(.title))

            for block in page.content?.blocks ?? [] {
                if let htmlBlock = try? htmlBlock(for: block) {
                    AnyView(htmlBlock)
                } else {
                    AnyView(String.empty)
                }
            }
        }
        .identifyBy(cssClass: .notion(.page))
    }
}
