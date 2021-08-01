package test;

import com.github.pagehelper.PageInfo;
import com.xuchen.domain.Employee;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringJUnitConfig;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.RequestBuilder;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations = {"classpath:applicationContext.xml","file:src/main/webapp/WEB-INF/dispatcherServlet-servlet.xml"})
public class MvcTest {
    MockMvc mockMvc;

    @Autowired
    WebApplicationContext webApplicationContext;
    @Before
    public void initMockMvc() throws Exception{
        mockMvc = MockMvcBuilders.webAppContextSetup(webApplicationContext).build();
    }

    @Test
    public void test() throws Exception {
//        发送请求: perform: 运行 : 需要建立请求参数
        MvcResult result = mockMvc.perform(MockMvcRequestBuilders.get("/emp").param("pn","3").param("ps","5")).andReturn();
        MockHttpServletRequest request = result.getRequest();
        PageInfo<Employee> pi = (PageInfo<Employee>) request.getAttribute("pi");
        System.out.println("当前页码:"+pi.getPageNum());
        System.out.println("总页码:"+pi.getPages());
        System.out.println("总记录数"+pi.getTotal());

        pi.getList().forEach(System.out::println);
    }
}
