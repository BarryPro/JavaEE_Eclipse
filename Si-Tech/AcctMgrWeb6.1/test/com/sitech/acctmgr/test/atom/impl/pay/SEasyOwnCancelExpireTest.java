package com.sitech.acctmgr.test.atom.impl.pay;

import java.util.HashMap;
import java.util.Map;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import com.sitech.acctmgr.atom.dto.pay.SEasyOwnCancelCfmInDTO;
import com.sitech.acctmgr.inter.pay.IEasyOwnCancelExpire;
import com.sitech.acctmgr.test.junit.ArgumentBuilder;
import com.sitech.acctmgr.test.junit.BaseTestCase;
import com.sitech.jcfx.dt.MBean;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

public class SEasyOwnCancelExpireTest extends BaseTestCase {

	
	private IEasyOwnCancelExpire bean;

	/**
	* 名称：
	* @param 
	* @return 
	* @throws 
	*/
	@Before
	public void setUp() throws Exception {
		bean = (IEasyOwnCancelExpire)getBean("easyOwnCancelExpireSvc");
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
	
    
    private String getArgStringForCfm() {
        ArgumentBuilder builder = new ArgumentBuilder();
        Map<String, Object> busiMap = new HashMap<>();
        busiMap.put("LOGIN_ACCEPT", "4646");
        busiMap.put("PHONE_NO", "13944161239");
        busiMap.put("CHN_SOURCE", "346546");
        busiMap.put("REMARK", "神州行余额限制取消测试");
        builder.setBusiargs(busiMap);

        Map<String, Object> oprMap = new HashMap<>();
        oprMap.put("LOGIN_NO", "caDS00");
        oprMap.put("GROUP_ID", "13436");
        builder.setOperargs(oprMap);

        return builder.toString();
    }

	
	@Test
	public void testCfm() {
		String inStr = getArgStringForCfm();

		InDTO inDto = parseInDTO(inStr, SEasyOwnCancelCfmInDTO.class);
		OutDTO outDto = bean.cfm(inDto);
		//System.out.println(outDto.toJson());
	}
}
