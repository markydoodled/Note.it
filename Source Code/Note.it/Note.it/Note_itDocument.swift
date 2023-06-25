//
//  Note_itDocument.swift
//  Note.it
//
//  Created by Mark Howard on 19/06/2023.
//

import SwiftUI
import UniformTypeIdentifiers

extension UTType {
    static var noteitText: UTType {
        UTType(importedAs: "com.MSJ.Note-it.text")
    }
}

struct Note_itDocument: FileDocument {
    var text: String

    init(text: String = "") {
        self.text = text
    }

    static var readableContentTypes: [UTType] { [.noteitText, .swiftSource, .plainText, .utf8PlainText, .utf16PlainText, .utf16ExternalPlainText, .utf8TabSeparatedText, .xml, .yaml, .json, .html, .assemblyLanguageSource, .cHeader, .cSource, .cPlusPlusHeader, .cPlusPlusSource, .objectiveCPlusPlusSource, .objectiveCSource, .appleScript, .javaScript, .shellScript, .pythonScript, .rubyScript, .perlScript, .phpScript] }

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
