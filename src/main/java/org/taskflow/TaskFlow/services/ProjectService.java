package org.taskflow.TaskFlow.services;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.taskflow.TaskFlow.models.Project;
import org.taskflow.TaskFlow.models.ProjectList;
import org.taskflow.TaskFlow.repositories.ProjectRepository;

import java.util.List;
import java.util.Optional;

@Service
@Slf4j
@RequiredArgsConstructor
public class ProjectService {

    private final ProjectRepository projectRepository;

    public ProjectList getProjectsByUserId(Long userId) {
        log.info("Receiving ProjectList by userId = {}", userId);
        return new ProjectList(projectRepository.findProjectIdAndNameByUserId(userId));
    }

    public Optional<Project> getProjectById(Long projectId) {
        log.info("Receiving project by projectId = {}", projectId);
        if (projectId == null) return Optional.empty();
        return projectRepository.findById(projectId);
    }

    public void addProject(Project project) {
        log.info("Saving new project {}", project);
        projectRepository.save(project);
    }

    public String getNameOfProjectById(Long projectId) {
        log.info("Getting name of project, projectId = {}", projectId);
        return projectRepository.getNameByProjectId(projectId);
    }

}
