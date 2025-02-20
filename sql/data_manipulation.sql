Это выберет 2 самых старых клиентов.
Мы использовали предложение WHERE для фильтрации строк
SELECT * FROM Customers
WHERE age IS NOT NULL
ORDER BY age DESC
LIMIT 2

Чтобы выбрать строки с 3-й по 5-ю из таблицы Employees, 
отсортированные по столбцу salary в порядке убывания:
SELECT * 
FROM employees
ORDER BY salary DESC
LIMIT 3 OFFSET 2

Функции работы со строками
Функция CONCAT позволяет объединить текст из нескольких столбцов в один.
SELECT CONCAT(firstname, lastname) AS name
FROM Customers 

Функция CONCAT может принимать любое количество аргументов, 
объединяя их вместе в результате.
Так что мы можем просто добавить пробел между столбцами, 
чтобы получить желаемый результат:
SELECT CONCAT(firstname, ' ', lastname) AS name
FROM Customers 

Создать запрос к таблице Players, который объединяет firstname с age 
в столбце под названием nickname, 
и упорядочивает результаты по столбцу points.
SELECT CONCAT (firstname, age) AS nickname
FROM Players
ORDER BY points DESC

Функция LOWER преобразует текст в предоставленной колонке в нижний регистр.
и другие, требуют использования круглых скобок для обозначения аргументов, 
которые передаются в функцию.
В SQL функции, такие как LOWER(), UPPER(), SUM(), AVG()
SELECT LOWER(firstname) FROM Customers


Функция SUBSTRING позволяет извлекать часть текста из столбца.
Она принимает начальную позицию и количество символов,
которые мы хотим извлечь.
SELECT SUBSTRING(firstname, 1, 3)
FROM Customers

Чтобы выбрать 3-й и 4-й символы из столбца name в таблице Customers, 
нужно указать начальную позицию и количество символов в функции SUBSTRING. 
Начальная позиция для 3-го символа будет 3, а количество символов будет 2.
SELECT SUBSTRING(name, 3, 2)
FROM Customers;


Функция REPLACE заменяет все вхождения указанной строки на другую.
Например, давайте заменим Нью-Йорк на NY в колонке город:
SELECT firstname, lastname,
REPLACE(city, 'New York', 'NY')
FROM Customers

Заменить все символы '!' на точку '.' в колонке описания таблицы Books. 
Отсортируйте результат по колонке года.
SELECT REPLACE(description, '!', '.')
FROM Books
ORDER BY year

Функции
Мы можем объединить несколько функций в один запрос.
Например, давайте создадим столбец с именем, который будет 
содержать первую букву из firstname, 
за которой следует точка и lastname в верхнем регистре:
SELECT CONCAT(
  SUBSTRING(firstname, 1, 1),
  '.',
  UPPER(lastname)) AS name
FROM Customers

Каков будет результат следующего утверждения, 
если столбец name содержит одну строку со значением "John"?
SELECT UPPER(SUBSTRING(name, 3, 1)) FROM Table
H

Выводы из урока
Теперь вы знаете, как использовать функции со строками.
Вот краткое резюме:
 - CONCAT используется для объединения нескольких строк в одну колонку.
 - LOWER и UPPER преобразуют текст в нижний и верхний регистр
 - SUBSTRING используется для выделения части текста. 
 - REPLACE используется для замены одного значения на другое в тексте. 
Дальше идут функции математики и агрегации! 

Математические и агрегатные функции
Математика 
SQL также поддерживает базовые математические операции.
Например, допустим, мы проводим акцию, и клиенты получают скидку 
в зависимости от их возраста. 
Процент скидки составляет половину от значения возраста:
SELECT firstname, lastname, age / 2 AS discount
FROM Customers

Мы можем использовать математические операторы на нескольких столбцах, 
чтобы получить результат.
Допустим, наша таблица включает столбцы weight (вес) 
и height (рост) для наших клиентов.
Мы можем вычислить BMI (индекс массы тела)
на основе этих значений. BMI равен весу, деленному на квадрат роста.
SELECT firstname, lastname, weight/(height*height) AS bmi
FROM Customers

Mинимальное и максимальное значения возраста:
SELECT MAX(age) FROM Customers;
SELECT MIN(age) FROM Customers;


