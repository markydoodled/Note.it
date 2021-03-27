//
//  TextEdit_itApp.swift
//  TextEdit.it
//
//  Created by Mark Howard on 06/02/2021.
//

import SwiftUI
import CodeMirror_SwiftUI
import KeyboardShortcuts

@main
struct TextEdit_itApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        DocumentGroup(newDocument: TextEdit_itDocument()) { file in
            ContentView(document: file.$document, fileTypeAttribute: "", fileSizeAttribute: 0, fileTitleAtribute: "", fileCreatedAttribute: Date(), fileModifiedAttribute: Date(), fileExtensionAttribute: "", fileOwnerAttribute: "", filePathAttribute: "", fileCommentsAttribute: "")
                .frame(minWidth: 850, idealWidth: .infinity, maxWidth: .infinity, minHeight: 400, idealHeight: .infinity, maxHeight: .infinity, alignment: .center)
        }
        .commands {
            SidebarCommands()
            CommandGroup(after: CommandGroupPlacement.printItem) {
                Button(action: { func print2(_ sender : Any) {
                    let printingView = NSHostingView(rootView: ContentView(document: .constant(TextEdit_itDocument()), fileTypeAttribute: "", fileSizeAttribute: 0, fileTitleAtribute: "", fileCreatedAttribute: Date(), fileModifiedAttribute: Date(), fileExtensionAttribute: "", fileOwnerAttribute: "", filePathAttribute: "", fileCommentsAttribute: ""))
                    
                    let printInfo = NSPrintInfo()
                    printInfo.bottomMargin = 72
                    printInfo.topMargin = 72
                    printInfo.leftMargin = 72
                    printInfo.rightMargin = 72
                    
                    let printPanel = NSPrintPanel()
                    printPanel.options = [.showsPageSetupAccessory, .showsCopies, .showsOrientation, .showsPageRange, .showsPaperSize, .showsPreview, .showsPrintSelection, .showsScaling]
                    
                    let printOperation = NSPrintOperation(view: printingView, printInfo: printInfo)
                    printOperation.view?.frame = .init(x: 0, y: 0, width: 500, height: 500)
                    printOperation.showsPrintPanel = true
                    printOperation.showsProgressPanel = true
                    printOperation.printPanel = printPanel
                    printOperation.run()
                    
                }
                print2(Any.self)
                }) {
                    Text("Print")
                }
                .keyboardShortcut("p", modifiers: .command)
            }
        }
        Settings {
            SettingsView()
        }
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_ notification: Notification) {
        createMenus()
        createEditMenu()
    }
    func createMenus() {
        
        let testMenuItem = NSMenuItem()
        NSApp.mainMenu?.addItem(testMenuItem)

        let testMenu = NSMenu()
        testMenu.title = "File Test"
        testMenuItem.submenu = testMenu

        let shortcut1 = NSMenuItem()
        shortcut1.title = "New"
        shortcut1.action = #selector(newShortcutAction)
        shortcut1.setShortcut(for: .newCommand)
        testMenu.addItem(shortcut1)

        let shortcut2 = NSMenuItem()
        shortcut2.title = "Open"
        shortcut2.action = #selector(openShortcutAction)
        shortcut2.setShortcut(for: .openCommand)
        testMenu.addItem(shortcut2)

        testMenu.addItem(NSMenuItem.separator())
        
        let shortcut3 = NSMenuItem()
        shortcut3.title = "Save"
        shortcut3.action = #selector(saveShortcutAction)
        shortcut3.setShortcut(for: .saveCommand)
        testMenu.addItem(shortcut3)

        let shortcut4 = NSMenuItem()
        shortcut4.title = "Copy"
        shortcut4.action = #selector(copyShortcutAction)
        shortcut4.setShortcut(for: .copyCommand)
        testMenu.addItem(shortcut4)
        
        let shortcut5 = NSMenuItem()
        shortcut4.title = "Print"
        shortcut4.action = #selector(printShortcutAction)
        shortcut4.setShortcut(for: .printCommand)
        testMenu.addItem(shortcut5)
        
        let shortcut6 = NSMenuItem()
        shortcut4.title = "Duplicate"
        shortcut4.action = #selector(duplicateShortcutAction)
        shortcut4.setShortcut(for: .duplicateCommand)
        testMenu.addItem(shortcut6)
        
        let shortcut7 = NSMenuItem()
        shortcut4.title = "Move To..."
        shortcut4.action = #selector(moveToShortcutAction)
        shortcut4.setShortcut(for: .moveToCommand)
        testMenu.addItem(shortcut7)
    }
    
    func createEditMenu() {
        let testEditMenuItem = NSMenuItem()
        NSApp.mainMenu?.addItem(testEditMenuItem)
        
        let testEditMenu = NSMenu()
        testEditMenu.title = "Edit Test"
        testEditMenuItem.submenu = testEditMenu
    }
    
    @objc
    func newShortcutAction(_ sender: NSMenuItem) {
        let doc = NSDocumentController()
        doc.newDocument(Any?.self)
    }

    @objc
    func openShortcutAction(_ sender: NSMenuItem) {
        let doc = NSDocumentController()
        doc.openDocument(Any?.self)
    }

    @objc
    func saveShortcutAction(_ sender: NSMenuItem) {
        let doc = NSDocument()
        NSApp.sendAction(#selector(doc.save(_:)), to: nil, from: self)
    }

    @objc
    func copyShortcutAction(_ sender: NSMenuItem) {
        let alert = NSAlert()
        alert.messageText = "Shortcut 4 menu item action triggered!"
        alert.runModal()
    }
    @objc
    func printShortcutAction(_ sender: NSMenuItem) {
        print("Test Print")
    }
    @objc
    func duplicateShortcutAction(_ sender: NSMenuItem) {
        let doc = NSDocument()
        NSApp.sendAction(#selector(doc.duplicate(_:)), to: nil, from: self)
    }
    @objc
    func moveToShortcutAction(_ sender: NSMenuItem) {
        let doc = NSDocument()
        NSApp.sendAction(#selector(doc.move(_:)), to: nil, from: self)
    }
}
