package com.itany.zshop.service;

import com.itany.zshop.dto.ProductDto;
import com.itany.zshop.pojo.ProductPO;

import java.util.List;

public interface ProductService {
    void add(ProductDto productDto) throws Exception;

    Boolean checkName(String name);

    List<ProductPO> findAll();
}
