package com.sitech.acctmgr.test.atom.impl.bill;

import java.util.HashMap;
import java.util.Map;

import org.junit.Before;
import org.junit.Test;

import com.sitech.acctmgr.atom.dto.bill.S8102QryBillDetailInDTO;
import com.sitech.acctmgr.inter.bill.I8102;
import com.sitech.acctmgr.test.junit.ArgumentBuilder;
import com.sitech.acctmgr.test.junit.BaseTestCase;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

/**
 * Created by wangyla on 2016/6/23.
 */
public class S8102Test extends BaseTestCase{
    private I8102 bean;

    @Before
    public void setUp() {
        bean = (I8102) getBean("8102Svc");
    }

    private String getArgStringForBillDetail() {
        ArgumentBuilder builder = new ArgumentBuilder();
        Map<String, Object> busiMap = new HashMap<>();
//        busiMap.put("PHONE_NO", "15946609449");
        busiMap.put("PHONE_NO", "15945484564");
        busiMap.put("CONTRACT_NO", "");
        busiMap.put("YEAR_MONTH", "201702");
        busiMap.put("QUERY_TYPE", "all");
        builder.setBusiargs(busiMap);

        Map<String, Object> oprMap = new HashMap<>();
        oprMap.put("LOGIN_NO", "aan70W");
        oprMap.put("GROUP_ID", "10789");
        oprMap.put("OP_CODE", "8102");
        builder.setOperargs(oprMap);

        return builder.toString();
    }

    @Test
    public void testQueryBillDetail() throws Exception {
        String inStr = this.getArgStringForBillDetail();
        InDTO inDto = parseInDTO(inStr, S8102QryBillDetailInDTO.class);
        OutDTO outDTO = bean.queryBillDetail(inDto);
        System.out.println(outDTO.toJson());


    }
}