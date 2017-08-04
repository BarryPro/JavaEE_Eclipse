package com.sitech.acctmgr.test.atom.impl.free;

import com.sitech.acctmgr.atom.dto.free.SFamilyFreeFunnyQueryInDTO;
import com.sitech.acctmgr.atom.dto.free.SFamilyFreeQueryInDTO;
import com.sitech.acctmgr.atom.dto.free.SFamilyFreeShareQueryInDTO;
import com.sitech.acctmgr.inter.free.IFamilyFree;
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
public class SFamilyFreeTest extends BaseTestCase{

    private IFamilyFree bean;

    @Before
    public void setUp() throws Exception {
        bean = (IFamilyFree) getBean("familyFreeSvc");
    }

    @After
    public void tearDown() throws Exception {
        bean = null;
    }

    private String getArgStringForFree() {
        ArgumentBuilder builder = new ArgumentBuilder();
        Map<String, Object> busiMap = new HashMap<>();
//        busiMap.put("PHONE_NO", "13796014541");
        busiMap.put("PHONE_NO", "18246348389");
        busiMap.put("YEAR_MONTH", "201604");
        busiMap.put("CHAT_FLAG", "2");
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
        InDTO inDTO = parseInDTO(inStr, SFamilyFreeQueryInDTO.class);
        OutDTO outDTO = bean.query(inDTO);
        System.out.println(outDTO.toJson());

    }

    @Test
    public void testFunnyQuery() throws Exception {
        String inStr = getArgStringForFree();
        InDTO inDTO = parseInDTO(inStr, SFamilyFreeFunnyQueryInDTO.class);
        OutDTO outDTO = bean.funnyQuery(inDTO);
        System.out.println(outDTO.toJson());
    }

    private String getArgStringForQuery() {
        ArgumentBuilder builder = new ArgumentBuilder();
        Map<String, Object> busiMap = new HashMap<>();
        busiMap.put("PHONE_NO", "15146733528");
        busiMap.put("YEAR_MONTH", "201702");
        builder.setBusiargs(busiMap);

        Map<String, Object> oprMap = new HashMap<>();
        oprMap.put("LOGIN_NO", "aan70W");
        oprMap.put("GROUP_ID", "10789");
        builder.setOperargs(oprMap);

        return builder.toString();
    }

    @Test
    public void testShareQuery() throws Exception {
        String inStr = getArgStringForQuery();
        InDTO inDTO = parseInDTO(inStr, SFamilyFreeShareQueryInDTO.class);
        OutDTO outDTO = bean.shareQuery(inDTO);
        System.out.println(outDTO.toJson());
    }

}