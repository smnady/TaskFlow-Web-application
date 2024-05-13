<!DOCTYPE html>

<html lang="en">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Comfortaa:wght@300..700&display=swap" rel="stylesheet">

<head>
    <meta charset="UTF-8">
    <title>Список задач</title>
    <style>
        body {
            font-family: Comfortaa, sans-serif;
        }
        .parent-block-for-todo-list {
            display: flex;
            width: 80%;
            margin-left: 10%;
        }
        .todo-list {
            display: block;
            border-width: 2px;
            border-color: black;
            border-radius: 5px;
            width: 38%;
        }
    </style>
</head>
<body>
<div class="container">
    <form method="get" action="/listOfProjects">
        <button type="submit">Вернуться к списку проектов</button>
    </form>
    <#if project?has_content>
        <div style="text-align: center;">
        <h1>${project.name}</h1>
        </div>
    </#if>
    <!-- Горизонтальный блок со списком проектов.
     При нажатии на какой-либо проект отображается
     страница с задачами выбранного проекта.
     -->
    <#--<div class="project-list">
        <form method="GET" action="/project">
            <#list projectList as project>
                <input value="${project.id}" name="projectId"  type="hidden" required>
                <button type="submit">${project.name}</button>
            </#list>
        </form>
        <button class="add-project" onclick="showAddProjectForm()">
            Создать проект
        </button>
    </div>-->
    <!-- Вертикальный блок.
     Содержание: кнопка добавления задачи,
     функционал для фильтрации задачю
     -->
    <#if project?has_content>
        <div class="buttons">
            <button class="add-new-task" onclick="showAddTaskForm()">Добавить задачу</button>
        </div>
    </#if>
    <#if taskList?has_content>
        <div class="parent-block-for-todo-list">

            <div class="todo-list" id="1">
                <#list taskList as task>
                    <#if task.isSolved() == false>
                        <div class="task-item">
                            <div>
                                <input type="checkbox" id="task${task.id}" name="task${task.id}" onchange="updateTaskStatus(${task.id}, this.checked)">
                                <label for="task${task.id}">${task.getName()}</label>
                            </div>
                        </div>
                    </#if>
                </#list>
            </div>

            <div class="todo-list" id="2">
                <#list taskList as task>
                    <#if task.isSolved()>
                        <div class="task-item">
                            <div>
                                <input type="checkbox" id="task${task.id}" name="task${task.id}" onchange="updateTaskStatus(${task.id}, this.checked)">
                                <label for="task${task.id}">${task.getName()}</label>
                            </div>
                        </div>
                    </#if>
                </#list>
            </div>

        </div>
    </#if>
    <div id="add-task-form" style="display: none">
        <form id="addTaskForm" action="/addTask" method="POST">
            <input type="hidden" name="projectId" value="${project.id}">
            <label for="taskName">Название задачи:</label>
            <input type="text" id="taskName" name="name" required><br>
            <label for="project">Проект:</label>
            <select id="project" name="project" required>
                <#list projectList as project>
                    <option value="${project.id}">${project.name}</option>
                </#list>
            </select><br>
            <label for="deadline">Дедлайн:</label>
            <input type="datetime-local" id="deadline" name="deadline"><br>
            <label for="priority">Приоритет:</label>
            <select id="priority" name="priority" required>
                <option value="DEFAULT" selected>Обычный</option>
                <option value="HIGH">Высокий</option>
                <option value="URGENT">Срочный</option>
            </select><br>
            <label for="description">Описание:</label><br>
            <textarea id="description" name="description"></textarea><br>
            <button type="submit">Добавить задачу</button>
        </form>
    </div>

</div>

<script>

    function showAddTaskForm() {
        document.getElementById("add-task-form").style.display = 'block';

        document.getElementById("addTaskForm").addEventListener("submit", function(event) {
            event.preventDefault(); // Предотвращение стандартного поведения при отправке формы

            var formData = new FormData(this); // Получение данных формы

            fetch(this.action, {
                method: this.method,
                body: formData
            })
                .then(response => response.text())
                .then(html => {
                    var tempElement = document.createElement('div');
                    tempElement.innerHTML = html;
                    var todoListContainer = document.querySelector(".todo-list");
                    var newTodoList = tempElement.querySelector(".todo-list");
                    todoListContainer.innerHTML = newTodoList.innerHTML;
                    hiddenTaskForm();
                    tempElement = null;
                })
                .catch(error => {
                    console.error("Ошибка при отправке AJAX запроса: " + error);
                });
        });
    }
    function hiddenTaskForm() {
        document.getElementById("add-task-form").style.display = 'none';
    }

    function updateTaskStatus(taskId, isChecked) {
        // Отправить запрос на сервер для обновления статуса задачи
        console.log("Задача с ID " + taskId + " была отмечена как " + (isChecked ? "выполненная" : "не выполненная"));
    }

</script>
</body>
</html>