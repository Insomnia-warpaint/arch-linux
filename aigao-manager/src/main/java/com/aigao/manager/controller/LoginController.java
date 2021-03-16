package com.aigao.manager.controller;

import com.aigao.manager.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

/**
 * @author insomnia
 * @date 2021/3/14 上午1:22
 * @effect
 */
@Controller
public class LoginController {

    @Autowired
    EmployeeService employeeService;

    @GetMapping({"/","/login"})
    public String index() {
        return "index";
    }
}
