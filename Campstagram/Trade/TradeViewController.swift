//
//  TradeViewController.swift
//  Campstagram
//
//  Created by duck on 2022/09/05.
//

import UIKit

class TradeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        let tradeNib = UINib(nibName: "TradeTableViewCell", bundle: nil)
        tableView.register(tradeNib, forCellReuseIdentifier: "TradeTableViewCell")
    }
    

   

}
extension TradeViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TradeTableViewCell", for: indexPath) as?
                TradeTableViewCell else{
            return UITableViewCell()
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let tradeResultViewController = TradeResultViewController()
        self.navigationController?.pushViewController(tradeResultViewController, animated: true)
    }
    
}
