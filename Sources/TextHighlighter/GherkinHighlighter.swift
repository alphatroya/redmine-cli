//
// Redmine CLI
// Copyright © 2020 Alexey Korolev <alphatroya@gmail.com>
//

import Foundation

public enum GherkinHighlighter {
    public static func highlight(_ input: String) -> String {
        let keywords = [
            "Функция",
            "Функциональность",
            "Функционал",
            "Свойство",
            "Предыстория",
            "Контекст",
            "Сценарий",
            "Структура сценария",
            "Примеры",
            "Допустим",
            "Дано",
            "Пусть",
            "Когда",
            "Если",
            "То",
            "Затем",
            "Тогда",
            "И",
            "К тому же",
            "Также",
            "Но",
            "А",
            "Иначе",
            "Правило",
            "Или",
        ]
        let lines = input.components(separatedBy: "\n")
        let resultLines: [String] = lines.map { line in
            let checkLine = line.trimmingCharacters(in: .whitespaces)
            for keyword in keywords {
                let keyword = keyword + ":"
                guard checkLine.hasPrefix(keyword),
                    let range = line.range(of: keyword)
                else {
                    continue
                }
                var newLine = line
                newLine.replaceSubrange(range, with: "**" + keyword + "**")
                return newLine
            }
            return line
        }
        return resultLines.joined(separator: "\n")
    }
}
