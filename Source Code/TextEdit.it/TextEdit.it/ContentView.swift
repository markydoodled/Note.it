//
//  ContentView.swift
//  TextEdit.it
//
//  Created by Mark Howard on 06/02/2021.
//

import SwiftUI
import AppKit

struct ContentView: View {
    @Binding var document: TextEdit_itDocument
    @State private var text = ""
    @State private var isShowingShare = false
    @State private var isShowingInfo = false
    var body: some View {
        NavigationView {
            List {
                Button(action: {NSDocumentController().newDocument(Any?.self)}) {
                    Label("New", systemImage: "plus")
                }
                .buttonStyle(BorderlessButtonStyle())
                Button(action: {NSDocumentController().openDocument(Any?.self)}) {
                    Label("Open", systemImage: "doc")
                }
                .buttonStyle(BorderlessButtonStyle())
                Button(action: {NSApp.sendAction(#selector(NSDocument.save(_:)), to: nil, from: self)}) {
                    Label("Save", systemImage: "square.and.arrow.down")
                }
                .buttonStyle(BorderlessButtonStyle())
                Button(action: {copyToClipBoard(textToCopy: document.text)}) {
                    Label("Copy", systemImage: "doc.on.doc")
                }
                .buttonStyle(BorderlessButtonStyle())
                Button(action: {func printDoc() {
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
                    printDoc()
                }) {
                    Label("Print", systemImage: "printer")
                }
                .buttonStyle(BorderlessButtonStyle())
                Button(action: {self.isShowingShare = true}) {
                    Label("Share", systemImage: "square.and.arrow.up")
                }
                .buttonStyle(BorderlessButtonStyle())
                .background(SharingsPicker(isPresented: $isShowingShare, sharingItems: [NSDocumentController().currentDocument as Any]))
            }
        EditorControllerView(text: $document.text)
        }
            .toolbar {
                ToolbarItem(placement: .navigation) {
                    Button(action: {toggleSidebar()}) {
                        Image(systemName: "sidebar.left")
                    }
                }
            }
    }
}

struct EditorControllerView: NSViewControllerRepresentable {
    @Binding var text: String
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    class Coordinator: NSObject, NSTextStorageDelegate {
        private var parent: EditorControllerView
        var shouldUpdateText = true
        
        init(_ parent: EditorControllerView) {
            self.parent = parent
        }
        
        func textStorage(_ textStorage: NSTextStorage, didProcessEditing editedMask: NSTextStorageEditActions, range editedRange: NSRange, changeInLength delta: Int) {
            guard shouldUpdateText else {
                return
            }
            let edited = textStorage.attributedSubstring(from: editedRange).string
            let insertIndex = parent.text.utf16.index(parent.text.utf16.startIndex, offsetBy: editedRange.lowerBound)
            
            func numberOfCharactersToDelete() -> Int {
                editedRange.length - delta
            }
            
            let endIndex = parent.text.utf16.index(insertIndex, offsetBy: numberOfCharactersToDelete())
            self.parent.text.replaceSubrange(insertIndex..<endIndex, with: edited)
        }
    }

    func makeNSViewController(context: Context) -> EditorController {
        let vc = EditorController()
        vc.textView.textStorage?.delegate = context.coordinator
        return vc
    }
    
    func updateNSViewController(_ nsViewController: EditorController, context: Context) {
        if text != nsViewController.textView.string {
            context.coordinator.shouldUpdateText = false
            nsViewController.textView.string = text
            context.coordinator.shouldUpdateText = true
        }
    }
}

class EditorController: NSViewController {
var textView = NSTextView()
    
override func loadView() {
    let scrollView = NSScrollView()
    scrollView.hasVerticalScroller = true
    
    textView.autoresizingMask = [.width]
    textView.allowsUndo = false
    textView.isGrammarCheckingEnabled = true
    textView.isContinuousSpellCheckingEnabled = true
    textView.usesInspectorBar = true
    textView.usesFindBar = true
    scrollView.documentView = textView
    
    self.view = scrollView
}

override func viewDidAppear() {
    self.view.window?.makeFirstResponder(self.view)
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

struct ContentView_Previews: PreviewProvider {
static var previews: some View {
    ContentView(document: .constant(TextEdit_itDocument()))
}
}
