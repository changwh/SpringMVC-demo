package com.cwh.controller;

import com.cnc.thirdparty.fastjson.JSON;
import com.cnc.thirdparty.fastjson.JSONArray;
import com.cnc.thirdparty.fastjson.JSONObject;
import com.cnc.thirdparty.fastjson.serializer.SimplePropertyPreFilter;
import com.cwh.model.InfoEntity;
import com.cwh.model.ReturnJson;
import com.cwh.model.UserEntity;
import com.cwh.repository.InfoRepository;
import com.cwh.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

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
    public String showInfo(ModelMap modelMap){
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

        List<UserEntity> userList=userRepository.findAll();
        List<InfoEntity> infoList=infoRepository.findAll();

//        SimplePropertyPreFilter fliterUser=new SimplePropertyPreFilter(UserEntity.class,"id","name","sex","age");
        SimplePropertyPreFilter fliterInfo=new SimplePropertyPreFilter(InfoEntity.class,"id","userByUserId","phone","address","email","mobile");

//        String user= JSON.toJSONString(userList,fliterUser);
        String info=JSON.toJSONString(infoList,fliterInfo);

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
        System.out.println();
        System.out.println(jsonArray.toJSONString());
        System.out.println();

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

    /**
     * 添加信息操作
     * @param infoEntity
     * @return
     */
    @RequestMapping(value = "/admin/info/addP",method = RequestMethod.POST)
    public String addInfoPost(@ModelAttribute("info") InfoEntity infoEntity){
        infoRepository.saveAndFlush(infoEntity);
        return "redirect:/admin/info";
    }

    /**
     * 显示信息详情
     * @param id
     * @param modelMap
     * @return
     */
    @RequestMapping(value = "/admin/info/show/{id}",method = RequestMethod.GET)
    public String showInfo(@PathVariable("id") int id,ModelMap modelMap){
        InfoEntity info=infoRepository.findOne(id);
        modelMap.addAttribute("info",info);
        return "admin/infoDetail";
    }

    /**
     * 访问修改信息页面
     * @param id
     * @param modelMap
     * @return
     */
    @RequestMapping(value = "/admin/info/update/{id}",method = RequestMethod.GET)
    public String updateInfo(@PathVariable("id") int id,ModelMap modelMap){
        InfoEntity info=infoRepository.findOne(id);
        List<UserEntity> userList=userRepository.findAll();
        modelMap.addAttribute("info",info);
        modelMap.addAttribute("userList",userList);
        return "admin/updateInfo";
    }

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

