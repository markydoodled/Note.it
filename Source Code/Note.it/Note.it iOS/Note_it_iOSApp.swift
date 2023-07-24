//
//  Note_it_iOSApp.swift
//  Note.it iOS
//
//  Created by Mark Howard on 19/06/2023.
//

import SwiftUI

@main
struct Note_it_iOSApp: App {
    var body: some Scene {
        DocumentGroup(newDocument: Note_it_iOSDocument()) { file in
            ContentView(document: file.$document, fileURL: file.fileURL!, fileTypeAttribute: "N/A", fileSizeAttribute: 0, fileTitleAtribute: "N/A", fileCreatedAttribute: Date(), fileModifiedAttribute: Date(), fileExtensionAttribute: "N/A", fileOwnerAttribute: "N/A", fileNameAttribute: "N/A", filePathAttribute: "N/A")
        }
    }
}
