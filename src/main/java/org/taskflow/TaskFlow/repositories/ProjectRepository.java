package org.taskflow.TaskFlow.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.taskflow.TaskFlow.models.Project;
import org.taskflow.TaskFlow.projections.ProjectProjection;

import java.util.List;

@Repository
public interface ProjectRepository extends JpaRepository<Project, Long> {

    List<Project> findAllByUserId(Long userId);

    @Query("SELECT p.name FROM Project p WHERE p.id = :projectId")
    String getNameByProjectId(@Param("projectId") Long projectId);

    @Query("SELECT p.id AS id, p.name AS name FROM Project p WHERE p.user.id = :userId")
    List<ProjectProjection> findProjectIdAndNameByUserId(@Param("userId") Long userId);

}
