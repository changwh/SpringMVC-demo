package com.cwh.controller;

import com.cnc.thirdparty.fastjson.JSON;
import com.cnc.thirdparty.fastjson.JSONArray;
import com.cnc.thirdparty.fastjson.JSONObject;
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


    /**
     * 批量删除用户
     * @param test
     * @return
     */
    @RequestMapping(value = "/admin/users/deleteSelected",method = RequestMethod.POST)
    public @ResponseBody String deleteSelectedUsers(@RequestBody String test){
        JSONObject idList=JSON.parseObject(test);

        Map<String,Object> status=new  HashMap<String,Object>();
        List<Integer> errorList=new ArrayList<Integer>();
        status.put("noError",true);

        int temp=0;
        int length=0;

        for (int i=0;i<idList.size();i++){
            try {
                temp=(int)idList.get("id"+i);
                userRepository.delete(temp);
            }catch (Exception e){
                length++;
                status.remove("noError");
                errorList.add(temp);
            }
        }

        status.put("length",length);
        status.put("errorList",errorList);
        String json=JSON.toJSONString(status,true);
        return json;
    }


    /**
     * 性别数据页面
     * @return
     */
    @RequestMapping(value = "/admin/users/sexData",method = RequestMethod.GET)
    public String sexData(){
        return "admin/sexRatio";
    }


    /**
     * 获取性别数据
     * @return
     */
    @RequestMapping(value = "/admin/users/getSexData",method = RequestMethod.GET)
    public @ResponseBody String getSexData(){

        long maleNum=userRepository.getSexNum("男");
        long results=userRepository.count();
        long femaleNum=results-maleNum;

        float male=(float) maleNum/results*100;
        float female=(float)femaleNum/results*100;

        List<Object> maleList=new JSONArray();
        maleList.add('男');
        maleList.add(male);

        List<Object> femaleList=new JSONArray();
        femaleList.add('女');
        femaleList.add(female);

        List<Object> list=new JSONArray();
        list.add(maleList);
        list.add(femaleList);

        String json=JSON.toJSONString(list);
        System.out.println(json);

        return json;
    }


    /**
     * 年龄数据页面
     * @return
     */
    @RequestMapping(value = "/admin/users/ageData",method = RequestMethod.GET)
    public String ageData(){
        return "admin/ageDistribution";
    }


    /**
     * 获取年龄数据
     * @return
     */
    @RequestMapping(value = "/admin/users/getAgeData",method = RequestMethod.GET)
    public @ResponseBody String getAgeData(){

        //可使用存储过程减少数据库访问
        long male0=userRepository.getAgeNum("男",0,9);
        long male1=userRepository.getAgeNum("男",10,19);
        long male2=userRepository.getAgeNum("男",20,29);
        long male3=userRepository.getAgeNum("男",30,39);
        long male4=userRepository.getAgeNum("男",40,49);
        long male5=userRepository.getAgeNum("男",50,59);
        long male6=userRepository.getAgeNum("男",60,69);
        long male7=userRepository.getAgeNum("男",70,79);
        long male8=userRepository.getAgeNum("男",80,89);
        long male9=userRepository.getAgeNum("男",90,99);
        long male10=userRepository.getAgeNum("男",100,120);

        long female0=userRepository.getAgeNum("女",0,9);
        long female1=userRepository.getAgeNum("女",10,19);
        long female2=userRepository.getAgeNum("女",20,29);
        long female3=userRepository.getAgeNum("女",30,39);
        long female4=userRepository.getAgeNum("女",40,49);
        long female5=userRepository.getAgeNum("女",50,59);
        long female6=userRepository.getAgeNum("女",60,69);
        long female7=userRepository.getAgeNum("女",70,79);
        long female8=userRepository.getAgeNum("女",80,89);
        long female9=userRepository.getAgeNum("女",90,99);
        long female10=userRepository.getAgeNum("女",100,120);

        long all0=userRepository.getALLAgeNum(0,9);
        long all1=userRepository.getALLAgeNum(10,19);
        long all2=userRepository.getALLAgeNum(20,29);
        long all3=userRepository.getALLAgeNum(30,39);
        long all4=userRepository.getALLAgeNum(40,49);
        long all5=userRepository.getALLAgeNum(50,59);
        long all6=userRepository.getALLAgeNum(60,69);
        long all7=userRepository.getALLAgeNum(70,79);
        long all8=userRepository.getALLAgeNum(80,89);
        long all9=userRepository.getALLAgeNum(90,99);
        long all10=userRepository.getALLAgeNum(100,120);

        List<Object> data=new JSONArray();
        Map<String,Object> male=new HashMap<String,Object>();
        Map<String,Object> female=new HashMap<String,Object>();
        Map<String,Object> all=new HashMap<String,Object>();

        List<Object> maleL=new JSONArray();
        List<Object> femaleL=new JSONArray();
        List<Object> allL=new JSONArray();

        maleL.add(male0);
        maleL.add(male1);
        maleL.add(male2);
        maleL.add(male3);
        maleL.add(male4);
        maleL.add(male5);
        maleL.add(male6);
        maleL.add(male7);
        maleL.add(male8);
        maleL.add(male9);
        maleL.add(male10);

        male.put("name","男");
        male.put("data",maleL);

        data.add(male);

        femaleL.add(female0);
        femaleL.add(female1);
        femaleL.add(female2);
        femaleL.add(female3);
        femaleL.add(female4);
        femaleL.add(female5);
        femaleL.add(female6);
        femaleL.add(female7);
        femaleL.add(female8);
        femaleL.add(female9);
        femaleL.add(female10);

        female.put("name","女");
        female.put("data",femaleL);

        data.add(female);

        allL.add(all0);
        allL.add(all1);
        allL.add(all2);
        allL.add(all3);
        allL.add(all4);
        allL.add(all5);
        allL.add(all6);
        allL.add(all7);
        allL.add(all8);
        allL.add(all9);
        allL.add(all10);

        all.put("name","合计");
        all.put("data",allL);

        data.add(all);

        String json=JSON.toJSONString(data);
        return json;
    }


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
