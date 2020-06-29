package com.itany.zshop.dao;

import com.itany.zshop.pojo.ProductPO;

import java.util.List;

public interface ProductDao {
    void insert(ProductPO productPO);

    ProductPO selectByName(String name);

    List<ProductPO> selectAll();
}
