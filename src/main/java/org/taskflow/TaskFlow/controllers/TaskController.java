package org.taskflow.TaskFlow.controllers;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.taskflow.TaskFlow.models.Task;
import org.taskflow.TaskFlow.services.TaskService;

import java.time.LocalDateTime;

import static java.lang.String.format;

@Controller
@RequiredArgsConstructor
public class TaskController {

    private final TaskService taskService;

    @PostMapping("/addTask")
    public String addTask(Task task,
                          HttpSession session,
                          @RequestParam(value = "projectId", required = false) Long projectId) {
        if (session.getAttribute("currentUser") == null)
            return "redirect:";
        task.setDateTimeOfCreation(LocalDateTime.now());
        taskService.addTask(task);
        if (projectId != null)
            return format("redirect:/project?projectId=%d", projectId);
        else return "redirect:/listOfProjects";
    }

    @PostMapping("/deleteTask")
    public String deleteTask(@RequestParam("taskId") Long taskId,
                             HttpSession session) {
        if (session.getAttribute("currentUser") == null)
            return "redirect:";
        taskService.deleteTask(taskId);
        return "redirect:/listOfProjects";
    }

    @PostMapping("/updateTask")
    public String updateTask(Task task,
                             HttpSession session) {
        if (session.getAttribute("currentUser") == null)
            return "redirect:";
        taskService.updateTask(task);
        return "redirect:/listOfProjects";
    }

    @PostMapping("/closeTask")
    public String closeTask(@RequestParam("taskId") Long taskId,
                            HttpSession session) {
        if (session.getAttribute("currentUser") == null)
            return "redirect:";
        taskService.closeTaskById(taskId);
        return "redirect:/listOfProjects";
    }

    @PostMapping("/openTask")
    public String openTask(@RequestParam("taskId") Long taskId,
                           HttpSession session) {
        if (session.getAttribute("currentUser") == null)
            return "redirect:";
        taskService.openTaskById(taskId);
        return "redirect:/listOfProjects";
    }

    @GetMapping("/getChangeTaskForm")
    public String getForm(@RequestParam("taskId") Long taskId,
                          Model model) {
        model.addAttribute("task", taskService.getTaskById(taskId));
        return "generated/changeTaskForm";
    }
    /*
    @PostMapping("/updateTask")
    public String updateTask(Task task)
*/
    @GetMapping("/tasks")
    public String ignore() {
        return "redirect:";
    }
}
