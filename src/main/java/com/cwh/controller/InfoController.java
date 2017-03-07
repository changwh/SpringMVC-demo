package com.cwh.controller;

import com.cnc.thirdparty.fastjson.JSON;
import com.cnc.thirdparty.fastjson.JSONArray;
import com.cnc.thirdparty.fastjson.JSONObject;
import com.cnc.thirdparty.fastjson.serializer.SerializerFeature;
import com.cwh.model.InfoEntity;
import com.cwh.model.Page;
import com.cwh.model.ReturnJson;
import com.cwh.model.UserEntity;
import com.cwh.repository.InfoRepository;
import com.cwh.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
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
     * 查看所有信息页面
     * @param modelMap
     * @return
     */
    @RequestMapping(value = "/admin/info",method = RequestMethod.GET)
    public String getInfo(ModelMap modelMap){
        return "admin/info";
    }


    /**
     * 查看所有信息操作
     * @param page
     * @return
     */
    @RequestMapping(value = "/admin/infoP",method = RequestMethod.GET)
    public @ResponseBody String getInfoP(@ModelAttribute("page") Page page){
        Map<String,Object> map = new HashMap<String,Object>();

        //分页查询user表中所有记录
        Pageable pageable=new PageRequest(page.getPageIndex(),page.getLimit());
        org.springframework.data.domain.Page<InfoEntity> infoPage=infoRepository.findAll(pageable);
        List<InfoEntity> infoList=infoPage.getContent();

        //转化为JSONString，关闭FastJSON的循环引用检测，防止出现"$ref"使前端无法解析
        String info=JSON.toJSONString(infoList,SerializerFeature.DisableCircularReferenceDetect);

        //再转化为JSON数组便于遍历取值
        JSONArray jsonArray=JSON.parseArray(info);
        for(int i = 0 ;i<jsonArray.size();i++) {

            //通过userByUserId获取用户名及用户ID
            JSONObject userObj=jsonArray.getJSONObject(i).getJSONObject("userByUserId");
            String userName=userObj.getString("name");
            String userId=userObj.getString("id");
            {
                //在当前数组元素中添加数值
                jsonArray.getJSONObject(i).put("userName",userName);
                jsonArray.getJSONObject(i).put("userId",userId);
            }
        }

        //获取数据数量
        long results=infoRepository.count();

        map.put("rows",jsonArray);
        map.put("results",results);

        String json=JSON.toJSONString(map,SerializerFeature.DisableCircularReferenceDetect);

        return json;
    }


    /**
     * 添加信息操作
     * @param returnJson
     * @return
     */
    @RequestMapping(value = "/admin/info/addP",method = RequestMethod.POST)
    public @ResponseBody String addInfoPost(@ModelAttribute("info") ReturnJson returnJson){
        //根据传回的userId获取user实体，便于之后赋予info实体中的UserByUserId
        UserEntity user=userRepository.findOne(returnJson.getUserId());

        InfoEntity info=new InfoEntity();

        info.setAddress(returnJson.getAddress());
        info.setEmail(returnJson.getEmail());
        info.setMobile(returnJson.getMobile());
        info.setPhone(returnJson.getPhone());
        info.setUserByUserId(user);

        infoRepository.saveAndFlush(info);

        Map<String,Object> status=new HashMap<String,Object>();
        status.put("status",302);
        //便于前端进行页面跳转
        status.put("location","/admin/users");
        String json=JSON.toJSONString(status, SerializerFeature.DisableCircularReferenceDetect);
        return json;
    }


    /**
     * 显示信息详情操作
     * @param returnJson
     * @return
     */
    @RequestMapping(value = "/admin/info/show",method = RequestMethod.POST)
    public @ResponseBody String showInfo(@ModelAttribute("show") ReturnJson returnJson){
        Map<String,Object> detail=new HashMap<String,Object>();

        try {
            InfoEntity info=infoRepository.findOne(returnJson.getId());
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

        String json=JSON.toJSONString(detail,SerializerFeature.DisableCircularReferenceDetect);
        return json;
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


    /**
     * 删除信息操作
     * @param returnJson
     * @return
     */
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

        String json=JSON.toJSONString(status,SerializerFeature.DisableCircularReferenceDetect);

        return json;
    }


    /**
     * 批量删除信息
     * @param test
     * @return
     */
    @RequestMapping(value = "/admin/info/deleteSelected",method = RequestMethod.POST)
    public @ResponseBody String deleteSelectedInfo(@RequestBody String test){
        JSONObject idList=JSON.parseObject(test);

        Map<String,Object> status=new  HashMap<String,Object>();
        List<Integer> errorList=new ArrayList<Integer>();
        status.put("noError",true);
        int temp=0;
        int length=0;
        for (int i=0;i<idList.size();i++){
            try {
                temp=(int)idList.get("id"+i);
                infoRepository.delete(temp);
            }catch (Exception e){
                length++;
                status.remove("noError");
                errorList.add(temp);
            }
        }
        status.put("length",length);
        status.put("errorList",errorList);
        String json=JSON.toJSONString(status,true);
        System.out.println(json);
        return json;
    }
}


