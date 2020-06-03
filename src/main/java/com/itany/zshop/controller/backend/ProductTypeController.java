package com.itany.zshop.controller.backend;

import com.itany.zshop.pojo.ProductTypePO;
import com.itany.zshop.service.ProductTypeService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import java.util.List;

@Controller
@RequestMapping("/backend/productType")
public class ProductTypeController {

    @Resource
    private ProductTypeService productTypeService;

    @RequestMapping("/findAll")
    public String findAll(Model model) {
        List<ProductTypePO> productTypes = productTypeService.findAll();
        model.addAttribute("productTypes", productTypes);
        return "backend/productTypeManager";
    }

}
