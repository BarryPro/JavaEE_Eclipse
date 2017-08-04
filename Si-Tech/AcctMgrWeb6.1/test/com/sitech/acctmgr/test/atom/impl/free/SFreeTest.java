package com.sitech.acctmgr.test.atom.impl.free;

import com.sitech.acctmgr.atom.dto.free.*;
import com.sitech.acctmgr.inter.free.IFree;
import com.sitech.acctmgr.test.junit.ArgumentBuilder;
import com.sitech.acctmgr.test.junit.BaseTestCase;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;
import org.junit.Before;
import org.junit.Test;

import java.util.HashMap;
import java.util.Map;

import static org.junit.Assert.*;

/**
 * Created by wangyla on 2016/8/8.
 */
public class SFreeTest extends BaseTestCase {
    private IFree bean;

    @Before
    public void setUp() {
        bean = (IFree) getBean("freeSvc");
    }

    private String getArgStringForFree() {
        ArgumentBuilder builder = new ArgumentBuilder();
        Map<String, Object> busiMap = new HashMap<>();
        busiMap.put("PHONE_NO", "13904841348"); //13904841348
        busiMap.put("YEAR_MONTH", "201706");
        builder.setBusiargs(busiMap);

        Map<String, Object> oprMap = new HashMap<>();
        oprMap.put("LOGIN_NO", "aan70W");
        oprMap.put("OP_CODE", "8123");
//        oprMap.put("GROUP_ID", "13436");
        builder.setOperargs(oprMap);

        return builder.toString();
    }

    @Test
    public void testFlowDetailQuery() throws Exception {
        //18246162371
        String inStr = getArgStringForFree();
        InDTO inDTO = parseInDTO(inStr, SFreeFlowDetailQueryInDTO.class);
        OutDTO outDTO = bean.flowDetailQuery(inDTO);
        System.out.println(outDTO.toJson());
    }

    @Test
    public void testShareQuery() throws Exception {
        //13895798069
        String inStr = getArgStringForFree();
        InDTO inDTO = parseInDTO(inStr, SFreeShareQueryInDTO.class);
        OutDTO outDTO = bean.shareQuery(inDTO);
        System.out.println(outDTO.toJson());

    }

    @Test
    public void testVpmnQuery() throws Exception {
        //18663001478
        String inStr = getArgStringForFree();
        InDTO inDTO = parseInDTO(inStr, SFreeVpmnQueryInDTO.class);
        OutDTO outDTO = bean.vpmnQuery(inDTO);
        System.out.println(outDTO.toJson());
    }

    @Test
    public void testGprsQuery() throws Exception {
        //15804619739
        String inStr = getArgStringForFree();
        InDTO inDTO = parseInDTO(inStr, SFreeGprsQueryInDTO.class);
        OutDTO outDTO = bean.gprsQuery(inDTO);
        System.out.println(outDTO.toJson());
    }

    @Test
    public void testUserFreeQuery() throws Exception {
        //13804510735
        String inStr = getArgStringForFree();
        InDTO inDTO = parseInDTO(inStr, SFreeUserFreeQueryInDTO.class);
        OutDTO outDTO = bean.userFreeQuery(inDTO);
        System.out.println(outDTO.toJson());
    }

    @Test
    public void testCarryOverQuery() throws Exception {
        //13895798069
        String inStr = getArgStringForFree();
        InDTO inDTO = parseInDTO(inStr, SFreeCarryOverQueryInDTO.class);
        OutDTO outDTO = bean.carryOverQuery(inDTO);
        System.out.println(outDTO.toJson());
    }

    @Test
    public void testWlanDetailQuery() throws Exception {
        //13846089578
        String inStr = getArgStringForFree();
        InDTO inDTO = parseInDTO(inStr, SFreeWlanDetailQueryInDTO.class);
        OutDTO outDTO = bean.wlanDetailQuery(inDTO);
        System.out.println(outDTO.toJson());
    }

    @Test
    public void testAllQuery() throws Exception {
        //13895798069
        String inStr = getArgStringForFree();
        InDTO inDTO = parseInDTO(inStr, SFreeAllQueryInDTO.class);
        OutDTO outDTO = bean.allQuery(inDTO);
        System.out.println(outDTO.toJson());
    }
}