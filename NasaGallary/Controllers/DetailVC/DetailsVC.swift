//
//  DetailsVC.swift
//  NasaGallary
//
//  Created by Sanjay Thakkar on 05/10/22.
//

import UIKit
import Hero
import ParallaxHeader
import RxSwift
import RxRelay
import RxCocoa

class DetailsVC: BaseVC {

    @IBOutlet var titleLabel: AppLabel!
    @IBOutlet var imgView: UIImageView!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var descLabel: AppLabel!
    @IBOutlet var dateLabel: AppLabel!
    @IBOutlet var copyRightLabel: AppLabel!
    
    @IBOutlet var constImgHeight: NSLayoutConstraint!
    
    weak var headerImageView: UIView?
    
    var viewModel: DetailsVM = DetailsVM()
    
    private var disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        
        imgView.hero.modifiers = [.useScaleBasedSizeChange, .useGlobalCoordinateSpace]
        // Do any additional setup after loading the view.
    }
    
    private func setupBindings() {
        viewModel.heroID.asObserver().subscribe { id in
            self.imgView.hero.id = id
        }.disposed(by: disposeBag)
        viewModel.imgURL.observe(on: MainScheduler.instance).subscribe { url in
            self.imgView.kf.setImage(with: URL(string: url), placeholder: UIImage(named: "placeholder"), options: nil) { result in
                switch result {
                case .success(let image):
                    self.constImgHeight.constant = image.image.size.height * 0.4
                    break
                case .failure(_):
                    break
                }
            }
        }.disposed(by: disposeBag)

        viewModel.description.observe(on: MainScheduler.instance).bind(to: self.descLabel.rx.text).disposed(by: disposeBag)
        viewModel.date.observe(on: MainScheduler.instance).bind(to: self.dateLabel.rx.text).disposed(by: disposeBag)
        viewModel.title.observe(on: MainScheduler.instance).bind(to: self.titleLabel.rx.text).disposed(by: disposeBag)
        viewModel.copyright.observe(on: MainScheduler.instance).bind(to: self.copyRightLabel.rx.text).disposed(by: disposeBag)
    }

    @IBAction func tapOnBack(_ sender: Any) {
        self.dismiss(animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
