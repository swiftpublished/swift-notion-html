import HTMLDSL

public extension CSSClass {
    enum Block: String {
        case callout
        case callout_container = "callout-container"
        case callout_note = "callout-note"
        case callout_note_container = "callout-note-container"
        case callout_important = "callout-important"
        case callout_important_container = "callout-important-container"
        case callout_warning = "callout-warning"
        case callout_warning_container = "callout-warning-container"
        case callout_tip = "callout-tip"
        case callout_tip_container = "callout-tip-container"
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
    }

    static func notion(_ block: Block) -> Self {
        Self.init(stringLiteral: "notion-\(block.rawValue)")
    }
}
