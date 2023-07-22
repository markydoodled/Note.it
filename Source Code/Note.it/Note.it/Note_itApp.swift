//
//  Note_itApp.swift
//  Note.it
//
//  Created by Mark Howard on 19/06/2023.
//

import SwiftUI

@main
struct Note_itApp: App {
    var body: some Scene {
        DocumentGroup(newDocument: Note_itDocument()) { file in
            ContentView(document: file.$document, fileURL: URL(string: "/")!, fileTypeAttribute: "N/A", fileSizeAttribute: 0, fileTitleAtribute: "N/A", fileCreatedAttribute: Date(), fileModifiedAttribute: Date(), fileExtensionAttribute: "N/A", fileOwnerAttribute: "N/A", filePathAttribute: "N/A")
                .frame(minWidth: 850, minHeight: 400)
                .focusedSceneValue(\.document, file.$document)
        }
        .commands {
            SidebarCommands()
            ToolbarCommands()
            CommandGroup(replacing: .importExport) {
                ExportCommandView()
            }
        }
        Settings {
            SettingsView()
                .frame(width: 600, height: 400)
        }
    }
}

struct ExportCommandView: View {
    @FocusedBinding(\.document) var document
    
    @State var isShowingSwiftSourceExport = false
    @State var isShowingPlainTextExport = false
    @State var isShowingXMLExport = false
    @State var isShowingYAMLExport = false
    @State var isShowingJSONExport = false
    @State var isShowingHTMLExport = false
    @State var isShowingAssemblyExport = false
    @State var isShowingCHeaderExport = false
    @State var isShowingCSourceExport = false
    @State var isShowingCPlusPlusHeaderExport = false
    @State var isShowingCPlusPlusSourceExport = false
    @State var isShowingObjectiveCPlusPlusSourceExport = false
    @State var isShowingObjectiveCSourceExport = false
    @State var isShowingAppleScriptExport = false
    @State var isShowingJavaScriptExport = false
    @State var isShowingShellScriptExport = false
    @State var isShowingPythonScriptExport = false
    @State var isShowingRubyScriptExport = false
    @State var isShowingPerlScriptExport = false
    @State var isShowingPHPScriptExport = false
    var body: some View {
        Menu("Export As") {
            Group {
                Button(action: {isShowingSwiftSourceExport.toggle()}) {
                    Text("Swift")
                }
                .fileExporter(isPresented: $isShowingSwiftSourceExport, document: document, contentType: .swiftSource, defaultFilename: "Exported File") { result in
                    switch result {
                    case .success(let url):
                        print("Saved To \(url)")
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
                Button(action: {isShowingPlainTextExport.toggle()}) {
                    Text("Plain Text")
                }
                .fileExporter(isPresented: $isShowingPlainTextExport, document: document, contentType: .plainText, defaultFilename: "Exported File") { result in
                    switch result {
                    case .success(let url):
                        print("Saved To \(url)")
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
                Button(action: {isShowingXMLExport.toggle()}) {
                    Text("XML")
                }
                .fileExporter(isPresented: $isShowingXMLExport, document: document, contentType: .xml, defaultFilename: "Exported File") { result in
                    switch result {
                    case .success(let url):
                        print("Saved To \(url)")
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
                Button(action: {isShowingYAMLExport.toggle()}) {
                    Text("YAML")
                }
                .fileExporter(isPresented: $isShowingYAMLExport, document: document, contentType: .yaml, defaultFilename: "Exported File") { result in
                    switch result {
                    case .success(let url):
                        print("Saved To \(url)")
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
                Button(action: {isShowingJSONExport.toggle()}) {
                    Text("JSON")
                }
                .fileExporter(isPresented: $isShowingJSONExport, document: document, contentType: .json, defaultFilename: "Exported File") { result in
                    switch result {
                    case .success(let url):
                        print("Saved To \(url)")
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
                Button(action: {isShowingHTMLExport.toggle()}) {
                    Text("HTML")
                }
                .fileExporter(isPresented: $isShowingHTMLExport, document: document, contentType: .html, defaultFilename: "Exported File") { result in
                    switch result {
                    case .success(let url):
                        print("Saved To \(url)")
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
                Button(action: {isShowingAssemblyExport.toggle()}) {
                    Text("Assembly")
                }
                .fileExporter(isPresented: $isShowingAssemblyExport, document: document, contentType: .assemblyLanguageSource, defaultFilename: "Exported File") { result in
                    switch result {
                    case .success(let url):
                        print("Saved To \(url)")
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
                Button(action: {isShowingCHeaderExport.toggle()}) {
                    Text("C Header")
                }
                .fileExporter(isPresented: $isShowingCHeaderExport, document: document, contentType: .cHeader, defaultFilename: "Exported File") { result in
                    switch result {
                    case .success(let url):
                        print("Saved To \(url)")
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
                Button(action: {isShowingCSourceExport.toggle()}) {
                    Text("C Source")
                }
                .fileExporter(isPresented: $isShowingCSourceExport, document: document, contentType: .cSource, defaultFilename: "Exported File") { result in
                    switch result {
                    case .success(let url):
                        print("Saved To \(url)")
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
                Button(action: {isShowingCPlusPlusHeaderExport.toggle()}) {
                    Text("C++ Header")
                }
                .fileExporter(isPresented: $isShowingCPlusPlusHeaderExport, document: document, contentType: .cPlusPlusHeader, defaultFilename: "Exported File") { result in
                    switch result {
                    case .success(let url):
                        print("Saved To \(url)")
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
            Group {
                Button(action: {isShowingCPlusPlusSourceExport.toggle()}) {
                    Text("C++ Source")
                }
                .fileExporter(isPresented: $isShowingCPlusPlusSourceExport, document: document, contentType: .cPlusPlusSource, defaultFilename: "Exported File") { result in
                    switch result {
                    case .success(let url):
                        print("Saved To \(url)")
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
                Button(action: {isShowingObjectiveCPlusPlusSourceExport.toggle()}) {
                    Text("Objective C++")
                }
                .fileExporter(isPresented: $isShowingObjectiveCPlusPlusSourceExport, document: document, contentType: .objectiveCPlusPlusSource, defaultFilename: "Exported File") { result in
                    switch result {
                    case .success(let url):
                        print("Saved To \(url)")
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
                Button(action: {isShowingObjectiveCSourceExport.toggle()}) {
                    Text("Objective C")
                }
                .fileExporter(isPresented: $isShowingObjectiveCSourceExport, document: document, contentType: .objectiveCSource, defaultFilename: "Exported File") { result in
                    switch result {
                    case .success(let url):
                        print("Saved To \(url)")
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
                Button(action: {isShowingAppleScriptExport.toggle()}) {
                    Text("AppleScript")
                }
                .fileExporter(isPresented: $isShowingAppleScriptExport, document: document, contentType: .appleScript, defaultFilename: "Exported File") { result in
                    switch result {
                    case .success(let url):
                        print("Saved To \(url)")
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
                Button(action: {isShowingJavaScriptExport.toggle()}) {
                    Text("JavaScript")
                }
                .fileExporter(isPresented: $isShowingJavaScriptExport, document: document, contentType: .javaScript, defaultFilename: "Exported File") { result in
                    switch result {
                    case .success(let url):
                        print("Saved To \(url)")
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
                Button(action: {isShowingShellScriptExport.toggle()}) {
                    Text("Shell Script")
                }
                .fileExporter(isPresented: $isShowingShellScriptExport, document: document, contentType: .shellScript, defaultFilename: "Exported File") { result in
                    switch result {
                    case .success(let url):
                        print("Saved To \(url)")
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
                Button(action: {isShowingPythonScriptExport.toggle()}) {
                    Text("Python")
                }
                .fileExporter(isPresented: $isShowingPythonScriptExport, document: document, contentType: .pythonScript, defaultFilename: "Exported File") { result in
                    switch result {
                    case .success(let url):
                        print("Saved To \(url)")
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
                Button(action: {isShowingRubyScriptExport.toggle()}) {
                    Text("Ruby")
                }
                .fileExporter(isPresented: $isShowingRubyScriptExport, document: document, contentType: .rubyScript, defaultFilename: "Exported File") { result in
                    switch result {
                    case .success(let url):
                        print("Saved To \(url)")
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
                Button(action: {isShowingPerlScriptExport.toggle()}) {
                    Text("Perl")
                }
                .fileExporter(isPresented: $isShowingPerlScriptExport, document: document, contentType: .perlScript, defaultFilename: "Exported File") { result in
                    switch result {
                    case .success(let url):
                        print("Saved To \(url)")
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
                Button(action: {isShowingPHPScriptExport.toggle()}) {
                    Text("PHP")
                }
                .fileExporter(isPresented: $isShowingPHPScriptExport, document: document, contentType: .phpScript, defaultFilename: "Exported File") { result in
                    switch result {
                    case .success(let url):
                        print("Saved To \(url)")
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
}

extension FocusedValues {
    struct DocumentFocusedValues: FocusedValueKey {
        typealias Value = Binding<Note_itDocument>
    }

    var document: Binding<Note_itDocument>? {
        get {
            self[DocumentFocusedValues.self]
        }
        set {
            self[DocumentFocusedValues.self] = newValue
        }
    }
}
