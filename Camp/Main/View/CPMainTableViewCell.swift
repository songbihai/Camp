//
//  CPMainTableViewCell.swift
//  Camp
//
//  Created by 宋碧海 on 16/8/3.
//  Copyright © 2016年 songbihai. All rights reserved.
//

import UIKit
import Kingfisher
import SnapKit

class CPMainTableViewCell: UITableViewCell {
    
    var girlImageView: UIImageView!
    
    private var maskBottonView: UIView!
    
    private var whoLabel: UILabel!
    
    private var createdAtLabel: UILabel!
    
    private var descLabel: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = CPColorUtil.mainColor
        selectionStyle = .None
        addAllSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addAllSubviews() {
        girlImageView = UIImageView()
        girlImageView.contentMode = .ScaleToFill
        girlImageView.userInteractionEnabled = true
        let corner = UIRectCorner.TopLeft.rawValue | UIRectCorner.TopRight.rawValue
        girlImageView.zy_cornerRadiusAdvance(10.0, rectCornerType: UIRectCorner(rawValue: corner))
        contentView.addSubview(girlImageView)
        girlImageView.snp.makeConstraints { (make) in
            make.edges.equalTo(contentView).inset(UIEdgeInsetsZero)
        }
        
        maskBottonView = UIView()
        maskBottonView.backgroundColor = CPColorUtil.mainColor.colorWithAlphaComponent(0.3)
        contentView.addSubview(maskBottonView)
        maskBottonView.snp.makeConstraints { (make) in
            make.left.right.equalTo(contentView)
            make.height.equalTo(50.0)
            make.bottom.equalTo(contentView)
        }
        
        func createdLabel() -> UILabel {
            let label = UILabel()
            label.textColor = UIColor.whiteColor()
            label.font = UIFont.systemFontOfSize(15.0)
            maskBottonView.addSubview(label)
            return label
        }
        
        whoLabel = createdLabel()
        whoLabel.snp.makeConstraints { (make) in
            make.left.equalTo(maskBottonView).offset(10.0)
            make.top.equalTo(maskBottonView).offset(5.0)
        }
        
        createdAtLabel = createdLabel()
        createdAtLabel.snp.makeConstraints { (make) in
            make.left.equalTo(whoLabel.snp.right).offset(5.0)
            make.centerY.equalTo(whoLabel)
        }
        
        descLabel = createdLabel()
        descLabel.snp.makeConstraints { (make) in
            make.left.equalTo(whoLabel)
            make.top.equalTo(whoLabel.snp.bottom).offset(5.0)
        }
    }
    
    func girlGetData(data: GirlModel) {
        girlImageView.kf_setImageWithURL(NSURL.init(string: data.url), placeholderImage: UIImage.init(named: "placeholder"))
        whoLabel.text = data.who ?? ""
        let date = CPDateUtil.stringToDate(data.createdAt)
        createdAtLabel.text = CPDateUtil.dateToString(date, dateFormat: "yyyy年mm月dd日") ?? ""
        descLabel.text = data.desc ?? ""
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
