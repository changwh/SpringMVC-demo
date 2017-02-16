package com.cwh.controller;

import com.cwh.model.InfoEntity;
import com.cwh.model.UserEntity;
import com.cwh.repository.InfoRepository;
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
public class InfoController {
    @Autowired
    InfoRepository infoRepository;

    @Autowired
    UserRepository userRepository;

    @RequestMapping(value = "/admin/info",method = RequestMethod.GET)
    public String showInfo(ModelMap modelMap){
        List<InfoEntity> infoList=infoRepository.findAll();
        modelMap.addAttribute("infoList",infoList);
        return "admin/info";
    }

    @RequestMapping(value = "/admin/info/add",method = RequestMethod.GET)
    public String addInfo(ModelMap modelMap){
        List<UserEntity>userList=userRepository.findAll();
        modelMap.addAttribute("userList",userList);
        return "admin/addInfo";
    }

    @RequestMapping(value = "/admin/info/addP",method = RequestMethod.POST)
    public String addInfoPost(@ModelAttribute("info") InfoEntity infoEntity){
        infoRepository.saveAndFlush(infoEntity);
        return "redirect:/admin/info";
    }

    @RequestMapping(value = "/admin/info/show/{id}",method = RequestMethod.GET)
    public String showInfo(@PathVariable("id") int id,ModelMap modelMap){
        InfoEntity info=infoRepository.findOne(id);
        modelMap.addAttribute("info",info);
        return "admin/infoDetail";
    }

    @RequestMapping(value = "/admin/info/update/{id}",method = RequestMethod.GET)
    public String updateInfo(@PathVariable("id") int id,ModelMap modelMap){
        InfoEntity info=infoRepository.findOne(id);
        List<UserEntity> userList=userRepository.findAll();
        modelMap.addAttribute("info",info);
        modelMap.addAttribute("userList",userList);
        return "admin/updateInfo";
    }

    @RequestMapping(value = "/admin/info/updateP",method = RequestMethod.POST)
    public String updateInfoP(@ModelAttribute("infoP") InfoEntity infoEntity){
        infoRepository.updateInfo(infoEntity.getPhone(),infoEntity.getAddress(),infoEntity.getEmail(),infoEntity.getMobile(),infoEntity.getUserByUserId().getId(),infoEntity.getId());
        infoRepository.flush();
        return "redirect:/admin/info";
    }

    @RequestMapping(value = "/admin/info/delete/{id}")
    public String deleteInfo(@PathVariable("id") int id){
        infoRepository.delete(id);
        infoRepository.flush();
        return "redirect:/admin/info";
    }
}
