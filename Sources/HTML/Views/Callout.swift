import HTMLDSL
import NotionParsing

struct Callout: HTMLBodyContentView {
    var attributes = [Attribute]()

    let callout: NotionParsing.Block.Callout

    init(_ callout: NotionParsing.Block.Callout) {
        self.callout = callout
    }

    var body: some View {
        Div {
            Paragraphs(callout.icon.type.emoji ?? "")
                .identifyBy(cssClass: .notion(.callout_emoji))

            Div {
                Paragraphs(richTexts: callout.richTexts)
            }
            .identifyBy(cssClass: .notion(.callout_content_container))
        }
        .identifyBy(cssClass: .notion(.callout))
    }
}

private extension Block.Icon.IconType {
    var emoji: String? {
        switch self {
        case .emoji(let emoji):
            return emoji
        case .external, .file:
            return nil
        }
    }
}
