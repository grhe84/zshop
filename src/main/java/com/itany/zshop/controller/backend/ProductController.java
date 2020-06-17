package com.itany.zshop.controller.backend;

import com.itany.zshop.pojo.ProductTypePO;
import com.itany.zshop.service.ProductTypeService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import java.util.List;

@Controller
@RequestMapping("/backend/product")
public class ProductController {

    @Resource
    private ProductTypeService productTypeService;

    @ModelAttribute("productTypes")
    public List<ProductTypePO> loadProductTypes() {
        return productTypeService.findEnable();
    }

    @RequestMapping("/findAll")
    public String findAll() {
        return "backend/productManager";
    }

}
