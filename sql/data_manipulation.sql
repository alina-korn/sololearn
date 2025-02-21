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

Выбрать все столбцы компании с максимальным числом доходов.
SELECT *
FROM Companies
WHERE revenue = (
    SELECT MAX(revenue)
    FROM Companies
);

Функция AVG() позволяет вам вычислить среднее значение.
Например, давайте вычислим средний возраст наших клиентов:
SELECT AVG(age) FROM Customers

Для расчета средней зарплаты в таблице Сотрудники.
SELECT AVG(salary)
FROM Employees

Как вы знаете, функция COUNT используется 
для возвращения количества строк в запросе.
Мы можем сочетать ее с GROUP BY, чтобы узнать, 
сколько у нас клиентов в каждом городе:
SELECT city, COUNT(*) AS ct
FROM Customers
GROUP BY city
ORDER BY ct DESC

Выбрать среднюю цену из таблицы Houses и назовите ее 
'mean' в результате. 
SELECT AVG(price) AS mean
FROM Houses;

Выводы из урока 
SQL поддерживает математические операторы, которые могут быть использованы на столбцах 
и значениях.
SQL также предоставляет ряд функций агрегации:
 MIN/MAX для получения минимального/максимального значения столбца, 
 AVG для получения среднего значения, 
 COUNT для получения количества записей.
Мы узнаем, как выбирать значения на основе условий в следующем уроке! 


Условия 
При создании пользовательских столбцов, SQL позволяет устанавливать значение 
на основе условий.
Допустим, мы хотим создать категорию на основе значения age наших клиентов.
CASE
Мы хотим установить значение столбца category на 'Senior', в случае, 
если значение возраста больше 65, 'Adult' в случае, если оно в диапазоне от 25 до 64, 
и 'Youth', если оно меньше 25.
Это делается с использованием оператора CASE.
Вот одно условие:
SELECT firstname, lastname,
CASE
    WHEN age >=65 THEN 'Senior'
END AS category
FROM Customers
пример:
CASE
    WHEN rating >= 8 THEN 'Great'
END

Мы можем добавить несколько условий, используя несколько разделов WHEN:
SELECT firstname, lastname,
CASE 
    WHEN age >= 65 THEN 'Senior'
    WHEN age >= 25 AND age < 65 THEN 'Adult'
END AS category
FROM Customers

Во всех остальных случаях, мы можем установить значение, используя ключевое слово ELSE:
SELECT fistname, lastname,
CASE
  WHEN age >= 65 THEN 'Senior'
  WHEN age >= 25 AND age < 65 THEN 'Adult'
  ELSE 'Youth'
END AS category
FROM Customers

Cоздать пользовательскую колонку под названием 'experience', 
которая определяется колонкой rating.
SELECT CASE
  WHEN rating < 3 THEN 'Bad'
  WHEN rating >= 3 AND rating < 8 THEN 'OK'
  ELSE 'Great'
END AS experience
FROM Hotels
  
Выводы из урока 
Вот краткое содержание урока:
 - Выражение CASE используется для установки значения для столбца на основе условий.
 - Условия устанавливаются в предложениях WHEN.
 - Первое предложение WHEN, которое удовлетворяет условию, устанавливается как значение.
 - Выражение CASE должно закрываться ключевым словом END


Викторина первого модуля
Рассчитать среднее значение столбца цен для домов, город для которых установлен как 'Лондон'.
SELECT AVG(price)
FROM Houses
WHERE city = 'London'
  
У вас есть таблица Cars с колонкой transmission, 
которая является числовой: 1 для Manual и 2 для Automatic. 
Cоздать запрос, который выбирает соответствующее текстовое
значение колонки transmission.
SELECT name, CASE
  WHEN transmission = 1 THEN 'Manual'
  ELSE 'Automatic'
END AS 'transmission'
FROM Cars

Вы хотите создать хэштеги из текста в таблице под названием Posts.
Напишите запрос, чтобы заменить все пробелы на '_' подчеркивания в текстовом столбце 
таблицы Posts и добавить символ '#' в начале. Назовите новую колонку "tag".
SELECT CONCAT('#', REPLACE(text, ' ', '_')) AS tag
FROM Posts

Выберите 5 записей с самой высокой ценой из таблицы Houses.
SELECT *
FROM Houses
ORDER BY price DESC
LIMIT 5


Ограничения таблицы
Идентичность
