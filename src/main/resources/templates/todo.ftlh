<!DOCTYPE html>

<html lang="en">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Comfortaa:wght@300..700&display=swap" rel="stylesheet">


<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>Список задач</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link href="https://getbootstrap.com/docs/5.3/assets/css/docs.css" rel="stylesheet">
    <style>
        body {
            font-family: Comfortaa, sans-serif;
            margin: 0;
            padding: 0;
        }
        .container {
            display: flex;
            flex-direction: column;
            align-items: center;
            padding: 20px;
        }
        .nav-header {
            display: flex;
            justify-content: space-around;
        }
        .project-list {
            display: block;
            padding-bottom: 2%;
        }
        .add-project button,
        .add-new-task button{
            padding: 5px 10px;
            border: none;
            background-color: #28a745;
            color: #fff;
            cursor: pointer;
        }
        .todo-list {
            border: 1px solid black;
            border-radius: 5px;
            width: 100%;
            margin-bottom: 10px;
            padding: 10px;
            box-sizing: border-box;
        }
        .task-item {
            display: flex;
            align-items: center;
            vertical-align: center;
            gap: 10px;
        }
        .task-item input[type="checkbox"] {
            margin-right: 10px;
        }
        #add-task-form, #add-project-form {
            display: none;
            margin-top: 20px;
        }
        .form-label {
            margin-bottom: 5px;
            font-weight: bold;
        }
        .form-input {
            width: 100%;
            padding: 5px;
            margin-bottom: 10px;
            box-sizing: border-box;
        }
        .form-button {
            padding: 5px 10px;
            border: none;
            background-color: #007bff;
            color: #fff;
            cursor: pointer;
        }
        .task {
            display: flex;
            padding-left: 3%;
            width: 97%;
            justify-content: space-between;
        }
        .btnn {
            display: block;
            border: none;
            background-color: inherit;
        }
        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            z-index: 1;
        }

        .modal-content {
            background-color: #fefefe;
            margin: 15% auto;
            padding: 20px;
            border: 1px solid #888;
            width: 80%;
            max-width: 400px;
            position: relative;
        }

        .close {
            position: absolute;
            top: 5px;
            right: 10px;
            font-size: 20px;
            cursor: pointer;
        }

        .close:hover {
            color: red;
        }

        .page-title {
            text-align: center;
        }

        .add-task-button {
            display: block;
            margin: 0 auto 2%;
        }

        .col-4 {
            display: block;
            width: 45vw;
            height: 60vh;
        }

        .ms-2 {
            display: flex;
        }
        .nav {
            display: inline-flex;
        }
    </style>
</head>
<body>
<div class="container">
    <!-- Горизонтальный блок со списком проектов.
     При нажатии на какой-либо проект отображается
     страница с задачами выбранного проекта.
     -->
    <div class="nav-header">

        <div class="project-list">
            <form  id="project-list" method="GET" action="/getProjectTasks">
                <ul class="nav nav-pills nav-fill gap-2 p-1 small bg-primary rounded-5 shadow-sm" id="pillNav2"
                    role="tablist" style="--bs-nav-link-color: var(--bs-white); --bs-nav-pills-link-active-color: var(--bs-primary); --bs-nav-pills-link-active-bg: var(--bs-white);">
                    <#list projectList.getProjects() as project>
                        <li class="nav-item" role="presentation">
                            <button type="submit" name="currentProjectId" value="${project.id}" class="nav-link rounded-5" id="profile-tab2" data-bs-toggle="tab" type="button" role="tab" aria-selected="false">
                                ${project.name}
                            </button>
                        </li>
                    </#list>
                    <li class="nav-item" role="presentation">
                        <button type="submit" name="currentProjectId" class="nav-link rounded-5" id="profile-tab2" data-bs-toggle="tab" role="tab" aria-selected="false">
                            Все задачи
                        </button>
                    </li>
                    <li class="nav-item" role="presentation">
                        <div onclick="showAddProjectForm()" class="nav-link rounded-5" id="profile-tab2" data-bs-toggle="tab" role="tab" aria-selected="false" style="color: black; font-weight: bolder;">
                            Создать проект
                        </div>
                    </li>
                </ul>

            </form>
        </div>
        <div class="ms-2">
            <button class="btnn icon-menu" type="button" data-bs-toggle="offcanvas"  data-bs-target="#offcanvasRight" aria-controls="offcanvasRight">
                <h3><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-person-circle" viewBox="0 0 16 16">
                    <path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0z"/>
                    <path fill-rule="evenodd" d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8zm8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1z"/>
                </svg></h3>
            </button>

            <div class="offcanvas offcanvas-end" tabindex="-1" id="offcanvasRight" aria-labelledby="offcanvasRightLabel">
                <div class="offcanvas-header">
                    <h5 class="offcanvas-title" id="offcanvasRightLabel">Меню</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Закрыть"></button>
                </div>
                <div class="offcanvas-body">
                     <button class="dropdown-item" type="button" onclick="">
                         Посмотреть данные профиля
                     </button>
                    <button class="dropdown-item" type="button" onclick="">
                        Статистика
                    </button>
                     <button class="dropdown-item" type="button" onclick="logOut()">
                         Выйти из аккаунта
                     </button>
                </div>
            </div>
        </div>
        <!-- <div class="dropdown ms-2">
            <button class="btnn" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                <h4><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-person-circle" viewBox="0 0 16 16">
                        <path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0z"/>
                        <path fill-rule="evenodd" d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8zm8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1z"/>
                    </svg></h4>
            </button>
            <ul class="dropdown-menu">
                <li>
                    <button class="dropdown-item" type="button" onclick="">
                        Аккаунт
                    </button>
                </li>
                <li>
                    <button class="dropdown-item" type="button" onclick="logOut()">
                        Выйти из аккаунта
                    </button>
                </li>
            </ul>
        </div> -->
    </div>

    <!-- Вертикальный блок.
     Содержание: кнопка добавления задачи,
     функционал для фильтрации задачю
     -->
    <div class="block">
        <#assign hasProjects = projectList?has_content && projectList.getProjects()?has_content>

    <div class="page-title">
        <#if hasProjects>

            <div style="text-align: center;">
                <h1>Все запланированные задачи</h1>
            </div>

            <button type="button" class="btn btn-warning add-task-button" onclick="showAddTaskForm()">
                Добавить задачу
            </button>

        <#else>
            <div style="text-align: center;">
                <h1>Создайте свой первый проект и начните планировать задачи!</h1>
            </div>
        </#if>
    </div>
       <#-- <#if project?-->
    <div class="task-content">
        <#if taskList?has_content>
            <div class="parent-block-for-todo-list">

                <div class="row justify-content-around">

                    <div class="col-4">
                        <div class="todo-list" id="1" >
                            <h5 class="modal-title" style="text-align: center;"><strong>ToDo List</strong></h5><hr>
                            <#list taskList as task>
                                <#if task.isSolved() == false>
                                    <div class="task-item">
                                        <div class="task">
                                            <div class="form-check">
                                                <input class="form-check-input" onchange="closeTask(${task.id})" type="checkbox" value="" id="flexCheckDefault">
                                                <label class="form-check-label" for="flexCheckDefault">
                                                    ${task.getName()}
                                                </label>
                                            </div>
                                            <div class="dropdown">
                                                <button class="btnn" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-three-dots-vertical" viewBox="0 0 16 16">
                                                        <path d="M9.5 13a1.5 1.5 0 1 1-3 0 1.5 1.5 0 0 1 3 0m0-5a1.5 1.5 0 1 1-3 0 1.5 1.5 0 0 1 3 0m0-5a1.5 1.5 0 1 1-3 0 1.5 1.5 0 0 1 3 0"/>
                                                    </svg>
                                                </button>
                                                <ul class="dropdown-menu">
                                                    <li><button class="dropdown-item" type="button" onclick="showDetails('taskDetailsModal-${task.id}')">Просмотреть</button></li>
                                                    <li><button class="dropdown-item" type="button" onclick="showChangeTaskForm(${task.id})">Изменить</button></li>
                                                    <li><button class="dropdown-item" onclick="deleteTask(${task.id})"  type="button">Удалить</button></li>
                                                </ul>
                                            </div>
                                            <div id="taskDetailsModal-${task.id}" class="modal" tabindex="-1" data-bs-backdrop="false">
                                                <div class="modal-dialog">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <h5 class="modal-title"><strong>${task.name}</strong></h5>
                                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                        </div>
                                                        <div class="modal-body">
                                                            <p><strong>Проект:</strong> ${task.project.name}</p>
                                                            <p><strong>Статус:</strong> ${task.condition.description}</p>
                                                            <p><strong>Дата создания:</strong> ${task.dateOfCreationRepresentation}</p>
                                                            <p><strong>Дата выполнения:</strong> ${task.dateOfClosingRepresentation}</p>
                                                            <p><strong>Дедлайн:</strong> ${task.getDeadlineRepresentation()}</p>
                                                            <p><strong>Приоритет:</strong> ${task.priority.description}</p>
                                                            <p><strong>Описание:</strong> ${task.description}</p>
                                                        </div>
                                                        <div class="modal-footer">
                                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Закрыть</button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div><hr>

                                </#if>
                            </#list>
                        </div>
                    </div>

                    <div class="col-4">
                        <div class="todo-list" id="2">
                            <h5 class="modal-title" style="text-align: center;"><strong>Completed tasks</strong></h5><hr>
                            <#list taskList as task>
                                <#if task.isSolved()>

                                    <div class="task-item">
                                        <div class="task">
                                            <div>
                                                <input type="checkbox" id="task${task.id}" name="task${task.id}" onchange="openTask(${task.id})" checked>
                                                <label for="task${task.id}">${task.getName()}</label>
                                            </div>
                                            <div class="dropdown">
                                                <button class="btnn" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-three-dots-vertical" viewBox="0 0 16 16">
                                                        <path d="M9.5 13a1.5 1.5 0 1 1-3 0 1.5 1.5 0 0 1 3 0m0-5a1.5 1.5 0 1 1-3 0 1.5 1.5 0 0 1 3 0m0-5a1.5 1.5 0 1 1-3 0 1.5 1.5 0 0 1 3 0"/>
                                                    </svg>
                                                </button>
                                                <ul class="dropdown-menu">
                                                    <li><button class="dropdown-item" type="button" onclick="showDetails('taskDetailsModal-${task.id}')">Просмотреть</button></li>
                                                    <li><button class="dropdown-item" type="button">Изменить</button></li>
                                                    <li><button class="dropdown-item" onclick="deleteTask(${task.id})"  type="button">Удалить</button></li>
                                                </ul>
                                            </div>

                                            <div id="taskDetailsModal-${task.id}" class="modal" tabindex="-1" data-bs-backdrop="false">
                                                <div class="modal-dialog">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <h5 class="modal-title"><strong>${task.name}</strong></h5>
                                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                        </div>
                                                        <div class="modal-body">
                                                            <p><strong>Проект:</strong> ${task.project.name}</p>
                                                            <p><strong>Статус:</strong> ${task.condition.description}</p>
                                                            <p><strong>Дата создания:</strong> ${task.dateOfCreationRepresentation}</p>
                                                            <p><strong>Дата выполнения:</strong> ${task.dateOfClosingRepresentation}</p>
                                                            <p><strong>Дедлайн:</strong> ${task.getDeadlineRepresentation()}</p>
                                                            <p><strong>Приоритет:</strong> ${task.priority.description}</p>
                                                            <p><strong>Описание:</strong> ${task.description}</p>
                                                        </div>
                                                        <div class="modal-footer">
                                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Закрыть</button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                        </div>
                                    </div><hr>

                                </#if>
                            </#list>
                        </div>
                    </div>
                </div>

            </div>
        </#if>
    </div>
    </div>
    <div id="add-task-modal" class="modal" style="display: none;">
        <div class="modal-content">
            <span class="close" onclick="closeAddTaskForm()">&times;</span>
                <form id="addTaskForm" action="/addTask" method="POST">
                    <label class="form-label" for="taskName">Название задачи:</label>
                    <input class="form-input" type="text" id="taskName" name="name" required><br>
                    <label class="form-label" for="project">Проект:</label>
                    <select class="form-input" id="project" name="project" required>
                        <#list projectList.getProjects() as project>
                            <option value="${project.id}">${project.name}</option>
                        </#list>
                    </select><br>
                    <label class="form-label" for="deadline">Дедлайн:</label>
                    <input class="form-input" type="datetime-local" id="deadline" name="deadline"><br>
                    <label class="form-label" for="priority">Приоритет:</label>
                    <select class="form-input" id="priority" name="priority" required>
                        <option value="DEFAULT">Без приоритета</option>
                        <option value="LOW" selected>Низкий</option>
                        <option value="MEDIUM" selected>Низкий</option>
                        <option value="HIGH">Высокий</option>
                    </select><br>
                    <label class="form-label" for="description">Описание:</label><br>
                    <textarea class="form-input" id="description" name="description"></textarea><br>
                    <button class="form-button" type="submit">Добавить задачу</button>
                </form>
        </div>
    </div>

    <div id="add-project-modal" class="modal" style="display: none;">
        <div class="modal-content">
            <span class="close" onclick="closeAddProjectForm()">&times;</span>
            <form action="/addProject" method="POST" class="modal-form">
                <label class="form-label" for="projectName">Название проекта: </label>
                <input class="form-input" type="text" id="projectName" name="projectName" required>
                <button class="form-button" type="submit">Добавить</button>
            </form>
        </div>
    </div>

    <#--<div id="change-task-modal" class="modal changeTaskForm" style="display: none;">
        <div class="modal-content">
            <span class="close" onclick="closeAddProjectForm()">&times;</span>
            <form action="/addProject" method="POST" class="modal-form">
                <label class="form-label" for="projectName">Название проекта: </label>
                <input class="form-input" type="text" id="projectName" name="projectName" required>
                <button class="form-button" type="submit">Добавить</button>
            </form>
        </div>
    </div>-->

</div>

<script>

    function logOut() {
        fetch('/logOut', {
            method: 'GET'
        })
            .then(response => {
                if (response.ok) {
                    window.location.href = '/';
                } else {
                    console.error('Ошибка при выходе из аккаунта:', response.status);
                }
            });
    }

    function showDetails(modalId) {
        var modal = document.getElementById(modalId);

        var modalBootstrap = new bootstrap.Modal(modal);

        modalBootstrap.show();
    }

    function closeTask(taskId) {
        sendTaskRequest("/closeTask", taskId);
    }

    function openTask(taskId) {
        sendTaskRequest("/openTask", taskId);
    }

    function deleteTask(taskId) {
        sendTaskRequest("/deleteTask", taskId);
    }

/*    function showChangeTaskForm(taskId) {
        var url = new URL("/getChangeTaskForm", window.location.origin);
        url.searchParams.append("taskId", taskId);

        fetch(url)
            .then(response => response.text())
            .then(html => {
                var tempElement = document.createElement('div');
                tempElement.innerHTML = html;
                var todoListContainer = document.querySelector(".changeTaskForm");
                var newTodoList = tempElement.querySelector(".changeTaskForm");
                todoListContainer.innerHTML = newTodoList.innerHTML;

                tempElement = null;
            })
            .catch(error => {
                console.error("Ошибка при отправке AJAX запроса: " + error);
            });
    }*/

    function sendTaskRequest(url, taskId) {
        var formData = new FormData();
        formData.append("taskId", taskId);

        fetch(url, {
            method: "POST",
            body: formData
        })
            .then(response => response.text())
            .then(html => {
                var tempElement = document.createElement('div');
                tempElement.innerHTML = html;
                var todoListContainer = document.querySelector(".task-content");
                var newTodoList = tempElement.querySelector(".task-content");
                todoListContainer.innerHTML = newTodoList.innerHTML;
                tempElement = null;
            })
            .catch(error => {
                console.error("Ошибка при отправке AJAX запроса: " + error);
            });
    }

    function showAddProjectForm() {
        document.getElementById("add-project-modal").style.display = 'block';
    }

    function closeAddProjectForm() {
        document.getElementById("add-project-modal").style.display = 'none';
    }

    /*window.onclick = function(event) {
        var modal = document.getElementById("add-project-modal");
        if (event.target === modal) {
            modal.style.display = "none";
        }
    }*/

    function showAddTaskForm() {
        document.getElementById("add-task-modal").style.display = 'block';
    }

    document.getElementById("addTaskForm").addEventListener("submit", function(event) {
        event.preventDefault();

        var formData = new FormData(this);
        clearAddTaskForm();
        closeAddTaskForm();

        fetch(this.action, {
            method: this.method,
            body: formData
        })
            .then(response => response.text())
            .then(html => {
                var tempElement = document.createElement('div');
                tempElement.innerHTML = html;
                var todoListContainer = document.querySelector(".task-content");
                var newTodoList = tempElement.querySelector(".task-content");
                todoListContainer.innerHTML = newTodoList.innerHTML;
                tempElement = null;
            })
            .catch(error => {
                console.error("Ошибка при отправке AJAX запроса: " + error);
            });
    });

    function clearAddTaskForm() {
        document.getElementById("addTaskForm").reset();
    }

    function updateTaskStatus(taskId, isChecked) {
        console.log("Задача с ID " + taskId + " была отмечена как " + (isChecked ? "выполненная" : "не выполненная"));
    }

    function updatePage(currentProjectId) {
        var url = new URL("/getProjectTasks", window.location.origin);
        url.searchParams.append("currentProjectId", currentProjectId);

        fetch(url)
            .then(response => response.text())
            .then(html => {
                var tempElement = document.createElement('div');
                tempElement.innerHTML = html;
                var todoListContainer = document.querySelector(".task-content");
                var newTodoList = tempElement.querySelector(".task-content");
                todoListContainer.innerHTML = newTodoList.innerHTML;

                tempElement = document.createElement('div-2');
                tempElement.innerHTML = html;
                var title = document.querySelector(".page-title");
                var newTitle = tempElement.querySelector(".page-title");
                title.innerHTML = newTitle.innerHTML;

                tempElement = null;

            })
            .catch(error => {
                console.error("Ошибка при отправке AJAX запроса: " + error);
            });
    }

    document.getElementById("project-list").addEventListener("submit", function(event) {
        event.preventDefault();

        var currentProjectId = event.submitter.value;

        updatePage(currentProjectId);
    });


    function closeAddTaskForm() {
        document.getElementById("add-task-modal").style.display = 'none';
    }

</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>
</html>