import HTMLDSL
import NotionParsing

func html(for page: Page) -> some View {
    Document {
        HTML {
            Head {
                Title("Notion Test Article")
            }

            Body {
                Headings(page.properties.title.text, type: .h1)

                for block in page.content?.blocks ?? [] {
                    switch block.type {
                    case .paragraph(let paragraph):
                        Paragraphs(richTexts: paragraph.richTexts)
                    case .bulletedListItem:
                        preconditionFailure("Not Handled")
                    }
                }
            }
        }
    }
}

extension Paragraphs {
    init(richTexts: [RichText]) {
        let richTextsElement = richTexts.map(HTMLRichText.init).map(\.body).joined()
        self.init(richTextsElement)
    }
}

struct HTMLRichText: HTMLBodyTextContentView {
    let body: String

    let newLine: NewLine = .none

    let tag = Tag.empty
    var attributes = [Attribute]()

    let text: String

    init(_ richText: RichText) {
        self.text = richText.type.description

        var body = text
        if richText.annotations.bold {
            body = body.bold
        }
        if richText.annotations.italic {
            body = body.italic
        }
        if richText.annotations.strikethrough {
            body = body.delete
        }
        if richText.annotations.underline {
            body = body.underline
        }

        self.body = body
    }
}
