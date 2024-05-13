package org.taskflow.TaskFlow.controllers;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.taskflow.TaskFlow.exceptions.IllegalEmailException;
import org.taskflow.TaskFlow.models.User;
import org.taskflow.TaskFlow.services.UserService;

import static org.taskflow.TaskFlow.security.PasswordHasher.hash;


@Controller
@RequiredArgsConstructor
public class UserController {

    private final UserService userService;

     /**
      * Мы не можем получить сразу юзера с представления,
      * т.к. password приходит в первоналальном виде
      */
    @PostMapping("/register")
    public String signIn(@RequestParam("username") String name,
                         @RequestParam("email") String email,
                         @RequestParam("password") String password,
                         RedirectAttributes attributes) {
        try {
            userService.add(new User(name, email, hash(password)));
        } catch (IllegalEmailException e) {
            attributes.addFlashAttribute("error", e.getMessage());
            return "redirect:";
        }
        attributes.addFlashAttribute("message",
                "Регистрация прошла успешно, можете выполнить вход.");
        return "redirect:";
    }

    @PostMapping("/login")
    public String logIn(@RequestParam("email") String email,
                        @RequestParam("password") String password,
                        HttpSession session,
                        RedirectAttributes attributes) {
        User user = userService.getUserByEmail(email);
        if (user == null) {
            attributes.addFlashAttribute("error", "Аккаунта с таким email не существует.");
            return "redirect:";
        } else if (!user.getHashOfPassword().equals(hash(password))) {
            attributes.addFlashAttribute("error", "Неверный пароль.");
            return "redirect:";
        } else {
            session.setAttribute("currentUser", user);
            return "redirect:/listOfProjects";
        }
    }

    @GetMapping("/logOut")
    public String logOut(HttpSession session) {
        session.setAttribute("currentUser", null);
        return "redirect:";
    }

    @GetMapping("/users")
    public String ignore() {
        return "redirect:";
    }

}
