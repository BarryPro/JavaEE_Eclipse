package com.sitech.acctmgr.test.liuhl_bj_test;

import java.util.HashMap;
import java.util.Map;

import org.junit.Before;
import org.junit.Test;

import com.sitech.acctmgr.atom.dto.feeqry.SBalanceQueryInDTO;
import com.sitech.acctmgr.inter.feeqry.IBalance;
import com.sitech.acctmgr.test.junit.ArgumentBuilder;
import com.sitech.acctmgr.test.junit.BaseTestCase;
import com.sitech.jcfx.dt.MBean;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

public class SBalanceTest extends BaseTestCase {
	IBalance balance = null;

	@Before
	public void setUp() throws Exception {
		balance = (IBalance) getBean("balanceSvc");
	}

	private String getInArgsString() {
		ArgumentBuilder builder = new ArgumentBuilder();
		Map<String, Object> busiMap = new HashMap<>();
		busiMap.put("PHONE_NO", "");
		busiMap.put("CONTRACT_NO", "");
		busiMap.put("QUERY_TYPE", "2");
		busiMap.put("BLACK_TYPE", "0");
		busiMap.put("ID_NO", "230870003007294737");
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
		InDTO inDto = parseInDTO(mbean, SBalanceQueryInDTO.class);

		OutDTO outDto = balance.query(inDto);
		System.err.println("出参" + outDto.toJson());

	}
}