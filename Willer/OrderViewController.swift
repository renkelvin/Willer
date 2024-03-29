//
//  OrderViewController.swift
//  Willer
//
//  Created by Chuan Ren on 10/27/16.
//  Copyright © 2016 Chuan Ren. All rights reserved.
//

import UIKit

class OrderViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var numLabel: UILabel!

    @IBOutlet var decksTableView: UITableView!
    @IBOutlet var toolBarView: UIView!

    var decks: [Deck] = []

    static var num: Int = 9
    let numMin: Int = 6
    let numMax: Int = 12

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.toolBarView.layer.shadowRadius = 4.0
        self.toolBarView.layer.shadowOffset = CGSize(width: 0.0, height: 0)
        self.toolBarView.layer.shadowColor = UIColor.black.cgColor
        self.toolBarView.layer.shadowOpacity = 0.4

        self.navigationController?.navigationBar.layer.shadowRadius = 4.0
        self.navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0.0, height: 0)
        self.navigationController?.navigationBar.layer.shadowColor = UIColor.black.cgColor
        self.navigationController?.navigationBar.layer.shadowOpacity = 0.4
    }

    override func viewWillAppear(_ animated: Bool) {
        self.refresh()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func minusButtonTap() {
        if OrderViewController.num > self.numMin {
            OrderViewController.num -= 1
            self.refresh()
        }
    }

    @IBAction func plusButtonTap() {
        if OrderViewController.num < self.numMax {
            OrderViewController.num += 1
            self.refresh()
        }
    }

    func refresh() {
        self.numLabel.text = String(OrderViewController.num)

        // Update table
        self.decks = MatchManager.shared.decks(for: OrderViewController.num)
        self.decksTableView.reloadData()
    }

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.decks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderTableViewCellReuseIdentifier", for: indexPath) as! DeckTableViewCell

        // Configure the cell...
        let deck = self.decks[indexPath.row]
        cell.config(deck: deck)

        return cell
    }

    // MARK: - Table view delegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "OrderPickSegueIdentifier" {
            let indexPath = self.decksTableView.indexPathForSelectedRow!
            let deck = self.decks[indexPath.row]
            PickViewController.deck = deck
        }
    }
    
}
