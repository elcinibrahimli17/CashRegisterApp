# 💰 CashRegister

A daily cash tracking iOS application built with UIKit and Swift.

---

https://github.com/user-attachments/assets/ed7fe8dc-6015-4971-bc8b-5927931f82bb

## 📱 Features

- Set an opening balance at the start of each day
- Add income (sales) and expense (purchase) transactions
- View real-time updates of total income, expenses, and net profit
- Browse transaction history filtered by **daily**, **weekly**, **monthly**, and **yearly** periods
- Data persistence using **UserDefaults**

---

## 🛠 Tech Stack

- **Language:** Swift
- **UI Framework:** UIKit
- **Architecture:** MVVM
- **Data Storage:** UserDefaults
- **Design Pattern:** Delegate

---

## 📂 Project Structure

```
CashRegister/
├── Models/
│   ├── TransactionModel.swift
│   └── TransactionProcessModel.swift
├── ViewModels/
│   ├── CashViewModel.swift
│   ├── StartSafeViewModel.swift
│   ├── AddTransactionViewModel.swift
│   └── HistoryViewModel.swift
├── Views/
│   ├── CashViewController.swift
│   ├── StartSafeViewController.swift
│   ├── AddTransactionViewController.swift
│   └── HistoryViewController.swift
├── Utilities/
│   ├── CodabelProcess.swift
│   ├── CashRepository.swift
│   └── UserDefaults+Ext.swift
```

---

## 🚀 Getting Started

1. Clone the repository
```bash
git clone https://github.com/elcinibrahimli17/CashRegister.git
```
2. Open `CashRegister.xcodeproj` in Xcode
3. Select a simulator or device
4. Press `Cmd + R` to run

---

## 👨‍💻 Author

**Elçin**  
Junior iOS Developer  
[LinkedIn](https://linkedin.com/in/elchin-ibrahimov-23390a34b) • [GitHub](https://github.com/elcinibrahimli17)
