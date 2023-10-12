
import UIKit
import SnapKit
import RealmSwift

class ViewController: UIViewController {
    
//    var plans: [String] = ["ror"]
    var plan: Results<ModelRealmSwift>?
    let realm = try! Realm()
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.register(PlanTableViewCell.self, forCellReuseIdentifier: "cell")
        table.dataSource = self
        table.delegate = self
        table.backgroundColor = .green
        return table
    }()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        navigationItem.title = "Notes"
        // Do any additional setup after loading the view.
        Viewshka()
        self.plan = realm.objects(ModelRealmSwift.self)
        
       
    }
    
    func Viewshka() {
        navigationItem.rightBarButtonItem = creatButtonImage(image: "plus", selector: #selector(plused))
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-100)
        }
    }
    
    @objc func plused() {
        let alert = UIAlertController(title: "Plan", message: "New plans", preferredStyle: .alert)
        
        var textField = UITextField()
        alert.addTextField { text in
            textField = text
        }
        
        let save = UIAlertAction(title: "Save", style: .default) { [self] _ in
            print("save")
//            plans.insert(textField.text!, at: 0)
//            tableView.reloadData()
            
            let add = ModelRealmSwift()
            add.name = textField.text!
           try! realm.write {
               realm.add(add)
               tableView.reloadData()
               print(textField.text!)
            }
        }
        
        let clase = UIAlertAction(title: "Close", style: .destructive) { _ in
            print("close")
        }
        
        alert.addAction(save)
        alert.addAction(clase)
        present(alert, animated: true)
        
    }
    
    func creatButtonImage(image: String, selector: Selector) -> UIBarButtonItem {
        let imageView = UIImageView()
        imageView.backgroundColor = .red
        imageView.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        imageView.image = UIImage(systemName: image)
        imageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: selector)
        imageView.addGestureRecognizer(tap)
        
        let barItem = UIBarButtonItem(customView: imageView)
        return barItem
    }


}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return plan!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PlanTableViewCell
        cell.nameLabel.text = plan![indexPath.row].name
        cell.contentView.backgroundColor = UIColor.clear

            let whiteRoundedView : UIView = UIView(frame: CGRectMake(10, 8, self.view.frame.size.width - 20, 90))

        whiteRoundedView.layer.backgroundColor = CGColor(colorSpace: CGColorSpaceCreateDeviceRGB(), components: [1.0, 1.0, 1.0, 0.8])
            whiteRoundedView.layer.masksToBounds = false
            whiteRoundedView.layer.cornerRadius = 5
            whiteRoundedView.layer.shadowOffset = CGSizeMake(-1, 1)
            whiteRoundedView.layer.shadowOpacity = 0.2

            cell.contentView.addSubview(whiteRoundedView)
            cell.contentView.sendSubviewToBack(whiteRoundedView)

        cell.backgroundColor = .green
//        cell.layer.cornerRadius =  / 1
//        cell.layer.borderWidth = 1
//        cell.imageCell.image = plans[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//
////            plan!.remove(at: indexPath.row)
////            tableView.reloadData()
//            print("delete")
//        }
        self.plan = realm.objects(ModelRealmSwift.self)
        try! realm.write({
            realm.delete(plan![indexPath.row])
            tableView.reloadData()
        })
    }
}


