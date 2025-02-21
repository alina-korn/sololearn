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
Как мы видели, в большинстве таблиц, с которыми мы работаем, 
есть столбец под названием id, который содержит число.
Этот столбец часто называют столбцом идентичности и он подобен номеру строки в Excel.
Вот столбец id для наших клиентов:
SELECT id, firstname FROM Customers

Часто id - это целое число, которое увеличивается с каждой новой строкой.
SQL позволяет вам создать столбец, который автоматически увеличивается
с каждой новой строкой.
Это делается с использованием ключевого слова AUTO_INCREMENT.
Вот пример для нашей таблицы Customers:
CREATE TABLE Customers (
  id int NOT NULL AUTO_INCREMENT,
  firstname varchar(255),
  lastname varchar(255)
);

Cоздать таблицу под названием 'Products' с автоинкрементной колонкой 
под названием 'number'.
CREATE TABLE Products (number int AUTO_INCREMENT);

Идентификация 
Теперь, при вставке новой строки, нам не нужно указывать значение столбца id, 
так как оно будет установлено автоматически.
Например:
INSERT INTO Customers (firstname, lastname, city, age)
VALUES
('demo', 'demo', 'Paris', 52),
('test', 'test', 'London', 21);
SELECT * FROM Customers; 


Идентификация 
По умолчанию, значение столбца AUTO_INCREMENT начинается с 1.
Если необходимо, это можно изменить, используя следующее:
ALTER TABLE Customers
 AUTO_INCREMENT=555
Теперь, когда вставляется новая строка, столбец id будет начинаться с указанного значения:
INSERT INTO Customers (firstname, lastname, city, age)
VALUES
('test', 'test', 'London', 21);
SELECT * FROM Customers; 

Установить начальное значение автоинкремента столбца 'number' на 100.
ALTER TABLE Products AUTO_INCREMENT = 100;

Выводы из урока 
Большинство таблиц имеют столбец идентификации, часто называемый id.
Этот столбец - это число, которое автоматически увеличивается с каждой новой строкой.
Столбец идентификации можно создать с помощью ключевого слова AUTO_INCREMENT, 
указанного рядом со столбцом при создании таблицы.

Ключи 
CREATE TABLE Customers (
  id int NOT NULL AUTO_INCREMENT,
firstname varchar(255),
lastname varchar(255),
  PRIMARY KEY (id)
);

Установить столбцы 'number' в качестве первичного ключа.
PRIMARY KEY (number)

Первичный ключ 
Вот некоторые правила для первичных ключей:
 - Первичный ключ должен содержать уникальные значения.
 - Колонка первичного ключа не может иметь NULL значения.
 - Таблица может иметь только один первичный ключ.

Внешний ключ 
Другой тип ограничения - это Внешний ключ.
Внешний ключ - это столбец в одной таблице, который ссылается на 
Первичный ключ в другой таблице.

В нашем случае, столбец customer_id в таблице PhoneNumbers является 
внешним ключом, который ссылается на первичный ключ id в таблице 
Customers. 
CREATE TABLE PhoneNumbers (
  id int NOT NULL AUTO_INCREMENT,
  customer_id int NOT NULL,
  number varchar(55),
type varchar(55),
  PRIMARY KEY (id),
  FOREIGN KEY (customer_id) REFERENCES Customers(id)
);

Создать внешний ключ в столбце 'number' 
таблицы Houses, ссылающийся на столбец 'id' таблицы 'Prices'.
FOREIGN KEY (number)
REFERENCES Prices (id)

У таблицы может быть несколько внешних ключей.
Выводы урока
Первичный ключ используется для уникальной идентификации каждой 
строки таблицы. Обычно это столбец идентификатора.
Внешний ключ используется для ссылки на столбец идентификатора в 
другой таблице. Это позволяет вам связывать данные между 
несколькими таблицами и предотвращать действия, которые могли бы 
нарушить отношения.


Уникальность
Ограничение UNIQUE гарантирует, что все значения в столбце будут разными.
Ограничение PRIMARY KEY автоматически имеет ограничение UNIQUE.
Однако, вы можете иметь много ограничений UNIQUE на одну 
таблицу, но только одно ограничение PRIMARY KEY на таблицу.

Ограничение первичного ключа автоматически обеспечивает уникальность.

Сделаем колонку lastname в нашей таблице Customers уникальной:
ALTER TABLE Customers
ADD UNIQUE (lastname)

Сделать колонку 'address' уникальной.
ALTER TABLE Houses
ADD UNIQUE (address)

Теперь, когда мы пытаемся вставить Клиента с фамилией, которая уже 
присутствует в таблице, мы получим ошибку:
INSERT INTO Customers (firstname, lastname, city, age)
VALUES ('demo', 'Anderson', 'London', 24);
SELECT * FROM Customers;

Bы можете иметь несколько значений NULL в уникальном столбце.

Резюме
Первичный ключ уникально идентифицирует каждую запись таблицы. 
Обычно он устанавливается как автоинкрементное целое число.
Внешние ключи используются для создания связей между таблицами. 
Они ссылаются на первичный ключ в других таблицах.
У таблицы может быть несколько внешних ключей, но только один 
первичный ключ.
Ограничение UNIQUE используется для обеспечения уникальности 
значений в столбце.

Викторина
Создайте таблицу с автоматически увеличиваемой колонкой под 
названием id, которая является первичным ключом.
CREATE TABLE Users (
id int AUTO_INCREMENT, 
name varchar(255) NOT NULL, 
PRIMARY KEY (id)
);

У таблицы НЕ может быть несколько первичных ключей.

Создать таблицу 'Users' с первичным ключом в столбце id 
и внешним ключом в столбце 'account_id', 
ссылающимся на столбец id таблицы Accounts.
CREATE TABLE Users (
id int NOT NULL AUTO_INCREMENT,
name varchar(255) NOT NULL,
account_id int NOT NULL,
PRIMARY KEY (id),
FOREIGN KEY (account_id)
REFERENCES Accounts (id)
);

Работа с данными
Несколько таблиц
Cгруппировать таблицу Houses по столбцу city и вычислить 
среднюю цену домов для каждого города.
SELECT city, AVG(price) AS mean_price
FROM Houses
GROUP BY city

Столбец внешнего ключа не обязательно должен быть уникальным.

Мы можем выбрать данные из нескольких таблиц, разделяя их запятыми 
в операторе SELECT:
SELECT firstname, lastname, city, number, type
FROM Customers, PhoneNumbers
WHERE Customer.id = PhoneNumber.customer_id

Вы работаете с таблицами Products и Orders. У каждого продукта есть id, 
в то время как в таблице Orders есть ссылочный product_id.
Выбрать название из таблицы продуктов и соответствующую цену из таблицы 
заказов.
SELECT name, price
FROM Products, Orders
WHERE Products.id = Orders.product_id

Работа с несколькими таблицами 
При работе с несколькими таблицами обычно столбцы определяются по 
полному имени – имя таблицы, за которым следует точка и имя столбца.

Например: Customers.id - это столбец id таблицы Customers, в то время 
как PhoneNumbers.id - это столбец id таблицы PhoneNumbers.

Выбрать столбец возраста из таблицы Users, используя полное имя столбца.
SELECT Users.age
FROM Users

Выводы урока 
Выбор данных из нескольких таблиц прост!
Просто разделите их имена в операторе SELECT запятой и укажите 
условие для связанных столбцов.

Вы работаете с базой данных библиотеки, которая хранит данные о книгах.
Таблица Books имеет колонки id, name, year, author_id.
Колонка author_id соединяется с таблицей Authors, которая хранит колонки id, name 
для авторов книг.
Вам нужно выбрать все книги с их авторами, упорядоченные по названию автора в 
алфавитном порядке, затем по году в порядке возрастания.
Результат должен содержать только 3 колонки: name, year книги и ее author (назовите 
колонку author). 
SELECT Books.name, Books.year, Authors.name AS author
FROM Books, Authors
WHERE Authors.id = Books.author_id
ORDER BY Authors.name ASC, Books.year ASC;


JOIN
Лучший способ объединения данных - это оператор JOIN.
Он позволяет вам объединять множество таблиц на основе условия.
SELECT firstname, lastname, city, number, type
FROM Customers JOIN PhoneNumbers
ON Customers.id = PhoneNumber.customer_id

Oбъединить таблицы Пользователи и Счета и выводить имена Пользователей 
и их номера счетов.
SELECT Users.name, Account.number
FROM Users JOIN Accounts
ON Users.id = Accounts.user_id

Возвращаются только записи, соответствующие условию объединения.
SELECT Clients.name, Companies.name
FROM Clients
JOIN Companies
ON Clients.company_id = Companies.id

Псевдоним 
Поскольку вы используете полные имена столбцов при объединении таблиц, 
запрос может стать действительно длинным.
Чтобы сделать его проще и короче, мы можем предоставить псевдонимы 
для наших таблиц:
SELECT C.firstname, C.lastname, C.city, PN.number, PN.type
FROM Customers AS C JOIN PhoneNumbers AS PN
ON C.id = PN.customer_id

LEFT JOIN 
Еще один тип JOIN - это LEFT JOIN.
LEFT JOIN возвращает все строки из левой таблицы (первой таблицы), 
даже если в правой таблице (второй таблице) нет совпадений. 
Это означает, что если для условия ON в правой таблице нет совпадений, 
оператор join все равно вернет строки из первой таблицы в результате.

SELECT U.name, T.amount
FROM Users AS U
JOIN Transactions AS T
ON U.id = T.userid

SELECT C.firstname, C.lastname, C.city, PN.number, PN.type
FROM Customers AS C LEFT JOIN PhoneNumbers AS PN
ON C.id = PN.customer_id
Если совпадение для определенной строки не найдено, для столбцов правой 
таблицы возвращается NULL.

SELECT A.id, B.id FROM 
A LEFT JOIN B
ON A.id = B.id
Результат: 4 строки

RIGHT JOIN 
Аналогично, RIGHT JOIN возвращает все строки из правой таблицы, 
даже если в левой таблице нет совпадений.
Например, мы могли бы переписать предыдущий запрос таким образом:
SELECT C.firstname, C.lastname, C.city, PN.number, PN.type
FROM PhoneNumber AS PN RIGHT JOIN Customers AS C
ON C.id = PN.customer_id
ORDER BY C.id

Если в левой таблице отсутствует соответствующая строка во время 
правого соединения (RIGHT JOIN), столбцы левой таблицы будут содержать 
значения NULL.

Выводы из урока
Операция JOIN позволяет вам объединять данные из нескольких таблиц 
на основе условий.
LEFT JOIN возвращает все строки из левой таблицы (первой таблицы), 
даже если в правой таблице (второй таблице) нет совпадений.
Аналогично, RIGHT JOIN возвращает все строки из правой таблицы, даже 
если в левой таблице нет совпадений.

UNION 
Иногда вам может потребоваться объединить данные из нескольких 
похожих таблиц в один общий набор данных. 
Например, у вас может быть несколько таблиц, хранящих данные 
Customers, и вы хотите объединить их в один результат.
Это может быть сделано с помощью оператора UNION.

Оператор UNION используется для объединения результатов двух или 
более SELECT-запросов.
Рассмотрим наличие таблиц Customers и Contacts, обе с колонками 
firstname, lastname и age:
SELECT firstname, lastname, age FROM Customers
UNION
SELECT firstname, lastname, age FROM Contacts

UNION ALL похож на UNION, но не удаляет дубликаты
SELECT firstname, lastname, age FROM Customers
UNION ALL
SELECT firstname, lastname, age FROM Contacts

Операторы SELECT должны иметь одинаковые столбцы, чтобы оператор 
UNION работал. В случае, если одна из таблиц имеет дополнительные 
столбцы, которые нам нужно выбрать, мы можем просто добавить их ко 
второму выбору как NULL:
SELECT firstname, lastname, age, city FROM Customers
UNION
SELECT firstname, lastname, age, NULL FROM Contacts

объединить строки таблиц Users и Clients
SELECT * FROM Users
UNION
SELECT * FROM Clients

Мы также можем установить условия для каждого выбранного в UNION.
У каждого оператора SELECT могут быть свои специфические условия.
SELECT firstname, lastname, age FROM Customers
WHERE age > 30
UNION
SELECT firstname, lastname, age FROM Contacts
WHERE age < 25


объединить строки Пользователей и Клиентов, но только для тех, у 
кого баланс больше 1000.
SELECT * FROM Users
WHERE balance > 1000
UNION
SELECT * FROM Clients
WHERE balance > 1000

Выводы урока 
 - UNION позволяет вам объединить записи из нескольких операторов SELECT в 
один набор данных.
 - Для работы UNION каждый оператор SELECT должен иметь одинаковое количество 
столбцов и совпадающие типы данных.
 - UNION удаляет дубликаты записей, в то время как UNION ALL не удаляет их.
 - Каждый оператор SELECT в UNION может иметь свои собственные условия. 
