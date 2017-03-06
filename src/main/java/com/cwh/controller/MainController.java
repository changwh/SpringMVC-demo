package com.cwh.controller;

import com.cnc.thirdparty.fastjson.JSON;
import com.cwh.model.Page;
import com.cwh.model.UserEntity;
import com.cwh.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
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
     * 查看所有用户页面
     * @param modelMap
     * @return
     */
    @RequestMapping(value = "/",method = RequestMethod.GET)
    public String getUsers(ModelMap modelMap){
        return "admin/users";
    }


    /**
     * 查看所有用户操作
     * @param page
     * @return
     */
    @RequestMapping(value = "/admin/usersP",method = RequestMethod.GET)
    public @ResponseBody String getUsersP(@ModelAttribute("page") Page page){
        Map<String,Object> map = new HashMap<String,Object>();

        //防止在其他页面调用查询全部用户时因未传入pageSize而报错
        int pageLimit;
        if (page.getLimit()!=0){
            pageLimit=page.getLimit();
        }else {
            pageLimit=9999999;
        }

        //分页查询user表中所有记录
        Pageable pageable=new PageRequest(page.getPageIndex(),pageLimit);
        org.springframework.data.domain.Page<UserEntity> userPage=userRepository.findAll(pageable);
        List<UserEntity> userL=userPage.getContent();
        long results=userRepository.count();

        map.put("rows",userL);
        map.put("results",results);
        String json=JSON.toJSONString(map,true);

        return json;
    }


    /**
     * post请求，处理添加用户请求
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


    /**
     * 删除用户操作
     * @param user
     * @return
     */
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



    //因为每页只有10个，所以可以试着构造一个id0-9的模型接收json
//    @RequestMapping(value = "/admin/users/deleteSelected",method = RequestMethod.POST)
//    public @ResponseBody String deleteUsersPost(@ModelAttribute("deleteSelected") String[] selectedUser){
//        System.out.println();
//        System.out.println(selectedUser[0]);
//        System.out.println();
////        for (int i=0;i<selectedUser.length;i++){
////            System.out.println(selectedUser[i].toString());
////        };
//        Map<String,Object> status=new  HashMap<String,Object>();
//        status.put("hasError","false");
//        String json=JSON.toJSONString(status,true);
//        return json;
//    }


    /**
     * 测试页面
     * @param modelMap
     * @return
     */
    @RequestMapping(value = "/test",method = RequestMethod.GET)
    public String test(ModelMap modelMap){
        return "test";
    }
}
