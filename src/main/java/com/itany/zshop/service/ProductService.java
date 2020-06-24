package com.itany.zshop.service;

import com.itany.zshop.dto.ProductDto;

public interface ProductService {
    void add(ProductDto productDto) throws Exception;

    Boolean checkName(String name);
}
