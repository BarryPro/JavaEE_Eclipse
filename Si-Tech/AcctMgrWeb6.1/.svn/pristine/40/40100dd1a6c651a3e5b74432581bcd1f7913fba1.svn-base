package com.sitech.acctmgr.test.liuhl_bj_test;

import java.util.HashMap;
import java.util.Map;

import org.junit.Before;
import org.junit.Test;

import com.sitech.acctmgr.atom.dto.feeqry.S8177InDTO;
import com.sitech.acctmgr.inter.feeqry.I8177;
import com.sitech.acctmgr.test.junit.ArgumentBuilder;
import com.sitech.acctmgr.test.junit.BaseTestCase;
import com.sitech.jcfx.dt.MBean;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

public class S8177Test extends BaseTestCase {
	I8177 i8177 = null;

	@Before
	public void setUp() throws Exception {
		i8177 = (I8177) getBean("8177Svc");
	}

	private String getInArgsString() {
		ArgumentBuilder builder = new ArgumentBuilder();
		Map<String, Object> busiMap = new HashMap<>();
		// busiMap.put("PHONE_NO", "13804310983");
		busiMap.put("CONTRACT_NO", "220101100000030015");
		busiMap.put("QUERY_TYPE", "1");
		busiMap.put("YEAR_MONTH", "201607");
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
		InDTO inDto = parseInDTO(mbean, S8177InDTO.class);

		OutDTO outDto = i8177.query(inDto);
		System.err.println("出参" + outDto.toJson());

	}
}