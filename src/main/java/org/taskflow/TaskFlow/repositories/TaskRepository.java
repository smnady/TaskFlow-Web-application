package org.taskflow.TaskFlow.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.taskflow.TaskFlow.models.Task;
import org.taskflow.TaskFlow.projections.TaskProjection;

import java.time.LocalDateTime;
import java.util.List;

@Repository
public interface TaskRepository extends JpaRepository<Task, Long> {

    @Query("SELECT t FROM Task t WHERE t.project.id = :projectId ORDER BY t.dateTimeOfCreation")
    List<Task> getTasksByProjectId(@Param("projectId") Long projectId);

    @Query("SELECT t FROM Task t WHERE t.project.user.id = :userId ORDER BY t.dateTimeOfCreation")
    List<Task> getTasksByUserId(@Param("userId") Long userId);

    Task findTaskById(Long taskId);
    List<Task> findAllByProjectId(Long projectId);

    @Modifying
    @Query("update Task t set t.condition = 'SOLVED', t.dateTimeOfClosing = :dateTime where t.id = :id")
    void closeTaskById(@Param("id") Long taskId,
                       @Param("dateTime") LocalDateTime dateTime);

    @Modifying
    @Query("update Task t set t.condition = 'UNRESOLVED', t.dateTimeOfClosing = null where t.id = :id")
    void openTaskById(@Param("id") Long taskId);
}
