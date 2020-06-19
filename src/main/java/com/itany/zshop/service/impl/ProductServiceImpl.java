package com.itany.zshop.service.impl;

import com.itany.zshop.dto.ProductDto;
import com.itany.zshop.service.ProductService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
public class ProductServiceImpl implements ProductService {
    @Override
    public void add(ProductDto productDto) {

    }
}
