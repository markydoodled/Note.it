//
//  TextEdit_itApp.swift
//  TextEdit.it
//
//  Created by Mark Howard on 06/02/2021.
//

import SwiftUI

@main
struct TextEdit_itApp: App {
    var body: some Scene {
        DocumentGroup(newDocument: TextEdit_itDocument()) { file in
            ContentView(document: file.$document)
                .frame(minWidth: 850, idealWidth: .infinity, maxWidth: .infinity, minHeight: 400, idealHeight: .infinity, maxHeight: .infinity, alignment: .center)
        }
        Settings {
            SettingsView()
        }
        .commands {
            TextEditingCommands()
            TextFormattingCommands()
            SidebarCommands()
            CommandGroup(after: CommandGroupPlacement.importExport) {
                Button(action: {}) {
                    Text("Print")
                }
                .keyboardShortcut("p", modifiers: .command)
            }
        }
    }
}
