import HTMLDSL

public extension CSSClass {
    enum Block: String {
        case page
        case heading1
        case paragraph
    }

    static func notion(_ block: Block) -> Self {
        Self.init(stringLiteral: "notion-\(block.rawValue)")
    }
}
