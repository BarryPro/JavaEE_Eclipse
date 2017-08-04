package com.sitech.acctmgr.test.atom.impl.bill;

import com.sitech.acctmgr.atom.dto.bill.SGrpBillQueryInDTO;
import com.sitech.acctmgr.atom.dto.bill.SGrpBillSixQueryInDTO;
import com.sitech.acctmgr.inter.bill.IGrpBill;
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
public class SGrpBillTest extends BaseTestCase{
    private IGrpBill bean;

    @Before
    public void setUp() {
        bean = (IGrpBill) getBean("grpBillSvc");
    }

    private String getArgStringForQuery() {
        ArgumentBuilder builder = new ArgumentBuilder();
        Map<String, Object> busiMap = new HashMap<>();
        busiMap.put("UNIT_ID", "4510202205");
        busiMap.put("YEAR_MONTH", "201609");
        builder.setBusiargs(busiMap);

        Map<String, Object> oprMap = new HashMap<>();
        oprMap.put("LOGIN_NO", "aan70W");
        oprMap.put("OP_CODE", "8103");
        builder.setOperargs(oprMap);

        return builder.toString();
    }

    @Test
    public void testQuery() throws Exception {
        String inStr = this.getArgStringForQuery();
        InDTO inDto = parseInDTO(inStr, SGrpBillQueryInDTO.class);
        OutDTO outDTO = bean.query(inDto);
        System.out.println(outDTO.toJson());
    }

    private String getArgStringForSixQuery() {
        ArgumentBuilder builder = new ArgumentBuilder();
        Map<String, Object> busiMap = new HashMap<>();
        busiMap.put("CONTRACT_NO", "230320003021453240");
        builder.setBusiargs(busiMap);

        Map<String, Object> oprMap = new HashMap<>();
        oprMap.put("LOGIN_NO", "aan70W");
        oprMap.put("OP_CODE", "8103");
        builder.setOperargs(oprMap);

        return builder.toString();
    }

    @Test
    public void testSixQuery() throws Exception {
        String inStr = this.getArgStringForSixQuery();
        InDTO inDto = parseInDTO(inStr, SGrpBillSixQueryInDTO.class);
        OutDTO outDTO = bean.sixQuery(inDto);
        System.out.println(outDTO.toJson());


    }
}