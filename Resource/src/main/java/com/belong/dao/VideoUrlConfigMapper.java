package com.belong.dao;

import com.belong.model.VideoUrlConfig;

import java.util.List;
import java.util.Map;

public interface VideoUrlConfigMapper {
    List<VideoUrlConfig> getVideo();
    int addVideo(Map map);
    List<VideoUrlConfig> getVideoPage(Map map);
}
