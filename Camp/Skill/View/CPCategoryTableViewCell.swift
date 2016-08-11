//
//  CPSkillTableViewCell.swift
//  Camp
//
//  Created by 宋碧海 on 16/8/3.
//  Copyright © 2016年 songbihai. All rights reserved.
//

import UIKit

class CPCategoryTableViewCell: UITableViewCell {
    
    private var logLabel: UILabel!
    
    private var descLabel: UILabel!

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = CPColorUtil.mainColor
        selectionStyle = .None
        addAllSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addAllSubviews() {
        descLabel = UILabel()
        descLabel.textColor = UIColor.whiteColor()
        contentView.addSubview(descLabel)
        descLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(contentView)
            make.left.equalTo(contentView).offset(40)
            make.right.equalTo(contentView).offset(-40)
        }
        
        logLabel = UILabel()
        logLabel.text = "»"
        logLabel.textColor = UIColor.whiteColor()
        contentView.addSubview(logLabel)
        logLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(descLabel)
            make.right.equalTo(descLabel.snp.left).offset(-15)
        }
    }
    
    func getCategoryData(data: CategoryModel) {
        descLabel.text = data.desc ?? ""
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
