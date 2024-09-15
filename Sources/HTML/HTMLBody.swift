import HTMLDSL
import NotionParsing

public struct Config {
    let video: Video.Config

    public init(video: Video.Config) {
        self.video = video
    }
}

public func htmlBody(for page: Page, with config: Config) -> some HTMLBodyContentView {
    Div {
        for block in page.content?.blocks ?? [] {
            AnyView(htmlBlock(for: block, with: config))
        }
    }
    .identifyBy(cssClass: .notion(.page))
}
