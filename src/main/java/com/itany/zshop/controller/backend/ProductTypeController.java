package com.itany.zshop.controller.backend;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.itany.zshop.pojo.ProductTypePO;
import com.itany.zshop.service.ProductTypeService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.RequestMapping;

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
        PageHelper.startPage(pageNum, 10);
        List<ProductTypePO> productTypes = productTypeService.findAll();
        PageInfo<ProductTypePO> pageInfo = new PageInfo<>(productTypes);
        model.addAttribute("pageInfo", pageInfo);
        return "backend/productTypeManager";
    }

}
