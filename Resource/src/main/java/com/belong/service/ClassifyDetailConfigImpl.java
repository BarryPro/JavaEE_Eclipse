package com.belong.service;

import com.belong.dao.ClassifyDetailConfigMapper;
import com.belong.model.ClassifyDetailConfig;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * @Description: <p></p>
 * @Author: belong.
 * @Date: 2017/5/11.
 */
@Service
public class ClassifyDetailConfigImpl implements IClassifyDetailConfig {
    @Autowired
    private ClassifyDetailConfigMapper dao;

    @Override
    public int addDetailClassify(Map map) {
        return dao.addDetailClassify(map);
    }

    @Override
    public List<ClassifyDetailConfig> getClassifyDetail() {
        return dao.selectAll();
    }
}
