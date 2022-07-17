//
//  YoutubeVideoView.swift
//  MoviesApp
//
//  Created by Anirudha Mahale on 17/07/22.
//
// https://developer.apple.com/tutorials/swiftui/interfacing-with-uikit
// https://sarunw.com/posts/uikit-in-swiftui/
//

import SwiftUI
import youtube_ios_player_helper

struct YoutubeVideoView : UIViewRepresentable {
  
  var videoID : String
  let videoEnded: () -> Void
  
  func makeCoordinator() -> Coordinator {
    Coordinator(self)
  }
  
  func makeUIView(context: Context) -> YTPlayerView {
    let playerView = YTPlayerView()
    playerView.delegate = context.coordinator
    playerView.load(withVideoId: videoID)
    return playerView
  }
  
  func updateUIView(_ uiView: YTPlayerView, context: Context) {
    //
  }
  
  class Coordinator: NSObject, YTPlayerViewDelegate {
    
    var parent: YoutubeVideoView
    
    init(_ view: YoutubeVideoView) {
      parent = view
    }
    
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
      // Player has loaded the video & ready to stream it.
      playerView.playVideo()
    }
    
    func playerView(_ playerView: YTPlayerView, didChangeTo state: YTPlayerState) {
      if state == .ended {
        parent.videoEnded()
      }
    }
  }
}

//struct YoutubeVideoView_Previews: PreviewProvider {
//  static var previews: some View {
//    YoutubeVideoView()
//  }
//}
