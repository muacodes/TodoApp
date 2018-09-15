//
//  TodoItemTableViewCell.swift
//  TodoApp
//
//  Created by Panuwat on 11/9/2561 BE.
//  Copyright © 2561 Panuwat. All rights reserved.
//

import UIKit

protocol TodoItemTableViewCellDelegate {
    func todoItemTableViewCellDidTapCheckboxButton(cell: TodoItemTableViewCell)
}

class TodoItemTableViewCell: UITableViewCell {
    
    var delegate: TodoItemTableViewCellDelegate?
    
    @IBOutlet weak var checkboxButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func checkboxButtonDidTab(){
        delegate?.todoItemTableViewCellDidTapCheckboxButton(cell: self)
    }

}
