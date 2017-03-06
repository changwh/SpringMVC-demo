package com.cwh.controller;

import com.cnc.thirdparty.fastjson.JSON;
import com.cnc.thirdparty.fastjson.JSONArray;
import com.cnc.thirdparty.fastjson.JSONObject;
import com.cnc.thirdparty.fastjson.serializer.SimplePropertyPreFilter;
import com.cnc.thirdparty.zookeeper.version.Info;
import com.cwh.model.InfoEntity;
import com.cwh.model.ReturnJson;
import com.cwh.model.UserEntity;
import com.cwh.repository.InfoRepository;
import com.cwh.repository.UserRepository;
import com.sun.org.apache.bcel.internal.generic.IFNONNULL;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by changwh1 on 2017/2/16.
 */
@Controller
public class InfoController {
    @Autowired
    InfoRepository infoRepository;

    @Autowired
    UserRepository userRepository;

    /**
     * 查看所有信息
     * @param modelMap
     * @return
     */
    @RequestMapping(value = "/admin/info",method = RequestMethod.GET)
    public String getInfo(ModelMap modelMap){
    //        List<InfoEntity> infoList=infoRepository.findAll();
    //        List<UserEntity>userList=userRepository.findAll();
    //        modelMap.addAttribute("userList",userList);
    //        modelMap.addAttribute("infoList",infoList);
        return "admin/info";
    }


    @RequestMapping(value = "/admin/infoP",method = RequestMethod.GET)
    public @ResponseBody String getInfoP(ModelMap modelMap){
        //查询user表中所有记录
        Map<String,Object> map = new HashMap<String,Object>();

//        List<UserEntity> userList=userRepository.findAll();
        List<InfoEntity> infoList=infoRepository.findAll();

//        SimplePropertyPreFilter fliterUser=new SimplePropertyPreFilter(UserEntity.class,"id","name","sex","age");
        SimplePropertyPreFilter fliterInfo=new SimplePropertyPreFilter(InfoEntity.class,"id","userByUserId","phone","address","email","mobile");

//        String user= JSON.toJSONString(userList,fliterUser);
        String info=JSON.toJSONString(infoList,fliterInfo);

//        System.out.println("json:");
//        System.out.println(info);

        JSONArray jsonArray=JSON.parseArray(info);
//        System.out.println("size of jsonArray:"+jsonArray.size());
//        System.out.println();
//        System.out.println(info);
        for(int i = 0 ;i<jsonArray.size();i++) {
            JSONObject userObj=jsonArray.getJSONObject(i).getJSONObject("userByUserId");
            String userName=userObj.getString("name");
            String userId=userObj.getString("id");
            {
                jsonArray.getJSONObject(i).put("userName",userName);
                jsonArray.getJSONObject(i).put("userId",userId);
            }
        }

//        System.out.println(jsonArray.toJSONString());

//        List<Object> userL=JSON.parseArray(user,Object.class);
//        List<Object> infoL=JSON.parseArray(info,Object.class);

        long results=infoRepository.count();

//        map.put("result",true);
//        map.put("users",userL);
        map.put("rows",jsonArray);
        map.put("results",results);

        String json=JSON.toJSONString(map,true);

//        System.out.println(json);
        return json;
    }



//    /**
//     * 添加信息操作
//     * @param infoEntity
//     * @return
//     */
    @RequestMapping(value = "/admin/info/addP",method = RequestMethod.POST)
    public @ResponseBody String addInfoPost(@ModelAttribute("info") ReturnJson returnJson){
//        infoRepository.saveAndFlush(infoEntity);
//        infoRepository.saveAndFlush(returnJson);

        UserEntity user=userRepository.findOne(returnJson.getUserId());

        InfoEntity info=new InfoEntity();

        info.setAddress(returnJson.getAddress());
        info.setEmail(returnJson.getEmail());
        info.setMobile(returnJson.getMobile());
        info.setPhone(returnJson.getPhone());
        info.setUserByUserId(user);

        infoRepository.saveAndFlush(info);


//        System.out.println(returnJson.toString());

        Map<String,Object> status=new HashMap<String,Object>();
        status.put("status",302);
        status.put("location","/admin/users");
        String json=JSON.toJSONString(status,true);
        return json;
    }


    @RequestMapping(value = "/admin/info/show",method = RequestMethod.POST)
    public @ResponseBody String showInfo(@ModelAttribute("show") ReturnJson returnJson){
//        InfoEntity info=infoRepository.findOne(id);
//        modelMap.addAttribute("info",info);

//        System.out.println();
//        System.out.println("UserId:"+returnJson.getUserId());
//        System.out.println("InfoId:"+returnJson.getId());
//        System.out.println();
        Map<String,Object> detail=new HashMap<String,Object>();

        try {
            InfoEntity info=infoRepository.findOne(returnJson.getId());
//        System.out.println("name:"+info.getUserByUserId().getName());
//        System.out.println("sex:"+info.getUserByUserId().getSex());
//        System.out.println("age:"+info.getUserByUserId().getAge());
//        System.out.println("phone:"+info.getPhone());
//        System.out.println("address:"+info.getAddress());
//        System.out.println("email:"+info.getEmail());
//        System.out.println("mobile:"+info.getMobile());
            detail.put("name",info.getUserByUserId().getName());
            detail.put("sex",info.getUserByUserId().getSex());
            detail.put("age",info.getUserByUserId().getAge());
            detail.put("phone",info.getPhone());
            detail.put("address",info.getAddress());
            detail.put("email",info.getEmail());
            detail.put("mobile",info.getMobile());
        }catch (Exception e){
            detail.put("hasError",true);
        }

        String json=JSON.toJSONString(detail);
        return json;
    }

//    /**
//     * 访问修改信息页面
//     * @param id
//     * @param modelMap
//     * @return
//     */
//    @RequestMapping(value = "/admin/info/update/{id}",method = RequestMethod.GET)
//    public String updateInfo(@PathVariable("id") int id,ModelMap modelMap){
//        InfoEntity info=infoRepository.findOne(id);
//        List<UserEntity> userList=userRepository.findAll();
//        modelMap.addAttribute("info",info);
//        modelMap.addAttribute("userList",userList);
//        return "admin/updateInfo";
//    }

    /**
     * 修改信息操作
     * @param returnJson
     * @return
     */
    @RequestMapping(value = "/admin/info/updateP",method = RequestMethod.POST)
    public String updateInfoP(@ModelAttribute("infoP") ReturnJson returnJson){
        //更新信息
        infoRepository.updateInfo(returnJson.getPhone(),returnJson.getAddress(),returnJson.getEmail(),returnJson.getMobile(),returnJson.getUserId(),returnJson.getId());
        infoRepository.flush();
        return "redirect:/admin/info";
    }

//    /**
//     * 删除信息
//     * @param id
//     * @return
//     */
//    @RequestMapping(value = "/admin/info/delete/{id}")
//    public String deleteInfo(@PathVariable("id") int id){
//        infoRepository.delete(id);
//        infoRepository.flush();
//        return "redirect:/admin/info";
//    }

    @RequestMapping(value = "/admin/info/deleteP",method = RequestMethod.POST)
    public @ResponseBody String deleteInfoPost(@ModelAttribute("deleteP") ReturnJson returnJson){

        Map<String,Object> status=new HashMap<String,Object>();

        status.put("hasError","false");
        try {
            //删除id为infoId的信息
            infoRepository.delete(returnJson.getId());
            //立即刷新
            infoRepository.flush();
        }catch (Exception e){
            status.remove("hasError");
            status.put("hasError","true");
            status.put("error","删除失败");
        }

        String json=JSON.toJSONString(status,true);

        return json;
    }
}

