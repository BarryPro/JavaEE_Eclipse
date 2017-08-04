package com.sitech.acctmgr.test.atom.impl.query;

import com.sitech.acctmgr.atom.dto.query.SBankPostQueryInDTO;
import com.sitech.acctmgr.atom.dto.query.SBankQueryInDTO;
import com.sitech.acctmgr.inter.query.IBank;
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
 * Created by wangyla on 2016/7/7.
 */
public class SBankTest extends BaseTestCase{
    private IBank bean;

    @Before
    public void setUp() throws Exception {
        bean = (IBank) getBean("bankSvc");
    }

    @After
    public void tearDown() {
        bean = null;
    }


    private String getArgStringForQuery() {
        ArgumentBuilder builder = new ArgumentBuilder();
        Map<String, Object> busiMap = new HashMap<>();
        busiMap.put("POST_BANK_CODE", "001");
        builder.setBusiargs(busiMap);

        Map<String, Object> oprMap = new HashMap<>();
        oprMap.put("LOGIN_NO", "aan70W");
        oprMap.put("GROUP_ID", "10789");
        builder.setOperargs(oprMap);

        return builder.toString();
    }

    @Test
    public void testQuery() throws Exception {
        String inStr = this.getArgStringForQuery();
        InDTO inDTO = parseInDTO(inStr, SBankQueryInDTO.class);
        OutDTO outDTO = bean.query(inDTO);
        System.out.println(outDTO.toJson());
    }

    @Test
    public void testPostQuery() throws Exception {
        String inStr = this.getArgStringForQuery();
        InDTO inDTO = parseInDTO(inStr, SBankPostQueryInDTO.class);
        OutDTO outDTO = bean.postQuery(inDTO);
        System.out.println(outDTO.toJson());
    }
}