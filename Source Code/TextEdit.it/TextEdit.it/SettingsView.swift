//
//  SettingsView.swift
//  TextEdit.it
//
//  Created by Mark Howard on 21/02/2021.
//

import SwiftUI
import CodeMirror_SwiftUI
import KeyboardShortcuts

struct KeyboardSettings: View {
    var body: some View {
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
                        Text("Close Command")
                            .padding(.vertical)
                        HStack {
                            Spacer()
                            KeyboardShortcuts.Recorder(for: .closeCommand)
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
                    VStack {
                        Text("Rename... Command")
                            .padding(.vertical)
                        HStack {
                            Spacer()
                            KeyboardShortcuts.Recorder(for: .renameCommand)
                            Spacer()
                        }
                    }
                    VStack {
                        Text("Revert To... Command")
                            .padding(.vertical)
                        HStack {
                            Spacer()
                            KeyboardShortcuts.Recorder(for: .revertToCommand)
                            Spacer()
                        }
                    }
                }
        }
        }
       .padding(20)
       .frame(width: 600, height: 300)
    }
}

struct EditorSettings: View {
    @AppStorage("lineWrapping") var lineWrapping = true
    @AppStorage("showInvisibleCharacters") var showInvisibleCharacters = false
    @AppStorage("fontSize") var fontSize = 12
    @AppStorage("appTheme") var appTheme: String = "system"
    var body: some View {
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
                .toggleStyle(SwitchToggleStyle())
                Toggle(isOn: $showInvisibleCharacters) {
                    Text("Show Invisible Characters")
                }
                .toggleStyle(SwitchToggleStyle())
            }
        }
        .padding(20)
        .frame(width: 400, height: 150)
    }
}

struct ThemesSettings: View {
    @AppStorage("selectedSyntax") var selectedSyntax = 1
    @AppStorage("selectedTheme") var selectedTheme = 0
    @AppStorage("syntax") var syntax: CodeMode = CodeMode.text
    @AppStorage("theme") var theme: CodeViewTheme = CodeViewTheme.zenburnesque
    var body: some View {
        Form {
            Picker(selection: $selectedTheme, label: Text("Theme: ")) {
                Group {
                Group {
                    Button(action: {}) {
                        Text("bbedit")
                    }
                    .tag(1)
                    Button(action: {}) {
                        Text("all-hallow-eve")
                    }
                    .tag(2)
                    Button(action: {}) {
                        Text("idleFingers")
                    }
                    .tag(3)
                    Button(action: {}) {
                        Text("spaceCadet")
                    }
                    .tag(4)
                    Button(action: {}) {
                        Text("idle")
                    }
                    .tag(5)
                    Button(action: {}) {
                        Text("oceanic")
                    }
                    .tag(6)
                    Button(action: {}) {
                        Text("clouds")
                    }
                    .tag(7)
                    Button(action: {}) {
                        Text("github")
                    }
                    .tag(8)
                    Button(action: {}) {
                        Text("ryan-light")
                    }
                    .tag(9)
                    Button(action: {}) {
                        Text("black-pearl")
                    }
                    .tag(10)
                }
                Group {
                    Button(action: {}) {
                        Text("monoindustrial")
                    }
                    .tag(11)
                    Button(action: {}) {
                        Text("happy-happy-joy-joy-2")
                    }
                    .tag(12)
                    Button(action: {}) {
                        Text("cube2media")
                    }
                    .tag(13)
                    Button(action: {}) {
                        Text("friendship-bracelet")
                    }
                    .tag(14)
                    Button(action: {}) {
                        Text("classic-modififed")
                    }
                    .tag(15)
                    Button(action: {}) {
                        Text("amy")
                    }
                    .tag(16)
                    Button(action: {}) {
                        Text("demo")
                    }
                    .tag(17)
                    Button(action: {}) {
                        Text("rdark")
                    }
                    .tag(18)
                    Button(action: {}) {
                        Text("espresso")
                    }
                    .tag(19)
                    Button(action: {}) {
                        Text("sunburst")
                    }
                    .tag(20)
                }
                Group {
                    Button(action: {}) {
                        Text("made-of-code")
                    }
                    .tag(21)
                    Button(action: {}) {
                        Text("arona")
                    }
                    .tag(22)
                    Button(action: {}) {
                        Text("putty")
                    }
                    .tag(23)
                    Button(action: {}) {
                        Text("nightlion")
                    }
                    .tag(24)
                    Button(action: {}) {
                        Text("sidewalkchalk")
                    }
                    .tag(25)
                    Button(action: {}) {
                        Text("swyphs-ii")
                    }
                    .tag(26)
                    Button(action: {}) {
                        Text("iplastic")
                    }
                    .tag(27)
                    Button(action: {}) {
                        Text("solarized-(light)")
                    }
                    .tag(28)
                    Button(action: {}) {
                        Text("mac-classic")
                    }
                    .tag(29)
                    Button(action: {}) {
                        Text("pastels-on-dark")
                    }
                    .tag(30)
                }
                Group {
                    Button(action: {}) {
                        Text("ir_black")
                    }
                    .tag(31)
                    Button(action: {}) {
                        Text("material")
                    }
                    .tag(32)
                    Button(action: {}) {
                        Text("monokai-fannonedition")
                    }
                    .tag(33)
                    Button(action: {}) {
                        Text("monokai-bright")
                    }
                    .tag(34)
                    Button(action: {}) {
                        Text("eiffel")
                    }
                    .tag(35)
                    Button(action: {}) {
                        Text("base16-light")
                    }
                    .tag(36)
                    Button(action: {}) {
                        Text("oceanic-muted")
                    }
                    .tag(37)
                    Button(action: {}) {
                        Text("summerfruit")
                    }
                    .tag(38)
                    Button(action: {}) {
                        Text("espresso-libre")
                    }
                    .tag(39)
                    Button(action: {}) {
                        Text("krtheme")
                    }
                    .tag(40)
                }
                Group {
                    Button(action: {}) {
                        Text("mreq")
                    }
                    .tag(41)
                    Button(action: {}) {
                        Text("chanfle")
                    }
                    .tag(42)
                    Button(action: {}) {
                        Text("venom")
                    }
                    .tag(43)
                    Button(action: {}) {
                        Text("juicy")
                    }
                    .tag(44)
                    Button(action: {}) {
                        Text("coda")
                    }
                    .tag(45)
                    Button(action: {}) {
                        Text("fluidvision")
                    }
                    .tag(46)
                    Button(action: {}) {
                        Text("tomorrow-night-blue")
                    }
                    .tag(47)
                    Button(action: {}) {
                        Text("migucwb-(amiga)")
                    }
                    .tag(48)
                    Button(action: {}) {
                        Text("twilight")
                    }
                    .tag(49)
                    Button(action: {}) {
                        Text("vibrant-ink")
                    }
                    .tag(50)
                }
                Group {
                    Button(action: {}) {
                        Text("summer-sun")
                    }
                    .tag(51)
                    Button(action: {}) {
                        Text("monokai")
                    }
                    .tag(52)
                    Button(action: {}) {
                        Text("rails-envy")
                    }
                    .tag(53)
                    Button(action: {}) {
                        Text("merbivore")
                    }
                    .tag(54)
                    Button(action: {}) {
                        Text("dracula")
                    }
                    .tag(55)
                    Button(action: {}) {
                        Text("pastie")
                    }
                    .tag(56)
                    Button(action: {}) {
                        Text("lowlight")
                    }
                    .tag(57)
                    Button(action: {}) {
                        Text("spectacular")
                    }
                    .tag(58)
                    Button(action: {}) {
                        Text("smoothy")
                    }
                    .tag(59)
                    Button(action: {}) {
                        Text("vibrant-fin")
                    }
                    .tag(60)
                }
                Group {
                    Button(action: {}) {
                        Text("blackboard")
                    }
                    .tag(61)
                    Button(action: {}) {
                        Text("slush-&-poppies")
                    }
                    .tag(62)
                    Button(action: {}) {
                        Text("freckle")
                    }
                    .tag(63)
                    Button(action: {}) {
                        Text("fantasyscript")
                    }
                    .tag(64)
                    Button(action: {}) {
                        Text("tomorrow-night-eighties")
                    }
                    .tag(65)
                    Button(action: {}) {
                        Text("rhuk")
                    }
                    .tag(66)
                    Button(action: {}) {
                        Text("toy-chest")
                    }
                    .tag(67)
                    Button(action: {}) {
                        Text("fake")
                    }
                    .tag(68)
                    Button(action: {}) {
                        Text("emacs-strict")
                    }
                    .tag(69)
                    Button(action: {}) {
                        Text("merbivore-soft")
                    }
                    .tag(70)
                }
                Group {
                    Button(action: {}) {
                        Text("fade-to-grey")
                    }
                    .tag(71)
                    Button(action: {}) {
                        Text("monokai-sublime")
                    }
                    .tag(72)
                    Button(action: {}) {
                        Text("johnny")
                    }
                    .tag(73)
                    Button(action: {}) {
                        Text("railscasts")
                    }
                    .tag(74)
                    Button(action: {}) {
                        Text("argonaut")
                    }
                    .tag(75)
                    Button(action: {}) {
                        Text("tomorrow-night-bright")
                    }
                    .tag(76)
                    Button(action: {}) {
                        Text("lazy")
                    }
                    .tag(77)
                    Button(action: {}) {
                        Text("tomorrow-night")
                    }
                    .tag(78)
                    Button(action: {}) {
                        Text("bongzilla")
                    }
                    .tag(79)
                    Button(action: {}) {
                        Text("zenburnesque")
                    }
                    .tag(80)
                }
                Group {
                    Button(action: {}) {
                        Text("notebook")
                    }
                    .tag(81)
                    Button(action: {}) {
                        Text("django-(smoothy)")
                    }
                    .tag(82)
                    Button(action: {}) {
                        Text("blackboard-black")
                    }
                    .tag(83)
                    Button(action: {}) {
                        Text("black-pearl-ii")
                    }
                    .tag(84)
                    Button(action: {}) {
                        Text("kuroir")
                    }
                    .tag(85)
                    Button(action: {}) {
                        Text("cobalt")
                    }
                    .tag(86)
                    Button(action: {}) {
                        Text("ayu-mirage")
                    }
                    .tag(87)
                    Button(action: {}) {
                        Text("chrome-devtools")
                    }
                    .tag(88)
                    Button(action: {}) {
                        Text("prospettiva")
                    }
                    .tag(89)
                    Button(action: {}) {
                        Text("espresso-soda")
                    }
                    .tag(90)
                }
                Group {
                    Button(action: {}) {
                        Text("birds-of-paradise")
                    }
                    .tag(91)
                    Button(action: {}) {
                        Text("text-ex-machina")
                    }
                    .tag(92)
                    Button(action: {}) {
                        Text("django")
                    }
                    .tag(93)
                    Button(action: {}) {
                        Text("tomorrow")
                    }
                    .tag(94)
                    Button(action: {}) {
                        Text("solarized-(dark)")
                    }
                    .tag(95)
                    Button(action: {}) {
                        Text("plasticcodewrap")
                    }
                    .tag(96)
                    Button(action: {}) {
                        Text("material-palenight")
                    }
                    .tag(97)
                    Button(action: {}) {
                        Text("bespin")
                    }
                    .tag(98)
                    Button(action: {}) {
                        Text("espresso-tutti")
                    }
                    .tag(99)
                    Button(action: {}) {
                        Text("vibrant-tango")
                    }
                    .tag(100)
                }
                }
                Group {
                    Button(action: {}) {
                        Text("tubster")
                    }
                    .tag(101)
                    Button(action: {}) {
                        Text("darkpastel")
                    }
                    .tag(102)
                    Button(action: {}) {
                        Text("dawn")
                    }
                    .tag(103)
                    Button(action: {}) {
                        Text("tango")
                    }
                    .tag(104)
                    Button(action: {}) {
                        Text("clouds-midnight")
                    }
                    .tag(105)
                    Button(action: {}) {
                        Text("glitterbomb")
                    }
                    .tag(106)
                    Button(action: {}) {
                        Text("ir_white")
                    }
                    .tag(107)
                }
            }
            .onChange(of: selectedTheme) { (themeValue) in
                print("Theme: \(themeValue)")
                if themeValue == 1 {
                    self.theme = CodeViewTheme.bbedit
                }
                if themeValue == 2 {
                    self.theme = CodeViewTheme.allHallowEve
                }
                if themeValue == 3 {
                    self.theme = CodeViewTheme.idleFingers
                }
                if themeValue == 4 {
                    self.theme = CodeViewTheme.spaceCadet
                }
                if themeValue == 5 {
                    self.theme = CodeViewTheme.idle
                }
                if themeValue == 6 {
                    self.theme = CodeViewTheme.oceanic
                }
                if themeValue == 7 {
                    self.theme = CodeViewTheme.clouds
                }
                if themeValue == 8 {
                    self.theme = CodeViewTheme.github
                }
                if themeValue == 9 {
                    self.theme = CodeViewTheme.ryanLight
                }
                if themeValue == 10 {
                    self.theme = CodeViewTheme.blackPearl
                }
                if themeValue == 11 {
                    self.theme = CodeViewTheme.monoIndustrial
                }
                if themeValue == 12 {
                    self.theme = CodeViewTheme.happyHappyJoyJoy2
                }
                if themeValue == 13 {
                    self.theme = CodeViewTheme.cube2Media
                }
                if themeValue == 14 {
                    self.theme = CodeViewTheme.friendshipBracelet
                }
                if themeValue == 15 {
                    self.theme = CodeViewTheme.classicModified
                }
                if themeValue == 16 {
                    self.theme = CodeViewTheme.amy
                }
                if themeValue == 17 {
                    self.theme = CodeViewTheme.default
                }
                if themeValue == 18 {
                    self.theme = CodeViewTheme.rdrak
                }
                if themeValue == 19 {
                    self.theme = CodeViewTheme.espresso
                }
                if themeValue == 20 {
                    self.theme = CodeViewTheme.sunburst
                }
                if themeValue == 21 {
                    self.theme = CodeViewTheme.madeOfCode
                }
                if themeValue == 22 {
                    self.theme = CodeViewTheme.arona
                }
                if themeValue == 23 {
                    self.theme = CodeViewTheme.putty
                }
                if themeValue == 24 {
                    self.theme = CodeViewTheme.nightlion
                }
                if themeValue == 25 {
                    self.theme = CodeViewTheme.sidewalkchalk
                }
                if themeValue == 26 {
                    self.theme = CodeViewTheme.swyphsii
                }
                if themeValue == 27 {
                    self.theme = CodeViewTheme.iplastic
                }
                if themeValue == 28 {
                    self.theme = CodeViewTheme.solarizedLight
                }
                if themeValue == 29 {
                    self.theme = CodeViewTheme.macClassic
                }
                if themeValue == 30 {
                    self.theme = CodeViewTheme.pastelsOnDark
                }
                if themeValue == 31 {
                    self.theme = CodeViewTheme.irBlack
                }
                if themeValue == 32 {
                    self.theme = CodeViewTheme.material
                }
                if themeValue == 33 {
                    self.theme = CodeViewTheme.monokaiFannonedition
                }
                if themeValue == 34 {
                    self.theme = CodeViewTheme.monokaiBright
                }
                if themeValue == 35 {
                    self.theme = CodeViewTheme.eiffel
                }
                if themeValue == 36 {
                    self.theme = CodeViewTheme.base16Light
                }
                if themeValue == 37 {
                    self.theme = CodeViewTheme.oceanicMuted
                }
                if themeValue == 38 {
                    self.theme = CodeViewTheme.summerfruit
                }
                if themeValue == 39 {
                    self.theme = CodeViewTheme.espressoLibre
                }
                if themeValue == 40 {
                    self.theme = CodeViewTheme.krtheme
                }
                if themeValue == 41 {
                    self.theme = CodeViewTheme.mreq
                }
                if themeValue == 42 {
                    self.theme = CodeViewTheme.chanfle
                }
                if themeValue == 43 {
                    self.theme = CodeViewTheme.venom
                }
                if themeValue == 44 {
                    self.theme = CodeViewTheme.juicy
                }
                if themeValue == 45 {
                    self.theme = CodeViewTheme.coda
                }
                if themeValue == 46 {
                    self.theme = CodeViewTheme.fluidvision
                }
                if themeValue == 47 {
                    self.theme = CodeViewTheme.tomorrowNightBlue
                }
                if themeValue == 48 {
                    self.theme = CodeViewTheme.magicwbAmiga
                }
                if themeValue == 49 {
                    self.theme = CodeViewTheme.twilight
                }
                if themeValue == 50 {
                    self.theme = CodeViewTheme.vibrantInk
                }
                if themeValue == 51 {
                    self.theme = CodeViewTheme.summerSun
                }
                if themeValue == 52 {
                    self.theme = CodeViewTheme.monokai
                }
                if themeValue == 53 {
                    self.theme = CodeViewTheme.railsEnvy
                }
                if themeValue == 54 {
                    self.theme = CodeViewTheme.merbivore
                }
                if themeValue == 55 {
                    self.theme = CodeViewTheme.dracula
                }
                if themeValue == 56 {
                    self.theme = CodeViewTheme.pastie
                }
                if themeValue == 57 {
                    self.theme = CodeViewTheme.lowlight
                }
                if themeValue == 58 {
                    self.theme = CodeViewTheme.spectacular
                }
                if themeValue == 59 {
                    self.theme = CodeViewTheme.smoothy
                }
                if themeValue == 60 {
                    self.theme = CodeViewTheme.vibrantFin
                }
                if themeValue == 61 {
                    self.theme = CodeViewTheme.blackboard
                }
                if themeValue == 62 {
                    self.theme = CodeViewTheme.slushPoppies
                }
                if themeValue == 63 {
                    self.theme = CodeViewTheme.freckle
                }
                if themeValue == 64 {
                    self.theme = CodeViewTheme.fantasyscript
                }
                if themeValue == 65 {
                    self.theme = CodeViewTheme.tomorrowNightEighties
                }
                if themeValue == 66 {
                    self.theme = CodeViewTheme.rhuk
                }
                if themeValue == 67 {
                    self.theme = CodeViewTheme.toyChest
                }
                if themeValue == 68 {
                    self.theme = CodeViewTheme.fake
                }
                if themeValue == 69 {
                    self.theme = CodeViewTheme.emacsStrict
                }
                if themeValue == 70 {
                    self.theme = CodeViewTheme.merbivoreSoft
                }
                if themeValue == 71 {
                    self.theme = CodeViewTheme.fadeToGrey
                }
                if themeValue == 72 {
                    self.theme = CodeViewTheme.monokaiSublime
                }
                if themeValue == 73 {
                    self.theme = CodeViewTheme.johnny
                }
                if themeValue == 74 {
                    self.theme = CodeViewTheme.railscasts
                }
                if themeValue == 75 {
                    self.theme = CodeViewTheme.argonaut
                }
                if themeValue == 76 {
                    self.theme = CodeViewTheme.tomorrowNightBright
                }
                if themeValue == 77 {
                    self.theme = CodeViewTheme.lazy
                }
                if themeValue == 78 {
                    self.theme = CodeViewTheme.tomorrowNight
                }
                if themeValue == 79 {
                    self.theme = CodeViewTheme.bongzilla
                }
                if themeValue == 80 {
                    self.theme = CodeViewTheme.zenburnesque
                }
                if themeValue == 81 {
                    self.theme = CodeViewTheme.notebook
                }
                if themeValue == 82 {
                    self.theme = CodeViewTheme.djangoSmoothy
                }
                if themeValue == 83 {
                    self.theme = CodeViewTheme.blackboardBlack
                }
                if themeValue == 84 {
                    self.theme = CodeViewTheme.blackPearlii
                }
                if themeValue == 85 {
                    self.theme = CodeViewTheme.kuroir
                }
                if themeValue == 86 {
                    self.theme = CodeViewTheme.cobalt
                }
                if themeValue == 87 {
                    self.theme = CodeViewTheme.ayuMirage
                }
                if themeValue == 88 {
                    self.theme = CodeViewTheme.chromeDevtools
                }
                if themeValue == 89 {
                    self.theme = CodeViewTheme.prospettiva
                }
                if themeValue == 90 {
                    self.theme = CodeViewTheme.espressoSoda
                }
                if themeValue == 91 {
                    self.theme = CodeViewTheme.birdsOfParadise
                }
                if themeValue == 92 {
                    self.theme = CodeViewTheme.textExMachina
                }
                if themeValue == 93 {
                    self.theme = CodeViewTheme.django
                }
                if themeValue == 94 {
                    self.theme = CodeViewTheme.tomorrow
                }
                if themeValue == 95 {
                    self.theme = CodeViewTheme.solarizedDark
                }
                if themeValue == 96 {
                    self.theme = CodeViewTheme.plasticcodewrap
                }
                if themeValue == 97 {
                    self.theme = CodeViewTheme.materialPalenight
                }
                if themeValue == 98 {
                    self.theme = CodeViewTheme.bespin
                }
                if themeValue == 99 {
                    self.theme = CodeViewTheme.espressoTutti
                }
                if themeValue == 100 {
                    self.theme = CodeViewTheme.vibrantTango
                }
                if themeValue == 101 {
                    self.theme = CodeViewTheme.tubster
                }
                if themeValue == 102 {
                    self.theme = CodeViewTheme.darkpastel
                }
                if themeValue == 103 {
                    self.theme = CodeViewTheme.dawn
                }
                if themeValue == 104 {
                    self.theme = CodeViewTheme.tango
                }
                if themeValue == 105 {
                    self.theme = CodeViewTheme.cloudsMidnight
                }
                if themeValue == 106 {
                    self.theme = CodeViewTheme.glitterbomb
                }
                if themeValue == 107 {
                    self.theme = CodeViewTheme.irWhite
                }
            }
            Picker(selection: $selectedSyntax, label: Text("Syntax Highlighting: ")) {
                Group {
                Button(action: {}) {
                    Text("apl")
                }
                .tag(1)
                Button(action: {}) {
                    Text("pgp")
                }
                .tag(2)
                Button(action: {}) {
                    Text("asn")
                }
                .tag(3)
                Button(action: {}) {
                    Text("cmake")
                }
                .tag(4)
                Button(action: {}) {
                    Text("c")
                }
                .tag(5)
                Button(action: {}) {
                    Text("cplus")
                }
                .tag(6)
                Button(action: {}) {
                    Text("objc")
                }
                .tag(7)
                Button(action: {}) {
                    Text("kotlin")
                }
                .tag(8)
                Button(action: {}) {
                    Text("scala")
                }
                .tag(9)
                Button(action: {}) {
                    Text("csharp")
                }
                .tag(10)
                }
                Group {
                Button(action: {}) {
                    Text("java")
                }
                .tag(11)
                Button(action: {}) {
                    Text("cobol")
                }
                .tag(12)
                Button(action: {}) {
                    Text("coffeescript")
                }
                .tag(13)
                Button(action: {}) {
                    Text("lisp")
                }
                .tag(14)
                Button(action: {}) {
                    Text("css")
                }
                .tag(15)
                Button(action: {}) {
                    Text("django")
                }
                .tag(16)
                Button(action: {}) {
                    Text("dockerfile")
                }
                .tag(17)
                Button(action: {}) {
                    Text("erlang")
                }
                .tag(18)
                Button(action: {}) {
                    Text("fortran")
                }
                .tag(19)
                Button(action: {}) {
                    Text("go")
                }
                .tag(20)
                }
                Group {
                Button(action: {}) {
                    Text("groovy")
                }
                .tag(21)
                Button(action: {}) {
                    Text("haskell")
                }
                .tag(22)
                Button(action: {}) {
                    Text("html")
                }
                .tag(23)
                    Button(action: {}) {
                        Text("http")
                    }
                    .tag(24)
                Button(action: {}) {
                    Text("javascript")
                }
                .tag(25)
                Button(action: {}) {
                    Text("typescript")
                }
                .tag(26)
                Button(action: {}) {
                    Text("json")
                }
                .tag(27)
                Button(action: {}) {
                    Text("ecma")
                }
                .tag(28)
                Button(action: {}) {
                    Text("jinja")
                }
                .tag(29)
                Button(action: {}) {
                    Text("lua")
                }
                .tag(30)
                }
                Button(action: {}) {
                    Text("markdown")
                }
                .tag(31)
                Group {
                Button(action: {}) {
                    Text("maths")
                }
                .tag(32)
                Button(action: {}) {
                    Text("pascal")
                }
                .tag(33)
                Button(action: {}) {
                    Text("perl")
                }
                .tag(34)
                Button(action: {}) {
                    Text("php")
                }
                .tag(35)
                Button(action: {}) {
                    Text("powershell")
                }
                .tag(36)
                Button(action: {}) {
                    Text("properties")
                }
                .tag(37)
                Button(action: {}) {
                    Text("protobuf")
                }
                .tag(38)
                Button(action: {}) {
                    Text("python")
                }
                .tag(39)
                Button(action: {}) {
                    Text("r")
                }
                .tag(40)
                Button(action: {}) {
                    Text("ruby")
                }
                .tag(41)
                }
                Group {
                Button(action: {}) {
                    Text("rust")
                }
                .tag(42)
                Button(action: {}) {
                    Text("sass")
                }
                .tag(43)
                Button(action: {}) {
                    Text("scheme")
                }
                .tag(44)
                Button(action: {}) {
                    Text("shell")
                }
                .tag(45)
                Button(action: {}) {
                    Text("sql")
                }
                .tag(46)
                Button(action: {}) {
                    Text("sqllite")
                }
                .tag(47)
                Button(action: {}) {
                    Text("mysql")
                }
                .tag(48)
                Button(action: {}) {
                    Text("latex")
                }
                .tag(49)
                Button(action: {}) {
                    Text("swift")
                }
                .tag(50)
                Button(action: {}) {
                    Text("text")
                }
                .tag(51)
                }
                Group {
                Button(action: {}) {
                    Text("toml")
                }
                .tag(52)
                Button(action: {}) {
                    Text("vb")
                }
                .tag(53)
                Button(action: {}) {
                    Text("vue")
                }
                .tag(54)
                Button(action: {}) {
                    Text("xml")
                }
                .tag(55)
                Button(action: {}) {
                    Text("yaml")
                }
                .tag(56)
                }
            }
            .onChange(of: selectedSyntax, perform: { value in
                print("Syntax: \(value)")
                if value == 1 {
                    self.syntax = CodeMode.apl
                }
                if value == 2 {
                    self.syntax = CodeMode.pgp
                }
                if value == 3 {
                    self.syntax = CodeMode.asn
                }
                if value == 4 {
                    self.syntax = CodeMode.cmake
                }
                if value == 5 {
                    self.syntax = CodeMode.c
                }
                if value == 6 {
                    self.syntax = CodeMode.cplus
                }
                if value == 7 {
                    self.syntax = CodeMode.objc
                }
                if value == 8 {
                    self.syntax = CodeMode.kotlin
                }
                if value == 9 {
                    self.syntax = CodeMode.scala
                }
                if value == 10 {
                    self.syntax = CodeMode.csharp
                }
                if value == 11 {
                    self.syntax = CodeMode.java
                }
                if value == 12 {
                    self.syntax = CodeMode.cobol
                }
                if value == 13 {
                    self.syntax = CodeMode.coffeescript
                }
                if value == 14 {
                    self.syntax = CodeMode.lisp
                }
                if value == 15 {
                    self.syntax = CodeMode.css
                }
                if value == 16 {
                    self.syntax = CodeMode.django
                }
                if value == 17 {
                    self.syntax = CodeMode.dockerfile
                }
                if value == 18 {
                    self.syntax = CodeMode.erlang
                }
                if value == 19 {
                    self.syntax = CodeMode.fortran
                }
                if value == 20 {
                    self.syntax = CodeMode.go
                }
                if value == 21 {
                    self.syntax = CodeMode.groovy
                }
                if value == 22 {
                    self.syntax = CodeMode.haskell
                }
                if value == 23 {
                    self.syntax = CodeMode.html
                }
                if value == 24 {
                    self.syntax = CodeMode.http
                }
                if value == 25 {
                    self.syntax = CodeMode.javascript
                }
                if value == 26 {
                    self.syntax = CodeMode.typescript
                }
                if value == 27 {
                    self.syntax = CodeMode.json
                }
                if value == 28 {
                    self.syntax = CodeMode.ecma
                }
                if value == 29 {
                    self.syntax = CodeMode.jinja
                }
                if value == 30 {
                    self.syntax = CodeMode.lua
                }
                if value == 31 {
                    self.syntax = CodeMode.markdown
                }
                if value == 32 {
                    self.syntax = CodeMode.maths
                }
                if value == 33 {
                    self.syntax = CodeMode.pascal
                }
                if value == 34 {
                    self.syntax = CodeMode.perl
                }
                if value == 35 {
                    self.syntax = CodeMode.php
                }
                if value == 36 {
                    self.syntax = CodeMode.powershell
                }
                if value == 37 {
                    self.syntax = CodeMode.properties
                }
                if value == 38 {
                    self.syntax = CodeMode.protobuf
                }
                if value == 39 {
                    self.syntax = CodeMode.python
                }
                if value == 40 {
                    self.syntax = CodeMode.r
                }
                if value == 41 {
                    self.syntax = CodeMode.ruby
                }
                if value == 42 {
                    self.syntax = CodeMode.rust
                }
                if value == 43 {
                    self.syntax = CodeMode.sass
                }
                if value == 44 {
                    self.syntax = CodeMode.scheme
                }
                if value == 45 {
                    self.syntax = CodeMode.shell
                }
                if value == 46 {
                    self.syntax = CodeMode.sql
                }
                if value == 47 {
                    self.syntax = CodeMode.sqllite
                }
                if value == 48 {
                    self.syntax = CodeMode.mysql
                }
                if value == 49 {
                    self.syntax = CodeMode.latex
                }
                if value == 50 {
                    self.syntax = CodeMode.swift
                }
                if value == 51 {
                    self.syntax = CodeMode.text
                }
                if value == 52 {
                    self.syntax = CodeMode.toml
                }
                if value == 53 {
                    self.syntax = CodeMode.vb
                }
                if value == 54 {
                    self.syntax = CodeMode.vue
                }
                if value == 55 {
                    self.syntax = CodeMode.xml
                }
                if value == 56 {
                    self.syntax = CodeMode.yaml
                }
            })
        }
        .padding(20)
        .frame(width: 350, height: 150)
    }
}

struct MiscSettings: View {
    var body: some View {
         Form {
            GroupBox(label: Label("Info", systemImage: "info.circle")) {
                VStack {
                    HStack {
                        Spacer()
                        VStack {
            Text("Version: 1.1")
            Text("Build: 9")
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
    }
}

/* struct SettingsView: View {
    @AppStorage("tabSelection") var tabSelection = 1
    @AppStorage("appTheme") var appTheme: String = "system"
    @AppStorage("selectedSyntax") var selectedSyntax = 1
    @AppStorage("selectedTheme") var selectedTheme = 0
    @AppStorage("lineWrapping") var lineWrapping = true
    @AppStorage("showInvisibleCharacters") var showInvisibleCharacters = false
    @AppStorage("fontSize") var fontSize = 12
    @AppStorage("syntax") var syntax: CodeMode = CodeMode.text
    @AppStorage("theme") var theme: CodeViewTheme = CodeViewTheme.zenburnesque
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
                            Text("Close Command")
                                .padding(.vertical)
                            HStack {
                                Spacer()
                                KeyboardShortcuts.Recorder(for: .closeCommand)
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
                        VStack {
                            Text("Rename... Command")
                                .padding(.vertical)
                            HStack {
                                Spacer()
                                KeyboardShortcuts.Recorder(for: .renameCommand)
                                Spacer()
                            }
                        }
                        VStack {
                            Text("Revert To... Command")
                                .padding(.vertical)
                            HStack {
                                Spacer()
                                KeyboardShortcuts.Recorder(for: .revertToCommand)
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
                    .toggleStyle(SwitchToggleStyle())
                    Toggle(isOn: $showInvisibleCharacters) {
                        Text("Show Invisible Characters")
                    }
                    .toggleStyle(SwitchToggleStyle())
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
                    Group {
                    Group {
                        Button(action: {}) {
                            Text("bbedit")
                        }
                        .tag(1)
                        Button(action: {}) {
                            Text("all-hallow-eve")
                        }
                        .tag(2)
                        Button(action: {}) {
                            Text("idleFingers")
                        }
                        .tag(3)
                        Button(action: {}) {
                            Text("spaceCadet")
                        }
                        .tag(4)
                        Button(action: {}) {
                            Text("idle")
                        }
                        .tag(5)
                        Button(action: {}) {
                            Text("oceanic")
                        }
                        .tag(6)
                        Button(action: {}) {
                            Text("clouds")
                        }
                        .tag(7)
                        Button(action: {}) {
                            Text("github")
                        }
                        .tag(8)
                        Button(action: {}) {
                            Text("ryan-light")
                        }
                        .tag(9)
                        Button(action: {}) {
                            Text("black-pearl")
                        }
                        .tag(10)
                    }
                    Group {
                        Button(action: {}) {
                            Text("monoindustrial")
                        }
                        .tag(11)
                        Button(action: {}) {
                            Text("happy-happy-joy-joy-2")
                        }
                        .tag(12)
                        Button(action: {}) {
                            Text("cube2media")
                        }
                        .tag(13)
                        Button(action: {}) {
                            Text("friendship-bracelet")
                        }
                        .tag(14)
                        Button(action: {}) {
                            Text("classic-modififed")
                        }
                        .tag(15)
                        Button(action: {}) {
                            Text("amy")
                        }
                        .tag(16)
                        Button(action: {}) {
                            Text("demo")
                        }
                        .tag(17)
                        Button(action: {}) {
                            Text("rdark")
                        }
                        .tag(18)
                        Button(action: {}) {
                            Text("espresso")
                        }
                        .tag(19)
                        Button(action: {}) {
                            Text("sunburst")
                        }
                        .tag(20)
                    }
                    Group {
                        Button(action: {}) {
                            Text("made-of-code")
                        }
                        .tag(21)
                        Button(action: {}) {
                            Text("arona")
                        }
                        .tag(22)
                        Button(action: {}) {
                            Text("putty")
                        }
                        .tag(23)
                        Button(action: {}) {
                            Text("nightlion")
                        }
                        .tag(24)
                        Button(action: {}) {
                            Text("sidewalkchalk")
                        }
                        .tag(25)
                        Button(action: {}) {
                            Text("swyphs-ii")
                        }
                        .tag(26)
                        Button(action: {}) {
                            Text("iplastic")
                        }
                        .tag(27)
                        Button(action: {}) {
                            Text("solarized-(light)")
                        }
                        .tag(28)
                        Button(action: {}) {
                            Text("mac-classic")
                        }
                        .tag(29)
                        Button(action: {}) {
                            Text("pastels-on-dark")
                        }
                        .tag(30)
                    }
                    Group {
                        Button(action: {}) {
                            Text("ir_black")
                        }
                        .tag(31)
                        Button(action: {}) {
                            Text("material")
                        }
                        .tag(32)
                        Button(action: {}) {
                            Text("monokai-fannonedition")
                        }
                        .tag(33)
                        Button(action: {}) {
                            Text("monokai-bright")
                        }
                        .tag(34)
                        Button(action: {}) {
                            Text("eiffel")
                        }
                        .tag(35)
                        Button(action: {}) {
                            Text("base16-light")
                        }
                        .tag(36)
                        Button(action: {}) {
                            Text("oceanic-muted")
                        }
                        .tag(37)
                        Button(action: {}) {
                            Text("summerfruit")
                        }
                        .tag(38)
                        Button(action: {}) {
                            Text("espresso-libre")
                        }
                        .tag(39)
                        Button(action: {}) {
                            Text("krtheme")
                        }
                        .tag(40)
                    }
                    Group {
                        Button(action: {}) {
                            Text("mreq")
                        }
                        .tag(41)
                        Button(action: {}) {
                            Text("chanfle")
                        }
                        .tag(42)
                        Button(action: {}) {
                            Text("venom")
                        }
                        .tag(43)
                        Button(action: {}) {
                            Text("juicy")
                        }
                        .tag(44)
                        Button(action: {}) {
                            Text("coda")
                        }
                        .tag(45)
                        Button(action: {}) {
                            Text("fluidvision")
                        }
                        .tag(46)
                        Button(action: {}) {
                            Text("tomorrow-night-blue")
                        }
                        .tag(47)
                        Button(action: {}) {
                            Text("migucwb-(amiga)")
                        }
                        .tag(48)
                        Button(action: {}) {
                            Text("twilight")
                        }
                        .tag(49)
                        Button(action: {}) {
                            Text("vibrant-ink")
                        }
                        .tag(50)
                    }
                    Group {
                        Button(action: {}) {
                            Text("summer-sun")
                        }
                        .tag(51)
                        Button(action: {}) {
                            Text("monokai")
                        }
                        .tag(52)
                        Button(action: {}) {
                            Text("rails-envy")
                        }
                        .tag(53)
                        Button(action: {}) {
                            Text("merbivore")
                        }
                        .tag(54)
                        Button(action: {}) {
                            Text("dracula")
                        }
                        .tag(55)
                        Button(action: {}) {
                            Text("pastie")
                        }
                        .tag(56)
                        Button(action: {}) {
                            Text("lowlight")
                        }
                        .tag(57)
                        Button(action: {}) {
                            Text("spectacular")
                        }
                        .tag(58)
                        Button(action: {}) {
                            Text("smoothy")
                        }
                        .tag(59)
                        Button(action: {}) {
                            Text("vibrant-fin")
                        }
                        .tag(60)
                    }
                    Group {
                        Button(action: {}) {
                            Text("blackboard")
                        }
                        .tag(61)
                        Button(action: {}) {
                            Text("slush-&-poppies")
                        }
                        .tag(62)
                        Button(action: {}) {
                            Text("freckle")
                        }
                        .tag(63)
                        Button(action: {}) {
                            Text("fantasyscript")
                        }
                        .tag(64)
                        Button(action: {}) {
                            Text("tomorrow-night-eighties")
                        }
                        .tag(65)
                        Button(action: {}) {
                            Text("rhuk")
                        }
                        .tag(66)
                        Button(action: {}) {
                            Text("toy-chest")
                        }
                        .tag(67)
                        Button(action: {}) {
                            Text("fake")
                        }
                        .tag(68)
                        Button(action: {}) {
                            Text("emacs-strict")
                        }
                        .tag(69)
                        Button(action: {}) {
                            Text("merbivore-soft")
                        }
                        .tag(70)
                    }
                    Group {
                        Button(action: {}) {
                            Text("fade-to-grey")
                        }
                        .tag(71)
                        Button(action: {}) {
                            Text("monokai-sublime")
                        }
                        .tag(72)
                        Button(action: {}) {
                            Text("johnny")
                        }
                        .tag(73)
                        Button(action: {}) {
                            Text("railscasts")
                        }
                        .tag(74)
                        Button(action: {}) {
                            Text("argonaut")
                        }
                        .tag(75)
                        Button(action: {}) {
                            Text("tomorrow-night-bright")
                        }
                        .tag(76)
                        Button(action: {}) {
                            Text("lazy")
                        }
                        .tag(77)
                        Button(action: {}) {
                            Text("tomorrow-night")
                        }
                        .tag(78)
                        Button(action: {}) {
                            Text("bongzilla")
                        }
                        .tag(79)
                        Button(action: {}) {
                            Text("zenburnesque")
                        }
                        .tag(80)
                    }
                    Group {
                        Button(action: {}) {
                            Text("notebook")
                        }
                        .tag(81)
                        Button(action: {}) {
                            Text("django-(smoothy)")
                        }
                        .tag(82)
                        Button(action: {}) {
                            Text("blackboard-black")
                        }
                        .tag(83)
                        Button(action: {}) {
                            Text("black-pearl-ii")
                        }
                        .tag(84)
                        Button(action: {}) {
                            Text("kuroir")
                        }
                        .tag(85)
                        Button(action: {}) {
                            Text("cobalt")
                        }
                        .tag(86)
                        Button(action: {}) {
                            Text("ayu-mirage")
                        }
                        .tag(87)
                        Button(action: {}) {
                            Text("chrome-devtools")
                        }
                        .tag(88)
                        Button(action: {}) {
                            Text("prospettiva")
                        }
                        .tag(89)
                        Button(action: {}) {
                            Text("espresso-soda")
                        }
                        .tag(90)
                    }
                    Group {
                        Button(action: {}) {
                            Text("birds-of-paradise")
                        }
                        .tag(91)
                        Button(action: {}) {
                            Text("text-ex-machina")
                        }
                        .tag(92)
                        Button(action: {}) {
                            Text("django")
                        }
                        .tag(93)
                        Button(action: {}) {
                            Text("tomorrow")
                        }
                        .tag(94)
                        Button(action: {}) {
                            Text("solarized-(dark)")
                        }
                        .tag(95)
                        Button(action: {}) {
                            Text("plasticcodewrap")
                        }
                        .tag(96)
                        Button(action: {}) {
                            Text("material-palenight")
                        }
                        .tag(97)
                        Button(action: {}) {
                            Text("bespin")
                        }
                        .tag(98)
                        Button(action: {}) {
                            Text("espresso-tutti")
                        }
                        .tag(99)
                        Button(action: {}) {
                            Text("vibrant-tango")
                        }
                        .tag(100)
                    }
                    }
                    Group {
                        Button(action: {}) {
                            Text("tubster")
                        }
                        .tag(101)
                        Button(action: {}) {
                            Text("darkpastel")
                        }
                        .tag(102)
                        Button(action: {}) {
                            Text("dawn")
                        }
                        .tag(103)
                        Button(action: {}) {
                            Text("tango")
                        }
                        .tag(104)
                        Button(action: {}) {
                            Text("clouds-midnight")
                        }
                        .tag(105)
                        Button(action: {}) {
                            Text("glitterbomb")
                        }
                        .tag(106)
                        Button(action: {}) {
                            Text("ir_white")
                        }
                        .tag(107)
                    }
                }
                .onChange(of: selectedTheme) { (themeValue) in
                    print("Theme: \(themeValue)")
                    if themeValue == 1 {
                        self.theme = CodeViewTheme.bbedit
                    }
                    if themeValue == 2 {
                        self.theme = CodeViewTheme.allHallowEve
                    }
                    if themeValue == 3 {
                        self.theme = CodeViewTheme.idleFingers
                    }
                    if themeValue == 4 {
                        self.theme = CodeViewTheme.spaceCadet
                    }
                    if themeValue == 5 {
                        self.theme = CodeViewTheme.idle
                    }
                    if themeValue == 6 {
                        self.theme = CodeViewTheme.oceanic
                    }
                    if themeValue == 7 {
                        self.theme = CodeViewTheme.clouds
                    }
                    if themeValue == 8 {
                        self.theme = CodeViewTheme.github
                    }
                    if themeValue == 9 {
                        self.theme = CodeViewTheme.ryanLight
                    }
                    if themeValue == 10 {
                        self.theme = CodeViewTheme.blackPearl
                    }
                    if themeValue == 11 {
                        self.theme = CodeViewTheme.monoIndustrial
                    }
                    if themeValue == 12 {
                        self.theme = CodeViewTheme.happyHappyJoyJoy2
                    }
                    if themeValue == 13 {
                        self.theme = CodeViewTheme.cube2Media
                    }
                    if themeValue == 14 {
                        self.theme = CodeViewTheme.friendshipBracelet
                    }
                    if themeValue == 15 {
                        self.theme = CodeViewTheme.classicModified
                    }
                    if themeValue == 16 {
                        self.theme = CodeViewTheme.amy
                    }
                    if themeValue == 17 {
                        self.theme = CodeViewTheme.default
                    }
                    if themeValue == 18 {
                        self.theme = CodeViewTheme.rdrak
                    }
                    if themeValue == 19 {
                        self.theme = CodeViewTheme.espresso
                    }
                    if themeValue == 20 {
                        self.theme = CodeViewTheme.sunburst
                    }
                    if themeValue == 21 {
                        self.theme = CodeViewTheme.madeOfCode
                    }
                    if themeValue == 22 {
                        self.theme = CodeViewTheme.arona
                    }
                    if themeValue == 23 {
                        self.theme = CodeViewTheme.putty
                    }
                    if themeValue == 24 {
                        self.theme = CodeViewTheme.nightlion
                    }
                    if themeValue == 25 {
                        self.theme = CodeViewTheme.sidewalkchalk
                    }
                    if themeValue == 26 {
                        self.theme = CodeViewTheme.swyphsii
                    }
                    if themeValue == 27 {
                        self.theme = CodeViewTheme.iplastic
                    }
                    if themeValue == 28 {
                        self.theme = CodeViewTheme.solarizedLight
                    }
                    if themeValue == 29 {
                        self.theme = CodeViewTheme.macClassic
                    }
                    if themeValue == 30 {
                        self.theme = CodeViewTheme.pastelsOnDark
                    }
                    if themeValue == 31 {
                        self.theme = CodeViewTheme.irBlack
                    }
                    if themeValue == 32 {
                        self.theme = CodeViewTheme.material
                    }
                    if themeValue == 33 {
                        self.theme = CodeViewTheme.monokaiFannonedition
                    }
                    if themeValue == 34 {
                        self.theme = CodeViewTheme.monokaiBright
                    }
                    if themeValue == 35 {
                        self.theme = CodeViewTheme.eiffel
                    }
                    if themeValue == 36 {
                        self.theme = CodeViewTheme.base16Light
                    }
                    if themeValue == 37 {
                        self.theme = CodeViewTheme.oceanicMuted
                    }
                    if themeValue == 38 {
                        self.theme = CodeViewTheme.summerfruit
                    }
                    if themeValue == 39 {
                        self.theme = CodeViewTheme.espressoLibre
                    }
                    if themeValue == 40 {
                        self.theme = CodeViewTheme.krtheme
                    }
                    if themeValue == 41 {
                        self.theme = CodeViewTheme.mreq
                    }
                    if themeValue == 42 {
                        self.theme = CodeViewTheme.chanfle
                    }
                    if themeValue == 43 {
                        self.theme = CodeViewTheme.venom
                    }
                    if themeValue == 44 {
                        self.theme = CodeViewTheme.juicy
                    }
                    if themeValue == 45 {
                        self.theme = CodeViewTheme.coda
                    }
                    if themeValue == 46 {
                        self.theme = CodeViewTheme.fluidvision
                    }
                    if themeValue == 47 {
                        self.theme = CodeViewTheme.tomorrowNightBlue
                    }
                    if themeValue == 48 {
                        self.theme = CodeViewTheme.magicwbAmiga
                    }
                    if themeValue == 49 {
                        self.theme = CodeViewTheme.twilight
                    }
                    if themeValue == 50 {
                        self.theme = CodeViewTheme.vibrantInk
                    }
                    if themeValue == 51 {
                        self.theme = CodeViewTheme.summerSun
                    }
                    if themeValue == 52 {
                        self.theme = CodeViewTheme.monokai
                    }
                    if themeValue == 53 {
                        self.theme = CodeViewTheme.railsEnvy
                    }
                    if themeValue == 54 {
                        self.theme = CodeViewTheme.merbivore
                    }
                    if themeValue == 55 {
                        self.theme = CodeViewTheme.dracula
                    }
                    if themeValue == 56 {
                        self.theme = CodeViewTheme.pastie
                    }
                    if themeValue == 57 {
                        self.theme = CodeViewTheme.lowlight
                    }
                    if themeValue == 58 {
                        self.theme = CodeViewTheme.spectacular
                    }
                    if themeValue == 59 {
                        self.theme = CodeViewTheme.smoothy
                    }
                    if themeValue == 60 {
                        self.theme = CodeViewTheme.vibrantFin
                    }
                    if themeValue == 61 {
                        self.theme = CodeViewTheme.blackboard
                    }
                    if themeValue == 62 {
                        self.theme = CodeViewTheme.slushPoppies
                    }
                    if themeValue == 63 {
                        self.theme = CodeViewTheme.freckle
                    }
                    if themeValue == 64 {
                        self.theme = CodeViewTheme.fantasyscript
                    }
                    if themeValue == 65 {
                        self.theme = CodeViewTheme.tomorrowNightEighties
                    }
                    if themeValue == 66 {
                        self.theme = CodeViewTheme.rhuk
                    }
                    if themeValue == 67 {
                        self.theme = CodeViewTheme.toyChest
                    }
                    if themeValue == 68 {
                        self.theme = CodeViewTheme.fake
                    }
                    if themeValue == 69 {
                        self.theme = CodeViewTheme.emacsStrict
                    }
                    if themeValue == 70 {
                        self.theme = CodeViewTheme.merbivoreSoft
                    }
                    if themeValue == 71 {
                        self.theme = CodeViewTheme.fadeToGrey
                    }
                    if themeValue == 72 {
                        self.theme = CodeViewTheme.monokaiSublime
                    }
                    if themeValue == 73 {
                        self.theme = CodeViewTheme.johnny
                    }
                    if themeValue == 74 {
                        self.theme = CodeViewTheme.railscasts
                    }
                    if themeValue == 75 {
                        self.theme = CodeViewTheme.argonaut
                    }
                    if themeValue == 76 {
                        self.theme = CodeViewTheme.tomorrowNightBright
                    }
                    if themeValue == 77 {
                        self.theme = CodeViewTheme.lazy
                    }
                    if themeValue == 78 {
                        self.theme = CodeViewTheme.tomorrowNight
                    }
                    if themeValue == 79 {
                        self.theme = CodeViewTheme.bongzilla
                    }
                    if themeValue == 80 {
                        self.theme = CodeViewTheme.zenburnesque
                    }
                    if themeValue == 81 {
                        self.theme = CodeViewTheme.notebook
                    }
                    if themeValue == 82 {
                        self.theme = CodeViewTheme.djangoSmoothy
                    }
                    if themeValue == 83 {
                        self.theme = CodeViewTheme.blackboardBlack
                    }
                    if themeValue == 84 {
                        self.theme = CodeViewTheme.blackPearlii
                    }
                    if themeValue == 85 {
                        self.theme = CodeViewTheme.kuroir
                    }
                    if themeValue == 86 {
                        self.theme = CodeViewTheme.cobalt
                    }
                    if themeValue == 87 {
                        self.theme = CodeViewTheme.ayuMirage
                    }
                    if themeValue == 88 {
                        self.theme = CodeViewTheme.chromeDevtools
                    }
                    if themeValue == 89 {
                        self.theme = CodeViewTheme.prospettiva
                    }
                    if themeValue == 90 {
                        self.theme = CodeViewTheme.espressoSoda
                    }
                    if themeValue == 91 {
                        self.theme = CodeViewTheme.birdsOfParadise
                    }
                    if themeValue == 92 {
                        self.theme = CodeViewTheme.textExMachina
                    }
                    if themeValue == 93 {
                        self.theme = CodeViewTheme.django
                    }
                    if themeValue == 94 {
                        self.theme = CodeViewTheme.tomorrow
                    }
                    if themeValue == 95 {
                        self.theme = CodeViewTheme.solarizedDark
                    }
                    if themeValue == 96 {
                        self.theme = CodeViewTheme.plasticcodewrap
                    }
                    if themeValue == 97 {
                        self.theme = CodeViewTheme.materialPalenight
                    }
                    if themeValue == 98 {
                        self.theme = CodeViewTheme.bespin
                    }
                    if themeValue == 99 {
                        self.theme = CodeViewTheme.espressoTutti
                    }
                    if themeValue == 100 {
                        self.theme = CodeViewTheme.vibrantTango
                    }
                    if themeValue == 101 {
                        self.theme = CodeViewTheme.tubster
                    }
                    if themeValue == 102 {
                        self.theme = CodeViewTheme.darkpastel
                    }
                    if themeValue == 103 {
                        self.theme = CodeViewTheme.dawn
                    }
                    if themeValue == 104 {
                        self.theme = CodeViewTheme.tango
                    }
                    if themeValue == 105 {
                        self.theme = CodeViewTheme.cloudsMidnight
                    }
                    if themeValue == 106 {
                        self.theme = CodeViewTheme.glitterbomb
                    }
                    if themeValue == 107 {
                        self.theme = CodeViewTheme.irWhite
                    }
                }
                Picker(selection: $selectedSyntax, label: Text("Syntax Highlighting: ")) {
                    Group {
                    Button(action: {}) {
                        Text("apl")
                    }
                    .tag(1)
                    Button(action: {}) {
                        Text("pgp")
                    }
                    .tag(2)
                    Button(action: {}) {
                        Text("asn")
                    }
                    .tag(3)
                    Button(action: {}) {
                        Text("cmake")
                    }
                    .tag(4)
                    Button(action: {}) {
                        Text("c")
                    }
                    .tag(5)
                    Button(action: {}) {
                        Text("cplus")
                    }
                    .tag(6)
                    Button(action: {}) {
                        Text("objc")
                    }
                    .tag(7)
                    Button(action: {}) {
                        Text("kotlin")
                    }
                    .tag(8)
                    Button(action: {}) {
                        Text("scala")
                    }
                    .tag(9)
                    Button(action: {}) {
                        Text("csharp")
                    }
                    .tag(10)
                    }
                    Group {
                    Button(action: {}) {
                        Text("java")
                    }
                    .tag(11)
                    Button(action: {}) {
                        Text("cobol")
                    }
                    .tag(12)
                    Button(action: {}) {
                        Text("coffeescript")
                    }
                    .tag(13)
                    Button(action: {}) {
                        Text("lisp")
                    }
                    .tag(14)
                    Button(action: {}) {
                        Text("css")
                    }
                    .tag(15)
                    Button(action: {}) {
                        Text("django")
                    }
                    .tag(16)
                    Button(action: {}) {
                        Text("dockerfile")
                    }
                    .tag(17)
                    Button(action: {}) {
                        Text("erlang")
                    }
                    .tag(18)
                    Button(action: {}) {
                        Text("fortran")
                    }
                    .tag(19)
                    Button(action: {}) {
                        Text("go")
                    }
                    .tag(20)
                    }
                    Group {
                    Button(action: {}) {
                        Text("groovy")
                    }
                    .tag(21)
                    Button(action: {}) {
                        Text("haskell")
                    }
                    .tag(22)
                    Button(action: {}) {
                        Text("html")
                    }
                    .tag(23)
                        Button(action: {}) {
                            Text("http")
                        }
                        .tag(24)
                    Button(action: {}) {
                        Text("javascript")
                    }
                    .tag(25)
                    Button(action: {}) {
                        Text("typescript")
                    }
                    .tag(26)
                    Button(action: {}) {
                        Text("json")
                    }
                    .tag(27)
                    Button(action: {}) {
                        Text("ecma")
                    }
                    .tag(28)
                    Button(action: {}) {
                        Text("jinja")
                    }
                    .tag(29)
                    Button(action: {}) {
                        Text("lua")
                    }
                    .tag(30)
                    }
                    Button(action: {}) {
                        Text("markdown")
                    }
                    .tag(31)
                    Group {
                    Button(action: {}) {
                        Text("maths")
                    }
                    .tag(32)
                    Button(action: {}) {
                        Text("pascal")
                    }
                    .tag(33)
                    Button(action: {}) {
                        Text("perl")
                    }
                    .tag(34)
                    Button(action: {}) {
                        Text("php")
                    }
                    .tag(35)
                    Button(action: {}) {
                        Text("powershell")
                    }
                    .tag(36)
                    Button(action: {}) {
                        Text("properties")
                    }
                    .tag(37)
                    Button(action: {}) {
                        Text("protobuf")
                    }
                    .tag(38)
                    Button(action: {}) {
                        Text("python")
                    }
                    .tag(39)
                    Button(action: {}) {
                        Text("r")
                    }
                    .tag(40)
                    Button(action: {}) {
                        Text("ruby")
                    }
                    .tag(41)
                    }
                    Group {
                    Button(action: {}) {
                        Text("rust")
                    }
                    .tag(42)
                    Button(action: {}) {
                        Text("sass")
                    }
                    .tag(43)
                    Button(action: {}) {
                        Text("scheme")
                    }
                    .tag(44)
                    Button(action: {}) {
                        Text("shell")
                    }
                    .tag(45)
                    Button(action: {}) {
                        Text("sql")
                    }
                    .tag(46)
                    Button(action: {}) {
                        Text("sqllite")
                    }
                    .tag(47)
                    Button(action: {}) {
                        Text("mysql")
                    }
                    .tag(48)
                    Button(action: {}) {
                        Text("latex")
                    }
                    .tag(49)
                    Button(action: {}) {
                        Text("swift")
                    }
                    .tag(50)
                    Button(action: {}) {
                        Text("text")
                    }
                    .tag(51)
                    }
                    Group {
                    Button(action: {}) {
                        Text("toml")
                    }
                    .tag(52)
                    Button(action: {}) {
                        Text("vb")
                    }
                    .tag(53)
                    Button(action: {}) {
                        Text("vue")
                    }
                    .tag(54)
                    Button(action: {}) {
                        Text("xml")
                    }
                    .tag(55)
                    Button(action: {}) {
                        Text("yaml")
                    }
                    .tag(56)
                    }
                }
                .onChange(of: selectedSyntax, perform: { value in
                    print("Syntax: \(value)")
                    if value == 1 {
                        self.syntax = CodeMode.apl
                    }
                    if value == 2 {
                        self.syntax = CodeMode.pgp
                    }
                    if value == 3 {
                        self.syntax = CodeMode.asn
                    }
                    if value == 4 {
                        self.syntax = CodeMode.cmake
                    }
                    if value == 5 {
                        self.syntax = CodeMode.c
                    }
                    if value == 6 {
                        self.syntax = CodeMode.cplus
                    }
                    if value == 7 {
                        self.syntax = CodeMode.objc
                    }
                    if value == 8 {
                        self.syntax = CodeMode.kotlin
                    }
                    if value == 9 {
                        self.syntax = CodeMode.scala
                    }
                    if value == 10 {
                        self.syntax = CodeMode.csharp
                    }
                    if value == 11 {
                        self.syntax = CodeMode.java
                    }
                    if value == 12 {
                        self.syntax = CodeMode.cobol
                    }
                    if value == 13 {
                        self.syntax = CodeMode.coffeescript
                    }
                    if value == 14 {
                        self.syntax = CodeMode.lisp
                    }
                    if value == 15 {
                        self.syntax = CodeMode.css
                    }
                    if value == 16 {
                        self.syntax = CodeMode.django
                    }
                    if value == 17 {
                        self.syntax = CodeMode.dockerfile
                    }
                    if value == 18 {
                        self.syntax = CodeMode.erlang
                    }
                    if value == 19 {
                        self.syntax = CodeMode.fortran
                    }
                    if value == 20 {
                        self.syntax = CodeMode.go
                    }
                    if value == 21 {
                        self.syntax = CodeMode.groovy
                    }
                    if value == 22 {
                        self.syntax = CodeMode.haskell
                    }
                    if value == 23 {
                        self.syntax = CodeMode.html
                    }
                    if value == 24 {
                        self.syntax = CodeMode.http
                    }
                    if value == 25 {
                        self.syntax = CodeMode.javascript
                    }
                    if value == 26 {
                        self.syntax = CodeMode.typescript
                    }
                    if value == 27 {
                        self.syntax = CodeMode.json
                    }
                    if value == 28 {
                        self.syntax = CodeMode.ecma
                    }
                    if value == 29 {
                        self.syntax = CodeMode.jinja
                    }
                    if value == 30 {
                        self.syntax = CodeMode.lua
                    }
                    if value == 31 {
                        self.syntax = CodeMode.markdown
                    }
                    if value == 32 {
                        self.syntax = CodeMode.maths
                    }
                    if value == 33 {
                        self.syntax = CodeMode.pascal
                    }
                    if value == 34 {
                        self.syntax = CodeMode.perl
                    }
                    if value == 35 {
                        self.syntax = CodeMode.php
                    }
                    if value == 36 {
                        self.syntax = CodeMode.powershell
                    }
                    if value == 37 {
                        self.syntax = CodeMode.properties
                    }
                    if value == 38 {
                        self.syntax = CodeMode.protobuf
                    }
                    if value == 39 {
                        self.syntax = CodeMode.python
                    }
                    if value == 40 {
                        self.syntax = CodeMode.r
                    }
                    if value == 41 {
                        self.syntax = CodeMode.ruby
                    }
                    if value == 42 {
                        self.syntax = CodeMode.rust
                    }
                    if value == 43 {
                        self.syntax = CodeMode.sass
                    }
                    if value == 44 {
                        self.syntax = CodeMode.scheme
                    }
                    if value == 45 {
                        self.syntax = CodeMode.shell
                    }
                    if value == 46 {
                        self.syntax = CodeMode.sql
                    }
                    if value == 47 {
                        self.syntax = CodeMode.sqllite
                    }
                    if value == 48 {
                        self.syntax = CodeMode.mysql
                    }
                    if value == 49 {
                        self.syntax = CodeMode.latex
                    }
                    if value == 50 {
                        self.syntax = CodeMode.swift
                    }
                    if value == 51 {
                        self.syntax = CodeMode.text
                    }
                    if value == 52 {
                        self.syntax = CodeMode.toml
                    }
                    if value == 53 {
                        self.syntax = CodeMode.vb
                    }
                    if value == 54 {
                        self.syntax = CodeMode.vue
                    }
                    if value == 55 {
                        self.syntax = CodeMode.xml
                    }
                    if value == 56 {
                        self.syntax = CodeMode.yaml
                    }
                })
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
} */

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
    static let printCommand = Self("printCommand", default: .init(.p, modifiers: [.command]))
    static let duplicateCommand = Self("duplicateCommand", default: .init(.s, modifiers: [.command, .shift]))
    static let moveToCommand = Self("moveToCommand")
    static let renameCommand = Self("renameCommand")
    static let revertToCommand = Self("revertToCommand")
    static let closeCommand = Self("closeCommand", default: .init(.w, modifiers: [.command]))
}
