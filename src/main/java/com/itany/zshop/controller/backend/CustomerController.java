package com.itany.zshop.controller.backend;

import com.itany.zshop.service.CustomerService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/backend/customer")
public class CustomerController {

    @Resource
    private CustomerService customerService;

    @RequestMapping("/findAll")
    public String findAll() {
        return "backend/customerManager";
    }

    @RequestMapping("/checkLoginName")
    @ResponseBody
    public Map<String, Object> checkLoginName(String loginName) {
        Map<String, Object> map = new HashMap<>();
        map.put("valid", customerService.checkLoginName(loginName));
        return map;
    }

}
