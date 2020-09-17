//
//  GenericTableView.swift
//  MLChallenge
//
//  Created by David Diego Gomez on 17/09/2020.
//

import UIKit

class GenericTableViewCell<T, S>: UITableViewCell {
    var service : S?
    var item : T?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
        selectionStyle = .none
    }
    
    static var identifier : String {
        return String(describing: self)
    }
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
}


class GenericTableView <U: GenericTableViewCell<T, ServiceManager>,T>: XibView, UITableViewDelegate, UITableViewDataSource {
    var tableView : UITableView!
    var items = [T]()
    var cellHeight : CGFloat?
    var automaticRowHeight = false {
        didSet {
            if automaticRowHeight {
                tableView.rowHeight = UITableView.automaticDimension
                tableView.estimatedRowHeight = 100
            }
        }
    }
    var tableviewBackgroundColor : UIColor = .white {
        didSet {
            tableView.backgroundColor = tableviewBackgroundColor
        }
    }
    var onSelectionItem : ((T) -> Void)?
    
    override func commonInit() {
        super .commonInit()
        createTableView()
    }
    
    func createTableView() {
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
        self.addSubview(tableView)
        tableView.register(U.nib, forCellReuseIdentifier: U.identifier)
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: U.identifier, for: indexPath) as! U
        cell.item = items[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let height = cellHeight else {
            return tableView.rowHeight // default value
        }
        return height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        onSelectionItem?(items[indexPath.row])
    }
}


