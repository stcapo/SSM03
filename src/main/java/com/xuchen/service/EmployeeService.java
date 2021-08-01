package com.xuchen.service;

import com.xuchen.dao.EmployeeMapper;
import com.xuchen.domain.Employee;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class EmployeeService {
    @Autowired
    EmployeeMapper em;
    public List<Employee> getAll() {
        return em.selectByExample(null);
    }
}
