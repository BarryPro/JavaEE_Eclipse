package com.sitech.acctmgr.test.atom.impl.bill;

import com.sitech.acctmgr.atom.dto.bill.S8102QryBillDetailInDTO;
import com.sitech.acctmgr.atom.dto.bill.SFamBillUnbillQueryInDTO;
import com.sitech.acctmgr.inter.bill.I8102;
import com.sitech.acctmgr.inter.bill.IFamBill;
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
public class SFamBillTest extends BaseTestCase{
    private IFamBill bean;

    @Before
    public void setUp() {
        bean = (IFamBill) getBean("famBillSvc");
    }

    private String getArgStringForQuery() {
        ArgumentBuilder builder = new ArgumentBuilder();
        Map<String, Object> busiMap = new HashMap<>();
        busiMap.put("PHONE_NO", "15246273783");
        busiMap.put("YEAR_MONTH", "201610");
        builder.setBusiargs(busiMap);

        Map<String, Object> oprMap = new HashMap<>();
        oprMap.put("LOGIN_NO", "aan70W");
        oprMap.put("GROUP_ID", "10789");
        builder.setOperargs(oprMap);

        return builder.toString();
    }

    @Test
    public void testUnbillQuery() throws Exception {
        String inStr = this.getArgStringForQuery();
        InDTO inDto = parseInDTO(inStr, SFamBillUnbillQueryInDTO.class);
        OutDTO outDTO = bean.unbillQuery(inDto);
        System.out.println(outDTO.toJson());


    }
}