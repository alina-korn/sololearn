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
