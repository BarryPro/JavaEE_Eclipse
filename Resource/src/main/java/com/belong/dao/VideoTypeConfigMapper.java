package com.belong.dao;

import java.util.List;
import java.util.Map;

public interface VideoTypeConfigMapper {

    int insert(Map map);

    List<String> selectConfig();

    List<String> selectCate();

    List<String> selectUrls();

}
