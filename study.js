Простейшая форма взаимодействия состоит из события, 
инициированного пользователем, которое вызывает действие
<button 
  onclick='alert("Hello")'>Press here
</button>

<button 
  onclick='alert("Important Information")'>
  Order now
</button>

<img src = "url"
  onclick='alert("Message")'>

Дополните код, чтобы при клике ширина изображения становилась 500 пикселей
<img src = "url"
  onclick='width=500>

<p onclick='alert
("Submitted")'>Paragraph</p>


JavaScript добавляет интерактивность на веб-страницы
Код JavaScript может быть добавлен в открывающие HTML-теги
onclick вызывает действие, когда пользователь кликает на элемент

<script>
alert("Message");
</script>

Script - это другое слово для кода. В веб-разработке, 
скриптинг означает предоставление инструкций для выполнения веб-браузером.
Инструкции, содержащиеся внутри тегов <script>, 
выполняются при загрузке страницы в браузере.

JS код может быть напрямую добавлен в HTML элементы.
Дополните, чтобы показать сообщение всплывающего окна, когда кнопка нажата
<button onclik = 'alert("Clicked")'>
<button>Place Order</button>
<script>
alert("Order Confirmed");
</script>

<p>check<script>
console.log("welcome to console");
</script>

<script>
alert("completed"); console.log("success"); 
</script>


⭐ внутренний JS код добавляется внутрь контейнерного тега <script>
⭐ консоль помогает вам находить и исправлять ошибки в вашем коде


Чтобы создать переменную, используйте ключевое слово let, за которым следует имя переменной.
Дополните код, чтобы создать переменную под названием item
let item = "bike";
let city = "London";
let population = 9000;

⭐ Информация представлена в различных формах и форматах. String это кусок текстовых данных
⭐ Numbers не должны быть окружены кавычками
⭐ Компьютерные программы используют variables для запоминания важной информации
⭐ У переменной есть name и value

let budget = 200;
alert(budget);

Вы можете переназначить переменную столько раз, сколько вам нужно.
let msg = "Solo";
msg = "learn"
msg = "Sololearn";
console.log(msg);

⭐ Вы можете получить доступ к значению, сохраненному в переменной, вызвав его имя
⭐ Переназначение переменной приведет к тому, что переменная забудет ранее сохраненное значение


<p id="p1">Paragraph text</p>
document.getElementById("intro")


<h2 id="e1">Heading</h2>
<p id="e2">Text</p>

<script>
document.getElementById("e1");
</script>


<p id="t1">Text1</p>

<script>
document.getElementById("t1").textContent;
</script>


<p id="p1">Text A</p>
<p id="p2">Text B</p>

<script>
let x1 = document.getElementById("p1").textContent;
let x2 = document.getElementById("p2").textContent;
</script>

⭐ DOM обрабатывает структуру веб-страницы как дерево

⭐ Чтобы получить информацию от элемента и изменить его, сначала вам нужно получить к нему доступ

⭐ Хранение информации элемента в переменной - удобный способ ссылаться на нее позже в вашем скрипте
