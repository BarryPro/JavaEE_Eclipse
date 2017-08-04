package com.sitech.acctmgr.test.atom.impl.query;

import com.sitech.acctmgr.atom.dto.query.STdGprsQueryInDTO;
import com.sitech.acctmgr.inter.query.ITdGprs;
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
 * Created by wangyla on 2016/8/9.
 */
public class STdGprsTest extends BaseTestCase{
    private ITdGprs bean;
    @Before
    public void setUp() throws Exception {
        bean = (ITdGprs) getBean("tdGprsSvc");
    }

    private String getArgStringForQuery() {
        ArgumentBuilder builder = new ArgumentBuilder();
        Map<String, Object> busiMap = new HashMap<>();
        busiMap.put("PHONE_NO", "13895798069");
        busiMap.put("YEAR_MONTH", "201608");
        builder.setBusiargs(busiMap);

        Map<String, Object> oprMap = new HashMap<>();
        oprMap.put("LOGIN_NO", "caDS00");
        oprMap.put("OP_CODE", "0000");
        oprMap.put("GROUP_ID", "724");
        oprMap.put("PROVINCE_ID", "220000");
        builder.setOperargs(oprMap);

        return builder.toString();
    }

    @Test
    public void testQuery() throws Exception {
        String inStr = getArgStringForQuery();
        InDTO inDTO = parseInDTO(inStr, STdGprsQueryInDTO.class);
        OutDTO outDTO = bean.query(inDTO);
        System.out.println(outDTO.toJson());
    }
}