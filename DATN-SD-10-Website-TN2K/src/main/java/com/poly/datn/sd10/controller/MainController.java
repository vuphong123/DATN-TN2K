package com.poly.datn.sd10.controller;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller

public class MainController {

    @GetMapping("/pages")
    public String showPage(@RequestParam(name = "page", required = false, defaultValue = "home") String page, Model model) {
        model.addAttribute("page", page); // Chuyển tên trang JSP đến layout.jsp
        return "layout"; // layout.jsp sẽ giữ nguyên sidebar và chỉ thay đổi nội dung
    }
    }
