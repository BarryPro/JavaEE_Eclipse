package com.sitech.acctmgr.test.atom.impl.free;

import com.sitech.acctmgr.atom.dto.free.*;
import com.sitech.acctmgr.inter.free.IFamilyFree;
import com.sitech.acctmgr.inter.free.IFreeOpen;
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
public class SFreeOpenTest extends BaseTestCase{

    private IFreeOpen bean;

    @Before
    public void setUp() throws Exception {
        bean = (IFreeOpen) getBean("freeOpenSvc");
    }

    @After
    public void tearDown() throws Exception {
        bean = null;
    }

    private String getArgStringForQuery() {
        ArgumentBuilder builder = new ArgumentBuilder();
        Map<String, Object> busiMap = new HashMap<>();
//        busiMap.put("PHONE_NO", "13796014541");
        busiMap.put("ServiceType", "01");
        busiMap.put("ServiceNumber", "13904841348");
        builder.setBusiargs(busiMap);

        Map<String, Object> oprMap = new HashMap<>();
        oprMap.put("LOGIN_NO", "aan70W");
        oprMap.put("GROUP_ID", "10789");
        builder.setOperargs(oprMap);

        return builder.toString();
    }

    @Test
    public void testQuery() throws Exception {
        String inStr = getArgStringForQuery();
        InDTO inDTO = parseInDTO(inStr, SFreeOpenQueryInDTO.class);
        OutDTO outDTO = bean.query(inDTO);
        System.out.println(outDTO.toJson());

    }

    private String getArgStringForGprsQuery() {
        ArgumentBuilder builder = new ArgumentBuilder();
        Map<String, Object> busiMap = new HashMap<>();
        busiMap.put("ServiceNumber", "13904841348");
        builder.setBusiargs(busiMap);

        Map<String, Object> oprMap = new HashMap<>();
        oprMap.put("LOGIN_NO", "aan70W");
        oprMap.put("GROUP_ID", "10789");
        builder.setOperargs(oprMap);

        return builder.toString();
    }

    @Test
    public void testGprsQuery() throws Exception {
        String inStr = getArgStringForGprsQuery();
        InDTO inDTO = parseInDTO(inStr, SFreeOpenGprsQueryInDTO.class);
        OutDTO outDTO = bean.gprsQuery(inDTO);
        System.out.println(outDTO.toJson());
    }

}