package com.sitech.acctmgr.test.atom.impl.invoice;

import java.util.HashMap;
import java.util.Map;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import com.sitech.acctmgr.atom.dto.invoice.S3101QryInDTO;
import com.sitech.acctmgr.inter.invoice.I3101;
import com.sitech.acctmgr.test.junit.ArgumentBuilder;
import com.sitech.acctmgr.test.junit.BaseTestCase;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

public class S3101QryTest extends BaseTestCase {

	private I3101 bean;

	@Before
	public void setUp() throws Exception {
		bean = (I3101) getBean("3101Svc");
	}

	@After
	public void tearDown() throws Exception {
		bean = null;
	}

	private String getArgStringForPrint() {
		ArgumentBuilder builder = new ArgumentBuilder();
		Map<String, Object> busiMap = new HashMap<>();
		busiMap.put("PHONE_NO", "13504680015");
		busiMap.put("YEAR_MONTH", "201612");
		busiMap.put("END_DATE", "20170224");
		busiMap.put("BEGIN_DATE", "20170201");
		busiMap.put("QRY_TYPE", "1");
		busiMap.put("PAGE_NUM", "1");

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
		InDTO inDTO = parseInDTO(inStr, S3101QryInDTO.class);
		OutDTO outDTO = bean.query(inDTO);
		System.err.println(outDTO.toJson());

	}

}
