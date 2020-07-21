package com.itany.zshop.dao;

import com.itany.zshop.param.SysuserParam;
import com.itany.zshop.pojo.SysuserPO;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface SysuserDao {
    List<SysuserPO> selectAll();

    void insert(SysuserPO sysuserPO);

    List<SysuserPO> selectByParam(SysuserParam sysuserParam);

    SysuserPO selectById(Integer id);

    void updateStatus(@Param("id") Integer id, @Param("status") Integer status);
}
