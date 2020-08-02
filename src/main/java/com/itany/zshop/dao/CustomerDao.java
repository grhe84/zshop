package com.itany.zshop.dao;

import com.itany.zshop.pojo.CustomerPO;

import java.util.List;

public interface CustomerDao {
    CustomerPO selectByLoginName(String loginName);

    void insert(CustomerPO customerPO);

    List<CustomerPO> selectAll();

    CustomerPO selectById(Integer id);

    void update(CustomerPO customerPO);
}
