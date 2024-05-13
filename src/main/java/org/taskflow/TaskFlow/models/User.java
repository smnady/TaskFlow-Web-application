package org.taskflow.TaskFlow.models;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

@Entity
@Table(name = "users")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @Column(name = "name", nullable = false)
    private String name;
    @Column(name = "email", nullable = false, unique = true)
    private String email;
    @Column(name = "hash_of_password", nullable = false)
    private String hashOfPassword;

    @OneToMany(mappedBy = "user")
    private List<Project> projectList;

    public User(long id, String name, String email, String hashOfPassword) {
        this.id = id;
        this.name = name;
        this.email = email;
        this.hashOfPassword = hashOfPassword;
    }

    public User(String name, String email, String hashOfPassword) {
        this.name = name;
        this.email = email;
        this.hashOfPassword = hashOfPassword;
    }

    public void addProject(Project project) {
        if(this.getProjectList() == null)
            projectList = new ArrayList<>();
        projectList.add(project);
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        User user = (User) o;
        return Objects.equals(id, user.id);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id);
    }

    @Override
    public String toString() {
        return "User{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", email='" + email + '\'' +
                '}';
    }
}
