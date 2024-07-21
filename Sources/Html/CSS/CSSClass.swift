import HTMLDSL

public extension CSSClass {
    enum Block: String {
        case caption
        case code
        case heading1
        case heading2
        case heading3
        case image
        case link
        case page
        case paragraph
        case title
        case video_iframe = "video-iframe"
        case video_iframe_container = "video-iframe-container"
    }

    static func notion(_ block: Block) -> Self {
        Self.init(stringLiteral: "notion-\(block.rawValue)")
    }
}
