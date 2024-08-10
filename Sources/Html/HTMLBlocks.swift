import HTMLDSL
import NotionParsing

@ViewBuilder
func htmlBlock(for block: Block) -> some HTMLBodyContentView {
    switch block.type {
    case .code(let code):
        Div {
            Pre(Code(code.richTexts.plainTexts).element)
                .identifyBy(cssClasses: ["language-\(code.language.rawValue)", .notion(.code)])
            Paragraphs(richTexts: code.caption ?? [])
                .identifyBy(cssClass: .notion(.caption))
        }

    case .divider:
        Divider()

    case .embed(let embed):
        Div {
            Div {
                Embed(embed.url.absoluteString)
                    .identifyBy(cssClass: .notion(.iframe))
            }
            .identifyBy(cssClasses: [.notion(.iframe_container)] + embed.cssClasses)

            Paragraphs(richTexts: embed.caption ?? [])
                .identifyBy(cssClass: .notion(.caption))
        }
    case .heading1(let heading):
        Headings(richTexts: heading.richTexts, type: .h2)
            .identifyBy(cssClass: .notion(.heading1))
    case .heading2(let heading):
        Headings(richTexts: heading.richTexts, type: .h3)
            .identifyBy(cssClass: .notion(.heading2))
    case .heading3(let heading):
        Headings(richTexts: heading.richTexts, type: .h4)
            .identifyBy(cssClass: .notion(.heading3))
    case .image(let image):
        Div {
            Image(image.file.type.url.absoluteString, alternateText: image.file.alternateText ?? .empty)
                .identifyBy(cssClass: .notion(.image))
            Paragraphs(richTexts: image.file.caption ?? [])
                .identifyBy(cssClass: .notion(.caption))
        }
    case .paragraph(let paragraph):
        Paragraphs(richTexts: paragraph.richTexts)
            .identifyBy(cssClass: .notion(.paragraph))

    case .quote(let quote):
        Div {
            Div {
                Paragraphs(String(quote.richTexts.plainTexts.split(separator: "\nAuthor - ").first ?? ""))
                    .identifyBy(cssClass: .notion(.quote))
                Paragraphs(String(quote.richTexts.plainTexts.split(separator: "\nAuthor - ").last ?? ""))
                    .identifyBy(cssClass: .notion(.quote_author))
            }
            .identifyBy(cssClass: .notion(.quote_container))
        }
        .identifyBy(cssClass: .notion(.quote_author_container))

    case .video(let video):
        switch video.file.type {
        case .notion:
            preconditionFailure("Not Handled")
        case .external:
            Div {
                Div {
                    Embed(video.file.type.url.absoluteString)
                        .identifyBy(cssClass: .notion(.iframe))
                }
                .identifyBy(cssClass: .notion(.iframe_container))

                Paragraphs(richTexts: video.file.caption ?? [])
                    .identifyBy(cssClass: .notion(.caption))
            }
        }
    default:
        preconditionFailure("Not Handled: \(block.type)")
    }
}
