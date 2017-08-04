package com.sitech.acctmgr.test.atom.impl.invoice;

import java.util.HashMap;
import java.util.Map;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import com.sitech.acctmgr.atom.dto.invoice.S8014PrintInDTO;
import com.sitech.acctmgr.inter.invoice.I8014AcceptList;
import com.sitech.acctmgr.test.junit.ArgumentBuilder;
import com.sitech.acctmgr.test.junit.BaseTestCase;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

public class S8014PrintTest extends BaseTestCase {

	private I8014AcceptList bean;

	@Before
	public void setUp() throws Exception {
		bean = (I8014AcceptList) getBean("8014AcceptListSvc");
	}

	@After
	public void tearDown() throws Exception {
		bean = null;
	}

	private String getArgStringForPrint() {
		ArgumentBuilder builder = new ArgumentBuilder();
		Map<String, Object> busiMap = new HashMap<>();
		busiMap.put("TRANS_SN", "30000000090025");
		busiMap.put("USER_FLAG", "1");

		builder.setBusiargs(busiMap);

		Map<String, Object> oprMap = new HashMap<>();
		oprMap.put("LOGIN_NO", "aan70W");
		oprMap.put("OP_CODE", "8014");
		oprMap.put("GROUP_ID", "13436");
		oprMap.put("PROVINCE_ID", "230000");
		builder.setOperargs(oprMap);

		return builder.toString();
	}

	@Test
	public void testPrint() throws Exception {
		String inStr = getArgStringForPrint();
		System.err.println(inStr + ">>>>>");
		InDTO inDTO = parseInDTO(inStr, S8014PrintInDTO.class);
		OutDTO outDTO = bean.print(inDTO);
		System.err.println(outDTO.toJson());

	}

}
