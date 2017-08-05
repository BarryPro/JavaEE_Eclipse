package com.belong.service;

import com.belong.dao.VideoTypeConfigMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * Created by belong on 2017/4/12.
 */
@Service
public class VideoTypeConfigImpl implements IVideoTypeConfig {
    @Autowired
    private VideoTypeConfigMapper dao;

    @Override
    public int addTypeConfig(Map map) {
        return dao.insert(map);
    }

    @Override
    public List getVideoCate() {
        return dao.selectCate();
    }
}
