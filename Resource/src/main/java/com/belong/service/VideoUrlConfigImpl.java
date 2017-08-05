package com.belong.service;

import com.belong.dao.VideoUrlConfigMapper;
import com.belong.model.VideoUrlConfig;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * @Description: <p></p>
 * @Author: belong.
 * @Date: 2017/5/13.
 */
@Service
public class VideoUrlConfigImpl implements IVideoUrlConfig {

    @Autowired
    private VideoUrlConfigMapper dao;
    @Override
    public int addVideo(Map map) {
        return dao.addVideo(map);
    }

    @Override
    public List<VideoUrlConfig> getVideo() {
        return dao.getVideo();
    }

    @Override
    public List<VideoUrlConfig> getVideoPage(Map map) {
        return dao.getVideoPage(map);
    }
}
