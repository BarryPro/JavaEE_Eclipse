package com.sitech.acctmgr.test.atom.impl.free;

import java.util.HashMap;
import java.util.Map;

import org.junit.Before;
import org.junit.Test;

import com.sitech.acctmgr.atom.dto.free.SIntlRoamFreeQueryInDTO;
import com.sitech.acctmgr.inter.free.IIntlRoamFree;
import com.sitech.acctmgr.test.junit.ArgumentBuilder;
import com.sitech.acctmgr.test.junit.BaseTestCase;
import com.sitech.jcfx.dt.MBean;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

public class SIntIRoamFreeQueryTest extends BaseTestCase {
	IIntlRoamFree intlRoamFee = null;

	@Before
	public void setUp() throws Exception {
		intlRoamFee = (IIntlRoamFree) getBean("intlRoamFreeSvc");
	}

	private String getInArgsString() {
		ArgumentBuilder builder = new ArgumentBuilder();
		Map<String, Object> busiMap = new HashMap<>();
		busiMap.put("PHONE_NO", "13504680035");
		builder.setBusiargs(busiMap);

		Map<String, Object> oprMap = new HashMap<>();
		oprMap.put("LOGIN_NO", "h20119");
		oprMap.put("OP_CODE", "0000");
		oprMap.put("PROVINCE_ID", "230000");
		builder.setOperargs(oprMap);

		return builder.toString();
	}

	@Test
	public void testQuery() throws Exception {
		String inStr = this.getInArgsString();
		System.err.println("instr:" + inStr);
		MBean mbean = new MBean(inStr);
		InDTO inDto = parseInDTO(mbean, SIntlRoamFreeQueryInDTO.class);

		OutDTO outDto = intlRoamFee.query(inDto);
		System.err.println("出参" + outDto.toJson());

	}
}