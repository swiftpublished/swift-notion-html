import HTMLDSL

public extension CSSClass {
    enum Block: String {
        case caption
        case code
        case code_inline = "code-inline"
        case heading1
        case heading2
        case heading3
        case iframe
        case iframe_container = "iframe-container"
        case iframe_container_podcast = "iframe-container-podcast"
        case image
        case intro
        case link
        case page
        case paragraph
        case quote
        case quote_author = "quote-author"
        case quote_author_container = "quote-author-container"
        case quote_container = "quote-container"
        case title
        case toggle
        case toggle_container = "toggle-container"
        case toggle_note = "toggle-note"
        case toggle_note_container = "toggle-note-container"
        case toggle_important = "toggle-important"
        case toggle_important_container = "toggle-important-container"
        case toggle_warning = "toggle-warning"
        case toggle_warning_container = "toggle-warning-container"
        case toggle_tip = "toggle-tip"
        case toggle_tip_container = "toggle-tip-container"
    }

    static func notion(_ block: Block) -> Self {
        Self.init(stringLiteral: "notion-\(block.rawValue)")
    }
}
