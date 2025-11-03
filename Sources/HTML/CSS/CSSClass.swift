import HTMLDSL

public extension CSSClass {
    enum Block: String {
        case callout
        case callout_emoji = "callout-emoji"
        case callout_content_container = "callout-content-container"
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
        case table_container = "table-container"
        case table_header = "table-header"
        case table_cell = "table-cell"
    }

    static func notion(_ block: Block) -> Self {
        Self.init(stringLiteral: "notion-\(block.rawValue)")
    }
}
