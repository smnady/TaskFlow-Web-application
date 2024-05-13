package org.taskflow.TaskFlow.enums;

public enum Condition {
    SOLVED("Решена"),
    UNRESOLVED("Не решена");

    private final String description;

    Condition(String description) {
        this.description = description;
    }

    public String getDescription() {
        return description;
    }
}
