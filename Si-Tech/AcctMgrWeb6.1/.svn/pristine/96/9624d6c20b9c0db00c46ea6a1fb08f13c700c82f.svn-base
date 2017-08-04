package com.sitech.acctmgr.test.liuhl_bj_test;

import java.util.HashMap;
import java.util.Map;

import org.junit.Before;
import org.junit.Test;

import com.sitech.acctmgr.atom.dto.cct.SDnyCreditCfmInDTO;
import com.sitech.acctmgr.atom.dto.cct.SDnyCreditQryInDTO;
import com.sitech.acctmgr.inter.cct.IDnyCreditOpr;
import com.sitech.acctmgr.test.junit.ArgumentBuilder;
import com.sitech.acctmgr.test.junit.BaseTestCase;
import com.sitech.jcfx.dt.MBean;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

public class SDnyCreditOprTest extends BaseTestCase {
	IDnyCreditOpr dnyCreditOpr = null;

	@Before
	public void setUp() throws Exception {
		dnyCreditOpr = (IDnyCreditOpr) getBean("dnyCreditOprSvc");
	}

	private String getQryInArgsString() {
		ArgumentBuilder builder = new ArgumentBuilder();
		Map<String, Object> busiMap = new HashMap<>();

		busiMap.put("ID_NO", "230870003007294737");
		builder.setBusiargs(busiMap);

		return builder.toString();
	}

	@Test
	public void testQuery() throws Exception {
		String inStr = this.getQryInArgsString();
		// MBean mbean = new MBean(inStr);
		InDTO inDto = parseInDTO(inStr, SDnyCreditQryInDTO.class);

		OutDTO outDto = dnyCreditOpr.query(inDto);
		System.err.println("出参：" + outDto.toJson());

	}

	private String getInCfmArgsString() {
		ArgumentBuilder builder = new ArgumentBuilder();
		Map<String, Object> busiMap = new HashMap<>();
		busiMap.put("ID_NO", "220101000000008024");
		busiMap.put("LIMIT_OWE", "200");
		busiMap.put("CREDIT_CODE", "2");
		busiMap.put("EXPIRE_TIME", "20161201");
		busiMap.put("OP_TYPE", "R");
		busiMap.put("OP_NOTE", "");
		// busiMap.put("LOGIN_ACCEPT", "");
		builder.setBusiargs(busiMap);

		Map<String, Object> oprMap = new HashMap<>();
		// oprMap.put("LOGIN_NO", "dd1124");
		oprMap.put("LOGIN_NO", "h20119");
		oprMap.put("OP_CODE", "8152");
		oprMap.put("PROVINCE_ID", "230000");
		oprMap.put("GROUP_ID", "10118");
		builder.setOperargs(oprMap);

		return builder.toString();
	}

	@Test
	public void testCfm() throws Exception {
		String inStr = this.getInCfmArgsString();
		MBean mbean = new MBean(inStr);
		InDTO inDto = parseInDTO(mbean, SDnyCreditCfmInDTO.class);

		OutDTO outDto = dnyCreditOpr.cfm(inDto);
		System.err.println("出参" + outDto.toJson());

	}
}