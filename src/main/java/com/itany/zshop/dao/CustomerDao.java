package com.itany.zshop.dao;

import com.itany.zshop.pojo.CustomerPO;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface CustomerDao {
    CustomerPO selectByLoginName(String loginName);

    void insert(CustomerPO customerPO);

    List<CustomerPO> selectAll();

    CustomerPO selectById(Integer id);

    void update(CustomerPO customerPO);

    void updateStatus(@Param("id") Integer id, @Param("status") Integer status);
}
