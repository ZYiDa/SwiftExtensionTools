//
//  ViewController.swift
//  SwiftExtensionTools
//
//  Created by zhoucz on 2021/07/26.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "identifier", for: indexPath)
        
        cell.textLabel?.text = "1wwk2mkm2km1m2k12m1kwm"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        LoadingHUD.showInfo(withMessage: "test - \(indexPath.row)", inView: self.view)

    }
    
    
    lazy var listView: UITableView = {
        let list = UITableView(frame: .zero, style: .grouped)
        list.rowHeight = 64
        list.delegate = self
        list.dataSource = self
        return list
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        self.view.addSubview(listView)
        listView.frame = CGRect(x: 0, y: 0, width: UIScreen.Width, height: UIScreen.Height)
        listView.register(UITableViewCell.self, forCellReuseIdentifier: "identifier")
        
        LoadingHUD.showInfo(withMessage: "000", inView: self.view)

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

    }
}

