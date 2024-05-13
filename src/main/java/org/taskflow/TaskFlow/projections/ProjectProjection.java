package org.taskflow.TaskFlow.projections;

public interface ProjectProjection {

    Long getId();

    String getName();

    default ProjectProjection create(Long id, String name) {
        return new ProjectProjection() {
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
