package com.sitech.acctmgr.test.atom.impl.query;

import java.util.HashMap;
import java.util.Map;

import org.junit.Before;
import org.junit.Test;

import com.sitech.acctmgr.atom.dto.feeqry.SOweQueryInDTO;
import com.sitech.acctmgr.inter.feeqry.IOweQuery;
import com.sitech.acctmgr.test.junit.ArgumentBuilder;
import com.sitech.acctmgr.test.junit.BaseTestCase;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;


public class SOweQueryTest extends BaseTestCase{
	private IOweQuery bean;
	
	@Before
	public void setUp(){
		bean = (IOweQuery) getBean("oweQuerySvc");
	}

	private String getArgStringForQuery() {
        ArgumentBuilder builder = new ArgumentBuilder();
        Map<String, Object> busiMap = new HashMap<>();
		busiMap.put("ID_NO", "230390003021466997");
        builder.setBusiargs(busiMap);

        Map<String, Object> oprMap = new HashMap<>();
        oprMap.put("LOGIN_NO", "caDS00");
        oprMap.put("OP_CODE", "8123");
        builder.setOperargs(oprMap);

        return builder.toString();
    }
	
    @Test
    public void testQuery() throws Exception {
    	
    	String inStr = this.getArgStringForQuery();
		InDTO inDto = parseInDTO(inStr, SOweQueryInDTO.class);
    	OutDTO outDto = bean.query(inDto);
    	System.out.println(outDto.toJson());

    }
}