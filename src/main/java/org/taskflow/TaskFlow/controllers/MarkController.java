package org.taskflow.TaskFlow.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MarkController {

    @GetMapping("/marks")
    public String ignore() {
        return "redirect:";
    }
}
