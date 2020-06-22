package com.itany.zshop.service.impl;

import com.itany.zshop.common.util.UploadUtil;
import com.itany.zshop.dao.ProductDao;
import com.itany.zshop.dto.ProductDto;
import com.itany.zshop.pojo.ProductPO;
import com.itany.zshop.pojo.ProductTypePO;
import com.itany.zshop.service.ProductService;
import org.apache.commons.beanutils.PropertyUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StreamUtils;

import javax.annotation.Resource;
import java.io.FileOutputStream;

@Service
@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
public class ProductServiceImpl implements ProductService {

    @Resource
    private ProductDao productDao;

    @Override
    public void add(ProductDto productDto) throws Exception {
        // 文件上传
        String uploadPath = productDto.getUploadPath() + "/" + UploadUtil.renameFile(productDto.getFileName());
        StreamUtils.copy(productDto.getInputStream(), new FileOutputStream(uploadPath));

        // 保存到数据库
        ProductPO productPO = new ProductPO();
        PropertyUtils.copyProperties(productPO, productDto);
        productPO.setImage(uploadPath);
        ProductTypePO productTypePO = new ProductTypePO();
        productTypePO.setId(productDto.getProductTypeId());
        productPO.setProductTypePO(productTypePO);

        productDao.insert(productPO);
    }
}
