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
    let fileURL: URL
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
                Button(action: {getAttributes()}) {
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
                  .onLoadFail { error in
                    print("Load failed : \(error.localizedDescription)")
                  }
                  .frame(height: reader.size.height)
              }.frame(height: reader.size.height)
            }
        }
        .onAppear {
            print("Name: \(fileURL.lastPathComponent), Size: \(fileURL.fileSizeString), Type: \(fileURL.fileType), Date: \(fileURL.creationDate ?? Date()), Extension: \(fileURL.pathExtension), Modification: \(fileURL.modificationDate ?? Date()), Owner: \(fileURL.fileOwner)")
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
            printOp.run()
    }
    func attributes() {
        let fileManager = FileManager.default

        if let documentsURLs = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first {
            do {
                let fileNames = try fileManager.contentsOfDirectory(atPath: documentsURLs.path)

                for fileName in fileNames {
                    let fileURL = documentsURLs.appendingPathComponent(fileName)

                    let fileAttribute = try fileManager.attributesOfItem(atPath: fileURL.path)
                    let fileSize = fileAttribute[FileAttributeKey.size] as! Int64
                    let fileType = fileAttribute[FileAttributeKey.type] as! String
                    let filecreationDate = fileAttribute[FileAttributeKey.creationDate] as! Date
                    let filemodificationDate = fileAttribute[FileAttributeKey.modificationDate] as! Date
                    let fileOwner = fileAttribute[FileAttributeKey.ownerAccountName] as! String
                    let fileExtension = fileURL.pathExtension;

                    print("Name: \(fileName), Size: \(fileSize), Type: \(fileType), Date: \(filecreationDate), Extension: \(fileExtension), Modification: \(filemodificationDate), Owner: \(fileOwner)")
                    fileTypeAttribute = fileType
                    fileSizeAttribute = fileSize
                    fileTitleAtribute = fileName
                    fileCreatedAttribute = filecreationDate
                    fileModifiedAttribute = filemodificationDate
                    fileExtensionAttribute = fileExtension
                    fileOwnerAttribute = fileOwner
                }
            } catch {
                print("Error: \(error)")
            }
        }
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
