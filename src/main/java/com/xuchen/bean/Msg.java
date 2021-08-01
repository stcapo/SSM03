package com.xuchen.bean;

import com.github.pagehelper.PageInfo;
import com.xuchen.domain.Employee;

import java.util.HashMap;
import java.util.Map;

public class Msg {
    /*响应状态码*/
    int statusCode;

    String status;

    Map<String, PageInfo<Employee>> map = new HashMap<>();

    public Msg(int statusCode, String status, Map<String, PageInfo<Employee>> map) {
        this.statusCode = statusCode;
        this.status = status;
    }

    public Msg() {
    }


    /*定义一些方法实现封装*/
    // 成功的链式反应
    public Msg success(){
        Msg msg = new Msg();
        msg.setStatusCode(200);
        msg.setStatus("success");
        return msg;
    }
    // 失败的链式反应
    public Msg fail(){
        Msg msg = new Msg();
        msg.setStatusCode(300);
        msg.setStatus("failed");
        return msg;
    }
    // add链式反应
    public Msg add(String s,PageInfo<Employee> pi){
        this.map.put(s,pi);
        return this;
    }











    public int getStatusCode() {
        return statusCode;
    }

    public void setStatusCode(int statusCode) {
        this.statusCode = statusCode;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Map<String, PageInfo<Employee>> getMap() {
        return map;
    }

    public void setMap(Map<String, PageInfo<Employee>> map) {
        this.map = map;
    }

    @Override
    public String toString() {
        return "Msg{" +
                "statusCode=" + statusCode +
                ", status='" + status + '\'' +
                ", map=" + map +
                '}';
    }
}
