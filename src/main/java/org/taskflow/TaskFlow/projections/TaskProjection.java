package org.taskflow.TaskFlow.projections;

public interface TaskProjection {

    Long getId();

    String getName();

    default TaskProjection create(Long id, String name) {
        return new TaskProjection() {
            @Override
            public Long getId() {
                return id;
            }

            @Override
            public String getName() {
                return name;
            }
        };
    }
}
