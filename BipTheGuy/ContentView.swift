//
//  ContentView.swift
//  BipTheGuy
//
//  Created by David Veeneman on 11/14/23.
//

import SwiftUI
import AVFAudio

struct ContentView: View {
    @State private var audioPlayer: AVAudioPlayer!

    var body: some View {
        VStack {
            Spacer()
            Image("clown")
                .resizable()
                .scaledToFit()
                .onTapGesture {
                    playSound(soundName: "punchSound")
                }
            Spacer()
            
            Button {
                // TODO: Button action here
            } label: {
                Label("Photo Library", systemImage: "photo.fill.on.rectangle.fill")
            }

        }
        .padding()
    }
    
    func playSound(soundName: String) {
            // Requires AVFAudio import, state variable for AVAudioPlayer

            guard let soundFile = NSDataAsset(name: soundName) else {
                print("􀀳 Could not read sound file named \(soundName)")
                return
            }
            
            do {
                audioPlayer = try AVAudioPlayer(data: soundFile.data)
                audioPlayer.play()
            } catch {
                print("􀀳 ERROR: \(error.localizedDescription) creating audio player.")
            }

        }

}

#Preview {
    ContentView()
}
