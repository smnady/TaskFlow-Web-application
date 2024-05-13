package org.taskflow.TaskFlow.models;

import jakarta.persistence.*;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.taskflow.TaskFlow.enums.Condition;
import org.taskflow.TaskFlow.enums.Priority;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Objects;
import java.util.Set;

@Entity
@Table(name = "task")
@Data
@NoArgsConstructor
public class Task implements Comparable<Task> {

    /**
     * id генерируется на стороне БД
     */
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "name", nullable = false)
    private String name;

    @ManyToOne
    @JoinColumn(name = "user_id", referencedColumnName = "id", nullable = false)
    private Project project;

    @Enumerated(EnumType.STRING)
    private Condition condition = Condition.UNRESOLVED;

    /**
     * dataTimeOfCreation инизиализируется при создании, хранит дату и время создания задачи.
     */

    @Column(name = "date_of_creation", nullable = false)
    private LocalDateTime dateTimeOfCreation;

    /**
     * dateTimeOfClosing хранит дату выполнения задачи, может изменяться
     */

    @Column(name = "date_of_closing")
    private LocalDateTime dateTimeOfClosing;

    /**
     * Переменная, хранящая дедлайн. Важно помнить, что это не обязательное поле,
     * и делать проверки, что он не равен null
     */

    @Column(name = "deadline")
    private LocalDateTime deadline;

    @ManyToMany
    @JoinTable(
            name = "project_task",
            joinColumns = @JoinColumn(name = "project_id"),
            inverseJoinColumns = @JoinColumn(name = "mark_id")
    )
    private Set<Mark> marks;

    @Enumerated(EnumType.STRING)
    private Priority priority = Priority.DEFAULT;

    @Column(name = "description", columnDefinition = "text")
    private String description;

    private final static DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH:mm dd MMMM yyyy");

    /**
     * конструктор
     * @param name название задачи
     * @param project проект, к которому относится задача
     */

    public Task(String name, Project project) {
        this.name = name;
        this.project = project;
        this.dateTimeOfCreation = LocalDateTime.now();
    }
    public void close() {
        if (condition == Condition.UNRESOLVED) {
            condition = Condition.SOLVED;
            dateTimeOfClosing = LocalDateTime.now();
        }
    }
    public String getDateOfCreationRepresentation() {
        return formatter.format(dateTimeOfCreation);
    }

    public String getDateOfClosingRepresentation() {
        if (dateTimeOfClosing == null)
            return "-";
        return formatter.format(dateTimeOfClosing);
    }

    public String getDeadlineRepresentation() {
        if (deadline == null)
            return "Не установлен";
        return formatter.format(deadline);
    }

    public String getDescription() {
        return description == null ? "Описание отсутствует" : description;
    }

    public boolean isSolved() {
        return condition.equals(Condition.SOLVED);
    }
    public void addMark(Mark mark) {
        marks.add(mark);
    }

    public void removeMark(Mark mark) {
        marks.remove(mark);
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Task task = (Task) o;
        return Objects.equals(id, task.id);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id);
    }

    @Override
    public String toString() {
        return "Task{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", project=" + project +
                ", condition=" + condition +
                '}';
    }

    @Override
    public int compareTo(Task o) {
        return dateTimeOfCreation.compareTo(o.dateTimeOfCreation);
    }
}