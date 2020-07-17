package com.itany.zshop.service.impl;

import com.itany.zshop.dao.SysuserDao;
import com.itany.zshop.param.SysuserParam;
import com.itany.zshop.pojo.RolePO;
import com.itany.zshop.pojo.SysuserPO;
import com.itany.zshop.service.SysuserService;
import com.itany.zshop.vo.SysuserVO;
import org.apache.commons.beanutils.PropertyUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.Date;
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

    @Override
    public void add(SysuserVO sysuserVO) throws Exception {
        SysuserPO sysuserPO = new SysuserPO();
        PropertyUtils.copyProperties(sysuserPO, sysuserVO);
        sysuserPO.setIsValid(1);
        sysuserPO.setCreateDate(new Date());
        RolePO rolePO = new RolePO();
        rolePO.setId(sysuserVO.getRoleId());
        sysuserPO.setRolePO(rolePO);
        sysuserDao.insert(sysuserPO);
    }

    @Override
    @Transactional(propagation = Propagation.SUPPORTS, readOnly = true)
    public List<SysuserPO> findByParam(SysuserParam sysuserParam) {
        return sysuserDao.selectByParam(sysuserParam);
    }
}
