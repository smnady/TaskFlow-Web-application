package org.taskflow.TaskFlow.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import org.taskflow.TaskFlow.models.Mark;

@Repository
public interface MarkRepository extends JpaRepository<Mark, Long> {

}
