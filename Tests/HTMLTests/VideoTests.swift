import XCTest
@testable import NotionHTML
import NotionParsing
@testable import NotionParsingTestHelpers

final class VideoTests: XCTestCase {
    func test_external_file() throws {
        let block: Block = .externalVideo(
            url: "https://host.com/videoId", caption: [.text("Hello")]
        )

        let video = htmlBlock(for: block)

        let expected = """
        <div class="notion-video-iframe-container">
        <iframe src="https://host.com/videoId" frameborder="0" class="notion-video-iframe">

        </iframe>
        <p class="notion-caption">
        Hello
        </p>
        </div>
        """

        XCTAssertEqual(video.element, expected)
    }
}
