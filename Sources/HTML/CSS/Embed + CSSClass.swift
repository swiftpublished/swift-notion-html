import HTMLDSL
import NotionParsing

extension Block.Embed {
    var cssClasses: [CSSClass] {
        guard let host = url.host else {
            return []
        }

        switch host {
        case let host where host.contains("embed.podcasts.apple.com"):
            return [.notion(.iframe_container_podcast)]
        default:
            return []
        }
    }
}
