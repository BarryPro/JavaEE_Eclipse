package com.sitech.acctmgr.test.atom.impl.free;

import java.util.HashMap;
import java.util.Map;

import org.junit.Before;
import org.junit.Test;

import com.sitech.acctmgr.atom.dto.free.STransFreeQueryInDTO;
import com.sitech.acctmgr.inter.free.ITransFree;
import com.sitech.acctmgr.test.junit.ArgumentBuilder;
import com.sitech.acctmgr.test.junit.BaseTestCase;
import com.sitech.jcfx.dt.MBean;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

public class STransFreeTest extends BaseTestCase {
	ITransFree transFree = null;

	@Before
	public void setUp() throws Exception {
		transFree = (ITransFree) getBean("transFreeSvc");
	}

	private String getInArgsString() {
		ArgumentBuilder builder = new ArgumentBuilder();
		Map<String, Object> busiMap = new HashMap<>();
		busiMap.put("PHONE_NO", "13904841348");
		busiMap.put("YEAR_MONTH", "201703");
		builder.setBusiargs(busiMap);

		Map<String, Object> oprMap = new HashMap<>();
		oprMap.put("LOGIN_NO", "h20119");
		builder.setOperargs(oprMap);

		return builder.toString();
	}

	@Test
	public void testQuery() throws Exception {
		String inStr = this.getInArgsString();
		MBean mbean = new MBean(inStr);
		InDTO inDto = parseInDTO(mbean, STransFreeQueryInDTO.class);

		OutDTO outDto = transFree.query(inDto);
		System.out.println("出参" + outDto.toJson());

	}
}