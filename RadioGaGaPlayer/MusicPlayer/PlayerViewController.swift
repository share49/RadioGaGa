//
//  PlayerViewController.swift
//  RadioGaGaPlayer
//
//  Created by Roger Pintó Diaz on 1/15/19.
//  Copyright © 2019 Roger Pintó Diaz. All rights reserved.
//

import UIKit
import AVFoundation

final class PlayerViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var ivCover: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblArtist: UILabel!
    @IBOutlet weak var btnPlayPause: UIButton!
    
    // MARK: - Var and const
    var songIndex = Int()
    var songs = [SearchResult]()
    var songPlayer: AVPlayer?
    
    // MARK: - Enums
    enum SwitchTrack: CaseIterable {
        case next
        case previous
    }
    
    // MARK: - UIViewController
    static func create(index: Int, songs: [SearchResult]) -> UIViewController {
        let storyboard = UIStoryboard.init(name: k.storyboards.player, bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: k.viewControllers.player) as! PlayerViewController
        viewController.songIndex = index
        viewController.songs = songs
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        styleView()
    }
    
    func styleView() {
        let song = songs[songIndex]
        
        title = song.title + " - " + song.artist
        ivCover.getAndCacheImage(stringUrl: song.coverUrl)
        lblTitle.text = song.title
        lblArtist.text = song.artist
    }
    
    // MARK: - onButton Actions
    @IBAction func onPlayPause(_ sender: UIButton) {
        playPauseSong()
    }
    
    @IBAction func onPreviousSong(_ sender: UIButton) {
        getSong(track: .previous)
    }
    
    @IBAction func onNextSong(_ sender: UIButton) {
        getSong(track: .next)
    }
    
    @IBAction func onShare(_ sender: UIButton) {
        let songLink = songs[songIndex].previewUrl
        let activityViewController = UIActivityViewController(activityItems: [songLink], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        present(activityViewController, animated: true)
    }
    
    // MARK: - Support methods
    func loadSongPlayer() {
        guard let url = URL(string: songs[songIndex].previewUrl) else {
            showOkAlertWithMessage(title: ls.oopsWeCouldntPlayTheSong)
            btnPlayPause.setTitle(ls.play, for: .normal)
            return
        }
        
        let playerItem = AVPlayerItem.init(url: url)
        songPlayer = AVPlayer.init(playerItem: playerItem)
    }
    
    func playPauseSong() {
        if songPlayer == nil {
            btnPlayPause.setTitle(ls.pause, for: .normal)
            loadSongPlayer()
            songPlayer?.play()
        } else if songPlayer?.rate != 0 && songPlayer?.error == nil {
            btnPlayPause.setTitle(ls.play, for: .normal)
            songPlayer?.pause()
        } else {
            btnPlayPause.setTitle(ls.pause, for: .normal)
            songPlayer?.play()
        }
    }
    
    func getSong(track: SwitchTrack) {
        songPlayer = nil
        songIndex = track == SwitchTrack.next ? songIndex + 1 : songIndex - 1
        playPauseSong()
        
        UIView.animate(withDuration: 0.3) {
            self.styleView()
        }
    }
    
    func showOkAlertWithMessage(title: String) {
        let alert = UIAlertController(title: nil, message: title, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: ls.ok, style: .cancel))
        alert.modalPresentationStyle = .popover
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Deinit
    deinit {
        I("Dealloc: PlayerViewController")
    }
}
