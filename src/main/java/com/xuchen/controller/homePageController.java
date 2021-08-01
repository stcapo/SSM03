package com.xuchen.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.xuchen.bean.Msg;
import com.xuchen.domain.Employee;
import com.xuchen.service.EmployeeService;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;


import java.util.Arrays;
import java.util.List;

import static junit.framework.TestCase.assertEquals;


@Controller
public class homePageController {
    @Autowired
    EmployeeService es;
    @Autowired
    SqlSession ss;


    @RequestMapping("/emp")
    @ResponseBody
    /*我们希望返回一个对象带有所有我们想要的参数包括: 响应状态码等等, 我们可以封装一个对象来实现*/
    public Msg AjaxController(@RequestParam(name = "pn",defaultValue = "1") Integer pn,
                              @RequestParam(name = "ps",defaultValue = "10")Integer ps){
        PageHelper.startPage(pn, ps);
        List<Employee> all = es.getAll();
        PageInfo<Employee> pi = new PageInfo<Employee>(all,5);
        return new Msg().success().add("pi",pi);
    }




    /*@RequestMapping("/emp")
    public String homePageAccess(Model model,
                                 @RequestParam(name = "pn",defaultValue = "1") Integer pn,
                                 @RequestParam(name = "ps",defaultValue = "10")Integer ps){
        PageHelper.startPage(pn, ps);
        List<Employee> all = es.getAll();
        PageInfo<Employee> pi = new PageInfo<Employee>(all,5);
        model.addAttribute("pi",pi);
        return "homePage";
    }*/
}
