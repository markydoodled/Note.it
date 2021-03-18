//
//  TextEdit_itApp.swift
//  TextEdit.it
//
//  Created by Mark Howard on 06/02/2021.
//

import SwiftUI
import CodeMirror_SwiftUI

@main
struct TextEdit_itApp: App {
    var body: some Scene {
        DocumentGroup(newDocument: TextEdit_itDocument()) { file in
            ContentView(document: file.$document, fileTypeAttribute: "", fileSizeAttribute: 0, fileTitleAtribute: "", fileCreatedAttribute: Date(), fileModifiedAttribute: Date(), fileExtensionAttribute: "", fileOwnerAttribute: "")
                .frame(minWidth: 850, idealWidth: .infinity, maxWidth: .infinity, minHeight: 400, idealHeight: .infinity, maxHeight: .infinity, alignment: .center)
        }
        .commands {
            SidebarCommands()
            CommandGroup(replacing: CommandGroupPlacement.printItem) {
                Button(action: {}) {
                    Text("Print")
                }
                .keyboardShortcut("p", modifiers: .command)
            }
            CommandMenu("Syntax") {
                Button(action: {SettingsView().syntax = CodeMode.swift.mode()}) {
                    Text("Swift")
                }
            }
        }
        Settings {
            SettingsView()
        }
    }
}
