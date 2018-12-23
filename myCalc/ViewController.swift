//
//  ViewController.swift
//  myCalc
//
//  Created by aa372953 on 2018/12/23.
//  Copyright © 2018 snymyn. All rights reserved.
//

import UIKit
import Expression

class ViewController: UIViewController {

    @IBOutlet weak var formulaLabel: UILabel!
    @IBOutlet weak var ansLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //viewがloadされた時点で式と答えのlabelは空にする
        formulaLabel.text = ""
        ansLabel.text = ""
    }
    
    
    
    @IBAction func inputFormula(_ sender: UIButton) {
        //buttonが押されたら式を表示する
        guard let formulaText = formulaLabel.text else {
            return
        }
        guard let senderedText = sender.titleLabel?.text else {
            return
        }
        formulaLabel.text = formulaText + senderedText
    
    
    }
    
    @IBAction func clearCalculation(_ sender: UIButton) {
        //c button -> clear ans
        formulaLabel.text = ""
        ansLabel.text = ""
    }
    
    @IBAction func caluculateAnswer(_ sender: UIButton) {
        // equal button pushで答えを計算して表示する
        guard let formulaText = formulaLabel.text else {
            return
        }
        let formula: String = formatFomula(formulaText)
        ansLabel.text = evalFomula(formula)
    }
    
    
    private func formatFomula(_ fomula: String) -> String {
        //入力された整数には.0を追加して少数として評価する
        //÷を/に、×を*に置換する
        let formattedFormula: String = fomula.replacingOccurrences(
            of: "(?<=^|[÷×\\+\\-\\(])([0-9]+)(?=[÷×\\+\\-\\)]|$)",
            with: "$1.0",
            options: NSString.CompareOptions.regularExpression,
            range: nil
            ).replacingOccurrences(of: "÷", with: "/").replacingOccurrences(of: "×", with: "*")
        return formattedFormula
    }
    
    private func evalFomula(_ formula: String) -> String {
        do {
            //Expressionで文字列の計算式を評価して答えを求める
            let expression = Expression(formula)
            let answer = try expression.evaluate()
            return formatAnswer(String(answer))
        } catch {
            //計算式が不当だった場合
            return "Please input properly"
        }
    }
    
    private func formatAnswer(_ answer:String) -> String {
        //答えの小数点以下が.0だった場合は.0を削除して答えを整数で表示する
        let formattedAnswer: String = answer.replacingOccurrences(
            of: "\\.0$",
            with: "",
            options: NSString.CompareOptions.regularExpression,
            range: nil)
        return formattedAnswer
    }
}

