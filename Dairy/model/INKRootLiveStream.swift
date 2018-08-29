//
//	INKRootLiveStream.swift
//	模型生成器（小波汉化）JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct INKRootLiveStream{

	var data : [INKRootData]!
	var errorCode : Int!
	var message : String!


	/**
	 * 用字典来初始化一个实例并设置各个属性值
	 */
	init(fromDictionary dictionary: NSDictionary){
		data = [INKRootData]()
		if let dataArray = dictionary["data"] as? [NSDictionary]{
			for dic in dataArray{
				let value = INKRootData(fromDictionary: dic)
				data.append(value)
			}
		}
		errorCode = dictionary["error_code"] as? Int
		message = dictionary["message"] as? String
	}

	/**
	 * 把所有属性值存到一个NSDictionary对象，键是相应的属性名。
	 */
	func toDictionary() -> NSDictionary
	{
		let dictionary = NSMutableDictionary()
		if data != nil{
			var dictionaryElements = [NSDictionary]()
			for dataElement in data {
				dictionaryElements.append(dataElement.toDictionary())
			}
			dictionary["data"] = dictionaryElements
		}
		if errorCode != nil{
			dictionary["error_code"] = errorCode
		}
		if message != nil{
			dictionary["message"] = message
		}
		return dictionary
	}

}
