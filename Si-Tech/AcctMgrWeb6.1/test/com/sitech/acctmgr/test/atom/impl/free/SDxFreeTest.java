package com.sitech.acctmgr.test.atom.impl.free;

import com.sitech.acctmgr.atom.dto.free.SDxFreeQueryInDTO;
import com.sitech.acctmgr.inter.free.IDxFree;
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
 * Created by wangyla on 2016/8/16.
 */
public class SDxFreeTest extends BaseTestCase{

    private IDxFree bean;

    @Before
    public void setUp() throws Exception {
        bean = (IDxFree) getBean("dxFreeSvc");
    }

    @After
    public void tearDown() throws Exception {
        bean = null;
    }

    private String getArgStringForFree() {
        ArgumentBuilder builder = new ArgumentBuilder();
        Map<String, Object> busiMap = new HashMap<>();
        busiMap.put("PHONE_NO", "13804510735");
        builder.setBusiargs(busiMap);

        Map<String, Object> oprMap = new HashMap<>();
        oprMap.put("LOGIN_NO", "aan70W");
        oprMap.put("GROUP_ID", "10789");
        builder.setOperargs(oprMap);

        return builder.toString();
    }

    @Test
    public void testQuery() throws Exception {
        String inStr = getArgStringForFree();
        InDTO inDTO = parseInDTO(inStr, SDxFreeQueryInDTO.class);
        OutDTO outDTO = bean.query(inDTO);
        System.out.println(outDTO.toJson());

    }
}