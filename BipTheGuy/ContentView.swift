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
    @State private var animateImage = true

    var body: some View {
        VStack {
            Spacer()
            
            Image("clown")
                .resizable()
                .scaledToFit()
                .scaleEffect(animateImage ? 1.0 : 0.9)
                .onTapGesture {
                    playSound(soundName: "punchSound")
                    animateImage = false // will immediately shrink using .scaleEffect to 90% of size
                    withAnimation (.spring(response: 0.3, dampingFraction: 0.3)) {
                        animateImage = true // Will go from 90% size to 100% size, but using the .spring animation
                    }
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
