//
//  TextEdit_itDocument.swift
//  TextEdit.it
//
//  Created by Mark Howard on 06/02/2021.
//

import SwiftUI
import UniformTypeIdentifiers

extension UTType {
    static var exampleText: UTType {
        UTType(importedAs: "com.MSJ.TextEdit-it.text")
    }
}

struct TextEdit_itDocument: FileDocument {
    var text: String

    init(text: String = "") {
        self.text = text
    }

    static var readableContentTypes: [UTType] { [.exampleText, .swiftSource, .plainText, .utf8PlainText, .utf16PlainText, .utf16ExternalPlainText, .utf8TabSeparatedText, .xml, .yaml, .json, .html, .assemblyLanguageSource, .cHeader, .cSource, .cPlusPlusHeader, .cPlusPlusSource, .objectiveCPlusPlusSource, .objectiveCSource, .appleScript, .javaScript, .shellScript, .pythonScript, .rubyScript, .perlScript, .phpScript] }

    init(configuration: ReadConfiguration) throws {
        guard let data = configuration.file.regularFileContents,
              let string = String(data: data, encoding: .utf8)
        else {
            throw CocoaError(.fileReadCorruptFile)
        }
        text = string
    }
    
    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        let data = text.data(using: .utf8)!
        return .init(regularFileWithContents: data)
    }
}
