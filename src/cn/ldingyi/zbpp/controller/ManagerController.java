package cn.ldingyi.zbpp.controller;

import org.springframework.context.ApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

@Controller
public class ManagerController {




    @RequestMapping("pay")
    public String intoSignIn(HttpServletRequest request, Model model){

        return "pay";

    }
}
