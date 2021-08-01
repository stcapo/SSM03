package test;

import com.xuchen.dao.EmployeeMapper;
import com.xuchen.domain.Employee;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import java.util.UUID;

public class Test {

    @org.junit.Test
    public void select(){
        
    }

    /*@org.junit.Test
    public void insert(){
        EmployeeMapper em = new ClassPathXmlApplicationContext("applicationContext.xml").getBean(EmployeeMapper.class);
        for (int i=10;i<100;i++){
            UUID uuid = UUID.randomUUID();
            Employee e = new Employee();
            e.setEmployeename(uuid.toString().substring(0,5));
            e.setWorkyears(i);
            e.setDepartmentid(3);
            em.insert(e);
        }
    }*/




}
