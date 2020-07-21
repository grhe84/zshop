package com.itany.zshop.service;

import com.itany.zshop.param.SysuserParam;
import com.itany.zshop.pojo.SysuserPO;
import com.itany.zshop.vo.SysuserVO;

import java.util.List;

public interface SysuserService {
    List<SysuserPO> findAll();

    void add(SysuserVO sysuserVO) throws Exception;

    List<SysuserPO> findByParam(SysuserParam sysuserParam);

    void modifyStatus(Integer id);
}
