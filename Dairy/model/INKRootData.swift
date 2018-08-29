//
//	INKRootData.swift
//	模型生成器（小波汉化）JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct INKRootData{

	var city : String!
	var gender : Int!
	var image2 : String!
	var level : Int!
	var liveid : String!
	var name : String!
	var nick : String!
	var onlineUsers : Int!
	var portrait : String!
	var uid : Int!


	/**
	 * 用字典来初始化一个实例并设置各个属性值
	 */
	init(fromDictionary dictionary: NSDictionary){
		city = dictionary["city"] as? String
		gender = dictionary["gender"] as? Int
		image2 = dictionary["image2"] as? String
		level = dictionary["level"] as? Int
		liveid = dictionary["liveid"] as? String
		name = dictionary["name"] as? String
		nick = dictionary["nick"] as? String
		onlineUsers = dictionary["online_users"] as? Int
		portrait = dictionary["portrait"] as? String
		uid = dictionary["uid"] as? Int
	}

	/**
	 * 把所有属性值存到一个NSDictionary对象，键是相应的属性名。
	 */
	func toDictionary() -> NSDictionary
	{
		let dictionary = NSMutableDictionary()
		if city != nil{
			dictionary["city"] = city
		}
		if gender != nil{
			dictionary["gender"] = gender
		}
		if image2 != nil{
			dictionary["image2"] = image2
		}
		if level != nil{
			dictionary["level"] = level
		}
		if liveid != nil{
			dictionary["liveid"] = liveid
		}
		if name != nil{
			dictionary["name"] = name
		}
		if nick != nil{
			dictionary["nick"] = nick
		}
		if onlineUsers != nil{
			dictionary["online_users"] = onlineUsers
		}
		if portrait != nil{
			dictionary["portrait"] = portrait
		}
		if uid != nil{
			dictionary["uid"] = uid
		}
		return dictionary
	}

}
