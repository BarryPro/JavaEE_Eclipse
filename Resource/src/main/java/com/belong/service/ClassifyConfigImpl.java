package com.belong.service;

import com.belong.dao.ClassifyConfigMapper;
import com.belong.model.ClassifyConfig;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * @Description: <p>用于实现添加电影类型</p>
 * @Author: belong.
 * @Date: 2017/5/11.
 */
@Service
public class ClassifyConfigImpl implements IClassifyConfig {
    @Autowired
    private ClassifyConfigMapper daoClassify;

    @Override
    public int addClassify(Map map) {
        return daoClassify.addClassify(map);
    }

    @Override
    public List<ClassifyConfig> getClassify() {
        return daoClassify.selectAll();
    }

    @Override
    public List<ClassifyConfig> chartData() {
        return daoClassify.selectClassify();
    }
}
