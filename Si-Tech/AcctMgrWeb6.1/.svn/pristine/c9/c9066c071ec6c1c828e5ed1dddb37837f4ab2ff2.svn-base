package com.sitech.acctmgr.test.atom.impl.bill;

import com.sitech.acctmgr.atom.dto.bill.SPhoneBillOpenQueryInDTO;
import com.sitech.acctmgr.inter.bill.IPhoneBillOpen;
import com.sitech.acctmgr.test.junit.ArgumentBuilder;
import com.sitech.acctmgr.test.junit.BaseTestCase;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;
import org.junit.Before;
import org.junit.Test;

import java.util.HashMap;
import java.util.Map;

/**
 * Created by wangyla on 2016/6/23.
 */
public class SPhoneBillOpenTest extends BaseTestCase{
    private IPhoneBillOpen bean;

    @Before
    public void setUp() {
        bean = (IPhoneBillOpen) getBean("phoneBillOpenSvc");
    }

    private String getArgStringForBillDetail() {
        ArgumentBuilder builder = new ArgumentBuilder();
        Map<String, Object> busiMap = new HashMap<>();
        busiMap.put("ServiceType", "01");
        busiMap.put("ServiceNumber", "13514572459");//13514528723 13836376565 13514572459
        busiMap.put("BgnMonth", "201704");
        busiMap.put("EndMonth", "201704");
        builder.setBusiargs(busiMap);

        Map<String, Object> oprMap = new HashMap<>();
        oprMap.put("LOGIN_NO", "aan70W");
        oprMap.put("GROUP_ID", "10789");
        builder.setOperargs(oprMap);

        return builder.toString();
    }

    @Test
    public void testQuery() throws Exception {
        String inStr = this.getArgStringForBillDetail();
        InDTO inDto = parseInDTO(inStr, SPhoneBillOpenQueryInDTO.class);
        OutDTO outDTO = bean.query(inDto);
        System.out.println(outDTO.toJson());


    }
}