package com.itany.zshop.service.impl;

import com.itany.zshop.dao.SysuserDao;
import com.itany.zshop.pojo.SysuserPO;
import com.itany.zshop.service.SysuserService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

@Service
@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
public class SysuserServiceImpl implements SysuserService {

    @Resource
    private SysuserDao sysuserDao;

    @Override
    @Transactional(propagation = Propagation.SUPPORTS, readOnly = true)
    public List<SysuserPO> findAll() {
        return sysuserDao.selectAll();
    }
}
