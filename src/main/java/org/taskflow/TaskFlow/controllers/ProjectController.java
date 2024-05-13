package org.taskflow.TaskFlow.controllers;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.taskflow.TaskFlow.models.Project;
import org.taskflow.TaskFlow.models.ProjectList;
import org.taskflow.TaskFlow.models.Task;
import org.taskflow.TaskFlow.models.User;
import org.taskflow.TaskFlow.services.ProjectService;
import org.taskflow.TaskFlow.services.TaskService;

import java.util.List;
@Controller
@RequiredArgsConstructor
public class ProjectController {

    private final ProjectService projectService;
    private final TaskService taskService;

    @GetMapping("/listOfProjects")
    public String getAllProjects(HttpSession session,
                                 Model model) {
        if (session.getAttribute("currentUser") == null) return "redirect:/";
        Long userId = ((User) session.getAttribute("currentUser")).getId();

        ProjectList projectList = projectService.getProjectsByUserId(userId);
        List<Task> taskList = taskService.getTasksByUserId(userId);
        model.addAttribute("projectList", projectList);
        model.addAttribute("taskList", taskList);
        model.addAttribute("project", null);

        return "todo";
    }

    @GetMapping("/getProjectTasks")
    public String getProjectTasks(@RequestParam(value = "currentProjectId", required = false) Long projectId,
                                  HttpSession session,
                                  Model model) {

        if (projectId == null) return "redirect:/listOfProjects";
        if (session.getAttribute("currentUser") == null) return "redirect:/";

        model.addAttribute("project", projectService.getProjectById(projectId).orElse(null));
        model.addAttribute("projectName", projectService.getNameOfProjectById(projectId));
        model.addAttribute("taskList", taskService.getTasksByProjectId(projectId));

        return "generated/generateTaskList";
    }

    @PostMapping("/addProject")
    public String addProject(@RequestParam("projectName") String projectName,
                             HttpSession session) {
        Project project = new Project(projectName,
                (User) session.getAttribute("currentUser"));
        projectService.addProject(project);
        return "redirect:/listOfProjects";
    }

    @GetMapping("/projects")
    public String ignore() {
        return "redirect:";
    }

}
