import XCTest
@testable import NotionHTML
import NotionParsing

final class ParagraphTests: XCTestCase {
    func test_simple_paragraph() throws {
        let block: Block = .paragraph([
            .text("This is a Paragraph")
        ])

        let paragraph = htmlBlock(for: block)

        let expected = """
        <p class="notion-paragraph">
        This is a Paragraph
        </p>
        """

        XCTAssertEqual(paragraph.element, expected)
    }

    func test_bold_paragraph() throws {
        let block: Block = .paragraph([
            .text("This is a Paragraph", bold: true)
        ])

        let paragraph = htmlBlock(for: block)

        let expected = """
        <p class="notion-paragraph">
        <b>This is a Paragraph</b>
        </p>
        """

        XCTAssertEqual(paragraph.element, expected)
    }

    func test_bold_and_italic_paragraph() throws {
        let block: Block = .paragraph([
            .text("This is a Paragraph", bold: true, italic: true)
        ])

        let paragraph = htmlBlock(for: block)

        let expected = """
        <p class="notion-paragraph">
        <i><b>This is a Paragraph</b></i>
        </p>
        """

        XCTAssertEqual(paragraph.element, expected)
    }

    func test_simple_bold_paragraph() throws {
        let block: Block = .paragraph([
            .text("This is "),
            .text("bold", bold: true)
        ])

        let paragraph = htmlBlock(for: block)

        let expected = """
        <p class="notion-paragraph">
        This is <b>bold</b>
        </p>
        """

        XCTAssertEqual(paragraph.element, expected)
    }

    func test_simple_bold_italic_paragraph() throws {
        let block: Block = .paragraph([
            .text("This is "),
            .text("bold & italic", bold: true, italic: true)
        ])

        let paragraph = htmlBlock(for: block)

        let expected = """
        <p class="notion-paragraph">
        This is <i><b>bold & italic</b></i>
        </p>
        """

        XCTAssertEqual(paragraph.element, expected)
    }

    func test_simple_bold_bold_italic_paragraph() throws {
        let block: Block = .paragraph([
            .text("This is normal, "),
            .text("bold", bold: true),
            .text(", "),
            .text("bold & italic", bold: true, italic: true)
        ])

        let paragraph = htmlBlock(for: block)

        let expected = """
        <p class="notion-paragraph">
        This is normal, <b>bold</b>, <i><b>bold & italic</b></i>
        </p>
        """

        XCTAssertEqual(paragraph.element, expected)
    }
}

private extension Block {
    static func paragraph(_ richTexts: [NotionParsing.RichText]) -> Self {
        let paragraph = Block.Paragraph(richTexts: richTexts, children: nil)
        let block = Block(
            id: "101",
            hasChildren: false,
            type: .paragraph(paragraph),
            level: nil,
            children: nil
        )
        return block
    }
}

private extension NotionParsing.RichText {
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
