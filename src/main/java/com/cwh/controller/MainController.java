package com.cwh.controller;

import com.cwh.model.UserEntity;
import com.cwh.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import java.util.List;

/**
 * Created by changwh1 on 2017/2/16.
 */
@Controller
public class MainController {
    @Autowired
    UserRepository userRepository;
    @RequestMapping(value = "/",method = RequestMethod.GET)
    public String index(){
        return "index";
    }
        @RequestMapping(value = "/admin/users",method = RequestMethod.GET)
    public String getUsers(ModelMap modelMap){
//        查询user表中所有记录
        List<UserEntity> userList=userRepository.findAll();
//        将所有记录传递给要返回的jsp页面，放在userList当中
        modelMap.addAttribute("userList",userList);
//        返回pages目录下的admin/users.jsp页面
        return "admin/users";
    }

//    get请求，访问添加用户界面
    @RequestMapping(value = "/admin/users/add",method = RequestMethod.GET)
    public String addUser(){
//        转到admin/addUser.jsp页面
        return "admin/addUser";
    }

//    post请求，处理添加用户请求，并重定向到用户管理页面
    @RequestMapping(value = "/admin/users/addP",method = RequestMethod.POST)
    public String addUserPost(@ModelAttribute("user") UserEntity userEntity){

//        数据库中添加一个用户，并立即刷新缓存
        userRepository.saveAndFlush(userEntity);

//        重定向到用户管理页面，方法为redirect:url
        return "redirect:/admin/users";
    }

//    get请求，查看用户详情
    @RequestMapping(value = "/admin/users/show/{id}",method = RequestMethod.GET)
    public String showUser(@PathVariable("id") int userId,ModelMap modelMap){
//        找到userId所表示的用户
        UserEntity userEntity=userRepository.findOne(userId);

//        传递给请求页面
        modelMap.addAttribute("user",userEntity);
        return "admin/userDetail";
    }

//    更新用户信息页面
    @RequestMapping(value = "/admin/users/update/{id}",method = RequestMethod.GET)
    public String updateUser(@PathVariable("id")int userId,ModelMap modelMap){
//        找到userId所表示的用户
        UserEntity userEntity=userRepository.findOne(userId);

//        传递给请求页面
        modelMap.addAttribute("user",userEntity);
        return "admin/updateUser";
    }

//    更新用户信息操作
    @RequestMapping(value = "/admin/users/updateP",method = RequestMethod.POST)
    public String updateUserPost(@ModelAttribute("userP")UserEntity user){
//        更新用户信息操作
        userRepository.updateUser(user.getName(),user.getSex(),user.getAge(),user.getId());
//        刷新缓冲区
        userRepository.flush();
        return "redirect:/admin/users";
    }

//    删除用户
    @RequestMapping(value = "/admin/users/delete/{id}",method = RequestMethod.GET)
    public String deleteUser(@PathVariable("id")int userId){
//        删除id为userId的用户
        userRepository.delete(userId);
//        立即刷新
        userRepository.flush();
        return "redirect:/admin/users";
    }
}
