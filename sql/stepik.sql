# Интерактивный тренажер по SQL
# 1. Основы 
SELECT 'столбцы или * для выбора всех столбцов; обязательно'

FROM 'таблица; обязательно'

WHERE 'условие/фильтрация, например, city = 'Moscow'; необязательно'

GROUP BY 'столбец, по которому хотим сгруппировать данные; необязательно'

HAVING 'условие/фильтрация на уровне сгруппированных данных; необязательно'

ORDER BY 'столбец, по которому хотим отсортировать вывод; необязательно'

## Основные типы данных SQL
INT 
INTEGER
Целое число, могут принимать значения от -2 147 483 648 до 2 147 483 647
  
DECIMAL
NUMERIC
Вещественное число, в скобках указывается максимальная
длина числа (включает символы слева и справа от десятичной запятой)
и количество знаков после запятой. Можно использовать оба этих типа, они эквивалентны,
принимают значения в диапазоне -1038+1 до 1038-1.
DECIMAL(4,1)
NUMERIC(6,3)
  
DATE
Дата в формате ГГГГ-ММ-ДД 
26 июля 2020 года
3 января 2021 года
  
VARCHAR
Строка длиной не более 255 символов, в скобках указывается максимальная
длина строки, которая может храниться в поле
VARCHAR(10)(рассматриваются однобайтовые кодировки,
для которых число в скобках соответствует максимальному количеству символов в строке)
  
## Создание таблицы
Сформулируйте SQL запрос для создания таблицы book
CREATE TABLE book (
    book_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(50),
    author VARCHAR(30),
    price DECIMAL(8, 2),
    amount INT
);

## Вставка записи в таблицу
INSERT INTO book (title, author, price, amount) 
VALUES ('Мастер и Маргарита', 'Булгаков М.А.', 670.99, 3);

## Несколько записей:
INSERT INTO book (title, author, price, amount) VALUES ('Белая гвардия', 'Булгаков М.А.', 540.50, 5);
INSERT INTO book (title, author, price, amount) VALUES ('Идиот', 'Достоевский Ф.М.', 460.00, 10);
INSERT INTO book (title, author, price, amount) VALUES ('Братья Карамазовы', 'Достоевский Ф.М.', 799.01, 2)

## Выборка всех данных из таблицы
SELECT * FROM book
  
## Выборка отдельных столбцов
SELECT author, title, price FROM book

## Присвоение новых имен столбцам при формировании выборки
SELECT title AS Название, author AS Автор FROM book

## Выборка данных с созданием вычисляемого столбца
SELECT title, author, price, amount, 
     price * amount AS total 
FROM book;

SELECT title, amount, amount*1.65 AS pack FROM book

## Выборка данных, вычисляемые столбцы, математические функции
SELECT title, 
    author, amount,
    ROUND((price*0.7),2) AS new_price 
FROM book

SELECT title, price, 
    price*18/118 AS tax, 
    price/1.18 AS price_tax 
FROM book;

## Выборка данных, вычисляемые столбцы, логические функции
Для каждой книги из таблицы book установим скидку следующим образом: 
если количество книг меньше 4, то скидка будет составлять 50% от цены, 
в противном случае 30%. Цена по скидке должна отображаться с двумя знаками после запятой, 
добавим в запрос округление:
SELECT title, amount, price, 
    ROUND(IF(amount<4, price*0.5, price*0.7),2) AS sale
FROM book;

Усложним вычисление скидки в зависимости от количества книг. 
Если количество книг меньше 4 , то скидка составляет 50%, для остальных книг, 
количество которых меньше 11, скидка 30%, для всех оставшихся – 10%. 
И еще укажем какая именно скидка на каждую книгу.
SELECT title, amount, price,
    ROUND(
     IF(amount < 4, price * 0.5, 
         IF(amount < 11, price * 0.7, price * 0.9)),
     2) AS sale,
    IF(amount < 4, 'скидка 50%', 
      IF(amount < 11, 'скидка 30%', 'скидка 10%')
     ) AS Ваша_скидка
FROM book;

При анализе продаж книг выяснилось, что наибольшей популярностью пользуются 
книги Михаила Булгакова, на втором месте книги Сергея Есенина. 
Исходя из этого решили поднять цену книг Булгакова на 10%, а цену книг 
Есенина - на 5%. Написать запрос, куда включить автора, название книги и 
новую цену, последний столбец назвать new_price. Значение округлить до 
двух знаков после запятой.
SELECT author, title,
    ROUND(
        IF(author = 'Булгаков М.А.', price * 1.1, 
           IF(author = 'Есенин С.А.', price * 1.05, price))
        , 2) AS new_price
FROM book;

## Выборка данных по условию
Вывести название и цену тех книг, цены которых меньше 600 рублей.
SELECT title, price 
FROM book
WHERE price < 600;

Вывести название, автора  и стоимость (цена умножить на количество) 
тех книг, стоимость которых больше 4000 рублей
SELECT title, author, price * amount AS total
FROM book
WHERE price * amount > 4000;

Вывести автора, название  и цены тех книг, количество которых меньше 10.
SELECT author, title, price 
FROM book
WHERE amount < 10 

Выборка данных, логические операции
Приоритеты операций:
1. круглые скобки
2. умножение  (*),  деление (/)
3. сложение  (+), вычитание (-)
4. операторы сравнения (=, >, <, >=, <=, <>)
5. NOT
6. AND
7. OR
Вывести название, автора и цену тех книг, которые написал Булгаков, 
ценой больше 600 рублей
SELECT title, author, price 
FROM book
WHERE price > 600 AND author = 'Булгаков М.А.';

Вывести название, цену  тех книг, которые написал Булгаков или Есенин, 
ценой больше 600 рублей
SELECT title, author, price 
FROM book
WHERE (author = 'Булгаков М.А.' OR author = 'Есенин С.А.') AND price > 600;

Вывести название, автора,  цену  и количество всех книг, цена 
которых меньше 500 или больше 600, а стоимость всех экземпляров 
этих книг больше или равна 5000.
SELECT title, author, price, amount
FROM book
WHERE (price < 500 OR price > 600) AND (price * amount) >= 5000

## Выборка данных, операторы BETWEEN, IN
Выбрать названия и количества тех книг, количество которых 
от 5 до 14 включительно.
SELECT title, amount 
FROM book
WHERE amount BETWEEN 5 AND 14;
или
SELECT title, amount 
FROM book
WHERE amount >= 5 AND amount <=14;

Выбрать названия и цены книг, написанных Булгаковым или Достоевским.
SELECT title, price 
FROM book
WHERE author IN ('Булгаков М.А.', 'Достоевский Ф.М.');
или
SELECT title, price 
FROM book
WHERE author = 'Булгаков М.А.' OR author = 'Достоевский Ф.М.';

Вывести название и авторов тех книг, цены которых принадлежат 
интервалу от 540.50 до 800 (включая границы),  а количество 
или 2, или 3, или 5, или 7 .
SELECT title, author
FROM book
WHERE (price BETWEEN 540.50 AND 800) AND (amount IN (2, 3, 5, 7)) 

## Выборка данных с сортировкой
ASC по возрастанию (по умолчанию)
DESC по убыванию

SELECT title, author, price
FROM book
ORDER BY title;

Вывести автора, название и количество книг, в отсортированном в 
алфавитном порядке по автору и по убыванию количества, для тех 
книг, цены которых меньше 750 рублей.
SELECT author, title, amount AS Количество
FROM book
WHERE price < 750
ORDER BY author, amount DESC;

Вывести  автора и название  книг, количество которых принадлежит 
интервалу от 2 до 14 (включая границы). Информацию  отсортировать 
сначала по авторам (в обратном алфавитном порядке), а затем по 
названиям книг (по алфавиту). 
SELECT author, title
FROM book
WHERE amount BETWEEN 2 AND 14
ORDER BY author DESC, title

## Выборка данных, оператор LIKE
% Любая строка, содержащая ноль или более символов
_ Любой одиночный символ

Вывести названия книг, начинающихся с буквы «Б».
SELECT title 
FROM book
WHERE title LIKE 'Б%';
/* эквивалентное условие 
title LIKE 'б%'
*/

Вывести название книг, состоящих ровно из 5 букв.
SELECT title FROM book 
WHERE title LIKE "_____"

Вывести книги, название которых длиннее 5 символов:
SELECT title FROM book 
WHERE title LIKE "______%";
/* эквивалентные условия 
title LIKE "%______"
title LIKE "%______%"
*/

Вывести названия книг, которые содержат букву "и" как отдельное слово, 
если считать, что слова в названии отделяются друг от друга пробелами 
и не содержат знаков препинания.
SELECT title FROM book 
WHERE   title LIKE "_% и _%" /*отбирает слово И внутри названия */
    OR title LIKE "и _%" /*отбирает слово И в начале названия */
    OR title LIKE "_% и" /*отбирает слово И в конце названия */
    OR title LIKE "и" /* отбирает название, состоящее из одного слова И */

Вывести названия книг, которые состоят ровно из одного слова, если считать, 
что слова в названии отделяются друг от друга пробелами .
SELECT title FROM book 
WHERE title NOT LIKE "% %"; 

Вывести название и автора тех книг, название которых состоит из двух 
и более слов, а инициалы автора содержат букву «С». Считать, что в 
названии слова отделяются друг от друга пробелами и не содержат знаков 
препинания, между фамилией автора и инициалами обязателен пробел, 
инициалы записываются без пробела в формате: буква, точка, буква, точка. 
Информацию отсортировать по названию книги в алфавитном порядке.
SELECT title, author
FROM book
WHERE title LIKE '_% _%'
  AND author LIKE '%_С.%'
ORDER BY title;

https://stepik.org/lesson/297509/step/13?unit=279269 тренировка

## 1.3 Выбор уникальных элементов столбца
DISTINCT - уникальные элементы некоторого столбца
Выбрать различных авторов, книги которых хранятся в таблице book.
SELECT DISTINCT author
FROM book;
Другой способ – использование оператора GROUP BY, который группирует 
данные при выборке, имеющие одинаковые значения в некотором столбце. 
Столбец, по которому осуществляется группировка, указывается после GROUP BY .
С помощью GROUP BY можно выбрать уникальные элементы столбца, по которому 
осуществляется группировка. Результат будет точно такой же как при 
использовании DISTINCT.
SELECT  author
FROM book
GROUP BY author;

Отобрать различные (уникальные) элементы столбца amount таблицы book.
SELECT DISTINCT amount
FROM book

## Выборка данных, групповые функции SUM и COUNT
SELECT author, sum(amount), count(amount)
FROM book
GROUP BY author;

Посчитать, сколько экземпляров книг каждого автора хранится на складе.
SELECT author, SUM(amount)
FROM book
GROUP BY author;

Посчитать, сколько различных книг каждого автора хранится на складе.
SELECT author, COUNT(author), COUNT(amount), COUNT(*)
FROM book
GROUP BY author;

COUNT(*) —  подсчитывает  все записи, относящиеся к группе, 
  в том числе и со значением NULL;
COUNT(имя_столбца) — возвращает количество записей конкретного 
  столбца (только NOT NULL), относящихся к группе.

Посчитать, количество различных книг и количество экземпляров книг 
каждого автора , хранящихся на складе.  Столбцы назвать Автор, 
Различных_книг и Количество_экземпляров соответственно.
SELECT author AS Автор, COUNT(amount) AS  Различных_книг, SUM(amount) AS Количество_экземпляров
FROM book
GROUP BY author

## Выборка данных, групповые функции MIN, MAX и AVG
SELECT author, MIN(price) AS min_price
FROM book
GROUP BY author;

Вывести фамилию и инициалы автора, минимальную, максимальную и 
среднюю цену книг каждого автора . Вычисляемые столбцы назвать 
Минимальная_цена, Максимальная_цена и Средняя_цена соответственно.
SELECT author, MIN(price) AS Минимальная_цена, MAX(price) AS Максимальная_цена, AVG(price) AS Средняя_цена
FROM book
GROUP BY author

## Выборка данных c вычислением, групповые функции
Вывести суммарную стоимость книг каждого автора.
SELECT author, SUM(price * amount) AS Стоимость
FROM book
GROUP BY author;

Найти среднюю цену книг каждого автора.
SELECT author, ROUND(AVG(price),2) AS Средняя_цена
FROM book
GROUP BY author;

Для каждого автора вычислить суммарную стоимость книг S 
(имя столбца Стоимость), а также вычислить налог на добавленную 
стоимость  для полученных сумм (имя столбца НДС ) , который 
включен в стоимость и составляет 18% (k=18),  а также стоимость 
книг  (Стоимость_без_НДС) без него. Значения округлить до двух 
знаков после запятой. В запросе для расчета НДС(tax)  и 
Стоимости без НДС(S_without_tax)
SELECT author, SUM(price*amount) 
  AS Стоимость, ROUND(SUM(price * amount) * 18 /118,2)
  AS НДС, ROUND(SUM(price * amount) / 1.18,2) 
  AS Стоимость_без_НДС
FROM book
GROUP BY author

## Вычисления по таблице целиком
Посчитать количество экземпляров книг на складе.
SELECT SUM(amount) AS Количество
FROM book;

Посчитать общее количество экземпляров книг на складе и их стоимость .
SELECT SUM(amount) AS Количество, 
    SUM(price * amount) AS Стоимость
FROM book;

Вывести цену самой дешевой книги, цену самой дорогой и среднюю цену 
всех книг на складе. Названия столбцов Минимальная_цена, Максимальная_цена, 
Средняя_цена соответственно. Среднюю цену округлить до двух знаков 
после запятой. 
SELECT MIN(price) 
  AS Минимальная_цена, MAX(price) 
  AS Максимальная_цена, ROUND(AVG(price),2) 
  AS Средняя_цена
FROM book
  
## Выборка данных по условию, групповые функции
Найти минимальную и максимальную цену книг всех авторов, общая стоимость 
книг которых больше 5000.
SELECT author,
    MIN(price) AS Минимальная_цена, 
    MAX(price) AS Максимальная_цена
FROM book
GROUP BY author
HAVING SUM(price * amount) > 5000; 

Найти минимальную и максимальную цену книг всех авторов, общая стоимость 
книг которых больше 5000. Результат вывести по убыванию минимальной цены.
SELECT author,
    MIN(price) AS Минимальная_цена, 
    MAX(price) AS Максимальная_цена
FROM book
GROUP BY author
HAVING SUM(price * amount) > 5000 
ORDER BY Минимальная_цена DESC;

Вычислить среднюю цену и суммарную стоимость тех книг, количество 
экземпляров которых принадлежит интервалу от 5 до 14, включительно. 
Столбцы назвать Средняя_цена и Стоимость, значения округлить до 2-х 
знаков после запятой.
SELECT 
  ROUND(AVG(price),2) AS Средняя_цена,  
  ROUND(SUM(price*amount),2) AS Стоимость
FROM book
WHERE amount BETWEEN 5 AND 14

## Выборка данных по условию, групповые функции, WHERE и HAVING
WHERE и HAVING могут использоваться в одном запросе. 
При этом необходимо учитывать порядок выполнения  SQL запроса на 
выборку на СЕРВЕРЕ:
1. FROM
2. WHERE
3. GROUP BY
4. HAVING
5. SELECT
6. ORDER BY
Сначала определяется таблица, из которой выбираются данные (FROM), 
затем из этой таблицы отбираются записи в соответствии с условием  
WHERE, выбранные данные агрегируются (GROUP BY),  из агрегированных 
записей выбираются те, которые удовлетворяют условию после HAVING. 
Потом формируются данные результирующей выборки, как это указано 
после SELECT ( вычисляются выражения, присваиваются имена и пр. ). 
Результирующая выборка сортируется, как указано после ORDER BY.

Вывести максимальную и минимальную цену книг каждого автора, 
кроме Есенина, количество экземпляров книг которого больше 10.
SELECT author,
    MIN(price) AS Минимальная_цена,
    MAX(price) AS Максимальная_цена
FROM book
WHERE author <> 'Есенин С.А.'
GROUP BY author
HAVING SUM(amount) > 10;

Посчитать стоимость всех экземпляров каждого автора без учета 
книг «Идиот» и «Белая гвардия». В результат включить только тех 
авторов, у которых суммарная стоимость книг (без учета книг «Идиот» 
и «Белая гвардия») более 5000 руб. Вычисляемый столбец назвать Стоимость. 
Результат отсортировать по убыванию стоимости.
SELECT author, SUM(price*amount) AS Стоимость
FROM book
WHERE title != 'Идиот' AND title !=  'Белая гвардия'
GROUP BY author
HAVING SUM(price * amount) > 5000
ORDER BY 
    Стоимость DESC;

Задание тестирование таблицы https://stepik.org/lesson/297515/step/9?unit=279275

## 1.4 Вложенный запрос, возвращающий одно значение
Вывести информацию о самых дешевых книгах, хранящихся на складе.
SELECT title, author, price, amount
FROM book
WHERE price = (
         SELECT MIN(price) 
         FROM book
      );

Вывести информацию (автора, название и цену) о  книгах, цены которых 
меньше или равны средней цене книг на складе. Информацию вывести в 
отсортированном по убыванию цены виде. Среднее вычислить как среднее по цене книги.
SELECT author, title, price
FROM book
WHERE price <= (SELECT AVG(price)
               FROM book
    )
ORDER BY 
    price DESC;

## Использование вложенного запроса в выражении
Вывести информацию о книгах, количество экземпляров которых отличается 
от среднего количества экземпляров книг на складе более чем на 3.
То есть нужно вывести и те книги, количество экземпляров которых 
меньше среднего на 3, или больше среднего на 3.
SELECT title, author, amount 
FROM book
WHERE ABS(amount - (SELECT AVG(amount) FROM book)) >3;

Вывести информацию (автора, название и цену) о тех книгах, 
цены которых превышают минимальную цену книги на складе не 
более чем на 150 рублей в отсортированном по возрастанию цены виде
SELECT author, title,  price
FROM book
WHERE price <= (SELECT MIN(price) FROM book) +150 
ORDER BY price ASC

## Вложенный запрос, оператор IN
WHERE имя_столбца IN (вложенный запрос, возвращающий один столбец)

Вывести информацию о книгах тех авторов, общее количество экземпляров 
книг которых не менее 12.
SELECT title, author, amount, price
FROM book
WHERE author IN (
        SELECT author 
        FROM book 
        GROUP BY author 
        HAVING SUM(amount) >= 12
      );

Вывести информацию (автора, книгу и количество) о тех книгах, количество 
экземпляров которых в таблице book не дублируется.
SELECT author, title, amount
FROM book
WHERE amount IN (SELECT amount
FROM book
GROUP BY AMOUNT HAVING COUNT(amount) = 1);

## Вложенный запрос, операторы ANY и ALL
Вывести информацию о тех книгах, количество которых меньше самого 
маленького среднего количества книг каждого автора.
SELECT title, author, amount, price
FROM book
WHERE amount < ALL (
        SELECT AVG(amount) 
        FROM book 
        GROUP BY author 
      );

Вывести информацию о тех книгах, количество которых меньше самого 
большого среднего количества книг каждого автора.
SELECT title, author, amount, price
FROM book
WHERE amount < ANY (
        SELECT AVG(amount) 
        FROM book 
        GROUP BY author 
      );

Вывести информацию о книгах(автор, название, цена), цена которых 
меньше самой большой из минимальных цен, вычисленных для каждого автора.
SELECT author, title, price
FROM book 
WHERE price < (
    SELECT MAX(min_price)
    FROM (
        SELECT MIN(PRICE) AS min_price
        FROM book
        GROUP BY author) as min_price);

## Вложенный запрос после SELECT
Вывести информацию о книгах, количество экземпляров которых отличается 
от среднего количества экземпляров книг на складе более чем на 3,  
а также указать среднее значение количества экземпляров книг.
SELECT title, author, amount, 
    (
     SELECT AVG(amount) 
     FROM book
    ) AS Среднее_количество 
FROM book
WHERE abs(amount - (SELECT AVG(amount) FROM book)) >3;

SELECT title, author, amount, 
      FLOOR((SELECT AVG(amount) FROM book)) AS Среднее_количество 
FROM book
WHERE ABS(amount - (SELECT AVG(amount) FROM book)) >3;

Посчитать сколько и каких экземпляров книг нужно заказать поставщикам, 
чтобы на складе стало одинаковое количество экземпляров каждой книги, 
равное значению самого большего количества экземпляров одной книги на складе. 
Вывести название книги, ее автора, текущее количество экземпляров на складе 
и количество заказываемых экземпляров книг. Последнему столбцу присвоить 
имя Заказ. В результат не включать книги, которые заказывать не нужно.
SELECT 
    title, 
    author, 
    amount,
    (SELECT MAX(amount) FROM book) - amount AS Заказ
FROM book
WHERE amount < (SELECT MAX(amount) FROM book);

Тренировка https://stepik.org/lesson/297514/step/7?unit=279274

## 1.5 Создание пустой таблицы
CREATE TABLE supply(
    supply_id INT PRIMARY KEY AUTO_INCREMENT, 
    title VARCHAR(50),
    author VARCHAR(30),
    price DECIMAL(8, 2),
    amount INT  
)

# Добавление записей в таблицу
INSERT INTO book (title, author, price, amount) 
VALUES 
    ('Война и мир','Толстой Л.Н.', 1070.20, 2),
    ('Анна Каренина', 'Толстой Л.Н.', 599.90, 3);

# Добавление записей из другой таблицы
Занести все книги из таблицы supply в таблицу book
INSERT INTO book (title, author, price, amount) 
SELECT title, author, price, amount 
FROM supply;

SELECT * FROM book;

Добавить из таблицы supply в таблицу book, все книги, 
кроме книг, написанных Булгаковым М.А. и Достоевским Ф.М.
INSERT INTO book (title, author, price, amount) 
SELECT title, author, price, amount 
FROM supply
WHERE author != 'Булгаков М.А.' and author != 'Достоевский Ф.М.';

SELECT * FROM book;

# Добавление записей, вложенные запросы
Занести из таблицы supply в таблицу book только те книги, 
названия которых отсутствуют в таблице book
INSERT INTO book (title, author, price, amount) 
SELECT title, author, price, amount 
FROM supply
WHERE title NOT IN (
        SELECT title 
        FROM book
      );
SELECT * FROM book;

# Запросы на обновление
UPDATE таблица SET поле = выражение
где 
таблица – имя таблицы, в которой будут проводиться изменения;
поле – поле таблицы, в которое будет внесено изменение;
выражение – выражение,  значение которого будет занесено в поле.

Пример
Уменьшить на 30% цену книг в таблице book
UPDATE book 
SET price = 0.7 * price;
SELECT * FROM book;

Уменьшить на 30% цену тех книг в таблице book, количество которых меньше 5.
UPDATE book 
SET price = 0.7 * price 
WHERE amount < 5;
SELECT * FROM book;

Уменьшить на 10% цену тех книг в таблице book, количество которых 
принадлежит интервалу от 5 до 10, включая границы.
UPDATE book
SET price = 0.9 * price
WHERE amount BETWEEN 5 AND 10

UPDATE book
SET price = price * 0.85
WHERE amount BETWEEN 10 AND 20;

## Запросы на обновление нескольких столбцов
Запросом UPDATE можно обновлять значения нескольких столбцов одновременно. 
В этом случае простейший запрос будет выглядеть так:
UPDATE таблица SET поле1 = выражение1, поле2 = выражение2

В столбце buy покупатель указывает количество книг, которые он хочет 
приобрести. Для каждой книги, выбранной покупателем, необходимо 
уменьшить ее количество на складе на указанное в столбцеbuy количество, 
а в столбец buy занести 0.
Запрос:
UPDATE book 
SET amount = amount - buy,
    buy = 0;
SELECT * FROM book;

В таблице book необходимо скорректировать значение для покупателя 
в столбце buy таким образом, чтобы оно не превышало количество 
экземпляров книг, указанных в столбце amount. А цену тех книг, 
которые покупатель не заказывал, снизить на 10%.
UPDATE book
SET 
    buy = IF(buy > amount, amount, buy),
    price = IF(buy = 0, price * 0.9, price);

## Запросы на обновление нескольких таблиц
Если в таблице supply  есть те же книги, что и в таблице book, 
добавлять эти книги в таблицу book не имеет смысла. Необходимо 
увеличить их количество на значение столбца amountтаблицы supply
UPDATE book, supply 
SET book.amount = book.amount + supply.amount
WHERE book.title = supply.title AND book.author = supply.author;
SELECT * FROM book;

Для тех книг в таблице book , которые есть в таблице supply, 
не только увеличить их количество в таблице book ( увеличить их 
количество на значение столбца amount таблицы supply), но и 
пересчитать их цену (для каждой книги найти сумму цен из таблиц 
book и supply и разделить на 2).
UPDATE book, supply
SET 
    book.amount = book.amount + supply.amount,  -- Увеличиваем количество
    book.price = (book.price + supply.price) / 2  -- Пересчитываем цену
WHERE 
    book.title = supply.title  -- Условие по названию
    AND book.author = supply.author;  -- Условие по автору

-- Проверяем результат
SELECT * FROM book;

## Запросы на удаление
DELETE FROM таблица;

После того, как информация о книгах из таблицы supply перенесена в book , 
необходимо очистить таблицу  supply
DELETE FROM supply;
SELECT * FROM supply;

Удалить из таблицы supply все книги, названия которых есть в таблице book
DELETE FROM supply 
WHERE title IN (
        SELECT title 
        FROM book
      );
SELECT * FROM supply;

Удалить из таблицы supply книги тех авторов, общее количество 
экземпляров книг которых в таблице book превышает 10.
DELETE FROM supply
WHERE author IN (
    SELECT author
    FROM book
    GROUP BY author
    HAVING SUM(amount) > 10
);

## Запросы на создание таблицы
CREATE TABLE имя_таблицы AS
SELECT ...
  
Создать таблицу заказ (ordering), куда включить авторов и названия 
тех книг, количество экземпляров которых в таблице book меньше 4. 
Для всех книг указать одинаковое количество экземпляров 5.
CREATE TABLE ordering AS
SELECT author, title, 5 AS amount
FROM book
WHERE amount < 4;
SELECT * FROM ordering;

Создать таблицу заказ (ordering), куда включить авторов и названия тех книг, 
количество экземпляров которых в таблице book меньше 4. Для всех книг указать 
одинаковое значение - среднее количество экземпляров книг в таблице book.
CREATE TABLE ordering AS
SELECT author, title, 
   (
    SELECT ROUND(AVG(amount)) 
    FROM book
   ) AS amount
FROM book
WHERE amount < 4;
SELECT * FROM ordering;

Создать таблицу заказ (ordering), куда включить авторов и названия тех книг, 
количество экземпляров которых в таблице book меньше среднего количества 
экземпляров книг в таблице book. В таблицу включить столбец   amount, 
в котором для всех книг указать одинаковое значение - среднее количество 
экземпляров книг в таблице book.
CREATE TABLE ordering AS
SELECT 
    author, 
    title, 
    (SELECT ROUND(AVG(amount)) FROM book) AS amount  -- Среднее количество экземпляров
FROM book
WHERE amount < (SELECT AVG(amount) FROM book);  -- Условие: количество меньше среднего

-- Проверяем результат
SELECT * FROM ordering;

Тестирование таблицы https://stepik.org/lesson/305012/step/11?unit=287020
