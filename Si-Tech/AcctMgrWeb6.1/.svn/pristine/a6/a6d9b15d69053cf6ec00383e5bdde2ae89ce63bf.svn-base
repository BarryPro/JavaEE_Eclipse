package com.sitech.acctmgr.test.atom.impl.bill;

import com.sitech.acctmgr.atom.dto.bill.SBankBillQueryInDTO;
import com.sitech.acctmgr.atom.dto.bill.SPhoneBillQueryInDTO;
import com.sitech.acctmgr.inter.bill.IBankBill;
import com.sitech.acctmgr.inter.bill.IPhoneBill;
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
public class SBankBillTest extends BaseTestCase{
    private IBankBill bean;

    @Before
    public void setUp() {
        bean = (IBankBill) getBean("bankBillSvc");
    }

    private String getArgStringForQuery() {
        ArgumentBuilder builder = new ArgumentBuilder();
        Map<String, Object> busiMap = new HashMap<>();
        busiMap.put("PHONE_NO", "18346349875");
        builder.setBusiargs(busiMap);

        Map<String, Object> oprMap = new HashMap<>();
        oprMap.put("LOGIN_NO", "aan70W");
        builder.setOperargs(oprMap);

        return builder.toString();
    }

    @Test
    public void testQuery() throws Exception {
        String inStr = this.getArgStringForQuery();
        InDTO inDto = parseInDTO(inStr, SBankBillQueryInDTO.class);
        OutDTO outDTO = bean.query(inDto);
        System.out.println(outDTO.toJson());


    }
}