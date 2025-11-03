import HTMLDSL
import NotionParsing

struct Table: HTMLBodyContentView {
    var attributes = [Attribute]()
    
    let table: NotionParsing.Block.Table
    let children: [Block]
    
    init(_ table: NotionParsing.Block.Table, children: [Block]) {
        self.table = table
        self.children = children
    }
    
    var body: some View {
        let tableRows = children.enumerated().compactMap { (index, childBlock) -> TableRow? in
            if case .tableRow(let tableRow) = childBlock.type {
                return TableRow(
                    tableRow: tableRow,
                    isHeader: table.hasColumnHeader && index == 0,
                    isRowHeader: table.hasRowHeader
                )
            }
            return nil
        }
        
        return Div {
            TableElement(tableWidth: table.tableWidth) {
                for row in tableRows {
                    AnyView(row)
                }
            }
        }
        .identifyBy(cssClass: .notion(.table_container))
    }
}

private struct TableElement<Content>: HTMLBodyContentView where Content: HTMLBodyContentView {
    let tableWidth: Int
    var body: Content
    
    let newLine: NewLine = .one
    let tag: Tag = .enclosing(.table)
    var attributes = [Attribute]()
    
    init(tableWidth: Int, @ViewBuilder content: () -> Content) {
        self.tableWidth = tableWidth
        self.body = content()
    }
}

private struct TableRow: HTMLBodyContentView {
    var attributes = [Attribute]()
    
    let tableRow: NotionParsing.Block.TableRow
    let isHeader: Bool
    let isRowHeader: Bool
    
    init(tableRow: NotionParsing.Block.TableRow, isHeader: Bool, isRowHeader: Bool) {
        self.tableRow = tableRow
        self.isHeader = isHeader
        self.isRowHeader = isRowHeader
    }
    
    var body: some View {
        TableRowElement {
            for (index, cellRichTexts) in tableRow.richTexts.enumerated() {
                if isHeader {
                    AnyView(TableHeader(richTexts: cellRichTexts))
                } else if isRowHeader && index == 0 {
                    AnyView(TableHeader(richTexts: cellRichTexts))
                } else {
                    AnyView(TableCell(richTexts: cellRichTexts))
                }
            }
        }
    }
}

private struct TableRowElement<Content>: HTMLBodyContentView where Content: HTMLBodyContentView {
    var body: Content
    
    let newLine: NewLine = .one
    let tag: Tag = .enclosing(.tableRow)
    var attributes = [Attribute]()
    
    init(@ViewBuilder content: () -> Content) {
        self.body = content()
    }
}

private struct TableHeader: HTMLBodyContentView {
    var attributes = [Attribute]()
    
    let richTexts: [NotionParsing.RichText]
    
    let newLine: NewLine = .one
    let tag: Tag = .enclosing(.tableHeader)
    
    init(richTexts: [NotionParsing.RichText]) {
        self.richTexts = richTexts
        self.attributes = [.class([.notion(.table_header)])]
    }
    
    var body: some View {
        Paragraphs(richTexts: richTexts)
    }
}

private struct TableCell: HTMLBodyContentView {
    var attributes = [Attribute]()
    
    let richTexts: [NotionParsing.RichText]
    
    let newLine: NewLine = .one
    let tag: Tag = .enclosing(.tableData)
    
    init(richTexts: [NotionParsing.RichText]) {
        self.richTexts = richTexts
        self.attributes = [.class([.notion(.table_cell)])]
    }
    
    var body: some View {
        Paragraphs(richTexts: richTexts)
    }
}

