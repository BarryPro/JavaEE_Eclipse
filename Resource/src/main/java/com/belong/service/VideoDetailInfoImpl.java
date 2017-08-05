package com.belong.service;

import com.belong.dao.VideoDetailInfoMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Map;

/**
 * @Description: <p></p>
 * @Author: belong.
 * @Date: 2017/5/13.
 */
@Service
public class VideoDetailInfoImpl implements IVideoDetailInfo {
    @Autowired
    private VideoDetailInfoMapper dao;

    @Override
    public int addVideoDetail(Map map) {
        return dao.addVideoDetail(map);
    }
}
