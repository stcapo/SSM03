/*
package com.xuchen.config;


import com.xuchen.mapper.UserMapper;
import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import javax.sql.DataSource;

@Configuration
@MapperScan({"com.xuchen.mapper"})
public class SpringConfiguration {
*/
/*
    @Autowired
    DataSource ds;
*//*

    @Autowired
    SqlSessionFactory ssf;

    */
/*@Bean
    public DataSource getDataSource(){
        DruidDataSource ds = new DruidDataSource();
        ds.setDriverClassName("com.mysql.jdbc.Driver");
        ds.setUrl("jdbc:mysql://localhost:3306/ssm");
        ds.setUsername("root");
        ds.setPassword("3306");
        return ds;
    }*//*


    @Bean
    public SqlSessionFactory getSqlSession() throws Exception{
        SqlSessionFactoryBean sqlSessionFactoryBean = new SqlSessionFactoryBean();
        sqlSessionFactoryBean.setDataSource(ds);
        return sqlSessionFactoryBean.getObject();
    }

    @Bean
    public UserMapper getUserMapper() throws Exception {
        SqlSessionTemplate sqlSessionTemplate = new SqlSessionTemplate(ssf);
        return sqlSessionTemplate.getMapper(UserMapper.class);
    }
}
*/
