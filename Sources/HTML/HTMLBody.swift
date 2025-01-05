import HTMLDSL
import NotionParsing

public struct Config {
    let video: Video.Config

    public init(video: Video.Config) {
        self.video = video
    }
}
