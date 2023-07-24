//
//  Note_itDocument.swift
//  Note.it
//
//  Created by Mark Howard on 19/06/2023.
//

import SwiftUI
import UniformTypeIdentifiers

//Get Custom Type For Document Creation
extension UTType {
    static var noteitText: UTType {
        UTType(importedAs: "com.MSJ.Note-it.text")
    }
}

struct Note_itDocument: FileDocument {
    var text: String

    //Set Text As Blank When Creating A New Document
    init(text: String = "") {
        self.text = text
    }

    //Set Readable File Types
    static var readableContentTypes: [UTType] { [.noteitText, .swiftSource, .plainText, .utf8PlainText, .utf16PlainText, .utf16ExternalPlainText, .utf8TabSeparatedText, .xml, .yaml, .json, .html, .assemblyLanguageSource, .cHeader, .cSource, .cPlusPlusHeader, .cPlusPlusSource, .objectiveCPlusPlusSource, .objectiveCSource, .appleScript, .javaScript, .shellScript, .pythonScript, .rubyScript, .perlScript, .phpScript] }

    //Set How To Read Documents
    init(configuration: ReadConfiguration) throws {
        guard let data = configuration.file.regularFileContents,
              let string = String(data: data, encoding: .utf8)
        else {
            throw CocoaError(.fileReadCorruptFile)
        }
        text = string
    }
    
    //Set How To Write Documents
    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        let data = text.data(using: .utf8)!
        return .init(regularFileWithContents: data)
    }
}
