package com.itany.zshop.dao;

import com.itany.zshop.pojo.ProductTypePO;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ProductTypeDao {

    List<ProductTypePO> selectAll();

    ProductTypePO selectByName(String name);

    void insert(@Param("name") String name, @Param("status") Integer status);

    ProductTypePO selectById(Integer id);

    void updateName(@Param("id") Integer id, @Param("name") String name);

    void deleteById(Integer id);
}
