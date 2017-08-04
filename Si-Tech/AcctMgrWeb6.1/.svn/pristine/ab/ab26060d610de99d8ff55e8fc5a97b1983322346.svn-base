package com.sitech.acctmgr.test.atom.impl.feeqry;

import java.util.HashMap;
import java.util.Map;

import org.junit.Before;
import org.junit.Test;

import com.sitech.acctmgr.atom.dto.feeqry.S8107QryPayInDTO;
import com.sitech.acctmgr.inter.feeqry.I8107;
import com.sitech.acctmgr.test.junit.ArgumentBuilder;
import com.sitech.acctmgr.test.junit.BaseTestCase;
import com.sitech.jcfx.dt.MBean;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

/**
 * Created by wangyla on 2016/6/2.
 */
public class S8107Test extends BaseTestCase {
	I8107 balance = null;

	@Before
	public void setUp() throws Exception {
		balance = (I8107) getBean("8107Svc");
	}

	private String getInArgsString() {
		ArgumentBuilder builder = new ArgumentBuilder();
		Map<String, Object> busiMap = new HashMap<>();
		// busiMap.put("PHONE_NO","18663001484");
		busiMap.put("CONTRACT_NO", "220101100000030018");
		busiMap.put("BEGIN_TIME", "20161101");
		busiMap.put("END_TIME", "20161115");
		builder.setBusiargs(busiMap);

		Map<String, Object> oprMap = new HashMap<>();
		oprMap.put("LOGIN_NO", "aan70W");
		oprMap.put("GROUP_ID", "");
		// oprMap.put("LOGIN_NO", "");
		oprMap.put("OP_CODE", "0000");
		// oprMap.put("PROVINCE_ID", "220000");
		builder.setOperargs(oprMap);

		return builder.toString();
	}

	@Test
	public void testQuery() throws Exception {
		String inStr = this.getInArgsString();
		MBean mbean = new MBean(inStr);
		InDTO inDto = parseInDTO(mbean, S8107QryPayInDTO.class);

		OutDTO outDto = balance.qryPay(inDto);
		System.out.println(outDto.toJson());

	}
}