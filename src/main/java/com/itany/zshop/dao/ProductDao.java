package com.itany.zshop.dao;

import com.itany.zshop.pojo.ProductPO;

public interface ProductDao {
    void insert(ProductPO productPO);

    ProductPO selectByName(String name);
}
