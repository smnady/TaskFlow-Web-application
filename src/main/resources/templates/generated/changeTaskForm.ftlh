<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
</head>
<body>

<div id="change-task-modal" class="modal changeTaskForm" style="display: block;">
    <div class="modal-content">
        <span class="close" onclick="closeAddTaskForm()">&times;</span>
        <form id="changeTaskForm" action="/changeTask" method="POST">
            <input name="id" value="${task.id}" type="hidden">
            <label class="form-label" for="taskName">Название задачи:</label>
            <input class="form-input" type="text" id="taskName" name="name" value="${task.name}" required><br>
            <label class="form-label" for="project">Проект:</label>
            <select class="form-input" id="project" name="project" required>
                <#list projectList.getProjects() as project>
                    <option value="${project.id}">${project.name}</option>
                </#list>
            </select><br>
            <label class="form-label" for="deadline">Дедлайн:</label>
            <input class="form-input" type="datetime-local" value="${task.deadline}" id="deadline" name="deadline"><br>
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

</body>
</html>