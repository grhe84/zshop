package com.itany.zshop.service;

import com.itany.zshop.common.exception.ProductTypeExistException;
import com.itany.zshop.pojo.ProductTypePO;

import java.util.List;

public interface ProductTypeService {

    List<ProductTypePO> findAll();

    void add(String name) throws ProductTypeExistException;

    ProductTypePO findById(Integer id);

    void modifyName(Integer id, String name) throws ProductTypeExistException;
}
