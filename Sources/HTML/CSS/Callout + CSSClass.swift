import HTMLDSL
import NotionParsing

extension Block.Callout {
    enum Emoji {
        enum Paragraph: String {
            case intro = "ℹ️"
        }

        enum Container: String {
            case note = "🤍"
            case important = "💛"
            case warning = "❤️"
            case tip = "💚"
        }
    }

    var isIntro: Bool {
        switch icon.type {
        case .emoji(let emoji):
            guard let emoji = Emoji.Paragraph(rawValue: emoji) else {
                return false
            }

            switch emoji {
            case .intro:
                return true
            }

        case .external, .file:
            return false
        }
    }

    var title: String {
        switch icon.type {
        case .emoji(let emoji):
            guard let emoji = Emoji.Container(rawValue: emoji) else {
                assertionFailure("Invalid Emoji")
                return ""
            }

            switch emoji {
            case .note:
                return "Note"
            case .important:
                return "Important"
            case .warning:
                return "Warning"
            case .tip:
                return "Tip"
            }

        case .external, .file:
            return ""
        }
    }

    var cssClasses: [CSSClass] {
        switch icon.type {
        case .emoji(let emoji):
            guard let emoji = Emoji.Container(rawValue: emoji) else {
                assertionFailure("Invalid Emoji")
                return []
            }

            switch emoji {
            case .note:
                return [.notion(.callout_note)]
            case .important:
                return [.notion(.callout_important)]
            case .warning:
                return [.notion(.callout_warning)]
            case .tip:
                return [.notion(.callout_tip)]
            }

        case .external, .file:
            return []
        }
    }

    var containerCSSClasses: [CSSClass] {
        switch icon.type {
        case .emoji(let emoji):
            guard let emoji = Emoji.Container(rawValue: emoji) else {
                assertionFailure("Invalid Emoji")
                return []
            }

            switch emoji {
            case .note:
                return [.notion(.callout_note_container)]
            case .important:
                return [.notion(.callout_important_container)]
            case .warning:
                return [.notion(.callout_warning_container)]
            case .tip:
                return [.notion(.callout_tip_container)]
            }

        case .external, .file:
            return []
        }
    }
}
