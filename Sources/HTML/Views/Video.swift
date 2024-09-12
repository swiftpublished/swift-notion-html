import Foundation
import HTMLDSL
import NotionParsing

struct Video: HTMLBodyContentView {
    private let video: NotionParsing.Block.Video

    var attributes = [Attribute]()

    init(_ video: NotionParsing.Block.Video) {
        self.video = video
    }

    enum Types {
        case youtube
        case vimeo
        case others
    }

    var type: Types {
        guard let host = video.file.type.url.host else {
            return .others
        }

        switch host {
        case let host where host.contains("youtube.com"):
            return .youtube
        case let host where host.contains("vimeo.com"):
            return .vimeo
        default:
            return .others
        }
    }

    var body: some View {
        switch type {
        case .youtube, .vimeo:
            Div {
                Div {
                    VideoEmbed(video.file.type.url.absoluteString)
                        .identifyBy(cssClass: .notion(.iframe))
                }
                .identifyBy(cssClass: .notion(.iframe_container))

                Paragraphs(richTexts: video.file.caption ?? [])
                    .identifyBy(cssClass: .notion(.caption))
            }

        case .others:
            Div {
                HTMLDSL.Video(video.file.type.url.absoluteString)

                Paragraphs(richTexts: video.file.caption ?? [])
                    .identifyBy(cssClass: .notion(.caption))
            }
        }
    }
}
