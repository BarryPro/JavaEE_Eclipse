package com.belong.service;

import com.belong.model.VideoUrlConfig;

import java.util.List;
import java.util.Map;

/**
 * @Description: <p></p>
 * @Author: belong.
 * @Date: 2017/5/13.
 */
public interface IVideoUrlConfig {
    int addVideo(Map map);
    List<VideoUrlConfig> getVideo();
    List<VideoUrlConfig> getVideoPage(Map map);
}
