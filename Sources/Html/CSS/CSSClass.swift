import HTMLDSL

public extension CSSClass {
    enum Block: String {
        case heading1
        case heading2
        case heading3
        case link
        case page
        case paragraph
    }

    static func notion(_ block: Block) -> Self {
        Self.init(stringLiteral: "notion-\(block.rawValue)")
    }
}
