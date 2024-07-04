import XCTest
@testable import NotionHTML
import NotionParsing
@testable import NotionParsingTestHelpers

final class ImageTests: XCTestCase {
    func test_notion_file() {
        let block: Block = .notionImage(
            url: "https://host.com/image.png",
            expiry: "2024-01-01T00:00:00.000Z"
        )

        XCTAssertThrowsError(try htmlBlock(for: block)) { error in
            XCTAssertTrue(error is NotionHTMLError)
            XCTAssertEqual(error.localizedDescription, "Don't use Notion Hosted Files")
        }
    }

    func test_external_file_without_an_alternate_text() {
        let block: Block = .externalImage(url: "https://host.com/image.png", caption: nil)

        XCTAssertThrowsError(try htmlBlock(for: block)) { error in
            XCTAssertTrue(error is NotionHTMLError)
            XCTAssertEqual(error.localizedDescription, "Don't use an Image without an alternate text")
        }
    }

    func test_external_file_with_an_alternate_text() throws {
        let block: Block = .externalImage(
            url: "https://host.com/image.png", caption: [.text("Hello")]
        )

        let image = try htmlBlock(for: block)

        let expected = """
        <img src="https://host.com/image.png" alt="Hello" class="notion-image">
        """

        XCTAssertEqual(image.element, expected)
    }
}
