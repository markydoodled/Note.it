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
    @State private var text = ""
    @State var codeMode = CodeMode.swift.mode()
    @State var codeTheme = CodeViewTheme.zenburnesque
    @State var settings = SettingsView()
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Metadata")) {
                    Text("Title")
                        .bold()
                    Text("File Type")
                        .bold()
                    Text("Author")
                        .bold()
                    Text("Encoding")
                        .bold()
                    Text("Comments")
                        .bold()
                    Text("Created")
                        .bold()
                    Text("Last Editor")
                        .bold()
                    Text("Modified")
                        .bold()
                }
            }
            .listStyle(SidebarListStyle())
            GeometryReader { reader in
              ScrollView {
                CodeView(theme: codeTheme,
                        code: $document.text,
                         mode: codeMode,
                         fontSize: settings.fontSize,
                         showInvisibleCharacters: settings.showInvisibleCharacters,
                         lineWrapping: settings.lineWrapping)
                  .onLoadSuccess {
                    print("Loaded")
                  }
                  .onLoadFail { error in
                    print("Load failed : \(error.localizedDescription)")
                  }
                  .frame(height: reader.size.height)
              }.frame(height: reader.size.height)
            }
        }
        .onAppear {
            self.test()
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
                Button(action: {printDoc()}) {
                    Image(systemName: "printer")
                }
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
                }
                ToolbarItem(placement: .status) {
                    Button(action: {NSDocumentController().newDocument(Any?.self)}) {
                        Image(systemName: "plus")
                    }
                }
                ToolbarItem(placement: .status) {
                    Button(action: {NSDocumentController().openDocument(Any?.self)}) {
                        Image(systemName: "doc")
                    }
                }
                ToolbarItem(placement: .status) {
                    Button(action: {NSApp.sendAction(#selector(NSDocument.save(_:)), to: nil, from: self)}) {
                        Image(systemName: "square.and.arrow.down")
                    }
                }
                ToolbarItem(placement: .status) {
                    Menu {
                        Button(action: {copyToClipBoard(textToCopy: document.text)}) {
                            Text("􀉁 Copy")
                        }
                        Button(action: {printDoc()}) {
                            Text("􀎚 Print")
                        }
                        Button(action: {NSApp.sendAction(#selector(NSDocument.move(_:)), to: nil, from: self)}) {
                            Text("􀈕 Move To...")
                        }
                        Button(action: {NSApp.sendAction(#selector(NSDocument.duplicate(_:)), to: nil, from: self)}) {
                            Text("􀣗 Duplicate")
                        }
                    } label: {
                        Label("More", systemImage: "ellipsis.circle")
                }
                }
            }
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
            printOp.run()
    }
    func test() {
        let testMenuItem = NSMenuItem()
        NSApp.mainMenu?.addItem(testMenuItem)

        let testMenu = NSMenu()
        testMenu.title = "Test"
        testMenuItem.submenu = testMenu

        let shortcut1 = NSMenuItem()
        shortcut1.title = "Shortcut 1"
        shortcut1.setShortcut(for: .newCommand)
        testMenu.addItem(shortcut1)
    }
}

public func toggleSidebar() {
        NSApp.keyWindow?.firstResponder?.tryToPerform(#selector(NSSplitViewController.toggleSidebar(_:)), with: nil)
    }

struct SharingsPicker: NSViewRepresentable {
    @Binding var isPresented: Bool
    var sharingItems: [Any] = []

    func makeNSView(context: Context) -> NSView {
        let view = NSView()
        return view
    }

    func updateNSView(_ nsView: NSView, context: Context) {
        if isPresented {
            let picker = NSSharingServicePicker(items: sharingItems)
            picker.delegate = context.coordinator

            // !! MUST BE CALLED IN ASYNC, otherwise blocks update
            DispatchQueue.main.async {
                picker.show(relativeTo: .zero, of: nsView, preferredEdge: .minY)
            }
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(owner: self)
    }

    class Coordinator: NSObject, NSSharingServicePickerDelegate {
        let owner: SharingsPicker

        init(owner: SharingsPicker) {
            self.owner = owner
        }

        func sharingServicePicker(_ sharingServicePicker: NSSharingServicePicker, didChoose service: NSSharingService?) {

            // do here whatever more needed here with selected service

            sharingServicePicker.delegate = nil   // << cleanup
            self.owner.isPresented = false        // << dismiss
        }
    }
}

private func copyToClipBoard(textToCopy: String) {
    let pasteBoard = NSPasteboard.general
    pasteBoard.clearContents()
    pasteBoard.setString(textToCopy, forType: .string)

}
