package com.itany.zshop.service;

import com.itany.zshop.dto.ProductDto;
import com.itany.zshop.pojo.ProductPO;

import java.io.IOException;
import java.io.OutputStream;
import java.util.List;

public interface ProductService {
    void add(ProductDto productDto) throws Exception;

    Boolean checkName(String name);

    List<ProductPO> findAll();

    ProductPO findById(Integer id);

    void findImage(String path, OutputStream outputStream) throws IOException;

    void modify(ProductDto productDto) throws Exception;

    void removeById(Integer id);
}
