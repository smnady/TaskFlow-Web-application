package org.taskflow.TaskFlow.enums;

public enum Priority {
    HIGH("Высокий"),
    MEDIUM("Средний"),
    LOW("Низкий"),
    DEFAULT("Без приоритета");

    private final String description;

    Priority(String description) {
        this.description = description;
    }

    public String getDescription() {
        return description;
    }
}

