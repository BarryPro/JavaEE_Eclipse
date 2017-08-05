package com.belong.service;

import com.belong.model.ClassifyDetailConfig;

import java.util.List;
import java.util.Map;

/**
 * @Description: <p></p>
 * @Author: belong.
 * @Date: 2017/5/11.
 */
public interface IClassifyDetailConfig {
    int addDetailClassify(Map map);
    List<ClassifyDetailConfig> getClassifyDetail();
}
