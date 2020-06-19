package com.itany.zshop.controller.backend;

import com.itany.zshop.dto.ProductDto;
import com.itany.zshop.pojo.ProductTypePO;
import com.itany.zshop.service.ProductService;
import com.itany.zshop.service.ProductTypeService;
import com.itany.zshop.vo.ProductVO;
import org.apache.commons.beanutils.PropertyUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/backend/product")
public class ProductController {

    @Resource
    private ProductService productService;

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

    @RequestMapping("/add")
    public String add(ProductVO productVO, HttpSession session, Model model) {
        String uploadPath = session.getServletContext().getRealPath("/WEB-INF/upload");
        ProductDto productDto = new ProductDto();
        try {
            PropertyUtils.copyProperties(productDto, productVO);
            productDto.setInputStream(productVO.getFile().getInputStream());
            productDto.setFileName(productVO.getFile().getOriginalFilename());
            productDto.setUploadPath(uploadPath);
            productService.add(productDto);
            model.addAttribute("addMsg", "添加成功");
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("addMsg", "添加失败");
        }
        return "backend/productManager";
    }

}
