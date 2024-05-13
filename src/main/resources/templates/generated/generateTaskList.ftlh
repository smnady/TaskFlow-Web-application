<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Document</title>
    <#--<style>
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
        .add-project button,
        .add-new-task button{
            padding: 5px 10px;
            border: none;
            background-color: #28a745;
            color: #fff;
            cursor: pointer;
        }
        .todo-list {
            border: 2px solid black;
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
        .task {
            display: flex;
            justify-content: space-between;
        }
        .btnn {
            display: block;
            border: none;
            background-color: inherit;
        }

    </style>-->
</head>
<body>
<div class="container">

    <div class="page-title">

            <div style="text-align: center;">
                <h1>${project.name}</h1>
            </div>

            <button type="button" class="btn btn-warning add-task-button" onclick="showAddTaskForm()">
                Добавить задачу
            </button>

    </div>
    <div class="task-content">
    <div class="parent-block-for-todo-list">

        <div class="row justify-content-around">

            <div class="col-4">
                <div class="todo-list" id="1">
                    <h5 class="modal-title" style="text-align: center;"><strong>ToDo List</strong></h5><hr>
                    <#list taskList as task>
                        <#if task.isSolved() == false>
                            <div class="task-item">
                                <div class="task">
                                    <div>
                                        <input type="checkbox" id="task${task.id}" name="task${task.id}" onchange="closeTask(${task.id})">
                                        <label for="task${task.id}" style="text-align: left">${task.getName()}</label>
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

            <div class="col-4">
                <div class="todo-list" id="2">
                    <h5 class="modal-title" style="text-align: center;"><strong>Completed tasks</strong></h5><hr>
                    <#list taskList as task>
                        <#if task.isSolved()>

                            <div class="task-item">
                                <div class="task">
                                    <div>
                                        <input type="checkbox" id="task${task.id}" name="task${task.id}" onchange="openTask(${task.id})" checked>
                                        <label for="task${task.id}" style="text-align: left">${task.getName()}</label>
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
    </div>
</div>
</body>
</html>