//
//  ContentView.swift
//  TextEdit.it
//
//  Created by Mark Howard on 06/02/2021.
//

import SwiftUI
import AppKit
import CodeMirror_SwiftUI
import KeyboardShortcuts

struct ContentView: View {
    @Binding var document: TextEdit_itDocument
    @State var editor = EditorSettings()
    @State var themes = ThemesSettings()
    @State var fileTypeAttribute: String
    @State var fileSizeAttribute: Int64
    @State var fileTitleAtribute: String
    @State var fileCreatedAttribute: Date
    @State var fileModifiedAttribute: Date
    @State var fileExtensionAttribute: String
    @State var fileOwnerAttribute: String
    @State var filePathAttribute: String
    @State var fileCommentsAttribute: String
    private let fileByteCountFormatter: ByteCountFormatter = {
        let bcf = ByteCountFormatter()
        bcf.allowedUnits = [.useAll]
        bcf.countStyle = .file
        return bcf
    }()
    @State var fileURL: URL
    @State var showNoURLWarning = false
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Metadata")) {
                    Group {
                        Text("􀅑 ")
                            .bold()
                            .foregroundColor(.accentColor)
                        + Text("Title")
                        .bold()
                            .foregroundColor(.secondary)
                        Text("\(NSDocumentController().currentDocument?.displayName ?? "None")")
                    Text("􀣕 ")
                        .bold()
                        .foregroundColor(.accentColor)
                    + Text("File Extension")
                        .bold()
                        .foregroundColor(.secondary)
                        Text("\(fileExtensionAttribute)")
                        Text("􀤂 ")
                            .bold()
                            .foregroundColor(.accentColor)
                     + Text("Size")
                        .bold()
                        .foregroundColor(.secondary)
                        Text("\(fileByteCountFormatter.string(fromByteCount: fileSizeAttribute))")
                    Text("􀣱 ")
                        .bold()
                        .foregroundColor(.accentColor)
                     + Text("File Path")
                        .bold()
                        .foregroundColor(.secondary)
                        Text("\(filePathAttribute)")
                    Text("􀉩 ")
                        .bold()
                        .foregroundColor(.accentColor)
                     + Text("Owner")
                        .bold()
                        .foregroundColor(.secondary)
                        Text("\(fileOwnerAttribute)")
                    }
                    Group {
                        Text("􀉊 ")
                            .bold()
                            .foregroundColor(.accentColor)
                         + Text("Created")
                            .bold()
                            .foregroundColor(.secondary)
                        Text("\(fileCreatedAttribute)")
                        Text("􀧞 ")
                            .bold()
                            .foregroundColor(.accentColor)
                         + Text("Modified")
                            .bold()
                            .foregroundColor(.secondary)
                        Text("\(fileModifiedAttribute)")
                        Text("􀈷 ")
                            .bold()
                            .foregroundColor(.accentColor)
                         + Text("File Type")
                            .bold()
                            .foregroundColor(.secondary)
                        Text("\(fileTypeAttribute)")
                }
                }
                if showNoURLWarning == true {
                    Text("􀅴 ").foregroundColor(.orange) + Text("Please Save")
                    Text("Or Press Update")
                    Text("To Get Metadata.")
                }
                Button(action: {fileURL = NSDocumentController().currentDocument?.fileURL ?? URL(string: "/")!
                            getAttributes()
                    self.showNoURLWarning = false
                }) {
                        Text("Update")
                    }
                    .padding(.horizontal)
            }
            .listStyle(SidebarListStyle())
            GeometryReader { reader in
              ScrollView {
                CodeView(theme: themes.theme,
                        code: $document.text,
                        mode: themes.syntax.mode(),
                         fontSize: editor.fontSize,
                         showInvisibleCharacters: editor.showInvisibleCharacters,
                         lineWrapping: editor.lineWrapping)
                  .onLoadSuccess {
                    print("Loaded")
                  }
                    .onContentChange { newCodeBlock in
                        if fileURL == URL(string: "/") {
                            self.showNoURLWarning = true
                        } else {
                            self.showNoURLWarning = false
                        }
                    }
                  .onLoadFail { error in
                    print("Load failed : \(error.localizedDescription)")
                  }
                  .frame(height: reader.size.height)
              }.frame(height: reader.size.height)
            }
        }
            .touchBar {
                Button(action: {NSDocumentController().newDocument(Any?.self)}) {
                    Image(systemName: "plus")
                }
                Button(action: {NSDocumentController().openDocument(Any?.self)}) {
                    Image(systemName: "doc")
                }
                Button(action: {NSApp.sendAction(#selector(NSDocument.save(_:)), to: nil, from: self)}) {
                    Image(systemName: "square.and.arrow.down")
                }
                Button(action: {copyToClipBoard(textToCopy: document.text)}) {
                    Image(systemName: "doc.on.doc")
                }
                /* Button(action: {printDoc()}) {
                    Image(systemName: "printer")
                } */
                Button(action: {NSApp.sendAction(#selector(NSDocument.move(_:)), to: nil, from: self)}) {
                    Image(systemName: "folder")
                }
                Button(action: {NSApp.sendAction(#selector(NSDocument.duplicate(_:)), to: nil, from: self)}) {
                    Image(systemName: "doc.badge.plus")
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigation) {
                    Button(action: {toggleSidebar()}) {
                        Image(systemName: "sidebar.left")
                    }
                    .help(Text("Toggle Sidebar"))
                }
                ToolbarItem(placement: .status) {
                    Button(action: {NSDocumentController().newDocument(Any?.self)}) {
                        Image(systemName: "plus")
                    }
                    .help(Text("New"))
                }
                ToolbarItem(placement: .status) {
                    Button(action: {NSDocumentController().openDocument(Any?.self)}) {
                        Image(systemName: "doc")
                    }
                    .help(Text("Open"))
                }
                ToolbarItem(placement: .status) {
                    Button(action: {NSApp.sendAction(#selector(NSDocument.save(_:)), to: nil, from: self)}) {
                        Image(systemName: "square.and.arrow.down")
                    }
                    .help(Text("Save"))
                }
                ToolbarItem(placement: .status) {
                    Button(action: {copyToClipBoard(textToCopy: document.text)}) {
                        Image(systemName: "doc.on.doc")
                    }
                    .help(Text("Copy"))
                }
                ToolbarItem(placement: .status) {
                    Button(action: {NSApp.sendAction(#selector(NSDocument.move(_:)), to: nil, from: self)}) {
                        Image(systemName: "folder")
                    }
                    .help(Text("Move To…"))
                }
                ToolbarItem(placement: .status) {
                    Button(action: {NSApp.sendAction(#selector(NSDocument.duplicate(_:)), to: nil, from: self)}) {
                        Image(systemName: "doc.badge.plus")
                    }
                    .help(Text("Duplicate"))
                }
                /* ToolbarItem(placement: .status) {
                    Menu {
                        Button(action: {copyToClipBoard(textToCopy: document.text)}) {
                            Text("􀉁 Copy")
                        }
                        Button(action: {printDoc()}) {
                            Text("􀎚 Print")
                        }
                        Button(action: {NSApp.sendAction(#selector(NSDocument.move(_:)), to: nil, from: self)}) {
                            Text("􀈕 Move To…")
                        }
                        Button(action: {NSApp.sendAction(#selector(NSDocument.duplicate(_:)), to: nil, from: self)}) {
                            Text("􀣗 Duplicate")
                        }
                    } label: {
                        Label("More", systemImage: "ellipsis.circle")
                }
                } */
            }
    }
    func getAttributes() {
        let creationDate = fileURL.creationDate
        let modificationDate = fileURL.modificationDate
        let type = fileURL.fileType
        let owner = fileURL.fileOwner
        let size = fileURL.fileSize
        let fileextension = fileURL.pathExtension
        let filePath = fileURL.path
        filePathAttribute = filePath
        fileExtensionAttribute = fileextension
        fileSizeAttribute = Int64(size)
        fileOwnerAttribute = owner
        fileTypeAttribute = type
        fileModifiedAttribute = modificationDate!
        fileCreatedAttribute = creationDate!
    }
    func printDoc() {
        let printView = NSTextView(frame: NSRect(x: 0, y: 0, width: 72*6, height: 72*8))
        printView.string = document.text
            let printInfo = NSPrintInfo()

            printInfo.bottomMargin = 72
            printInfo.topMargin = 72
            printInfo.leftMargin = 72
            printInfo.rightMargin = 72
        
        let printPanel = NSPrintPanel()
        printPanel.options = [.showsPageSetupAccessory, .showsCopies, .showsOrientation, .showsPageRange, .showsPaperSize, .showsPreview, .showsPrintSelection, .showsScaling]

            let printOp = NSPrintOperation(view: printView, printInfo: printInfo)
        printOp.printPanel = printPanel
        printOp.showsPrintPanel = true
        printOp.showsProgressPanel = true
            printOp.run()
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
            
            let printOperation = NSPrintOperation(view: printingView, printInfo: printInfo)
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
        override init(title: String) {
            super.init(title: title)
            let mainMenu = NSMenuItem()
            mainMenu.submenu = NSMenu(title: "MainMenu")
            mainMenu.submenu?.items = [
            NSMenuItem(title: "About \(applicationName)", action: #selector(NSApplication.orderFrontStandardAboutPanel(_:)), keyEquivalent: ""),
            NSMenuItem.separator(),
                NSMenuItem(title: "Preferences…", action: #selector(openPreferences), keyEquivalent: ","),
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
                NSMenuItem(title: "Note.it Help", action: #selector(NSApplication.showHelp(_:)), keyEquivalent: ""),
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
            renameItem.title = "Rename…"
            renameItem.action = #selector(renameAction)
            renameItem.setShortcut(for: .renameCommand)
            fileMenu2.addItem(renameItem)
            
            let moveToItem = NSMenuItem()
            moveToItem.title = "Move To…"
            moveToItem.action = #selector(moveToShortcutAction)
            moveToItem.setShortcut(for: .moveToCommand)
            fileMenu2.addItem(moveToItem)
            
            let revertToItem = NSMenuItem()
            revertToItem.title = "Revert To…"
            revertToItem.action = #selector(revertToShortcutAction)
            revertToItem.setShortcut(for: .revertToCommand)
            fileMenu2.addItem(revertToItem)
            
            fileMenu2.addItem(NSMenuItem.separator())
            
            /* let printItem = NSMenuItem()
            printItem.title = "Print"
            printItem.action = #selector(printShortcutAction)
            printItem.setShortcut(for: .printCommand)
            fileMenu2.addItem(printItem)
            
            fileMenu2.addItem(NSMenuItem.separator()) */
            
            fileMenu2.addItem(NSDocumentController().standardShareMenuItem())
            
            items = [mainMenu, fileMenuItem, editMenu, viewMenu, windowMenu, helpMenu]
            NSApplication.shared.helpMenu = helpMenu.submenu
            NSApplication.shared.windowsMenu = windowMenu.submenu
        }
        required init(coder: NSCoder) {
            super.init(coder: coder)
        }
    }
}

public func toggleSidebar() {
        NSApp.keyWindow?.firstResponder?.tryToPerform(#selector(NSSplitViewController.toggleSidebar(_:)), with: nil)
    }

private func copyToClipBoard(textToCopy: String) {
    let pasteBoard = NSPasteboard.general
    pasteBoard.clearContents()
    pasteBoard.setString(textToCopy, forType: .string)

}

extension URL {
    var attributes: [FileAttributeKey : Any]? {
        do {
            return try FileManager.default.attributesOfItem(atPath: path)
        } catch let error as NSError {
            print("FileAttribute error: \(error)")
        }
        return nil
    }

    var fileSize: UInt64 {
        return attributes?[.size] as? UInt64 ?? UInt64(0)
    }

    var fileSizeString: String {
        return ByteCountFormatter.string(fromByteCount: Int64(fileSize), countStyle: .file)
    }

    var creationDate: Date? {
        return attributes?[.creationDate] as? Date
    }
    
    var fileType: String {
        return attributes?[.type] as? String ?? ""
    }
    
    var modificationDate: Date? {
        return attributes?[.modificationDate] as? Date
    }
    
    var fileOwner: String {
        return attributes?[.ownerAccountName] as? String ?? ""
    }
}
