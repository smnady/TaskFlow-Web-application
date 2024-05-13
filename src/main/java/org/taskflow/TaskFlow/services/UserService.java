package org.taskflow.TaskFlow.services;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.taskflow.TaskFlow.exceptions.IllegalEmailException;
import org.taskflow.TaskFlow.models.User;
import org.taskflow.TaskFlow.repositories.UserRepository;

import java.util.Optional;

@Service
@Slf4j
@RequiredArgsConstructor
public class UserService {

    private final UserRepository userRepository;

    public void add(User user) throws IllegalEmailException  {
        if (userRepository.findByEmail(user.getEmail()) != null) {
            throw new IllegalEmailException();
        }
        log.info("Saving user {}", user);
        userRepository.save(user);
    }

    public User getUserByEmail(String email) {
        return userRepository.findByEmail(email);
    }

    public void deleteUser(Long userId) {
        userRepository.deleteById(userId);
    }
}
