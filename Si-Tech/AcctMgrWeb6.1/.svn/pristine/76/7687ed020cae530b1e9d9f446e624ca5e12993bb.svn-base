package com.sitech.acctmgr.test.atom.impl.adj;

import java.util.HashMap;
import java.util.Map;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import com.sitech.acctmgr.atom.dto.pay.SFeiDouPayCfmInDTO;
import com.sitech.acctmgr.atom.dto.pay.SFeiDouPayCheckInDTO;
import com.sitech.acctmgr.inter.adj.IFeiDouPay;
import com.sitech.acctmgr.test.junit.ArgumentBuilder;
import com.sitech.acctmgr.test.junit.BaseTestCase;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

/**
*
* <p>Title:   </p>
* <p>Description:   </p>
* <p>Copyright: Copyright (c) 2016</p>
* <p>Company: SI-TECH </p>
* @author guowy
* @version 1.0
*/
public class SFeiDouPayTest extends BaseTestCase {
	
	private IFeiDouPay bean;

	/**
	* 名称：
	* @param 
	* @return 
	* @throws 
	*/
	@Before
	public void setUp() throws Exception {
		bean = (IFeiDouPay)getBean("feiDouPaySvc");
	}

	/**
	* 名称：
	* @param 
	* @return 
	* @throws 
	*/
	@After
	public void tearDown() throws Exception {
		bean = null;
	}
	
    private String getArgStringForCheck() {
        ArgumentBuilder builder = new ArgumentBuilder();
        Map<String, Object> busiMap = new HashMap<>();
        busiMap.put("OPT_SEQ", "test");
        busiMap.put("BUSS_TYPE", "ab");
        busiMap.put("PHONE_NO", "13944161243");
        busiMap.put("SYSPLAT_ID", "1");
        busiMap.put("PROVINCE", "369");
        busiMap.put("SESSION_ID", "");
        busiMap.put("REQ_DATE", "20160711174800");
        busiMap.put("SERV_ID", 220101000000008024L);
        busiMap.put("PAY_ACCID", 220101100000030018L);
        busiMap.put("UNIT", 0);
        busiMap.put("CHARGE_SUM", 999999999);
        builder.setBusiargs(busiMap);

        Map<String, Object> oprMap = new HashMap<>();
        oprMap.put("LOGIN_NO", "caDS00");
        oprMap.put("GROUP_ID", "13436");
        builder.setOperargs(oprMap);

        return builder.toString();
    }
    
    private String getArgStringForCfm() {
        ArgumentBuilder builder = new ArgumentBuilder();
        Map<String, Object> busiMap = new HashMap<>();
        busiMap.put("OPT_SEQ", "test");
        busiMap.put("PHONE_NO", "13944161243");
        busiMap.put("SMS_CONTENT", "是");
        builder.setBusiargs(busiMap);

        Map<String, Object> oprMap = new HashMap<>();
        oprMap.put("LOGIN_NO", "caDS00");
        builder.setOperargs(oprMap);

        return builder.toString();
    }

	@Test
	public void testCheck() {
		String inStr = getArgStringForCheck();

		InDTO inDto = parseInDTO(inStr, SFeiDouPayCheckInDTO.class);
		OutDTO outDto = bean.check(inDto);
		System.out.println(outDto.toJson());
	}
	
	@Test
	public void testCfm() {
		String inStr = getArgStringForCfm();

		InDTO inDto = parseInDTO(inStr, SFeiDouPayCfmInDTO.class);
		OutDTO outDto = bean.cfm(inDto);
		System.out.println(outDto.toJson());
	}

}
