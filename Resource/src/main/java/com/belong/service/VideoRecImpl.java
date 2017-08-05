package com.belong.service;

import com.belong.dao.VideoRecMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Map;

/**
 * @Description: <p></p>
 * @Author: belong.
 * @Date: 2017/4/29.
 */
@Service
public class VideoRecImpl implements IVideoRec{

    @Autowired
    private VideoRecMapper dao;

    @Override
    public int addRec(Map map) {
        return dao.addRec(map);
    }
}
