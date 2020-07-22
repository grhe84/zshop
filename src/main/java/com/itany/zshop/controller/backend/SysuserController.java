package com.itany.zshop.controller.backend;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.itany.zshop.common.util.ResponseResult;
import com.itany.zshop.param.SysuserParam;
import com.itany.zshop.pojo.SysuserPO;
import com.itany.zshop.service.SysuserService;
import com.itany.zshop.vo.SysuserVO;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.List;

@Controller
@RequestMapping("/backend/sysuser")
public class SysuserController {

    @Resource
    private SysuserService sysuserService;

    @RequestMapping("/login")
    public String login() {
        return "backend/main";
    }

    @RequestMapping("/findAll")
    public String findAll(Integer pageNum, Model model) {
        if (ObjectUtils.isEmpty(pageNum)) {
            pageNum = 1;
        }
        PageHelper.startPage(pageNum, 5);
        List<SysuserPO> sysusers = sysuserService.findAll();
        PageInfo<SysuserPO> pageInfo = new PageInfo<>(sysusers);
        model.addAttribute("pageInfo", pageInfo);
        return "backend/sysuserManager";
    }

    @RequestMapping("/findByParam")
    public String findByParam(Integer pageNum, SysuserParam sysuserParam, Model model) {
        if (ObjectUtils.isEmpty(pageNum)) {
            pageNum = 1;
        }
        PageHelper.startPage(pageNum, 5);
        List<SysuserPO> sysusers = sysuserService.findByParam(sysuserParam);
        PageInfo<SysuserPO> pageInfo = new PageInfo<>(sysusers);
        model.addAttribute("pageInfo", pageInfo);
        model.addAttribute("sysuserParam", sysuserParam);
        return "backend/sysuserManager";
    }

    @RequestMapping("/findById")
    @ResponseBody
    public ResponseResult findById(Integer id) {
        ResponseResult result = new ResponseResult();
        result.setStatus(1);
        result.setData(sysuserService.findById(id));
        return result;
    }

    @RequestMapping("/add")
    @ResponseBody
    public ResponseResult add(SysuserVO sysuserVO) {
        ResponseResult result = new ResponseResult();
        try {
            sysuserService.add(sysuserVO);
            result.setStatus(1);
            result.setMessage("添加成功");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    @RequestMapping("/modify")
    @ResponseBody
    public ResponseResult modify(SysuserVO sysuserVO) {
        ResponseResult result = new ResponseResult();
        try {
            sysuserService.modify(sysuserVO);
            result.setStatus(1);
            result.setMessage("修改成功");
        } catch (Exception e) {
            e.printStackTrace();
            result.setStatus(0);
            result.setMessage("修改失败");
        }
        return result;
    }

    @RequestMapping("/modifyStatus")
    @ResponseBody
    public ResponseResult modifyStatus(Integer id) {
        ResponseResult result = new ResponseResult();
        sysuserService.modifyStatus(id);
        result.setStatus(1);
        result.setMessage("修改成功");
        return result;
    }

}
