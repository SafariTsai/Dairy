//
//  LiveTableViewController.swift
//  
//
//  Created by SAI on 2018/08/22.
//

import UIKit
import Just
import Kingfisher


class LiveTableViewController: UITableViewController {
	
	
	@IBAction func btnBack(_ sender: UIButton) {
		self.dismiss(animated: true, completion: nil)
		
	}
	let get_uid_url = "http://baseapi.busi.inke.cn/live/LiveHotList"
	var list : [INKCell] = []
	
	////////////////////////////////////////////////////////////////////////////////
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
				self.tableView.reloadData()
			}
		}
	}
	
//	func setRadius(){
//		let cell = tableView.dequeueReusableCell(withIdentifier: "LiveCell") as! LiveTableViewCell
//		cell.imgOverview.layer.cornerRadius = 30.0
//		cell.imgOverview.layer.masksToBounds = true
//
//	}

    override func viewDidLoad() {
		
        super.viewDidLoad()
		loadList()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return list.count
    }

	
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LiveCell", for: indexPath) as! LiveTableViewCell
		
		let live = list[indexPath.row]
		
		cell.labelNick.text = live.nick
		cell.LabelLocation.text = live.location
		cell.labelOLUser.text = String(live.online_users)
		let imgurl = URL(string:live.portrait)
		cell.imgOverview.kf.setImage(with: imgurl)
        // Configure the cell...
        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

	
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
		let dest = segue.destination as! LivingViewController
		dest.liveList = list[(tableView.indexPathForSelectedRow?.row)!]
		
    }
	

}
