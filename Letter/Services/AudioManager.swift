//
//  AudioManager.swift
//  Letter
//
//  Created by Giovani Nascimento Pereira on 21/07/18.
//  Copyright © 2018 Bianca Itiroko. All rights reserved.
//

import Foundation
import AVFoundation

enum SFX {
    case sound
}

enum Music {
    case soundtrack
}

//Dictionary for all the audio URLs
let audioFilename: [Music: String] =
    [.soundtrack: "kids.m4a"]

let audioSFX: [SFX: String] =
    [:]

class AudioManager {
    
    //The SFX Player
    var SFXplayer: AVAudioPlayer?
    
    //The background music player
    var backgroundPlayer: AVAudioPlayer?
    let defaults = UserDefaults.standard
    
    //Shared instance
    static let instance = AudioManager()
    
    // MARK: BACKGROUND MUSIC
    
    /// Plays the game background music
    ///
    /// - Parameter gameMode: the gameMode refering to the song
    func playGameMusic(for music: Music) {
        // Check the user configuration
        if UserDefaultsManager.instance.getMusicState() == false {
            return
        }
        
        //Song address
        if let url = musicURL(music: music) {
            startSong(url)
        } else {
            return
        }
    }
    
    /// Start playing a song with an url
    ///
    /// - Parameter url: the song address
    private func startSong(_ url: URL) {
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
            
            backgroundPlayer = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            
            guard let backgroundPlayer = backgroundPlayer else { return }
            
            backgroundPlayer.volume = 0.8
            backgroundPlayer.numberOfLoops = -1
            backgroundPlayer.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    /// Get the Music URL
    ///
    /// - Parameter gameMode: the current gameode
    /// - Returns: the song URL
    private func musicURL(music: Music) -> URL? {
        var url: URL?
        if let address = Bundle.main.url(forResource: audioFilename[music], withExtension: nil) {
            url = address
        }
        return url
    }
    
    /// Stop the background Music
    func stopMusic() {
        backgroundPlayer?.stop()
    }
    
    /// Update the music state playing/stopped
    /// according with the UserDefaults configuration
    func checkAudioState() {
        if UserDefaultsManager.instance.getMusicState() == false {
            stopMusic()
        } else {
            playGameMusic(for: .soundtrack)
        }
    }
    
    // MARK: SOUND EFFECTS
    
    /// Get the SFX URL
    ///
    /// - Parameter gameMode: the current gameode
    /// - Returns: the song URL
    private func sfxURL(for sfx: SFX) -> URL? {
        var url: URL?
        if let address = Bundle.main.url(forResource: audioSFX[sfx], withExtension: nil) {
            url = address
        }
        return url
    }

    /// Plays the game SFX
    ///
    /// - Parameter type: the SFX type to be played
    func playSFX(for type: SFX) {
        
        // Check the user configuration
        if UserDefaultsManager.instance.getSFXState() == false {
            return
        }
        
        //Song address
        if let url = sfxURL(for: type) {
            startSFX(url)
        } else {
            return
        }
    }
    
    /// Start playing an SFX with an url
    ///
    /// - Parameter url: the song address
    private func startSFX(_ url: URL) {
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
            
            SFXplayer = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            
            guard let SFXplayer = SFXplayer else { return }
            
            SFXplayer.volume = 0.5
            SFXplayer.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    /// Singleton
    private init(){}
}
