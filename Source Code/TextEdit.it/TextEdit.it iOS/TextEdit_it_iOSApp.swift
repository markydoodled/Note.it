//
//  TextEdit_it_iOSApp.swift
//  TextEdit.it iOS
//
//  Created by Mark Howard on 03/05/2021.
//

import SwiftUI

@main
struct TextEdit_it_iOSApp: App {
    var body: some Scene {
        DocumentGroup(newDocument: TextEdit_it_iOSDocument()) { file in
            ContentView(document: file.$document, fileURL: URL(string: "/")!, fileSizeAttribute: 0, fileTitleAtribute: "", fileCreatedAttribute: Date(), fileModifiedAttribute: Date(), fileExtensionAttribute: "", fileOwnerAttribute: "", filePathAttribute: "", fileCommentsAttribute: "")
        }
    }
}
