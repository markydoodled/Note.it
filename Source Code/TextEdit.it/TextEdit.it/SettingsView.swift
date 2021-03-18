//
//  SettingsView.swift
//  TextEdit.it
//
//  Created by Mark Howard on 21/02/2021.
//

import SwiftUI
import CodeMirror_SwiftUI
import KeyboardShortcuts

struct SettingsView: View {
    @AppStorage("tabSelection") var tabSelection = 1
    @AppStorage("appTheme") var appTheme: String = "system"
    @AppStorage("selectedSyntax") var selectedSyntax = 1
    @AppStorage("selectedTheme") var selectedTheme = 0
    @AppStorage("lineWrapping") var lineWrapping = true
    @AppStorage("showInvisibleCharacters") var showInvisibleCharacters = false
    @AppStorage("fontSize") var fontSize = 12
    @State var syntax = CodeMode.text.mode()
    var themes = CodeViewTheme.allCases.sorted {
      return $0.rawValue < $1.rawValue
    }
    var body: some View {
        TabView(selection: $tabSelection) {
            Form {
                HStack {
                    VStack {
                VStack {
                    Text("New Command")
                        .padding(.vertical)
                    HStack {
                        Spacer()
                        KeyboardShortcuts.Recorder(for: .newCommand)
                        Spacer()
                    }
                }
                VStack {
                    Text("Open Command")
                        .padding(.vertical)
                    HStack {
                        Spacer()
                        KeyboardShortcuts.Recorder(for: .openCommand)
                        Spacer()
                    }
                }
                VStack {
                    Text("Save Command")
                        .padding(.vertical)
                    HStack {
                        Spacer()
                        KeyboardShortcuts.Recorder(for: .saveCommand)
                        Spacer()
                    }
                }
                    }
                    VStack {
                        VStack {
                            Text("Copy Command")
                                .padding(.vertical)
                            HStack {
                                Spacer()
                                KeyboardShortcuts.Recorder(for: .copyCommand)
                                Spacer()
                            }
                        }
                        VStack {
                            Text("Print Command")
                                .padding(.vertical)
                            HStack {
                                Spacer()
                                KeyboardShortcuts.Recorder(for: .printCommand)
                                Spacer()
                            }
                        }
                        VStack {
                            Text("Duplicate Command")
                                .padding(.vertical)
                            HStack {
                                Spacer()
                                KeyboardShortcuts.Recorder(for: .duplicateCommand)
                                Spacer()
                            }
                        }
                    }
                    VStack {
                        VStack {
                            Text("Move To... Command")
                                .padding(.vertical)
                            HStack {
                                Spacer()
                                KeyboardShortcuts.Recorder(for: .moveToCommand)
                                Spacer()
                            }
                        }
                    }
            }
            }
            .padding(20)
            .frame(width: 600, height: 300)
            .tag(1)
            .tabItem {
                Label("Keyboard", systemImage: "keyboard")
            }
            Form {
                VStack {
                    HStack {
                        Spacer()
                        Stepper("Font Size: \(fontSize)", value: $fontSize, in: 1...120)
                        Spacer()
                    }
                    HStack {
                        Text("Appearance: ")
                        Button(action: {NSApp.appearance = NSAppearance(named: .aqua)
                            appTheme = "light"}) {
                        Text("Light")
                        }
                        .padding(.horizontal)
                        Button(action: {NSApp.appearance = NSAppearance(named: .darkAqua)
                            appTheme = "dark"}) {
                        Text("Dark")
                        }
                        .padding(.trailing)
                        Button(action: {NSApp.appearance = nil
                            appTheme = "system"}) {
                        Text("System")
                        }
                        .padding(.trailing)
                    }
                    Toggle(isOn: $lineWrapping) {
                        Text("Line Wrapping")
                    }
                    Toggle(isOn: $showInvisibleCharacters) {
                        Text("Show Invisible Characters")
                    }
                }
            }
            .padding(20)
            .frame(width: 400, height: 150)
            .tag(2)
            .tabItem {
                Label("Editor", systemImage: "note.text")
            }
            Form {
                Picker(selection: $selectedTheme, label: Text("Theme: ")) {
                  ForEach(0 ..< themes.count) {
                    Text(self.themes[$0].rawValue)
                  }
                }
                Picker(selection: $selectedSyntax, label: Text("Syntax Highlighting: ")) {
                    Button(action: {self.syntax = CodeMode.swift.mode()}) {
                        Text("Swift")
                    }
                    .tag(1)
                }
            }
            .padding(20)
            .frame(width: 350, height: 150)
            .tag(3)
            .tabItem {
                Label("Themes", systemImage: "paintbrush")
            }
        Form {
            GroupBox(label: Label("Info", systemImage: "info.circle")) {
                VStack {
                    HStack {
                        Spacer()
                        VStack {
            Text("Version: 1.0")
            Text("Build: 1")
                        }
                        Spacer()
                    }
                }
            }
            GroupBox(label: Label("Misc.", systemImage: "ellipsis.circle")) {
                VStack {
                    HStack {
                        Spacer()
                    Button(action: {SendEmail.send()}) {
                        Text("Send Some Feedback")
                    }
                        Spacer()
                    }
                }
            }
        }
                .padding(20)
                .frame(width: 350, height: 150)
        .tag(4)
        .tabItem {
            Label("Misc.", systemImage: "ellipsis.circle")
        }
    }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

class SendEmail: NSObject {
    static func send() {
        let service = NSSharingService(named: NSSharingService.Name.composeEmail)!
        service.recipients = ["markhoward2005@gmail.com"]
        service.subject = "TextEdit.it Feedback"

        service.perform(withItems: ["Please Fill Out All Necessary Sections:", "Report A Bug - ", "Rate The App - ", "Suggest An Improvment - "])
    }
}

extension KeyboardShortcuts.Name {
    static let newCommand = Self("newCommand", default: .init(.n, modifiers: [.command]))
    static let openCommand = Self("openCommand", default: .init(.o, modifiers: [.command]))
    static let saveCommand = Self("saveCommand", default: .init(.s, modifiers: [.command]))
    static let copyCommand = Self("copyCommand", default: .init(.c, modifiers: [.command]))
    static let printCommand = Self("printCommand", default: .init(.p, modifiers: [.command]))
    static let duplicateCommand = Self("duplicateCommand", default: .init(.s, modifiers: [.command, .shift]))
    static let moveToCommand = Self("moveToCommand")
}
