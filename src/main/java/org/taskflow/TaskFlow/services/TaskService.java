package org.taskflow.TaskFlow.services;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.taskflow.TaskFlow.models.Task;
import org.taskflow.TaskFlow.repositories.TaskRepository;

import java.time.LocalDateTime;
import java.util.List;

@Service
@Slf4j
@RequiredArgsConstructor
public class TaskService {

    private final TaskRepository taskRepository;

    public Task getTaskById(Long taskId) {
        log.info("Getting information about task, taskId = {}", taskId);
        return taskRepository.findTaskById(taskId);
    }

    public void addTask(Task task) {
        log.info("Saving task {}", task);
        taskRepository.save(task);
    }

    public List<Task> getTasksByProjectId(Long projectId) {
        log.info("Getting a task list by projectId = {}", projectId);
        return taskRepository.findAllByProjectId(projectId);
    }

    public List<Task> getTasksByUserId(Long userId) {
        log.info("Getting a task list by userId = {}", userId);
        return taskRepository.getTasksByUserId(userId);
    }

    public void deleteTask(Long taskId) {
        log.info("Deleting the task by taskId = {}", taskId);
        taskRepository.deleteById(taskId);
    }

    public void updateTask(Task task) {
        log.info("Updating the task: {}", task);
        taskRepository.save(task);
    }

    @Transactional
    public void closeTaskById(Long taskId) {
        log.info("Set condition = SOLVED, taskId = {}", taskId);
        taskRepository.closeTaskById(taskId, LocalDateTime.now());
    }

    @Transactional
    public void openTaskById(Long taskId) {
        log.info("Set condition = UNRESOLVED, taskId = {}", taskId);
        taskRepository.openTaskById(taskId);
    }

}
