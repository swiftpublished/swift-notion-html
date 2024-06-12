import XCTest
@testable import NotionHtml
import NotionParsing

final class HTMLTests: XCTestCase {
    func testSimpleParagraph() throws {
        let page: Page = .paragraph([
            .text("This is a Paragraph")
        ])

        let document = html(for: page)

        let expected = """
        <!DOCTYPE html>
        <html lang="en">
        <head>
        <title> Notion Test Article </title>
        </head>
        <body>
        <h1> Notion Test Article Title </h1>
        <p>
        This is a Paragraph
        </p>
        </body>
        </html>
        """

        XCTAssertEqual(document.element, expected)
    }

    func testBoldParagraph() throws {
        let page: Page = .paragraph([
            .text("This is a Paragraph", bold: true)
        ])

        let document = html(for: page)

        let expected = """
        <!DOCTYPE html>
        <html lang="en">
        <head>
        <title> Notion Test Article </title>
        </head>
        <body>
        <h1> Notion Test Article Title </h1>
        <p>
        <b>This is a Paragraph</b>
        </p>
        </body>
        </html>
        """

        XCTAssertEqual(document.element, expected)
    }

    func testBoldAndItalicParagraph() throws {
        let page: Page = .paragraph([
            .text("This is a Paragraph", bold: true, italic: true)
        ])

        let document = html(for: page)

        let expected = """
        <!DOCTYPE html>
        <html lang="en">
        <head>
        <title> Notion Test Article </title>
        </head>
        <body>
        <h1> Notion Test Article Title </h1>
        <p>
        <i><b>This is a Paragraph</b></i>
        </p>
        </body>
        </html>
        """

        XCTAssertEqual(document.element, expected)
    }

    func testSimpleParagraphWithPartBold() throws {
        let page: Page = .paragraph([
            .text("This is "),
            .text("bold", bold: true)
        ])

        let document = html(for: page)

        let expected = """
        <!DOCTYPE html>
        <html lang="en">
        <head>
        <title> Notion Test Article </title>
        </head>
        <body>
        <h1> Notion Test Article Title </h1>
        <p>
        This is <b>bold</b>
        </p>
        </body>
        </html>
        """

        XCTAssertEqual(document.element, expected)
    }

    func testSimpleParagraphWithPartBoldAndItalic() throws {
        let page: Page = .paragraph([
            .text("This is "),
            .text("bold & italic", bold: true, italic: true)
        ])

        let document = html(for: page)

        let expected = """
        <!DOCTYPE html>
        <html lang="en">
        <head>
        <title> Notion Test Article </title>
        </head>
        <body>
        <h1> Notion Test Article Title </h1>
        <p>
        This is <i><b>bold & italic</b></i>
        </p>
        </body>
        </html>
        """

        XCTAssertEqual(document.element, expected)
    }
}

private extension Page {
    static func paragraph(_ richTexts: [RichText]) -> Self {
        let title = Page.Properties.Title(text: "Notion Test Article Title")
        let properties = Page.Properties(title: title)

        let paragraph = Block.Paragraph(richTexts: richTexts, children: nil)
        let block = Block(id: "101", hasChildren: false, type: .paragraph(paragraph), children: nil)
        let content = Content(nextCursor: nil, hasMore: false, blocks: [block])

        return Page(
            id: UUID(uuidString: "59833787-2cf9-4fdf-8782-e53db20768a5")!,
            lastEditedTime: DateFormatter.iso8601Notion.date(from: "2020-03-17T19:10:04.968Z")!,
            properties: properties,
            content: content
        )
    }
}

private extension RichText {
    static func text(_ text: String, bold: Bool = false, italic: Bool = false) -> Self {
        let text = RichText.Types.Text(content: text, link: nil)
        let annotations = RichText.Annotations(
            bold: bold,
            italic: italic,
            strikethrough: false,
            underline: false,
            code: false
        )
        return RichText(type: .text(text), annotations: annotations)
    }
}
