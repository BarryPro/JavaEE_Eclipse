package com.sitech.acctmgr.test.atom.impl.feeqry;

import java.util.HashMap;
import java.util.Map;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import com.sitech.acctmgr.atom.dto.feeqry.SFeeQueryBalanceQueryInDTO;
import com.sitech.acctmgr.inter.feeqry.IFeeQuery;
import com.sitech.acctmgr.test.junit.ArgumentBuilder;
import com.sitech.acctmgr.test.junit.BaseTestCase;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

/**
 * Created by wangyla on 2016/8/2.
 */
public class SFeeQueryTest extends BaseTestCase{
    private IFeeQuery bean;

    @Before
    public void setUp() throws Exception {
        bean = (IFeeQuery) getBean("feeQuerySvc");
    }

    @After
    public void tearDown() throws Exception {
        bean = null;
    }

    private String getInArgsString(){
        ArgumentBuilder builder = new ArgumentBuilder();
        Map<String, Object> busiMap = new HashMap<>();
		busiMap.put("PHONE_NO", "13644637777");
        builder.setBusiargs(busiMap);

        Map<String, Object> oprMap = new HashMap<>();
        oprMap.put("LOGIN_NO", "");
        oprMap.put("OP_CODE", "0000");
        builder.setOperargs(oprMap);

        return builder.toString();
    }

    @Test
    public void testBalanceQuery() throws Exception {
        String inStr = this.getInArgsString();
        InDTO inDTO = parseInDTO(inStr, SFeeQueryBalanceQueryInDTO.class);
        OutDTO outDTO = bean.balanceQuery(inDTO);
		System.err.println("outDTO = " + outDTO.toJson());

    }
}