//
//  GoalsViewController.swift
//  DayPlanner
//
//  Created by Ryan LaSante on 7/9/16.
//  Copyright © 2016 rlasante. All rights reserved.
//

import UIKit
import CoreData

class GoalsViewController: UIViewController, ContextConfigurable {
    var context: NSManagedObjectContext!
    var day: Day?
    var selectedIndexPath: NSIndexPath?
    var selectedIndex: Int? {
        get {
            return selectedIndexPath?.row
        }
    }

    @IBOutlet var tableView: UITableView!

    @IBOutlet weak var keyboardPlaceholderConstraint: NSLayoutConstraint!

    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillShow), name: UIKeyboardWillShowNotification, object: nil)

        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillHide), name: UIKeyboardWillHideNotification, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        goalCell(for: NSIndexPath(forRow: 0, inSection: 0))?.textField.becomeFirstResponder()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo else {
            return
        }
        dispatch(after: 0.175) { [weak self] in
            self?.animateForKeyboard(userInfo)
        }
    }

    func keyboardWillHide(notification: NSNotification) {
        guard let userInfo = notification.userInfo else {
            return
        }
        dispatch(after: 0.175) { [weak self] in
            self?.animateForKeyboard(userInfo)
        }
    }

    func animateForKeyboard(userInfo: [NSObject: AnyObject]) {
        guard let finalFrame: CGRect = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.CGRectValue(),
            let animationDuration = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue,
            let rawCurve = (userInfo[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber)?.integerValue,
            let curve = UIViewAnimationCurve(rawValue: rawCurve) else {
                return
        }

        let newHeight = max(view.frame.size.height - finalFrame.minY, 0)

        UIView.animateWithDuration(animationDuration, delay: 0, options: curve.asOption(), animations: { [weak self] in
            self?.keyboardPlaceholderConstraint.constant = newHeight
        }, completion: nil)
    }
}

extension GoalsViewController: UITableViewDelegate {

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedIndexPath = indexPath
    }

    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        selectedIndexPath = nil
    }

}

extension GoalsViewController: UITableViewDataSource {

    var goals: [Goal] {
        get {
            guard let unorderedGoals = day?.goals else {
                return []
            }
            return unorderedGoals.sort { (firstGoal, secondGoal) -> Bool in
                let priorityOrder = firstGoal.priority >= secondGoal.priority
                let dateOrdering = firstGoal.creationDate.compare(secondGoal.creationDate) == .OrderedDescending
                return priorityOrder && dateOrdering
            }
        }
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let day = day else {
            return 1
        }
        return day.goals.count + 1
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCellWithIdentifier("GoalCell") as? GoalTableViewCell else {
            assertionFailure("No cell found of this identifier")
            abort()
        }
        cell.textField.delegate = self

        switch indexPath.row {
        case 0:
            // Don't set the text
            cell.textField.text = nil
        default:
            cell.textField.text = goals[indexPath.row - 1].text
        }
        return cell
    }

}

extension GoalsViewController: UITextFieldDelegate {

    @IBAction func onDone(sender: UIButton) {
        guard let indexPath = selectedIndexPath,
            cell = goalCell(for: indexPath) else {
                return
        }
        cell.textField.resignFirstResponder()
        let _ = try? context.save()
    }

    @IBAction func onLongPress(recognizer: UILongPressGestureRecognizer) {
        guard let textField = recognizer.view as? UITextField else {
            return
        }
    }

    func textFieldShouldClear(textField: UITextField) -> Bool {
        // If this isn't the first index then lets bounce
        guard let indexPath = indexPath(for: textField) where indexPath.row != 0 && !textField.isFirstResponder() else {
            return true
        }
        // Don't start editing, just delete this cell
        deleteGoal(at: indexPath)
        return false
    }

    func textFieldDidBeginEditing(textField: UITextField) {
        // Let's get the index
        selectedIndexPath = indexPath(for: textField)
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        guard let selectedIndex = selectedIndex else {
                return true
        }

        // Don't return if we're on index 0, otherwise we do want to return
        guard selectedIndex == 0 else {
            goalCell(for: NSIndexPath(forRow: 0, inSection: 0))?.textField.becomeFirstResponder()
            return true
        }

        if let text = textField.text where !text.isEmpty {
            day?.createGoals(text)
            textField.text = nil
            tableView.insertRowsAtIndexPaths([NSIndexPath(forRow: 1, inSection: 0)], withRowAnimation: .Top)
        }

        return false
    }

    func textFieldDidEndEditing(textField: UITextField) {
        guard let selectedIndexPath = selectedIndexPath,
            let selectedIndex = selectedIndex else {
                return
        }
        guard let text = textField.text where !text.isEmpty else {
            if selectedIndex != 0 {
                // Remove a goal if there isn't any text
                deleteGoal(at: selectedIndexPath)
            }
            return
        }

        if selectedIndex != 0 {
            goals[selectedIndex - 1].text = text
            tableView.deselectRowAtIndexPath(selectedIndexPath, animated: true)
        }
    }

    func deleteGoal(at indexPath: NSIndexPath) {
        let goal = goals[indexPath.row - 1]
        day?.goals.remove(goal)
        context.deleteObject(goal)
        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    }

    func indexPath(for textField: UITextField) -> NSIndexPath? {
        guard let cell = textField.superview?.superview as? UITableViewCell else {
            return nil
        }
        return tableView.indexPathForCell(cell)
    }

    func goalCell(for indexPath: NSIndexPath) -> GoalTableViewCell? {
        return tableView.cellForRowAtIndexPath(indexPath) as? GoalTableViewCell
    }

}
