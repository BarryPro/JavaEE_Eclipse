package com.sitech.acctmgr.test.atom.impl.invoice;

import java.util.HashMap;
import java.util.Map;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import com.sitech.acctmgr.atom.dto.invoice.S8068PrintInDTO;
import com.sitech.acctmgr.atom.dto.invoice.S8068QueryInDTO;
import com.sitech.acctmgr.inter.invoice.I8068Invoice;
import com.sitech.acctmgr.test.junit.ArgumentBuilder;
import com.sitech.acctmgr.test.junit.BaseTestCase;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

public class S8068PrintTest extends BaseTestCase {

	private I8068Invoice bean;

	@Before
	public void setUp() throws Exception {
		bean = (I8068Invoice) getBean("8068InvoiceSvc");
	}

	@After
	public void tearDown() throws Exception {
		bean = null;
	}

	private String getArgStringForPrint() {
		ArgumentBuilder builder = new ArgumentBuilder();
		Map<String, Object> busiMap = new HashMap<>();
		busiMap.put("PAY_SN", "30000000100049");
		busiMap.put("YEAR_MONTH", "201703");

		builder.setBusiargs(busiMap);

		Map<String, Object> oprMap = new HashMap<>();
		oprMap.put("LOGIN_NO", "aan70W");
		oprMap.put("OP_CODE", "8068");
		oprMap.put("GROUP_ID", "13436");
		oprMap.put("PROVINCE_ID", "230000");
		builder.setOperargs(oprMap);

		return builder.toString();
	}

	@Test
	public void testPrint() throws Exception {
		String inStr = getArgStringForPrint();
		System.err.println(inStr + ">>>>>");
		InDTO inDTO = parseInDTO(inStr, S8068PrintInDTO.class);
		OutDTO outDTO = bean.print(inDTO);
		System.err.println(outDTO.toJson());

	}

	private String getArgStringForQuery() {
		ArgumentBuilder builder = new ArgumentBuilder();
		Map<String, Object> busiMap = new HashMap<>();
		busiMap.put("CONTRACT_NO", "230750003006088551");

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
	public void testQuery() throws Exception {
		String inStr = getArgStringForQuery();
		System.err.println(inStr + ">>>>>");
		InDTO inDTO = parseInDTO(inStr, S8068QueryInDTO.class);
		OutDTO outDTO = bean.query(inDTO);
		System.err.println(outDTO.toJson());

	}

}
