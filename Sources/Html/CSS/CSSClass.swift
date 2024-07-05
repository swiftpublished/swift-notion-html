import HTMLDSL

public extension CSSClass {
    enum Block: String {
        case caption
        case heading1
        case heading2
        case heading3
        case image
        case link
        case page
        case paragraph
        case title
    }

    static func notion(_ block: Block) -> Self {
        Self.init(stringLiteral: "notion-\(block.rawValue)")
    }
}
