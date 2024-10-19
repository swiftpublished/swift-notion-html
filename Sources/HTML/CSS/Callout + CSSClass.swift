import HTMLDSL
import NotionParsing

extension Block.Toggle {
    enum Types {
        enum Paragraph: String {
            case Intro
        }

        enum Container: String {
            case Note
            case Important
            case Warning
            case Tip
        }
    }

    var isIntro: Bool {
        let title = richTexts.plainTexts
        guard let type = Types.Paragraph(rawValue: title) else {
            return false
        }

        switch type {
        case .Intro:
            return true
        }
    }

    var title: String {
        let title = richTexts.plainTexts
        guard let type = Types.Container(rawValue: title) else {
            assertionFailure("Invalid Toggle.Container")
            return ""
        }

        return type.rawValue
    }

    var cssClasses: [CSSClass] {
        let title = richTexts.plainTexts
        guard let type = Types.Container(rawValue: title) else {
            assertionFailure("Invalid Toggle.Container")
            return []
        }

        switch type {
        case .Note:
            return [.notion(.toggle_note)]
        case .Important:
            return [.notion(.toggle_important)]
        case .Warning:
            return [.notion(.toggle_warning)]
        case .Tip:
            return [.notion(.toggle_tip)]
        }
    }

    var containerCSSClasses: [CSSClass] {
        let title = richTexts.plainTexts
        guard let type = Types.Container(rawValue: title) else {
            assertionFailure("Invalid Toggle.Container")
            return []
        }

        switch type {
        case .Note:
            return [.notion(.toggle_note_container)]
        case .Important:
            return [.notion(.toggle_important_container)]
        case .Warning:
            return [.notion(.toggle_warning_container)]
        case .Tip:
            return [.notion(.toggle_tip_container)]
        }
    }
}
