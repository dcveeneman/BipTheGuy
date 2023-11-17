//
//  ContentView.swift
//  BipTheGuy
//
//  Created by David Veeneman on 11/14/23.
//

import SwiftUI
import AVFAudio
import PhotosUI

struct ContentView: View {
    @State private var audioPlayer: AVAudioPlayer!
    @State private var animateImage = true
    @State private var selectedPhoto: PhotosPickerItem?
    @State private var bipImage = Image("clown")

    var body: some View {
        VStack {
            Spacer()
            
            bipImage
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
            
            PhotosPicker(selection: $selectedPhoto, matching: .images, preferredItemEncoding: .automatic){
                Label("Photo Library", systemImage: "photo.fill.on.rectangle.fill")
            }
            .onChange(of: selectedPhoto) {
                // We need to:
                // (1) get the data inside the PhotosPickerItem selectedPhoto;
                // (2) use that data to create a UIImage;
                // (3) use the UIImage to create an Image; and
                // (4) assign that image to bipImage
                Task {
                    do {
                        if let data = try await selectedPhoto?.loadTransferable(type: Data.self) { // (1)
                            if let uiImage = UIImage(data: data) { // (2)
                                bipImage = Image(uiImage: uiImage) // (3), (4)
                            }
                        }
                    } catch {
                        print("􀀳 ERROR: loading failed-- \(error.localizedDescription)")
                    }
                }
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
