import XCTest
@testable import NotionHTML
import NotionParsing
@testable import NotionParsingTestHelpers

final class RichTextTests: XCTestCase {
    func test_basic_text() throws {
        let richText: NotionParsing.RichText = .text("Normal")

        let richTextHTML = RichText(richText)

        let expected = """
        Normal
        """

        XCTAssertEqual(richTextHTML.element, expected)
    }

    func test_bold_text() throws {
        let richText: NotionParsing.RichText = .text("Bold", .bold)

        let richTextHTML = RichText(richText)

        let expected = """
        <b>Bold</b>
        """

        XCTAssertEqual(richTextHTML.element, expected)
    }

    func test_bold_and_italic_text() throws {
        let richText: NotionParsing.RichText = .text("Bold & Italic", .bold_and_italic)

        let richTextHTML = RichText(richText)

        let expected = """
        <i><b>Bold & Italic</b></i>
        """

        XCTAssertEqual(richTextHTML.element, expected)
    }

    func test_basic_link() throws {
        let richText: NotionParsing.RichText = .text("Normal", link: "https://www.google.com")

        let richTextHTML = RichText(richText)

        let expected = """
        <a href="https://www.google.com" class="notion-link">
        Normal
        </a>
        """

        XCTAssertEqual(richTextHTML.element, expected)
    }

    func test_bold_link() throws {
        let richText: NotionParsing.RichText = .text("Bold", .bold, link: "https://www.google.com")

        let richTextHTML = RichText(richText)

        let expected = """
        <a href="https://www.google.com" class="notion-link">
        <b>Bold</b>
        </a>
        """

        XCTAssertEqual(richTextHTML.element, expected)
    }

    func test_bold_and_italic_link() throws {
        let richText: NotionParsing.RichText = .text("Bold & Italic", .bold_and_italic, link: "https://www.google.com")

        let richTextHTML = RichText(richText)

        let expected = """
        <a href="https://www.google.com" class="notion-link">
        <i><b>Bold & Italic</b></i>
        </a>
        """

        XCTAssertEqual(richTextHTML.element, expected)
    }
}
