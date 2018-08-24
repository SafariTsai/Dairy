//
//  SecondViewController.swift
//  Dairy
//
//  Created by SAI on 2018/08/21.
//  Copyright © 2018 SAI. All rights reserved.
//

import UIKit
import Just
import Kingfisher

class SecondViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
	
	@IBOutlet weak var SecTableView: UITableView!
	let get_uid_url = "http://baseapi.busi.inke.cn/live/LiveHotList"
	var list : [INKCell] = []
	
/******************************************************************************************************************/
	func loadList ( ) {
		Just.post(get_uid_url) { (r) in
			guard let json = r.json as? NSDictionary else{
				return
			}
			let lives = INKRootLiveStream(fromDictionary: json).data!
			self.list = lives.map({ (live) -> INKCell in
				return INKCell(portrait: live.image2, nick: live.nick, online_users: live.onlineUsers, location: live.city, stream_url:"http://wssource.hls.inke.cn/live/"+live.liveid+"/playlist.m3u8")
			})
			print(self.list)
			OperationQueue.main.addOperation {
				self.SecTableView.reloadData()
			}
		}
	}
/****************************************************************************************************************/

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return list.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "SecCell", for: indexPath) as! SecTableViewCell
		
		let live = list[indexPath.row]
		let imgurl = URL(string:live.portrait)
		cell.img.kf.setImage(with: imgurl)
		// Configure the cell...
		return cell
	}
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		SecTableView.delegate = self
		SecTableView.dataSource = self
		loadList()	
		// Do any additional setup after loading the view, typically from a nib.
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}

