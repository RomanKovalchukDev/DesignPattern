//
//  StateSample.swift
//  DesignPatterns
//
//  Created by Roman Kovalchuk on 27.01.2025.
//

/*
 With complext states, mostly players, editors.
 */

import SwiftUI
import SFSafeSymbols
import Combine

protocol MediaPlayerStateType {
    var playerView: AnyView { get }
    var title: String { get }
    
    func play(context: MediaPlayer)
    func pause(context: MediaPlayer)
    func stop(context: MediaPlayer)
}

final class PlayingState: MediaPlayerStateType {
    var playerView: AnyView {
        AnyView(
            VStack {
                Text("Playing...")
                    .font(.largeTitle)
                    .padding()
                
                Image(systemSymbol: SFSymbol.playCircleFill)
                    .resizable()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.green)
            }
        )
    }
    
    var title: String {
        "Playing"
    }
    
    func play(context: MediaPlayer) {
        print("Already playing")
    }
    
    func pause(context: MediaPlayer) {
        context.setState(PausedState())
    }
    
    func stop(context: MediaPlayer) {
        context.setState(IdleState())
    }
}

final class PausedState: MediaPlayerStateType {
    var playerView: AnyView {
        AnyView(
            VStack {
                Text("Paused")
                    .font(.largeTitle)
                    .padding()
                
                Image(systemSymbol: SFSymbol.pauseCircleFill)
                    .resizable()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.yellow)
            }
        )
    }
    
    var title: String {
        "Paused"
    }
    
    func play(context: MediaPlayer) {
        context.setState(PlayingState())
    }
    
    func pause(context: MediaPlayer) {
        debugPrint("Already paused")
    }
    
    func stop(context: MediaPlayer) {
        context.setState(IdleState())
    }
}

final class IdleState: MediaPlayerStateType {
    var playerView: AnyView {
        AnyView(
            VStack {
                Text("Idle")
                    .font(.largeTitle)
                    .padding()
                
                Image(systemSymbol: SFSymbol.stopCircleFill)
                    .resizable()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.gray)
            }
        )
    }
    
    var title: String {
        "Idle"
    }
    
    func play(context: MediaPlayer) {
        context.setState(PlayingState())
    }
    
    func pause(context: MediaPlayer) {
        context.setState(PausedState())
    }
    
    func stop(context: MediaPlayer) {
        debugPrint("Already iddle")
    }
}

final class MediaPlayer: ObservableObject {
    
    var stateChangedPublisher: AnyPublisher<any MediaPlayerStateType, Never> {
        rawStateChangedPublisher.eraseToAnyPublisher()
    }
    
    var state: any MediaPlayerStateType = IdleState() {
        didSet {
            rawStateChangedPublisher.send(state)
        }
    }
    
    private let rawStateChangedPublisher: PassthroughSubject<any MediaPlayerStateType, Never> = .init()
        
    func setState(_ newState: MediaPlayerStateType) {
        state = newState
    }
    
    func play() {
        state.play(context: self)
    }
    
    func pause() {
        state.pause(context: self)
    }
    
    func stop() {
        state.stop(context: self)
    }
}

struct MediaPlayerView: View {
    @StateObject private var mediaPlayer = MediaPlayer()
    @State private var currentState: MediaPlayerStateType = IdleState()
    
    var body: some View {
        VStack(spacing: 20) {
            // State title
            Text(currentState.title)
                .font(.headline)
            
            // Display the current state's view
            currentState.playerView

            // Control buttons
            HStack(spacing: 20) {
                Button(
                    action: { mediaPlayer.play() },
                    label: {
                        Text("Play")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                )

                Button(
                    action: { mediaPlayer.pause() },
                    label: {
                        Text("Pause")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.orange)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                )

                Button(
                    action: { mediaPlayer.stop() },
                    label: {
                        Text("Stop")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                )
            }
        }
        .padding()
        .onReceive(mediaPlayer.stateChangedPublisher) { newState in
            currentState = newState
        }
        .navigationTitle("Media Player")
    }
}

// MARK: - Preview
struct MediaPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        MediaPlayerView()
    }
}
