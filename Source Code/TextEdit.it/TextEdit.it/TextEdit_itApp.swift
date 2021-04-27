//
//  TextEdit_itApp.swift
//  TextEdit.it
//
//  Created by Mark Howard on 06/02/2021.
//

import SwiftUI
import CodeMirror_SwiftUI
import KeyboardShortcuts
import Preferences

@main
struct TextEdit_itApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        DocumentGroup(newDocument: TextEdit_itDocument()) { file in
            ContentView(document: file.$document, fileTypeAttribute: "", fileSizeAttribute: 0, fileTitleAtribute: "", fileCreatedAttribute: Date(), fileModifiedAttribute: Date(), fileExtensionAttribute: "", fileOwnerAttribute: "", filePathAttribute: "", fileCommentsAttribute: "", fileURL: URL(string: "/")!)
                .frame(minWidth: 850, idealWidth: .infinity, maxWidth: .infinity, minHeight: 400, idealHeight: .infinity, maxHeight: .infinity, alignment: .center)
        }
        /* .commands {
            SidebarCommands()
        }
        Settings {
            SettingsView()
        } */
    }
}

class AppMenu: NSMenu {
    private lazy var applicationName = ProcessInfo.processInfo.processName
    @objc
    func openPreferences(_ sender: NSMenuItem) {
        AppDelegate().preferencesWindowController.show()
    }
    @objc
    func revertToShortcutAction(_ sender: NSMenuItem) {
        let doc = NSDocument()
        NSApp.sendAction(#selector(doc.browseVersions(_:)), to: nil, from: self)
    }
    @objc
    func toggleSidebar() {
            NSApp.keyWindow?.firstResponder?.tryToPerform(#selector(NSSplitViewController.toggleSidebar(_:)), with: nil)
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
    func printShortcutAction(_ sender: NSMenuItem) {
        let printingView = NSHostingView(rootView: ContentView(document: .constant(TextEdit_itDocument()), fileTypeAttribute: "", fileSizeAttribute: 0, fileTitleAtribute: "", fileCreatedAttribute: Date(), fileModifiedAttribute: Date(), fileExtensionAttribute: "", fileOwnerAttribute: "", filePathAttribute: "", fileCommentsAttribute: "", fileURL: URL(string: "")!))
        let printView = NSTextView(frame: NSRect(x: 0, y: 0, width: 72*6, height: 72*8))
        printView.string = printingView.rootView.document.text
        
        let printInfo = NSPrintInfo()
        printInfo.bottomMargin = 72
        printInfo.topMargin = 72
        printInfo.leftMargin = 72
        printInfo.rightMargin = 72
        
        let printPanel = NSPrintPanel()
        printPanel.options = [.showsPageSetupAccessory, .showsCopies, .showsOrientation, .showsPageRange, .showsPaperSize, .showsPreview, .showsPrintSelection, .showsScaling]
        
        let printOperation = NSPrintOperation(view: printView, printInfo: printInfo)
        printOperation.view?.frame = .init(x: 0, y: 0, width: 500, height: 500)
        printOperation.showsPrintPanel = true
        printOperation.showsProgressPanel = true
        printOperation.printPanel = printPanel
        printOperation.run()
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
    @objc
    func closeAction(_ sender: NSMenuItem) {
        let window = NSWindow()
        NSApp.sendAction(#selector(window.performClose(_:)), to: nil, from: self)
    }
    @objc
    func renameAction(_ sender: NSMenuItem) {
        let doc = NSDocumentController()
        doc.currentDocument?.rename(Any?.self)
    }
    override init(title: String) {
        super.init(title: title)
        let mainMenu = NSMenuItem()
        mainMenu.submenu = NSMenu(title: "MainMenu")
        mainMenu.submenu?.items = [
        NSMenuItem(title: "About \(applicationName)", action: #selector(NSApplication.orderFrontStandardAboutPanel(_:)), keyEquivalent: ""),
        NSMenuItem.separator(),
            NSMenuItem(title: "Preferences...", action: #selector(openPreferences), keyEquivalent: ","),
        NSMenuItem.separator(),
        NSMenuItem(title: "Hide \(applicationName)", action: #selector(NSApplication.hide(_:)), keyEquivalent: "h"),
        NSMenuItem(title: "Hide Others", target: self, action: #selector(NSApplication.hideOtherApplications(_:)), keyEquivalent: "h", modifier: .init(arrayLiteral: [.command, .option])),
        NSMenuItem(title: "Show All", action: #selector(NSApplication.unhideAllApplications(_:)), keyEquivalent: ""),
        NSMenuItem.separator(),
        NSMenuItem(title: "Quit \(applicationName)", action: #selector(NSApplication.shared.terminate(_:)), keyEquivalent: "q")
        ]
        let editMenu = NSMenuItem()
        editMenu.submenu = NSMenu(title: "Edit")
        editMenu.submenu?.items = [
        NSMenuItem(title: "Undo", action: #selector(UndoManager.undo), keyEquivalent: "z"),
        NSMenuItem(title: "Redo", action: #selector(UndoManager.redo), keyEquivalent: "Z"),
        NSMenuItem.separator(),
        NSMenuItem(title: "Cut", action: #selector(NSText.cut(_:)), keyEquivalent: "x"),
        NSMenuItem(title: "Copy", action: #selector(NSText.copy(_:)), keyEquivalent: "c"),
        NSMenuItem(title: "Paste", action: #selector(NSText.paste(_:)), keyEquivalent: "v"),
        NSMenuItem.separator(),
        NSMenuItem(title: "Select All", action: #selector(NSText.selectAll(_:)), keyEquivalent: "a"),
        ]
        let viewMenu = NSMenuItem()
        viewMenu.submenu = NSMenu(title: "View")
        viewMenu.submenu?.items = [
            NSMenuItem(title: "Toggle Sidebar", action: #selector(toggleSidebar), keyEquivalent: "s", modifier: .init(arrayLiteral: [.command, .option]))
        ]
        let windowMenu = NSMenuItem()
        windowMenu.submenu = NSMenu(title: "Window")
        windowMenu.submenu?.items = [
         NSMenuItem(title: "Minmize", action: #selector(NSWindow.miniaturize(_:)), keyEquivalent: "m"),
        NSMenuItem(title: "Zoom", action: #selector(NSWindow.performZoom(_:)), keyEquivalent: ""),
        NSMenuItem.separator(),
            NSMenuItem(title: "Move Tab to New Window", action: #selector(NSWindow.moveTabToNewWindow(_:)), keyEquivalent: ""),
            NSMenuItem(title: "Merge All Windows", action: #selector(NSWindow.mergeAllWindows(_:)), keyEquivalent: ""),
            NSMenuItem.separator(),
        NSMenuItem(title: "Bring All to Front", action: #selector(NSApplication.arrangeInFront(_:)), keyEquivalent: ""),
        ]
        let helpMenu = NSMenuItem()
        helpMenu.submenu = NSMenu(title: "Help")
        helpMenu.submenu?.items = [
            NSMenuItem(title: "TextEdit.it Help", action: #selector(NSApplication.showHelp(_:)), keyEquivalent: ""),
        ]
        
        let fileMenuItem = NSMenuItem()

        let fileMenu2 = NSMenu()
        fileMenu2.title = "File"
        fileMenuItem.submenu = fileMenu2
        

        let newItem = NSMenuItem()
        newItem.title = "New"
        newItem.action = #selector(newShortcutAction)
        newItem.setShortcut(for: .newCommand)
        fileMenu2.addItem(newItem)

        let openItem = NSMenuItem()
        openItem.title = "Open"
        openItem.action = #selector(openShortcutAction)
        openItem.setShortcut(for: .openCommand)
        fileMenu2.addItem(openItem)
        

        fileMenu2.addItem(NSMenuItem.separator())
        
        let closeItem = NSMenuItem()
        closeItem.title = "Close"
        closeItem.action = #selector(closeAction)
        closeItem.setShortcut(for: .closeCommand)
        fileMenu2.addItem(closeItem)
        
        let saveItem = NSMenuItem()
        saveItem.title = "Save"
        saveItem.action = #selector(saveShortcutAction)
        saveItem.setShortcut(for: .saveCommand)
        fileMenu2.addItem(saveItem)
        
        let duplicateItem = NSMenuItem()
        duplicateItem.title = "Duplicate"
        duplicateItem.action = #selector(duplicateShortcutAction)
        duplicateItem.setShortcut(for: .duplicateCommand)
        fileMenu2.addItem(duplicateItem)
        
        let renameItem = NSMenuItem()
        renameItem.title = "Rename..."
        renameItem.action = #selector(renameAction)
        renameItem.setShortcut(for: .renameCommand)
        fileMenu2.addItem(renameItem)
        
        let moveToItem = NSMenuItem()
        moveToItem.title = "Move To..."
        moveToItem.action = #selector(moveToShortcutAction)
        moveToItem.setShortcut(for: .moveToCommand)
        fileMenu2.addItem(moveToItem)
        
        let revertToItem = NSMenuItem()
        revertToItem.title = "Revert To..."
        revertToItem.action = #selector(revertToShortcutAction)
        revertToItem.setShortcut(for: .revertToCommand)
        fileMenu2.addItem(revertToItem)
        
        fileMenu2.addItem(NSMenuItem.separator())
        
        let printItem = NSMenuItem()
        printItem.title = "Print"
        printItem.action = #selector(printShortcutAction)
        printItem.setShortcut(for: .printCommand)
        fileMenu2.addItem(printItem)
        
        fileMenu2.addItem(NSMenuItem.separator())
        
        fileMenu2.addItem(NSDocumentController().standardShareMenuItem())
        
        items = [mainMenu, fileMenuItem, editMenu, viewMenu, windowMenu, helpMenu]
        NSApplication.shared.helpMenu = helpMenu.submenu
        NSApplication.shared.windowsMenu = windowMenu.submenu
    }
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    lazy var preferencesWindowController = PreferencesWindowController(
        panes: [Preferences.Pane(identifier: .keyboard, title: "Keyboard", toolbarIcon: NSImage(systemSymbolName: "keyboard", accessibilityDescription: "Keyboard Preferences")!) {KeyboardSettings()}, Preferences.Pane(identifier: .editor, title: "Editor", toolbarIcon: NSImage(systemSymbolName: "note.text", accessibilityDescription: "Editor Preferences")!) {EditorSettings()}, Preferences.Pane(identifier: .themes, title: "Themes", toolbarIcon: NSImage(systemSymbolName: "paintbrush", accessibilityDescription: "Themes Preferences")!) {ThemesSettings()}, Preferences.Pane(identifier: .misc, title: "Misc.", toolbarIcon: NSImage(systemSymbolName: "ellipsis.circle", accessibilityDescription: "Misc. Preferences")!) {MiscSettings()}],
        style: .toolbarItems,
        animated: false
    )
    @objc
    func openPreferences(_ sender: NSMenuItem) {
        preferencesWindowController.show()
    }
    func applicationDidFinishLaunching(_ notification: Notification) {
        let menu = AppMenu()
        NSApp.mainMenu = menu
    }
    @objc
    func revertToShortcutAction(_ sender: NSMenuItem) {
        let doc = NSDocument()
        NSApp.sendAction(#selector(doc.browseVersions(_:)), to: nil, from: self)
    }
    @objc
    func toggleSidebar() {
            NSApp.keyWindow?.firstResponder?.tryToPerform(#selector(NSSplitViewController.toggleSidebar(_:)), with: nil)
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
    func printShortcutAction(_ sender: NSMenuItem) {
         let printingView = NSHostingView(rootView: ContentView(document: .constant(TextEdit_itDocument()), fileTypeAttribute: "", fileSizeAttribute: 0, fileTitleAtribute: "", fileCreatedAttribute: Date(), fileModifiedAttribute: Date(), fileExtensionAttribute: "", fileOwnerAttribute: "", filePathAttribute: "", fileCommentsAttribute: "", fileURL: (NSDocument().presentedItemURL ?? URL(string: "/Users/markhoward/Downloads/Test.textedit"))!))
        let printView = NSTextView(frame: NSRect(x: 0, y: 0, width: 72*6, height: 72*8))
        printView.string = printingView.rootView.document.text
        
        let printInfo = NSPrintInfo()
        printInfo.bottomMargin = 72
        printInfo.topMargin = 72
        printInfo.leftMargin = 72
        printInfo.rightMargin = 72
        
        let printPanel = NSPrintPanel()
        printPanel.options = [.showsPageSetupAccessory, .showsCopies, .showsOrientation, .showsPageRange, .showsPaperSize, .showsPreview, .showsPrintSelection, .showsScaling]
        
        let printOperation = NSPrintOperation(view: printView, printInfo: printInfo)
        printOperation.view?.frame = .init(x: 0, y: 0, width: 500, height: 500)
        printOperation.showsPrintPanel = true
        printOperation.showsProgressPanel = true
        printOperation.printPanel = printPanel
        printOperation.run()
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
    @objc
    func closeAction(_ sender: NSMenuItem) {
        let window = NSWindow()
        NSApp.sendAction(#selector(window.performClose(_:)), to: nil, from: self)
    }
    @objc
    func renameAction(_ sender: NSMenuItem) {
        let doc = NSDocumentController()
        doc.currentDocument?.rename(Any?.self)
    }
}

extension NSMenuItem {
convenience init(title string: String, target: AnyObject = self as AnyObject, action selector: Selector?, keyEquivalent charCode: String, modifier: NSEvent.ModifierFlags = .command) {
self.init(title: string, action: selector, keyEquivalent: charCode)
keyEquivalentModifierMask = modifier
self.target = target
}
convenience init(title string: String, submenuItems: [NSMenuItem]) {
self.init(title: string, action: nil, keyEquivalent: "")
self.submenu = NSMenu()
self.submenu?.items = submenuItems
}
}

extension Preferences.PaneIdentifier {
    static let keyboard = Self("keyboard")
    static let editor = Self("editor")
    static let themes = Self("themes")
    static let misc = Self("misc")
}
