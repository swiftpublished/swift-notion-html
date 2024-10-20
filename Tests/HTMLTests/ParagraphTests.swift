import XCTest
@testable import NotionHTML
import NotionParsing
@testable import NotionParsingTestHelpers

final class ParagraphTests: XCTestCase {
    func test_simple_paragraph() throws {
        let block: Block = .paragraph([
            .text("This is a Paragraph")
        ])

        let paragraph = htmlBlock(for: block, with: .test)

        let expected = """
        <p class="notion-paragraph">
        This is a Paragraph
        </p>
        """

        XCTAssertEqual(paragraph.element, expected)
    }

    func test_bold_paragraph() throws {
        let block: Block = .paragraph([
            .text("This is a Paragraph", .bold)
        ])

        let paragraph = htmlBlock(for: block, with: .test)

        let expected = """
        <p class="notion-paragraph">
        <b>This is a Paragraph</b>
        </p>
        """

        XCTAssertEqual(paragraph.element, expected)
    }

    func test_bold_and_italic_paragraph() throws {
        let block: Block = .paragraph([
            .text("This is a Paragraph", .bold_and_italic)
        ])

        let paragraph = htmlBlock(for: block, with: .test)

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
            .text("bold", .bold)
        ])

        let paragraph = htmlBlock(for: block, with: .test)

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
            .text("bold & italic", .bold_and_italic)
        ])

        let paragraph = htmlBlock(for: block, with: .test)

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
            .text("bold", .bold),
            .text(", "),
            .text("bold & italic", .bold_and_italic)
        ])

        let paragraph = htmlBlock(for: block, with: .test)

        let expected = """
        <p class="notion-paragraph">
        This is normal, <b>bold</b>, <i><b>bold & italic</b></i>
        </p>
        """

        XCTAssertEqual(paragraph.element, expected)
    }
}
