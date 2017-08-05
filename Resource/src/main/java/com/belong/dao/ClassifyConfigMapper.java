package com.belong.dao;

import com.belong.model.ClassifyConfig;

import java.util.List;
import java.util.Map;

public interface ClassifyConfigMapper {
    List<ClassifyConfig> selectAll();

    int addClassify(Map map);

    List<ClassifyConfig> selectClassify();
}
