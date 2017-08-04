package com.sitech.acctmgr.test.atom.impl.query;

import java.util.HashMap;
import java.util.Map;

import org.junit.Before;
import org.junit.Test;

import com.sitech.acctmgr.atom.dto.query.S8414QryPayTypeInfoInDTO;
import com.sitech.acctmgr.inter.query.I8414;
import com.sitech.acctmgr.test.junit.ArgumentBuilder;
import com.sitech.acctmgr.test.junit.BaseTestCase;
import com.sitech.jcfx.dt.MBean;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

public class S8414Test extends BaseTestCase {
	I8414 i8414 = null;

	@Before
	public void setUp() throws Exception {
		i8414 = (I8414) getBean("8414Svc");
	}

	private String getInArgsString() {
		ArgumentBuilder builder = new ArgumentBuilder();
		Map<String, Object> busiMap = new HashMap<>();
		busiMap.put("PAY_TYPE", "0");
		busiMap.put("PAGE_NUM", "7");
		builder.setBusiargs(busiMap);

		Map<String, Object> oprMap = new HashMap<>();
		// oprMap.put("LOGIN_NO", "dd1124");
		oprMap.put("LOGIN_NO", "h20119");
		oprMap.put("OP_CODE", "0000");
		oprMap.put("PROVINCE_ID", "230000");
		builder.setOperargs(oprMap);

		return builder.toString();
	}

	@Test
	public void testQuery() throws Exception {
		String inStr = this.getInArgsString();
		MBean mbean = new MBean(inStr);
		InDTO inDto = parseInDTO(mbean, S8414QryPayTypeInfoInDTO.class);

		OutDTO outDto = i8414.queryWriteItem(inDto);
		System.err.println("出参" + outDto.toJson());

	}

}