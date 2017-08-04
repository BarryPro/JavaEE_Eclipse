package com.sitech.acctmgr.test.atom.impl.acctmng;

import java.util.HashMap;
import java.util.Map;

import org.junit.Before;
import org.junit.Test;

import com.sitech.acctmgr.atom.dto.acctmng.SCollectionOrderQueryInDTO;
import com.sitech.acctmgr.inter.acctmng.ICollectionOrder;
import com.sitech.acctmgr.test.junit.ArgumentBuilder;
import com.sitech.acctmgr.test.junit.BaseTestCase;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

/**
 * Created by wangyla on 2016/7/5.
 */
public class SCollectionOrderTest extends BaseTestCase{
	private ICollectionOrder bean;

    @Before
    public void setUp() throws Exception {
    	bean = (ICollectionOrder) getBean("collectionOrderSvc");
    }

    private String getArgStringForQuery() {
        ArgumentBuilder builder = new ArgumentBuilder();
        Map<String, Object> busiMap = new HashMap<>();
        busiMap.put("DIS_GROUP_ID", "14");
        busiMap.put("BILL_CYCLE", "201306");
        busiMap.put("BEGIN_PRINT_NO", "0");
        busiMap.put("END_PRINT_NO", "999");
        busiMap.put("BEGIN_BANK_CODE", "a0001");
        busiMap.put("END_BANK_CODE", "a005");
        busiMap.put("PRINT_DATE", "20160706");
        builder.setBusiargs(busiMap);

        Map<String, Object> oprMap = new HashMap<>();
        oprMap.put("LOGIN_NO", "caDS00");
//        oprMap.put("LOGIN_NO", "aan70W");
        oprMap.put("OP_CODE", "8226");
        oprMap.put("PROVINCE_ID", "220000");
        builder.setOperargs(oprMap);

        return builder.toString();
    }
    
    @Test
    public void testQuery() throws Exception {
    	String inStr = this.getArgStringForQuery();
    	InDTO inDto = super.parseInDTO(inStr, SCollectionOrderQueryInDTO.class);
    	OutDTO outDTO = bean.query(inDto);
    	System.out.println(outDTO.toJson());

    }

    @Test
    public void testPrint() throws Exception {

    }
}