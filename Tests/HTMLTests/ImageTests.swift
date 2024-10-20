import XCTest
@testable import NotionHTML
import NotionParsing
@testable import NotionParsingTestHelpers

final class ImageTests: XCTestCase {
    func test_external_file_with_an_alternate_text() throws {
        let block: Block = .externalImage(
            url: "https://host.com/image.png", caption: [.text("Hello")]
        )

        let image = htmlBlock(for: block, with: .test)

        let expected = """
        <div>
        <img src="https://host.com/image.png" alt="Hello" class="notion-image">
        <p class="notion-caption">
        Hello
        </p>
        </div>
        """

        XCTAssertEqual(image.element, expected)
    }
}
