import UIKit

class TimePickerView: UIPickerView, UIPickerViewDataSource {

    enum ComponentType: Int {
        case hours = 0
        case minutes = 1
        case seconds = 2
    }

    private let hoursInDay = 24
    private let secondsInMinute = 60
    private let minutesInHour = 60
    private let secondsInHour = 3600

    private var hoursLabel: UILabel!
    private var minutesLabel: UILabel!
    private var secondsLabel: UILabel!

    var hours: Int = 0
    var minutes: Int = 0
    var seconds: Int = 0

    var totalTimeInSeconds: Int {
        return hours * self.secondsInHour + minutes * self.secondsInMinute + seconds
    }

    required internal init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    func setup() {
        self.setValue(UIColor.white, forKey: "textColor")
        self.setValue(UIColor.white, forKey: "textColor")

        let textHours = NSLocalizedString("hours", comment: "")
        let textSec = NSLocalizedString("sec", comment: "")
        let textMin = NSLocalizedString("min", comment: "")

        hoursLabel = UILabel()
        hoursLabel.text = textHours
        hoursLabel.textColor = UIColor.white
        addSubview(hoursLabel)

        minutesLabel = UILabel()
        minutesLabel.text = textMin
        minutesLabel.textColor = UIColor.white
        addSubview(minutesLabel)

        secondsLabel = UILabel()
        secondsLabel.text = textSec
        secondsLabel.textColor = UIColor.white
        addSubview(secondsLabel)

        dataSource = self
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        hoursLabel.frame = CGRect(x: (frame.size.width / 6) + 16, y: frame.size.height / 2 - 15, width: 75, height: 30)
        minutesLabel.frame = CGRect(x: (3 * frame.size.width / 6) + 22, y: frame.size.height / 2 - 15, width: 75, height: 30)
        secondsLabel.frame = CGRect(x: (5 * frame.size.width / 6) + 22, y: frame.size.height / 2 - 15, width: 75, height: 30)
    }

    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case ComponentType.hours.rawValue:
            return self.hoursInDay
        case ComponentType.minutes.rawValue:
            return self.minutesInHour
        case ComponentType.seconds.rawValue:
            return self.secondsInMinute
        default:
            fatalError("Invalid component in pickerView")
        }
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(row)
    }

    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 30
    }

    func timeChanged(row: Int, component: Int) {
        switch component {
        case ComponentType.hours.rawValue:
            hours = row
        case ComponentType.minutes.rawValue:
            minutes = row
        case ComponentType.seconds.rawValue:
            seconds = row
        default:
            fatalError("no component with number \(component)")
        }
    }

}
