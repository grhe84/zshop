package com.itany.zshop.service.impl;

import com.itany.zshop.common.exception.ProductTypeExistException;
import com.itany.zshop.dao.ProductTypeDao;
import com.itany.zshop.pojo.ProductTypePO;
import com.itany.zshop.service.ProductTypeService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

@Service
@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
public class ProductTypeServiceImpl implements ProductTypeService {

    @Resource
    private ProductTypeDao productTypeDao;

    @Override
    @Transactional(propagation = Propagation.SUPPORTS, readOnly = true)
    public List<ProductTypePO> findAll() {
        return productTypeDao.selectAll();
    }

    @Override
    public void add(String name) throws ProductTypeExistException {
        if (productTypeDao.selectByName(name) != null) {
            throw new ProductTypeExistException("商品类型已存在");
        }
        productTypeDao.insert(name, 1);
    }

}
