package com.itany.zshop.controller.backend;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.itany.zshop.common.util.ResponseResult;
import com.itany.zshop.param.CustomerParam;
import com.itany.zshop.pojo.CustomerPO;
import com.itany.zshop.service.CustomerService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/backend/customer")
public class CustomerController {

    @Resource
    private CustomerService customerService;

    @RequestMapping("/findAll")
    public String findAll(Integer pageNum, Model model) {
        if (ObjectUtils.isEmpty(pageNum)) {
            pageNum = 1;
        }
        PageHelper.startPage(pageNum, 5);
        List<CustomerPO> customers = customerService.findAll();
        PageInfo<CustomerPO> pageInfo = new PageInfo<>(customers);
        model.addAttribute("pageInfo", pageInfo);
        return "backend/customerManager";
    }

    @RequestMapping("/findById")
    @ResponseBody
    public ResponseResult findAll(Integer id) {
        ResponseResult result = new ResponseResult();
        CustomerPO customerPO = customerService.findById(id);
        result.setStatus(1);
        result.setData(customerPO);
        return result;
    }

    @RequestMapping("/findByParam")
    public String findByParam(Integer pageNum, String flag, CustomerParam customerParam, Model model) {
        if (!ObjectUtils.isEmpty(flag)) {
            pageNum = 1;
        }
        if (ObjectUtils.isEmpty(pageNum)) {
            pageNum = 1;
        }
        PageHelper.startPage(pageNum, 5);
        List<CustomerPO> customers = customerService.findByParam(customerParam);
        PageInfo<CustomerPO> pageInfo = new PageInfo<>(customers);
        model.addAttribute("pageInfo", pageInfo);
        model.addAttribute("customerParam", customerParam);
        return "backend/customerManager";
    }

    @RequestMapping("/checkLoginName")
    @ResponseBody
    public Map<String, Object> checkLoginName(String loginName) {
        Map<String, Object> map = new HashMap<>();
        map.put("valid", customerService.checkLoginName(loginName));
        return map;
    }

    @RequestMapping("/add")
    public String add(CustomerPO customerPO, Model model) {
        customerService.add(customerPO);
        model.addAttribute("updateMsg", "添加成功");
        return "forward:findAll";
    }

    @RequestMapping("/modify")
    public String modify(CustomerPO customerPO, Integer pageNum, Model model) {
        customerService.modify(customerPO);
        model.addAttribute("updateMsg", "修改成功");
        return "forward:findAll?pageNum=" + pageNum;
    }

    @RequestMapping("/modifyStatus")
    @ResponseBody
    public ResponseResult modifyStatus(Integer id) {
        ResponseResult result = new ResponseResult();
        customerService.modifyStatus(id);
        result.setStatus(1);
        result.setMessage("修改成功");
        return result;
    }

}
