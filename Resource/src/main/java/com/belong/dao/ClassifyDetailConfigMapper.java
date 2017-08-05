package com.belong.dao;

import com.belong.model.ClassifyDetailConfig;

import java.util.List;
import java.util.Map;

public interface ClassifyDetailConfigMapper {
    List<ClassifyDetailConfig> selectAll();

    int addDetailClassify(Map map);
}
