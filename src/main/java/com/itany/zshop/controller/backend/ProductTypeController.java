package com.itany.zshop.controller.backend;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.itany.zshop.common.exception.ProductTypeExistException;
import com.itany.zshop.common.util.ResponseResult;
import com.itany.zshop.pojo.ProductTypePO;
import com.itany.zshop.service.ProductTypeService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.List;

@Controller
@RequestMapping("/backend/productType")
public class ProductTypeController {

    @Resource
    private ProductTypeService productTypeService;

    @RequestMapping("/findAll")
    public String findAll(Integer pageNum, Model model) {
        if (ObjectUtils.isEmpty(pageNum)) {
            pageNum = 1;
        }
        PageHelper.startPage(pageNum, 5);
        List<ProductTypePO> productTypes = productTypeService.findAll();
        PageInfo<ProductTypePO> pageInfo = new PageInfo<>(productTypes);
        model.addAttribute("pageInfo", pageInfo);
        return "backend/productTypeManager";
    }

    @RequestMapping("/add")
    @ResponseBody
    public ResponseResult add(String name) {
        ResponseResult result = new ResponseResult();
        try {
            productTypeService.add(name);
            result.setStatus(1);
            result.setMessage("添加成功");
        } catch (ProductTypeExistException e) {
            result.setStatus(0);
            result.setMessage(e.getMessage());
        }
        return result;
    }

    @RequestMapping("/findById")
    @ResponseBody
    public ResponseResult findById(Integer id) {
        ResponseResult result = new ResponseResult();
        ProductTypePO productType = productTypeService.findById(id);
        result.setStatus(1);
        result.setData(productType);
        return result;
    }

    @RequestMapping("/modifyName")
    @ResponseBody
    public ResponseResult modifyName(Integer id, String name) {
        ResponseResult result = new ResponseResult();
        try {
            productTypeService.modifyName(id, name);
            result.setStatus(1);
            result.setMessage("修改成功");
        } catch (ProductTypeExistException e) {
            result.setStatus(0);
            result.setMessage(e.getMessage());
        }
        return result;
    }

    @RequestMapping("/modifyStatus")
    @ResponseBody
    public ResponseResult modifyStatus(Integer id) {
        ResponseResult result = new ResponseResult();
        productTypeService.modifyStatus(id);
        result.setStatus(1);
        return result;
    }

    @RequestMapping("/removeById")
    @ResponseBody
    public ResponseResult removeById(Integer id) {
        ResponseResult result = new ResponseResult();
        productTypeService.removeById(id);
        result.setStatus(1);
        result.setMessage("删除成功");
        return result;
    }

}
