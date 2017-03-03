package com.cwh.controller;

import com.cnc.thirdparty.fastjson.JSON;
import com.cnc.thirdparty.fastjson.serializer.SimplePropertyPreFilter;
import com.cwh.model.UserEntity;
import com.cwh.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import java.util.*;

/**
 * Created by changwh1 on 2017/2/16.
 */
@Controller
public class MainController {
    @Autowired
    UserRepository userRepository;

    /**
     * 查看所有用户
     * @param modelMap
     * @return
     */
    @RequestMapping(value = "/",method = RequestMethod.GET)
    public String getUsers(ModelMap modelMap){
        return "admin/users";
    }




    @RequestMapping(value = "/admin/usersP",method = RequestMethod.GET)
    public @ResponseBody String getUsersP(ModelMap modelMap){
        //查询user表中所有记录
        Map<String,Object> map = new HashMap<String,Object>();
        List<UserEntity> userList=userRepository.findAll();
        SimplePropertyPreFilter fliter=new SimplePropertyPreFilter(UserEntity.class,"id","name","sex","age");
        String user= JSON.toJSONString(userList,fliter);
        List<Object> userL=JSON.parseArray(user,Object.class);
        long results=userRepository.count();

        map.put("rows",userL);
        map.put("results",results);

        String json=JSON.toJSONString(map,true);

//        System.out.println(json);
        return json;
    }

    @RequestMapping(value = "/test",method = RequestMethod.GET)
    public String test(ModelMap modelMap){
        return "test";
    }


    /**
     * post请求，处理添加用户请求，并重定向到用户管理页面
     * @param userEntity
     * @return
     */
    @RequestMapping(value = "/admin/users/addP",method = RequestMethod.POST)
    public @ResponseBody String addUserPost(@ModelAttribute("user") UserEntity userEntity){

        //数据库中添加一个用户，并立即刷新缓存
        userRepository.saveAndFlush(userEntity);

        Map<String,Object> status=new HashMap<String,Object>();
        status.put("status",302);
        status.put("location","/admin/users");
        String json=JSON.toJSONString(status,true);
        return json;
    }



    /**
     * 更新用户信息操作
     * @param user
     * @return
     */
    @RequestMapping(value = "/admin/users/updateP",method = RequestMethod.POST)
    public String updateUserPost(@ModelAttribute("userP")UserEntity user){
        //更新用户信息操作
        userRepository.updateUser(user.getName(),user.getSex(),user.getAge(),user.getId());
        //刷新缓冲区
        userRepository.flush();
        return "redirect:/";
    }



    @RequestMapping(value = "/admin/users/deleteP",method = RequestMethod.POST)
    public @ResponseBody String deleteUserPost(@ModelAttribute("deleteP") UserEntity user){

        Map<String,Object> status=new HashMap<String,Object>();

        status.put("hasError","false");
        try {
            //删除id为userId的用户
            userRepository.delete(user.getId());
            //立即刷新
            userRepository.flush();
        }catch (Exception e){
            status.remove("hasError");
            status.put("hasError","true");
            status.put("error","删除失败");
        }

        String json=JSON.toJSONString(status,true);


        return json;
    }

    @RequestMapping(value = "/admin/test",method = RequestMethod.GET)
    public String test(){
        return "/admin/test";
    }
}
