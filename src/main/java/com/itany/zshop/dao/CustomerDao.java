package com.itany.zshop.dao;

import com.itany.zshop.pojo.CustomerPO;

public interface CustomerDao {
    CustomerPO selectByLoginName(String loginName);
}
