import XCTest
@testable import NotionHTML
import NotionParsing
@testable import NotionParsingTestHelpers

final class PageTests: XCTestCase {
    func test_basic() throws {
        let page: Page = .noContent(
            title: [.text("Title")]
        )

        let body = htmlBody(for: page, with: .test)

        let expected = """
        <div class="notion-page">
        <h1 class="notion-title"> Title </h1>
        </div>
        """

        XCTAssertEqual(body.element, expected)
    }

    func test_basic_content() throws {
        let page: Page = .paragraphContent(
            title: [.text("Title")],
            paragraph: [.text("Paragraph")]
        )

        let body = htmlBody(for: page, with: .test)

        let expected = """
        <div class="notion-page">
        <h1 class="notion-title"> Title </h1>
        <p class="notion-paragraph">
        Paragraph
        </p>
        </div>
        """

        XCTAssertEqual(body.element, expected)
    }

    func test_basic_formatted_content() throws {
        let page: Page = .paragraphContent(
            title: [
                .text("Hello "),
                .text("World", .italic)
            ],
            paragraph: [
                .text("Welcome "),
                .text("aboard", .bold)
            ]
        )

        let body = htmlBody(for: page, with: .test)

        let expected = """
        <div class="notion-page">
        <h1 class="notion-title"> Hello <i>World</i> </h1>
        <p class="notion-paragraph">
        Welcome <b>aboard</b>
        </p>
        </div>
        """

        XCTAssertEqual(body.element, expected)
    }
}
