package com.itany.zshop.service.impl;

import com.itany.zshop.dao.CustomerDao;
import com.itany.zshop.service.CustomerService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;

@Service
@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
public class CustomerServiceImpl implements CustomerService {

    @Resource
    private CustomerDao customerDao;

    @Override
    @Transactional(propagation = Propagation.SUPPORTS, readOnly = true)
    public Boolean checkLoginName(String loginName) {
        return customerDao.selectByLoginName(loginName) == null;
    }
}
