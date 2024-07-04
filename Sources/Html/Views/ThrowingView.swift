import HTMLDSL

struct ThrowingView<Content>: HTMLBodyContentView where Content: HTMLBodyContentView {
    let body: Content

    let tag = Tag.empty
    var attributes = [Attribute]()

    init(@ViewBuilder content: () throws -> Content) throws {
        self.body = try content()
    }
}

extension ThrowingView where Content == Never {
    init(throwing error: Error) throws {
        throw error
    }
}
