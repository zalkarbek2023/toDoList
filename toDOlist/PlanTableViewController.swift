
import UIKit
import SnapKit
import RealmSwift

class PlanTableViewCell: UITableViewCell {

     lazy var nameLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
     lazy var imageCell: UIImageView = {
        let image = UIImageView(image: UIImage(named: "1"))
         image.isUserInteractionEnabled = true
         let tap = UITapGestureRecognizer(target: self, action: #selector(addCell))
         image.addGestureRecognizer(tap)
         return image
    }()
    
    override func layoutSubviews() {
      super.layoutSubviews()
        Viewshka()
//        contentView.layer.cornerRadius = 100 / 4
//        contentView.layer.borderWidth = 0.5
//        contentView.layer.borderColor = UIColor.systemGray2.cgColor
//        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
    }
    
    func Viewshka() {
        addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(20)
            make.width.equalTo(250)
        }
        addSubview(imageCell)
        imageCell.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-20)
            make.width.height.equalTo(50)
        }
    }
    
    @objc func addCell() {
        imageCell.image = UIImage(named: "2")
    }

}

