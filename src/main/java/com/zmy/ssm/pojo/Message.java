package com.zmy.ssm.pojo;

import java.util.HashMap;
import java.util.Map;

/**
 * @author Sam  Email:superdouble@yeah.net
 * @Description     通用的返回类
 * @create 2022-04-21 21:38
 */
public class Message {

    // 100-成功  200-失败
    private int code;
    // 提示信息
    private String msg;
    // 用户要返回给浏览器的数据
    private Map<String,Object> extend = new HashMap<>();
    public static Message success(){
        Message result = new Message();
        result.setCode(100);
        result.setMsg("处理成功");
        return result;
    }
    public static Message fail(){
        Message result = new Message();
        result.setCode(200);
        result.setMsg("处理失败");
        return result;
    }
    public Message add(String key,Object value){
        this.getExtend().put(key,value);
        return this;
    }
    public int getCode() {
        return code;
    }
    public void setCode(int code) {
        this.code = code;
    }
    public String getMsg() {
        return msg;
    }
    public void setMsg(String msg) {
        this.msg = msg;
    }
    public Map<String, Object> getExtend() {
        return extend;
    }
    public void setExtend(Map<String, Object> extend) {
        this.extend = extend;
    }
}
