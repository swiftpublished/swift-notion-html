import Foundation
import HTMLDSL
import NotionParsing

public struct Video: HTMLBodyContentView {
    private let video: NotionParsing.Block.Video
    private let config: Config
    
    public var attributes = [Attribute]()
    
    init(_ video: NotionParsing.Block.Video, config: Config) {
        self.video = video
        self.config = config
    }
    
    public struct Config {
        var type: (URL) -> Types
        
        public init(type: @escaping (URL) -> Types) {
            self.type = type
        }
    }
    
    public enum Types {
        case embed
        case `internal`
        case unknown
    }
    
    public var body: some View {
        switch config.type(video.file.type.url) {
        case .embed:
            Div {
                Div {
                    VideoEmbed(video.file.type.url.absoluteString)
                        .identifyBy(cssClass: .notion(.iframe))
                }
                .identifyBy(cssClass: .notion(.iframe_container))
                
                Paragraphs(richTexts: video.file.caption ?? [])
                    .identifyBy(cssClass: .notion(.caption))
            }
            
        case .internal:
            Div {
                HTMLDSL.Video(video.file.type.url.absoluteString)
                
                Paragraphs(richTexts: video.file.caption ?? [])
                    .identifyBy(cssClass: .notion(.caption))
            }
            
        case .unknown:
            Div {
                AnyView(EmptyView())
            }
        }
    }
}
