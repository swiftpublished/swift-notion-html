import XCTest
@testable import NotionHTML
import NotionParsing
@testable import NotionParsingTestHelpers

final class PageTests: XCTestCase {
    func test_basic() throws {
        let page: Page = .noContent(
            title: [.text("Title")]
        )

        let body = htmlBody(for: page)

        let expected = """
        <div class="notion-page">
        <h1 class="notion-heading1"> Title </h1>
        </div>
        """

        XCTAssertEqual(body.element, expected)
    }
}
