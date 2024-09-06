import HTMLDSL
import NotionParsing

extension Block.Callout {
    var title: String {
        switch icon.type {
        case .emoji(let emoji):
            switch emoji {
            case "🤍":
                return "Note"
            case "💛":
                return "Important"
            case "❤️":
                return "Warning"
            case "💚":
                return "Tip"
            default:
                return ""
            }

        case .external, .file:
            return ""
        }
    }

    var cssClasses: [CSSClass] {
        switch icon.type {
        case .emoji(let emoji):
            switch emoji {
            case "🤍":
                return [.notion(.callout_note)]
            case "💛":
                return [.notion(.callout_important)]
            case "❤️":
                return [.notion(.callout_warning)]
            case "💚":
                return [.notion(.callout_tip)]
            default:
                return []
            }

        case .external, .file:
            return []
        }
    }

    var containerCSSClasses: [CSSClass] {
        switch icon.type {
        case .emoji(let emoji):
            switch emoji {
            case "🤍":
                return [.notion(.callout_note_container)]
            case "💛":
                return [.notion(.callout_important_container)]
            case "❤️":
                return [.notion(.callout_warning_container)]
            case "💚":
                return [.notion(.callout_tip_container)]
            default:
                return []
            }

        case .external, .file:
            return []
        }
    }
}
