package com.poly.datn.sd10.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class test {
    @GetMapping()
    public String get(){
        return "home";
    }
}
