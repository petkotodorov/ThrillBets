# Thrill Bets

Project name: **Thrill bets**

Projects developed by: **Petko Todorov** (petko.e.todorov@gmail.com)

Programming language: **Swift**

Minimum supported iOS version: **iOS 16**

Architecture: **MVVM**

Known issues / Areas for improvement: The countdown of each event starts from 00:00:00 every time the item becomes visible after scrolling. The timer itself should be moved out of the UICollectionViewCell subclass, so that: 1) the calculations don't take place there. 2) the countdown should be passed from EventSectionItem or the EventSectionViewModel

