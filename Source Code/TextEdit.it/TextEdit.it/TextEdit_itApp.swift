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
        .commands {
            TextEditingCommands()
            TextFormattingCommands()
            SidebarCommands()
            CommandGroup(after: CommandGroupPlacement.importExport) {
                Button(action: {printDoc()}) {
                    Text("Print")
                }
                .keyboardShortcut("p", modifiers: .command)
            }
        }
        Settings {
            SettingsView()
        }
    }
    func printDoc() {
        let docToPrint = ContentView(document: .constant(TextEdit_itDocument()))
        let printView = NSTextView(frame: NSRect(x: 0, y: 0, width: 72*6, height: 72*8))
        printView.string = docToPrint.document.text
            let printInfo = NSPrintInfo()

            printInfo.bottomMargin = 72
            printInfo.topMargin = 72
            printInfo.leftMargin = 72
            printInfo.rightMargin = 72
        
        let printPanel = NSPrintPanel()
        printPanel.options = [.showsPageSetupAccessory, .showsCopies, .showsOrientation, .showsPageRange, .showsPaperSize, .showsPreview, .showsPrintSelection, .showsScaling]

            let printOp = NSPrintOperation(view: printView, printInfo: printInfo)
        printOp.printPanel = printPanel
            printOp.run()
    }
}
