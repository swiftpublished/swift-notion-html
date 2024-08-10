import HTMLDSL

public extension CSSClass {
    enum Block: String {
        case caption
        case code
        case heading1
        case heading2
        case heading3
        case iframe
        case iframe_container = "iframe-container"
        case iframe_container_podcast = "iframe-container-podcast"
        case image
        case link
        case page
        case paragraph
        case quote
        case quote_author = "quote-author"
        case quote_author_container = "quote-author-container"
        case quote_container = "quote-container"
        case title
    }

    static func notion(_ block: Block) -> Self {
        Self.init(stringLiteral: "notion-\(block.rawValue)")
    }
}
