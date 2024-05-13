package org.taskflow.TaskFlow.models;

import lombok.AllArgsConstructor;
import lombok.Data;
import org.taskflow.TaskFlow.projections.ProjectProjection;

import java.util.Collection;
import java.util.List;

@Data
@AllArgsConstructor
public class ProjectList {

    private List<ProjectProjection> projects;

    /*public Project getProjectById(Long id) {
        if (projects == null)
            return null;
        return projects.stream()
                .filter(p -> p.getId().equals(id))
                .findFirst().orElse(null);
    }*/

    /*public List<Task> getAllTasks() {
        if (projects == null) return null;
        return projects.stream()
                .map(Project::getTaskList)
                .flatMap(Collection::stream)
                .sorted().toList();
    }*/
}
