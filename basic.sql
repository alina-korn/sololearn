Это выберет 2 самых старых клиентов.
Мы использовали предложение WHERE для фильтрации строк, 
для которых не было определено значение возраста.

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
