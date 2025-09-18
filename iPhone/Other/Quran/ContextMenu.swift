import SwiftUI

struct SurahContextMenu: View {
    @EnvironmentObject var settings: Settings
    @EnvironmentObject var quranData: QuranData
    @EnvironmentObject var quranPlayer: QuranPlayer

    let surahID: Int
    let surahName: String
    
    let favoriteSurahs: Set<Int>
    
    @Binding var searchText: String
    @Binding var scrollToSurahID: Int
    
    var lastListened: Bool?

    private var isFavorite: Bool {
        favoriteSurahs.contains(surahID)
    }

    var body: some View {
        Button(role: isFavorite ? .destructive : .cancel) {
            settings.hapticFeedback()
            settings.toggleSurahFavorite(surah: surahID)
        } label: {
            Label(
                isFavorite ? "Unfavorite Surah" : "Favorite Surah",
                systemImage: isFavorite ? "star.fill" : "star"
            )
        }
        
        Button {
            settings.hapticFeedback()
            
            if let surah = quranData.surah(surahID) {
                if let randomAyah = surah.ayahs.randomElement() {
                    quranPlayer.playAyah(
                        surahNumber: surahID,
                        ayahNumber: randomAyah.id,
                        continueRecitation: true
                    )
                }
            }
        } label: {
            Label("Play Random Ayah", systemImage: "shuffle.circle.fill")
        }
        
        if lastListened == nil {
            Button {
                settings.hapticFeedback()
                quranPlayer.playSurah(surahNumber: surahID, surahName: surahName)
            } label: {
                Label("Play Surah", systemImage: "play.fill")
            }
        }

        Button {
            settings.hapticFeedback()
            
            withAnimation {
                searchText = ""
                scrollToSurahID = surahID
                self.endEditing()
            }
        } label: {
            Text("Scroll To Surah")
            Image(systemName: "arrow.down.circle")
        }
    }
}

struct AyahContextMenuModifier: ViewModifier {
    @EnvironmentObject var settings: Settings
    @EnvironmentObject var quranData: QuranData
    @EnvironmentObject var quranPlayer: QuranPlayer

    let surah: Int
    let ayah: Int
    
    let favoriteSurahs: Set<Int>
    let bookmarkedAyahs: Set<String>
    
    @Binding var searchText: String
    @Binding var scrollToSurahID: Int
    
    let lastRead: Bool
    
    @State var shareSettings = ShareSettings()
    @State var showAyahSheet = false
    
    @State private var showingNoteSheet = false
    @State private var draftNote: String = ""
    @State private var showRespectAlert = false

    private var isBookmarked: Bool {
        bookmarkedAyahs.contains("\(surah)-\(ayah)")
    }
    
    func containsProfanity(_ text: String) -> Bool {
        let t = text.folding(options: [.diacriticInsensitive, .widthInsensitive], locale: .current).lowercased()
        return profanityFilter.contains { !$0.isEmpty && t.contains($0) }
    }
    
    private func isNoteAllowed(_ text: String) -> Bool {
        !containsProfanity(text)
    }
    
    private var bookmarkIndex: Int? {
        settings.bookmarkedAyahs.firstIndex { $0.surah == surah && $0.ayah == ayah }
    }
    
    private var bookmark: BookmarkedAyah? {
        bookmarkIndex.flatMap { settings.bookmarkedAyahs[$0] }
    }
    
    private var isBookmarkedHere: Bool { bookmarkIndex != nil }
    private var currentNote: String {
        (bookmark?.note ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    private func setNote(_ text: String?) {
        withAnimation {
            let normalized = text?.trimmingCharacters(in: .whitespacesAndNewlines)
            if let idx = bookmarkIndex {
                var b = settings.bookmarkedAyahs[idx]
                b.note = (normalized?.isEmpty == true) ? nil : normalized
                settings.bookmarkedAyahs[idx] = b
            } else {
                let new = BookmarkedAyah(surah: surah, ayah: ayah, note: (normalized?.isEmpty == true ? nil : normalized))
                settings.bookmarkedAyahs.append(new)
            }
        }
    }

    private func removeNote() {
        guard let idx = bookmarkIndex else { return }
        withAnimation {
            var b = settings.bookmarkedAyahs[idx]
            b.note = nil
            settings.bookmarkedAyahs[idx] = b
        }
    }
    
    @State private var confirmRemoveNote = false

    private func toggleBookmarkWithNoteGuard() {
        if isBookmarkedHere, !currentNote.isEmpty {
            confirmRemoveNote = true
        } else {
            settings.hapticFeedback()
            settings.toggleBookmark(surah: surah, ayah: ayah)
        }
    }

    @ViewBuilder
    func body(content: Content) -> some View {
        let surahObj = quranData.quran.first { $0.id == surah }
        
        #if os(watchOS)
        content
        #else
        content
            .contextMenu {
                if lastRead {
                    Button(role: .destructive) {
                        settings.hapticFeedback()
                        withAnimation {
                            settings.lastReadSurah = 0
                            settings.lastReadAyah = 0
                        }
                    } label: { Label("Remove", systemImage: "trash") }
                    
                    Divider()
                }
                
                Button(role: isBookmarked ? .destructive : .cancel) {
                    settings.hapticFeedback()
                    toggleBookmarkWithNoteGuard()
                } label: {
                    Label(
                        isBookmarked ? "Unbookmark Ayah" : "Bookmark Ayah",
                        systemImage: isBookmarked ? "bookmark.fill" : "bookmark"
                    )
                }

                Button {
                    settings.hapticFeedback()
                    quranPlayer.playAyah(surahNumber: surah, ayahNumber: ayah)
                } label: {
                    Label("Play Ayah", systemImage: "play.circle")
                }

                Button {
                    settings.hapticFeedback()
                    quranPlayer.playAyah(
                        surahNumber: surah,
                        ayahNumber: ayah,
                        continueRecitation: true
                    )
                } label: {
                    Label("Play from Ayah", systemImage: "play.circle.fill")
                }
                
                Divider()
                
                Button {
                    settings.hapticFeedback()
                    if !isBookmarked {
                        settings.toggleBookmark(surah: surah, ayah: ayah)
                    }
                    draftNote = currentNote
                    showingNoteSheet = true
                } label: {
                    Label(currentNote.isEmpty ? "Add Note" : "Edit Note", systemImage: "note.text")
                }

                if !currentNote.isEmpty {
                    Button(role: .destructive) {
                        settings.hapticFeedback()
                        removeNote()
                    } label: {
                        Label("Remove Note", systemImage: "trash")
                    }
                }
                
                Divider()

                Button {
                    settings.hapticFeedback()
                    shareSettings = ShareSettings(
                        arabic: settings.showArabicText,
                        transliteration: settings.showTransliteration,
                        englishSaheeh: settings.showEnglishSaheeh,
                        englishMustafa: settings.showEnglishMustafa
                    )
                    showAyahSheet = true
                } label: {
                    Label("Share Ayah", systemImage: "square.and.arrow.up")
                }

                Divider()

                if let surah = surahObj {
                    SurahContextMenu(
                        surahID: surah.id,
                        surahName: surah.nameTransliteration,
                        favoriteSurahs: favoriteSurahs,
                        searchText: $searchText,
                        scrollToSurahID: $scrollToSurahID
                    )
                }
            }
            .sheet(isPresented: $showAyahSheet) {
                ShareAyahSheet(
                    shareSettings: $shareSettings,
                    surahNumber: surah,
                    ayahNumber: ayah
                )
            }
            .sheet(isPresented: $showingNoteSheet) {
                if let surah = surahObj {
                    NoteEditorSheet(
                        title: "Note for \(surah.nameTransliteration) \(surah.id):\(ayah)",
                        text: $draftNote,
                        onAttemptSave: { text in
                            if isNoteAllowed(text) {
                                setNote(text)
                                return true
                            } else {
                                showRespectAlert = true
                                return false
                            }
                        },
                        onCancel: {},
                        onSave: { setNote(draftNote) }
                    )
                }
            }
            .confirmationDialog("Note not saved", isPresented: $showRespectAlert, titleVisibility: .visible) {
                Button("OK", role: .cancel) { }
            } message: {
                Text("Please keep notes Islamic and respectful.")
            }
            .confirmationDialog("Remove bookmark and delete note?", isPresented: $confirmRemoveNote, titleVisibility: .visible) {
                Button("Remove", role: .destructive) {
                    settings.hapticFeedback()
                    settings.toggleBookmark(surah: surah, ayah: ayah)
                }
                Button("Cancel", role: .cancel) {}
            } message: {
                Text("This ayah has a note. Unbookmarking will delete the note.")
            }
        #endif
    }
}

extension View {
    func ayahContextMenuModifier(
        surah: Int,
        ayah: Int,
        favoriteSurahs: Set<Int>,
        bookmarkedAyahs: Set<String>,
        searchText: Binding<String>,
        scrollToSurahID: Binding<Int>,
        lastRead: Bool = false
    ) -> some View {
        self.modifier(AyahContextMenuModifier(
            surah: surah,
            ayah: ayah,
            favoriteSurahs: favoriteSurahs,
            bookmarkedAyahs: bookmarkedAyahs,
            searchText: searchText,
            scrollToSurahID: scrollToSurahID,
            lastRead: lastRead
        ))
    }
}

struct LeftSwipeActions: ViewModifier {
    @EnvironmentObject private var settings: Settings

    let surah: Int
    let favoriteSurahs: Set<Int>
    let bookmarkedAyahs: Set<String>?
    let bookmarkedSurah: Int?
    let bookmarkedAyah: Int?

    private var isFavorite: Bool {
        favoriteSurahs.contains(surah)
    }

    private var isBookmarked: Bool {
        if let bookmarkedAyahs, let s = bookmarkedSurah, let a = bookmarkedAyah {
            return bookmarkedAyahs.contains("\(s)-\(a)")
        }
        return false
    }
    
    private var bookmarkIndex: Int? {
        let surah = bookmarkedSurah ?? 1
        let ayah = bookmarkedAyah ?? 1
        
        return settings.bookmarkedAyahs.firstIndex { $0.surah == surah && $0.ayah == ayah }
    }
    
    private var bookmark: BookmarkedAyah? {
        bookmarkIndex.flatMap { settings.bookmarkedAyahs[$0] }
    }
    
    private var isBookmarkedHere: Bool { bookmarkIndex != nil }
    
    private var currentNote: String {
        (bookmark?.note ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    @State private var confirmRemoveNote = false

    private func toggleBookmarkWithNoteGuard(_ surah: Int, _ ayah: Int) {
        if isBookmarkedHere, !currentNote.isEmpty {
            confirmRemoveNote = true
        } else {
            settings.hapticFeedback()
            settings.toggleBookmark(surah: surah, ayah: ayah)
        }
    }

    func body(content: Content) -> some View {
        content
            .swipeActions(edge: .leading) {
                Button {
                    settings.hapticFeedback()
                    settings.toggleSurahFavorite(surah: surah)
                } label: {
                    Image(systemName: isFavorite ? "star.fill" : "star")
                }
                .tint(settings.accentColor)

                if let s = bookmarkedSurah, let a = bookmarkedAyah {
                    Button {
                        settings.hapticFeedback()
                        toggleBookmarkWithNoteGuard(s, a)
                    } label: {
                        Image(systemName: isBookmarked ? "bookmark.fill" : "bookmark")
                    }
                    .tint(settings.accentColor)
                }
            }
            .confirmationDialog("Remove bookmark and delete note?", isPresented: $confirmRemoveNote, titleVisibility: .visible) {
                Button("Remove", role: .destructive) {
                    settings.hapticFeedback()
                    settings.toggleBookmark(surah: bookmarkedSurah ?? 1, ayah: bookmarkedAyah ?? 1)
                }
                Button("Cancel", role: .cancel) {}
            } message: {
                Text("This ayah has a note. Unbookmarking will delete the note.")
            }
    }
}

public extension View {
    func leftSwipeActions(
        surah: Int,
        favoriteSurahs: Set<Int>,
        bookmarkedAyahs: Set<String>? = nil,
        bookmarkedSurah: Int? = nil,
        bookmarkedAyah: Int? = nil
    ) -> some View {
        modifier(LeftSwipeActions(
            surah: surah,
            favoriteSurahs: favoriteSurahs,
            bookmarkedAyahs: bookmarkedAyahs,
            bookmarkedSurah: bookmarkedSurah,
            bookmarkedAyah: bookmarkedAyah
        ))
    }
}

struct RightSwipeActions: ViewModifier {
    @EnvironmentObject private var settings: Settings
    @EnvironmentObject private var quranPlayer: QuranPlayer

    let surahID: Int
    let surahName: String
    let ayahID: Int?
    let certainReciter: Bool

    @Binding var searchText: String
    @Binding var scrollToSurahID: Int

    private func endEditing() {
        #if !os(watchOS)
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        #endif
    }

    func body(content: Content) -> some View {
        content.swipeActions(edge: .trailing) {
            Button {
                settings.hapticFeedback()
                quranPlayer.playSurah(
                    surahNumber: surahID,
                    surahName: surahName,
                    certainReciter: certainReciter
                )
            } label: {
                Image(systemName: "play.fill")
            }
            .tint(settings.accentColor)

            if let ayah = ayahID {
                Button {
                    settings.hapticFeedback()
                    quranPlayer.playAyah(surahNumber: surahID, ayahNumber: ayah)
                } label: {
                    Image(systemName: "play.circle")
                }
            }

            Button {
                settings.hapticFeedback()
                withAnimation {
                    searchText = ""
                    scrollToSurahID = surahID
                    endEditing()
                }
            } label: {
                Image(systemName: "arrow.down.circle")
            }
            .tint(.secondary)
        }
    }
}

public extension View {
    func rightSwipeActions(
        surahID: Int,
        surahName: String,
        ayahID: Int? = nil,
        certainReciter: Bool = false,
        searchText: Binding<String>,
        scrollToSurahID: Binding<Int>
    ) -> some View {
        modifier(RightSwipeActions(
            surahID: surahID,
            surahName: surahName,
            ayahID: ayahID,
            certainReciter: certainReciter,
            searchText: searchText,
            scrollToSurahID: scrollToSurahID
        ))
    }
}

#if !os(watchOS)
import SwiftUI

struct NoteEditorSheet: View {
    let title: String
    @Binding var text: String
    var onAttemptSave: (String) -> Bool
    var onCancel: () -> Void
    var onSave: () -> Void

    @Environment(\.dismiss) private var dismiss
    @Environment(\.colorScheme) private var scheme
    
    @FocusState private var noteFocused: Bool

    private let maxChars: Int = 300

    private var characterCount: Int { text.count }
    private var remaining: Int { max(0, maxChars - characterCount) }
    private var isEmpty: Bool { text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }

    var body: some View {
        NavigationView {
            VStack(spacing: 12) {
                let cardFill   = Color(UIColor.secondarySystemBackground)
                let cardStroke = Color.primary.opacity(0.12)

                TextEditor(text: $text)
                    .padding(12)
                    .background(Color.clear)
                    .frame(minHeight: 220)
                    .modifier(HideEditorScrollBackground())
                    .textInputAutocapitalization(.sentences)
                    .disableAutocorrection(false)
                    .focused($noteFocused)
                    .onChange(of: text) { newValue in
                        if newValue.count > maxChars {
                            text = String(newValue.prefix(maxChars))
                        }
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 12, style: .continuous)
                            .fill(cardFill)
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 12, style: .continuous)
                            .stroke(cardStroke, lineWidth: 1)
                    )

                HStack(spacing: 8) {
                    Text("\(remaining) characters left")
                        .font(.footnote.monospacedDigit())
                        .foregroundColor(.secondary)
                    Spacer()
                }
                .accessibilityElement(children: .combine)
                .accessibilityLabel("Character limit")
                .accessibilityValue("\(maxChars) limit, \(remaining) remaining")

                VStack(alignment: .leading, spacing: 10) {
                    HStack(alignment: .firstTextBaseline, spacing: 8) {
                        Image(systemName: "hands.sparkles")
                            .imageScale(.large)
                        Text("A respectful reminder")
                            .font(.headline)
                    }
                    .foregroundColor(.accentColor)

                    Text("Your note will appear next to the Quran, the Words of Allah ﷻ. Please keep it dignified and beneficial.")
                        .font(.subheadline)

                    VStack(alignment: .leading, spacing: 6) {
                        Label("Avoid profanity or insults", systemImage: "checkmark.seal")
                        Label("No mockery, slurs, or indecency", systemImage: "checkmark.seal")
                        Label("Keep remarks relevant and respectful", systemImage: "checkmark.seal")
                    }
                    .font(.footnote)
                    .foregroundColor(.secondary)

                    Text("May Allah ﷻ reward you, protect you, and keep us all firm upon the truth.")
                        .font(.footnote)
                        .foregroundColor(.secondary)
                }
                .padding()
                .accessibilityElement(children: .combine)
                .transition(.opacity.combined(with: .move(edge: .bottom)))
                .background(
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .fill(cardFill)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .stroke(cardStroke, lineWidth: 1)
                )
            }
            .padding(.horizontal)
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        onCancel()
                        dismiss()
                    }
                }

                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        if onAttemptSave(text) {
                            dismiss()
                        }
                    }
                    .disabled(isEmpty)
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                    noteFocused = true
                }
            }
            .onDisappear {
                noteFocused = false
            }
        }
    }
}

private struct HideEditorScrollBackground: ViewModifier {
    func body(content: Content) -> some View {
        if #available(iOS 16.0, *) {
            content.scrollContentBackground(.hidden)
        } else {
            content
                .onAppear {
                    UITextView.appearance().backgroundColor = .clear
                }
        }
    }
}
#endif
