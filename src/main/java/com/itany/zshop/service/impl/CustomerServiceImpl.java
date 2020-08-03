package com.itany.zshop.service.impl;

import com.itany.zshop.dao.CustomerDao;
import com.itany.zshop.param.CustomerParam;
import com.itany.zshop.pojo.CustomerPO;
import com.itany.zshop.service.CustomerService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;

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

    @Override
    public void add(CustomerPO customerPO) {
        customerPO.setPassword("123456");
        customerPO.setIsValid(1);
        customerPO.setRegistDate(new Date());
        customerDao.insert(customerPO);
    }

    @Override
    @Transactional(propagation = Propagation.SUPPORTS, readOnly = true)
    public List<CustomerPO> findAll() {
        return customerDao.selectAll();
    }

    @Override
    @Transactional(propagation = Propagation.SUPPORTS, readOnly = true)
    public CustomerPO findById(Integer id) {
        return customerDao.selectById(id);
    }

    @Override
    public void modify(CustomerPO customerPO) {
        customerDao.update(customerPO);
    }

    @Override
    public void modifyStatus(Integer id) {
        CustomerPO customerPO = customerDao.selectById(id);
        Integer status = (customerPO.getIsValid() == 1) ? 0 : 1;
        customerDao.updateStatus(id, status);
    }

    @Override
    @Transactional(propagation = Propagation.SUPPORTS, readOnly = true)
    public List<CustomerPO> findByParam(CustomerParam customerParam) {
        return customerDao.selectByParam(customerParam);
    }
}
