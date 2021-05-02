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
        let menu = ContentView.AppMenu()
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
    /* @objc
    func printShortcutAction(_ sender: NSMenuItem) {
       let printingView = NSHostingView(rootView: ContentView(document: .constant(TextEdit_itDocument()), fileTypeAttribute: "", fileSizeAttribute: 0, fileTitleAtribute: "", fileCreatedAttribute: Date(), fileModifiedAttribute: Date(), fileExtensionAttribute: "", fileOwnerAttribute: "", filePathAttribute: "", fileCommentsAttribute: "", fileURL: URL(string: "/")!))
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
    } */
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
