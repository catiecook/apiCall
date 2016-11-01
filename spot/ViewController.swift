//
//  ViewController.swift
//  spot
//
//  Created by Catie Cook on 11/1/16.
//  Copyright © 2016 catiecook. All rights reserved.
//

import UIKit
import Alamofire

class TableViewController: UITableViewController {
    
    var names = [String]()
    var searchURL = "https://api.spotify.com/v1/search?q=Alabama+Shakes&type=track&offset=20"
    typealias JSONStandard = [String: AnyObject]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        callAlamo(url: searchURL)
    }
    
    func callAlamo(url: String){
        Alamofire.request(url).responseJSON(completionHandler : {
            response in
            self.parseData(JSONData: response.data!)
        })
    }
    
    func parseData(JSONData : Data) {
        do {
            let readableJSON = try JSONSerialization.jsonObject(with: JSONData, options: .mutableContainers) as! JSONStandard
            if let tracks = readableJSON["tracks"] as? JSONStandard {
                if let items = tracks["items"] {
                    
                    for i in 0..<items.count {
                        let item = items[i] as! JSONStandard
                        let name = item["name"] as! String
                        
                        names.append(name)
                    }
                }
            }
        }
        catch {
            print(error)
        }
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

