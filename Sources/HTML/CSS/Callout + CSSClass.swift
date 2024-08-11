import HTMLDSL
import NotionParsing

extension Block.Callout {
    var cssClasses: [CSSClass] {
        switch icon.type {
        case .emoji(let emoji):
            switch emoji {
            case "🗒️":
                return [.notion(.callout_note)]
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
            case "🗒️":
                return [.notion(.callout_note_container)]
            default:
                return []
            }

        case .external, .file:
            return []
        }
    }
}
