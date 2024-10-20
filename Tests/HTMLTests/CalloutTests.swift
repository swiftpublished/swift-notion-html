import XCTest
@testable import NotionHTML
import NotionParsing
@testable import NotionParsingTestHelpers

final class CalloutTests: XCTestCase {
    func test_simple_callout() throws {
        let block: Block = .emojiCallout(
            emoji: "❤️",
            richTexts: [
                .text("This is a Callout")
            ]
        )

        let callout = htmlBlock(for: block, with: .test)

        let expected = """
        <div style="display: flex;gap: 0.5rem;" class="notion-callout">
        <p>❤️</p>
        <p>This is a Callout</p>
        </div>
        """

        XCTAssertEqual(callout.element, expected)
    }
}

private extension Video.Config {
    static var test = Self { _ in .unknown }
}

extension Config {
    static var test = Self(video: .test)
}
