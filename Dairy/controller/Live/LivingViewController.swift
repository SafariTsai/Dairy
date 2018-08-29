//
//  LivingViewController.swift
//  Dairy
//
//  Created by SAI on 2018/08/22.
//  Copyright © 2018 SAI. All rights reserved.
//

import UIKit

class LivingViewController: UIViewController {

	
	
	var liveList : INKCell!
	var playerView : UIView!
	var ijkPlayer :IJKMediaPlayback!
	
	@IBOutlet weak var btnBack: UIButton!
	@IBAction func tapBack(_ sender: UIButton) {
		ijkPlayer.shutdown()	
		self.dismiss(animated: true, completion: nil)
		
	}
	
	func bringToFront (){
		view.bringSubview(toFront: btnBack)
	}
	func setPlayerView(){
		self.playerView = UIView(frame: view.bounds)
		view.addSubview(playerView)
		ijkPlayer = IJKFFMoviePlayerController(contentURLString:liveList.stream_url,with: nil)
		let pv = ijkPlayer.view!
		pv.frame = playerView.bounds
		pv.autoresizingMask = [.flexibleWidth,.flexibleHeight]
		playerView.insertSubview(pv, at: 1)
		ijkPlayer.scalingMode = .aspectFill
		
		
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		ijkPlayer.prepareToPlay()
	}
	
	override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		setPlayerView()
		bringToFront()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
