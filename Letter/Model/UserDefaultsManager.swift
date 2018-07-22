//
//  UserDefaultsManager.swift
//  Letter
//
//  Created by Giovani Nascimento Pereira on 19/07/18.
//  Copyright © 2018 Bianca Itiroko. All rights reserved.
//

import Foundation

enum Keys: String {
    case numberOfExecutions
    case objDict
    case music
    case sfx
}

class UserDefaultsManager {
    
    static let instance = UserDefaultsManager()
    let defaults = UserDefaults.standard
    
    /// Retrieve stored dictionary on UserDefaults
    ///
    /// - Returns: the dictionary [String: Bool] which represents
    /// the completed objects on the game
    func getObjectsDictionary() -> [String: Bool] {
        return (defaults.dictionary(forKey: Keys.objDict.rawValue) as? [String: Bool]) ?? [:]
    }
    
    /// Updates the stored dictionary of objects wirh a new
    /// key:value object
    /// if the key already exists, replace the value with the new one
    ///
    /// - Parameter dict: new values to be added on the dictionary
    func updateObjectsDictionary(with dict: [String: Bool]) {
        let oldValue = self.getObjectsDictionary()
        let newValue = oldValue.merging(dict) {$1}
        defaults.set(newValue, forKey: Keys.objDict.rawValue)
    }
    
    func getMusicState() -> Bool {
        return defaults.bool(forKey: Keys.music.rawValue)
    }
    
    func setMusicState(to state: Bool) {
        defaults.set(state, forKey: Keys.music.rawValue)
    }
    
    func getSFXState() -> Bool {
        return defaults.bool(forKey: Keys.sfx.rawValue)
    }
    
    func setSFXState(to state: Bool) {
        defaults.set(state, forKey: Keys.sfx.rawValue)
    }
    
    func getNumberOfExecutions() -> Int {
        return defaults.integer(forKey: Keys.numberOfExecutions.rawValue)
    }
    
    func updateNumbeOfExecutions() {
        defaults.set(self.getNumberOfExecutions() + 1, forKey: Keys.numberOfExecutions.rawValue)
    }
    
    /// Singleton
    private init() {}
}
