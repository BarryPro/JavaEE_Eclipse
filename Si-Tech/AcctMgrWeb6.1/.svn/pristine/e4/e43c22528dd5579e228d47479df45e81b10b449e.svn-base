package com.sitech.acctmgr.test.atom.impl.query;

import java.util.HashMap;
import java.util.Map;

import org.junit.Before;
import org.junit.Test;

import com.sitech.acctmgr.atom.dto.query.S8123QryInDTO;
import com.sitech.acctmgr.inter.query.I8123;
import com.sitech.acctmgr.test.junit.ArgumentBuilder;
import com.sitech.acctmgr.test.junit.BaseTestCase;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

/**
 * Created by wangyla on 2016/7/5.
 */
public class S8123Test extends BaseTestCase{
	private I8123 bean;
	
	@Before
	public void setUp(){
		bean = (I8123)getBean("8123Svc");
	}

	private String getArgStringForQuery() {
        ArgumentBuilder builder = new ArgumentBuilder();
        Map<String, Object> busiMap = new HashMap<>();
        busiMap.put("PHONE_NO", "15945484564");
        busiMap.put("YEAR_MONTH", "201701");
        busiMap.put("BUSI_CODE", "0");
        builder.setBusiargs(busiMap);

        Map<String, Object> oprMap = new HashMap<>();
        oprMap.put("LOGIN_NO", "aan70W");
        oprMap.put("GROUP_ID", "13968");
        oprMap.put("OP_CODE", "8123");
        builder.setOperargs(oprMap);

        return builder.toString();
    }
	
    @Test
    public void testQuery() throws Exception {
    	
    	String inStr = this.getArgStringForQuery();
    	InDTO inDto = parseInDTO(inStr, S8123QryInDTO.class);
    	OutDTO outDto = bean.query(inDto);
    	System.out.println(outDto.toJson());

    }
}