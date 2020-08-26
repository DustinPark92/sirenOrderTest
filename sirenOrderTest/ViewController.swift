//
//  ViewController.swift
//  sirenOrderTest
//
//  Created by Dustin on 2020/08/26.
//  Copyright © 2020 Dustin. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

private let tableViewCell = "TableViewCell"
private let collectionViewCell = "CollectionViewCell"

class ViewController: UIViewController {
    
    let tableView = UITableView()
    let topView : UIView = {
        let uv = UIView()
        uv.backgroundColor = .red
        return uv
    }()
    
    var dict = [String:Array<Any>]()
    var moneydict = [String:Array<Any>]()
    var extraGroupSet = Set<String>()
    
    var extraModel = [ExtraModel]()
    var arr = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        callRequest()
    }
    
    func configureUI() {
        view.addSubview(tableView)
        view.addSubview(topView)
        topView.anchor(top:view.topAnchor,left: view.leftAnchor,right: view.rightAnchor,height: 100)
        tableView.anchor(top:topView.bottomAnchor,left: view.leftAnchor,bottom: view.bottomAnchor,right: view.rightAnchor,paddingBottom: 50)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .blue
        tableView.register(TableViewCell.self, forCellReuseIdentifier: tableViewCell)

    }
    
    func callRequest() {
        
        let param = ["menu_id":"4"]
        
        AF.request("http://54.180.56.44:8080/ExtraFindByMenuId.do", method: .get, parameters: param
        ).validate().responseJSON { response in
            
            
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                var extra = ExtraModel()
                
                
                for i in 1..<json["extra"].array!.count {
                    if json["extra"][i]["extra_group"].stringValue == json["extra"][i-1]["extra_group"].stringValue {
                        print(json["extra"][i-1]["extra_name"].stringValue)
                        self.arr.append(json["extra"][i-1]["extra_name"].stringValue)
                        self.arr.append(json["extra"][i]["extra_name"].stringValue)
                        self.dict.updateValue(self.arr, forKey: json["extra"][i-1]["extra_group"].stringValue)
                        self.arr.removeAll()
                        
                    }
                    
                }
                
                for i in 1..<json["extra"].array!.count {
                    if json["extra"][i]["extra_group"].stringValue == json["extra"][i-1]["extra_group"].stringValue {
                        print(json["extra"][i-1]["extra_price"].stringValue)
                        self.arr.append(json["extra"][i-1]["extra_price"].stringValue)
                        self.arr.append(json["extra"][i]["extra_price"].stringValue)
                        self.moneydict.updateValue(self.arr, forKey: json["extra"][i-1]["extra_group"].stringValue)
                        self.arr.removeAll()
                        
                    }
                    
                }
                
                
                
                for item in json["extra"].array! {
                    //                    if item["extra_group"].stringValue != "null" {
                    //                    self.dict.updateValue(item["extra_name"].stringValue, forKey: item["extra_group"].stringValue)
                    //                    }
                    
                    if item["extra_group"].stringValue != "null" {
                        self.extraGroupSet.insert(item["extra_group"].stringValue)
                    }
                    
                    extra.extra_group = item["extra_group"].stringValue
                    extra.extra_name = item["extra_name"].stringValue
                    extra.extra_id = item["extra_id"].intValue
                    extra.extra_maxcount = item["extra_maxcount"].intValue
                    self.extraModel.append(extra)
                    
                }
            case .failure(let error):
                
                print(error.errorDescription)
                
                
                
            }
            
            
            
            
            self.tableView.reloadData()
            
            for item in self.extraGroupSet {
                for item1 in self.extraModel {
                    if item1.extra_group == item {
                        print()
                    }
                }
                
            }
            print("딕셔너리는 \(self.dict)")
            print("딕셔너리는 \(self.moneydict)")
            
            
        }
        
    }
    
    
    
    
}


extension ViewController : UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return extraGroupSet.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableViewCell, for: indexPath) as! TableViewCell
        
        cell.collectionView.delegate = self
        cell.collectionView.dataSource = self
        cell.collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: collectionViewCell)
        cell.collectionView.tag = indexPath.row
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "필수 옵션"
        }
        return "퍼스널 옵션"
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    
    
}

extension ViewController : UICollectionViewDelegate,UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 0 {
            let mySetIndex = extraGroupSet.index(extraGroupSet.startIndex, offsetBy: section)
            let element = extraGroupSet[mySetIndex]
            return dict[element]!.count
            
        } else if collectionView.tag == 1 {
            let mySetIndex = extraGroupSet.index(extraGroupSet.startIndex, offsetBy: section)
            let element = extraGroupSet[mySetIndex]
            return dict[element]!.count
            
            
        }
        
        return 5
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionViewCell, for: indexPath) as! CollectionViewCell
        
        
        if collectionView.tag == 0 {
            
            let mySetIndex = extraGroupSet.index(extraGroupSet.startIndex, offsetBy: collectionView.tag)
            let element = extraGroupSet[mySetIndex]
            
            cell.label.text = dict[element]![indexPath.item] as! String
            
            return cell
        } else if collectionView.tag == 1 {
            let mySetIndex = extraGroupSet.index(extraGroupSet.startIndex, offsetBy: collectionView.tag)
            let element = extraGroupSet[mySetIndex]
            
            cell.label.text = dict[element]![indexPath.item] as! String
            
            return cell
            
        }
        
        
        return cell
        
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
}
