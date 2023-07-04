//
//  ContentView.swift
//  Note.it
//
//  Created by Mark Howard on 19/06/2023.
//

import SwiftUI
import AppKit
import CodeMirror_SwiftUI

struct ContentView: View {
    @Binding var document: Note_itDocument
    @State var editor = EditorSettings()
    @State var themes = ThemeSettings()
    private let fileByteCountFormatter: ByteCountFormatter = {
        let bcf = ByteCountFormatter()
        bcf.allowedUnits = [.useAll]
        bcf.countStyle = .file
        return bcf
    }()
    @State var fileURL: URL
    @State var fileTypeAttribute: String
    @State var fileSizeAttribute: Int64
    @State var fileTitleAtribute: String
    @State var fileCreatedAttribute: Date
    @State var fileModifiedAttribute: Date
    @State var fileExtensionAttribute: String
    @State var fileOwnerAttribute: String
    @State var filePathAttribute: String
    @AppStorage("selectedAppearance") var selectedAppearance = 3
    var body: some View {
        NavigationSplitView {
            List {
                Section {
                    Text("\(NSDocumentController().currentDocument?.displayName ?? "None")")
                } header: {
                    Label("Title", systemImage: "textformat")
                }
                .collapsible(false)
                Section {
                    Text("\(fileExtensionAttribute)")
                } header: {
                    Label("Extension", systemImage: "square.grid.3x1.folder.badge.plus")
                }
                .collapsible(false)
                Section {
                    Text("\(fileByteCountFormatter.string(fromByteCount: fileSizeAttribute))")
                } header: {
                    Label("Size", systemImage: "externaldrive")
                }
                .collapsible(false)
                Section {
                    Text("\(filePathAttribute)")
                } header: {
                    Label("Path", systemImage: "point.topleft.down.curvedto.point.bottomright.up")
                }
                .collapsible(false)
                Section {
                    Text("\(fileOwnerAttribute)")
                } header: {
                    Label("Owner", systemImage: "person")
                }
                .collapsible(false)
                Section {
                    Text("\(fileCreatedAttribute.formatted(.dateTime))")
                } header: {
                    Label("Created", systemImage: "calendar.badge.plus")
                }
                .collapsible(false)
                Section {
                    Text("\(fileModifiedAttribute.formatted(.dateTime))")
                } header: {
                    Label("Modified", systemImage: "calendar.badge.clock")
                }
                .collapsible(false)
                Section {
                    Text("\(fileTypeAttribute)")
                } header: {
                    Label("File Type", systemImage: "doc")
                }
                .collapsible(false)
            }
            .frame(minWidth: 250)
        } detail: {
            GeometryReader { reader in
                ScrollView {
                    CodeView(theme: themes.theme, code: $document.text, mode: themes.syntax.mode(), fontSize: editor.fontSize, showInvisibleCharacters: editor.showInvisibleCharacters, lineWrapping: editor.lineWrapping)
                        .onLoadSuccess {
                            fileURL = NSDocumentController().currentDocument?.fileURL ?? URL(string: "/")!
                            getAttributes()
                        }
                        .onLoadFail { error in
                            print("Load Failed: \(error.localizedDescription)")
                        }
                        .onContentChange { change in
                            fileURL = NSDocumentController().currentDocument?.fileURL ?? URL(string: "/")!
                            getAttributes()
                        }
                        .frame(height: reader.size.height)
                }
                .frame(height: reader.size.height)
            }
                .toolbar(id: "quick-actions") {
                    ToolbarItem(id: "update-metadata", placement: .status) {
                        Button(action: {
                            fileURL = NSDocumentController().currentDocument?.fileURL ?? URL(string: "/")!
                            getAttributes()
                        }) {
                            Label("Update Metadata", systemImage: "arrow.counterclockwise")
                        }
                        .help("Update Metadata")
                    }
                    ToolbarItem(id: "change-appearance", placement: .status) {
                        Menu {
                            Button(action: {selectedAppearance = 1}) {
                                Text("Light")
                            }
                            Button(action: {selectedAppearance = 2}) {
                                Text("Dark")
                            }
                            Button(action: {selectedAppearance = 3}) {
                                Text("System")
                            }
                        } label: {
                            Label("Appearance", systemImage: "cloud.sun")
                        }
                        .help("Change Appearance")
                    }
                    ToolbarItem(id: "new-doc", placement: .secondaryAction) {
                        Button(action: {NSDocumentController().newDocument(Any?.self)}) {
                            Label("New", systemImage: "doc.badge.plus")
                        }
                        .help("New Document")
                    }
                    ToolbarItem(id: "open-doc", placement: .secondaryAction) {
                        Button(action: {NSDocumentController().openDocument(Any?.self)}) {
                            Label("Open", systemImage: "doc.badge.arrow.up")
                        }
                        .help("Open Document")
                    }
                    ToolbarItem(id: "save-doc", placement: .secondaryAction) {
                        Button(action: {NSApp.sendAction(#selector(NSDocument.save(_:)), to: nil, from: self)}) {
                            Label("Save", systemImage: "square.and.arrow.down")
                        }
                        .help("Save Document")
                    }
                    ToolbarItem(id: "copy-doc", placement: .secondaryAction) {
                        Button(action: {copyToClipBoard(textToCopy: document.text)}) {
                            Label("Copy", systemImage: "text.badge.plus")
                        }
                        .help("Copy Text")
                    }
                    ToolbarItem(id: "move-doc", placement: .secondaryAction) {
                        Button(action: {NSApp.sendAction(#selector(NSDocument.move(_:)), to: nil, from: self)}) {
                            Label("Move", systemImage: "folder")
                        }
                        .help("Move Document")
                    }
                    ToolbarItem(id: "duplicate-doc", placement: .secondaryAction) {
                        Button(action: {NSApp.sendAction(#selector(NSDocument.duplicate(_:)), to: nil, from: self)}) {
                            Label("Duplicate", systemImage: "doc.on.doc")
                        }
                        .help("Duplicate Document")
                    }
                }
                .toolbarRole(.editor)
        }
        .touchBar {
            Button(action: {
                fileURL = NSDocumentController().currentDocument?.fileURL ?? URL(string: "/")!
                getAttributes()
            }) {
                Label("Metadata", systemImage: "arrow.counterclockwise")
            }
            Button(action: {NSDocumentController().newDocument(Any?.self)}) {
                Label("New", systemImage: "doc.badge.plus")
            }
            Button(action: {NSDocumentController().openDocument(Any?.self)}) {
                Label("Open", systemImage: "doc.badge.arrow.up")
            }
            Button(action: {NSApp.sendAction(#selector(NSDocument.save(_:)), to: nil, from: self)}) {
                Label("Save", systemImage: "square.and.arrow.down")
            }
            Button(action: {copyToClipBoard(textToCopy: document.text)}) {
                Label("Copy", systemImage: "text.badge.plus")
            }
            Button(action: {NSApp.sendAction(#selector(NSDocument.move(_:)), to: nil, from: self)}) {
                Label("Move", systemImage: "folder")
            }
            Button(action: {NSApp.sendAction(#selector(NSDocument.duplicate(_:)), to: nil, from: self)}) {
                Label("Duplicate", systemImage: "doc.on.doc")
            }
        }
        .onAppear() {
            if selectedAppearance == 1 {
                NSApp.appearance = NSAppearance(named: .aqua)
            } else if selectedAppearance == 2 {
                NSApp.appearance = NSAppearance(named: .darkAqua)
            } else {
                NSApp.appearance = nil
            }
            fileURL = NSDocumentController().currentDocument?.fileURL ?? URL(string: "/")!
            getAttributes()
        }
        .onChange(of: selectedAppearance) { appearance in
            if selectedAppearance == 1 {
                NSApp.appearance = NSAppearance(named: .aqua)
            } else if selectedAppearance == 2 {
                NSApp.appearance = NSAppearance(named: .darkAqua)
            } else {
                NSApp.appearance = nil
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
    private func copyToClipBoard(textToCopy: String) {
        let pasteBoard = NSPasteboard.general
        pasteBoard.clearContents()
        pasteBoard.setString(textToCopy, forType: .string)

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(document: .constant(Note_itDocument()), fileURL: URL(string: "/")!, fileTypeAttribute: "", fileSizeAttribute: 0, fileTitleAtribute: "", fileCreatedAttribute: Date(), fileModifiedAttribute: Date(), fileExtensionAttribute: "", fileOwnerAttribute: "", filePathAttribute: "")
    }
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
