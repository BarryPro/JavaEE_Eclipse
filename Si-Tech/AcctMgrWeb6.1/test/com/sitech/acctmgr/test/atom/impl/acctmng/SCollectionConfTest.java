package com.sitech.acctmgr.test.atom.impl.acctmng;

import com.sitech.acctmgr.atom.dto.acctmng.SCollectionConfQueryInDTO;
import com.sitech.acctmgr.inter.acctmng.ICollectionConf;
import com.sitech.acctmgr.test.junit.ArgumentBuilder;
import com.sitech.acctmgr.test.junit.BaseTestCase;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import java.util.HashMap;
import java.util.Map;

/**
 * Created by wangyla on 2016/7/8.
 */
public class SCollectionConfTest extends BaseTestCase{
    private ICollectionConf bean;

    @Before
    public void setUp() throws Exception {
        bean = (ICollectionConf)getBean("collectionConfSvc");
    }

    @After
    public void tearDown() throws Exception {
        bean = null;
    }

    private String getArgStringForQuery() {
        ArgumentBuilder builder = new ArgumentBuilder();
        Map<String, Object> busiMap = new HashMap<>();
        builder.setBusiargs(busiMap);

        Map<String, Object> oprMap = new HashMap<>();
        oprMap.put("LOGIN_NO", "aan70W");
        oprMap.put("GROUP_ID", "13436");
        builder.setOperargs(oprMap);

        return builder.toString();
    }

    @Test
    public void testQuery() throws Exception {
        String inStr = this.getArgStringForQuery();

        InDTO inDTO = parseInDTO(inStr, SCollectionConfQueryInDTO.class);
        OutDTO outDTO = bean.query(inDTO);
        System.out.println(outDTO.toJson());

    }
}