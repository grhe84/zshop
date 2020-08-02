package com.itany.zshop.service;

import com.itany.zshop.pojo.CustomerPO;

import java.util.List;

public interface CustomerService {
    Boolean checkLoginName(String loginName);

    void add(CustomerPO customerPO);

    List<CustomerPO> findAll();

    CustomerPO findById(Integer id);

    void modify(CustomerPO customerPO);
}
