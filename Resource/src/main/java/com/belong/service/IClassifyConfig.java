package com.belong.service;

import com.belong.model.ClassifyConfig;

import java.util.List;
import java.util.Map;

/**
 * @Description: <p></p>
 * @Author: belong.
 * @Date: 2017/5/11.
 */
public interface IClassifyConfig {
    int addClassify(Map map);
    List<ClassifyConfig> getClassify();
    List<ClassifyConfig> chartData();
}
