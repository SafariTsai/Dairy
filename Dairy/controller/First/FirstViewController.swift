//
//  FirstViewController.swift
//  Dairy
//
//  Created by SAI on 2018/08/21.
//  Copyright © 2018 SAI. All rights reserved.
//

import UIKit
import StreamingKit

class FirstViewController: UIViewController {
	
	@IBOutlet weak var playbackSlider: UISlider!
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var playTime: UILabel!
	@IBOutlet weak var pauseBtn: UIButton!
	
	var timer:Timer!
	var audioPlayer:STKAudioPlayer!
	
	//播放列表
	var queue = [Music(name: "歌曲1",
					   url: URL(string: "https://ohoh.fun/uploads/tracks/1592391466_2040109480_47494354.mp3")!),
				 Music(name: "歌曲2",
					   url: URL(string: "http://mxd.766.com/sdo/music/data/3/m12.mp3")!),
				 Music(name: "歌曲3",
					   url: URL(string: "http://mxd.766.com/sdo/music/data/3/m13.mp3")!)]
	
	//当前播放音乐索引
	var currentIndex:Int = -1
	
	//是否循环播放
	var loop:Bool = false
	
	//当前播放状态
	var state:STKAudioPlayerState = []
	
	override func viewDidAppear(_ animated: Bool) {
		if state != .playing{
			audioPlayer.resume()
		}
	}
	
	override func viewDidLoad() {
		
		super.viewDidLoad()
		
		//设置进度条相关属性
		playbackSlider!.minimumValue = 0
		playbackSlider!.isContinuous = false
		
		//重置播放器
		resetAudioPlayer()
		
		//开始播放歌曲列表
		playWithQueue(queue: queue)
		
		//设置一个定时器，每三秒钟滚动一次
		timer = Timer.scheduledTimer(timeInterval: 0.1, target: self,
									 selector: #selector(tick), userInfo: nil, repeats: true)
	}
	
	//重置播放器
	func resetAudioPlayer() {
		var options = STKAudioPlayerOptions()
		options.flushQueueOnSeek = true
		options.enableVolumeMixer = true
		audioPlayer = STKAudioPlayer(options: options)
		
		audioPlayer.meteringEnabled = true
		audioPlayer.volume = 1
		audioPlayer.delegate = self
	}
	
	//开始播放歌曲列表（默认从第一首歌曲开始播放）
	func playWithQueue(queue: [Music], index: Int = 0) {
		guard index >= 0 && index < queue.count else {
			return
		}
		self.queue = queue
		audioPlayer.clearQueue()
		let url = queue[index].url
		audioPlayer.play(url)
		
		for i in 1 ..< queue.count {
			audioPlayer.queue(queue[Int((index + i) % queue.count)].url)
		}
		currentIndex = index
		loop = false
	}
	
	//停止播放
	func stop() {
		audioPlayer.stop()
		queue = []
		currentIndex = -1
	}
	
	//单独播放某个歌曲
	func play(file: Music) {
		audioPlayer.play(file.url)
	}
	
	//下一曲
	func next() {
		guard queue.count > 0 else {
			return
		}
		currentIndex = (currentIndex + 1) % queue.count
		playWithQueue(queue: queue, index: currentIndex)
	}
	
	//上一曲
	func prev() {
		currentIndex = max(0, currentIndex - 1)
		playWithQueue(queue: queue, index: currentIndex)
	}
	
	//下一曲按钮点击
	@IBAction func nextBtnTapped(_ sender: Any) {
		next()
	}
	
	//上一曲按钮点击
	@IBAction func prevBtnTapped(_ sender: Any) {
		prev()
	}
	
	//暂停继续按钮点击
	@IBAction func pauseBtnTapped(_ sender: Any) {
		//在暂停和继续两个状态间切换
		if self.state == .paused {
			audioPlayer.resume()
		}else{
			audioPlayer.pause()
		}
	}
	
	//结束按钮点击
	@IBAction func stopBtnTapped(_ sender: Any) {
		stop()
	}
	
	//定时器响应，更新进度条和时间
	@objc func tick() {
		if state == .playing {
			//更新进度条进度值
			self.playbackSlider!.value = Float(audioPlayer.progress)
			
			//一个小算法，来实现00：00这种格式的播放时间
			let all:Int=Int(audioPlayer.progress)
			let m:Int=all % 60
			let f:Int=Int(all/60)
			var time:String=""
			if f<10{
				time="0\(f):"
			}else {
				time="\(f)"
			}
			if m<10{
				time+="0\(m)"
			}else {
				time+="\(m)"
			}
			//更新播放时间
			self.playTime!.text=time
		}
	}
	
	//拖动进度条改变值时触发
	@IBAction func playbackSliderValueChanged(_ sender: Any) {
		//播放器定位到对应的位置
		audioPlayer.seek(toTime: Double(playbackSlider.value))
		//如果当前时暂停状态，则继续播放
		if state == .paused
		{
			audioPlayer.resume()
		}
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}
	override func viewDidDisappear(_ animated: Bool) {
		if state == .playing{
			audioPlayer.pause()
		}
	}
	
}

//Audio Player相关代理方法
extension FirstViewController: STKAudioPlayerDelegate {
	
	//开始播放歌曲
	func audioPlayer(_ audioPlayer: STKAudioPlayer,
					 didStartPlayingQueueItemId queueItemId: NSObject) {
		if let index = (queue.index { $0.url == queueItemId as! URL }) {
			currentIndex = index
		}
	}
	
	//缓冲完毕
	func audioPlayer(_ audioPlayer: STKAudioPlayer,
					 didFinishBufferingSourceWithQueueItemId queueItemId: NSObject) {
		updateNowPlayingInfoCenter()
	}
	
	//播放状态变化
	func audioPlayer(_ audioPlayer: STKAudioPlayer,
					 stateChanged state: STKAudioPlayerState,
					 previousState: STKAudioPlayerState) {
		self.state = state
		if state != .stopped && state != .error && state != .disposed {
		}
		updateNowPlayingInfoCenter()
	}
	
	//播放结束
	func audioPlayer(_ audioPlayer: STKAudioPlayer,
					 didFinishPlayingQueueItemId queueItemId: NSObject,
					 with stopReason: STKAudioPlayerStopReason,
					 andProgress progress: Double, andDuration duration: Double) {
		if let index = (queue.index {
			$0.url == audioPlayer.currentlyPlayingQueueItemId() as! URL
		}) {
			currentIndex = index
		}
		
		//自动播放下一曲
		if stopReason == .eof {
			next()
		} else if stopReason == .error {
			stop()
			resetAudioPlayer()
		}
	}
	
	//发生错误
	func audioPlayer(_ audioPlayer: STKAudioPlayer,
					 unexpectedError errorCode: STKAudioPlayerErrorCode) {
		print("Error when playing music \(errorCode)")
		resetAudioPlayer()
		playWithQueue(queue: queue, index: currentIndex)
	}
	
	//更新当前播放信息
	func updateNowPlayingInfoCenter() {
		if currentIndex >= 0 {
			let music = queue[currentIndex]
			//更新标题
			titleLabel.text = "当前播放：\(music.name)"
			
			//更新暂停按钮名字
			let pauseBtnTitle = self.state == .playing ? "暂停" : "继续"
			pauseBtn.setTitle(pauseBtnTitle, for: .normal)
			
			//设置进度条相关属性
			playbackSlider!.maximumValue = Float(audioPlayer.duration)
		}else{
			//停止播放
			titleLabel.text = "播放停止!"
			//更新进度条和时间标签
			playbackSlider.value = 0
			playTime.text = "--:--"
		}
	}
}

//歌曲类
class Music {
	var name:String
	var url:URL
	
	//类构造函数
	init(name:String, url:URL){
		self.name = name
		self.url = url
	}
}

