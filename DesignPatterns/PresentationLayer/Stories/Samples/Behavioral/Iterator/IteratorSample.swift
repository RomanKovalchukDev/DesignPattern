//
//  IteratorSample.swift
//  DesignPatterns
//
//  Created by Roman Kovalchuk on 27.01.2025.
//

/*
 - used for iterating in collection of elements, ui, data etc.
 
 When to Use a Custom Iterator
     •    You are working with complex data structures (e.g., trees, graphs, linked lists).
     •    You need custom traversal logic (e.g., reverse order, filtering, skipping elements).
     •    You need lazy evaluation (e.g., fetching paginated API data on-demand).
     •    You want to preserve encapsulation (hide internal structure but allow iteration).
     •    You need multiple iteration strategies (e.g., depth-first vs breadth-first traversal).
     •    You are iterating over external resources (e.g., files, database rows).
     •    To improve code reusability by centralizing iteration logic.

 When Not to Use a Custom Iterator
     •    You are working with simple collections (e.g., arrays, dictionaries, sets).
     •    The default iteration mechanisms provided by the language meet your requirements.
     •    The custom iterator adds unnecessary complexity without significant benefits.
 
 */

// MARK: - Sample

import SwiftUI

// MARK: - Song Model
struct Song {
    let title: String
    let artist: String
    let isFavorite: Bool
}

// MARK: - Playlist Iterator
struct PlaylistIterator: IteratorProtocol {
    private var songs: [Song]
    private var index = 0
    private var skipNonFavorites: Bool

    init(songs: [Song], skipNonFavorites: Bool = false) {
        self.songs = songs
        self.skipNonFavorites = skipNonFavorites
    }

    mutating func next() -> Song? {
        while index < songs.count {
            let song = songs[index]
            index += 1

            if skipNonFavorites && !song.isFavorite {
                continue
            }
            return song
        }
        return nil
    }
}

// MARK: - Playlist Sequence
struct Playlist: Sequence {
    private var songs: [Song]

    init(songs: [Song]) {
        self.songs = songs
    }
    
    func makeIterator() -> some IteratorProtocol {
        PlaylistIterator(songs: songs)
    }

    func makeIterator(skipNonFavorites: Bool = false) -> PlaylistIterator {
        PlaylistIterator(songs: songs, skipNonFavorites: skipNonFavorites)
    }
}

// MARK: - Playlist View
struct PlaylistView: View {
    
    var body: some View {
        VStack {
            Toggle("Show Favorites Only", isOn: $displayFavoritesOnly)
                .padding()
                .onChange(of: displayFavoritesOnly) {
                    updateDisplayedSongs()
                }

            List(displayedSongs, id: \.title) { song in
                VStack(alignment: .leading) {
                    Text(song.title)
                        .font(.headline)
                    
                    Text("By \(song.artist)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
            .onAppear {
                updateDisplayedSongs()
            }
        }
        .navigationTitle("Playlist")
        .padding()
    }
    
    private let playlist: Playlist
    @State private var displayFavoritesOnly: Bool = false
    @State private var displayedSongs: [Song] = []

    init() {
        playlist = Playlist(songs: [
            Song(title: "Song 1", artist: "Artist A", isFavorite: false),
            Song(title: "Song 2", artist: "Artist B", isFavorite: true),
            Song(title: "Song 3", artist: "Artist C", isFavorite: false),
            Song(title: "Song 4", artist: "Artist D", isFavorite: true),
            Song(title: "Song 5", artist: "Artist E", isFavorite: false)
        ])
    }

    private func updateDisplayedSongs() {
        var iterator = playlist.makeIterator(skipNonFavorites: displayFavoritesOnly)
        var songs: [Song] = []
        
        while let song = iterator.next() {
            songs.append(song)
        }
        
        displayedSongs = songs
    }
}

// MARK: - Preview
struct PlaylistView_Previews: PreviewProvider {
    static var previews: some View {
        PlaylistView()
    }
}
