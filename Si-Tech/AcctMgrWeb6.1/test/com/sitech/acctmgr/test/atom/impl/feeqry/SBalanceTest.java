package com.sitech.acctmgr.test.atom.impl.feeqry;

import java.util.HashMap;
import java.util.Map;

import org.junit.Before;
import org.junit.Test;

import com.sitech.acctmgr.atom.dto.feeqry.SBalanceQryBackFeeInDTO;
import com.sitech.acctmgr.atom.dto.feeqry.SBalanceQueryInDTO;
import com.sitech.acctmgr.inter.feeqry.IBalance;
import com.sitech.acctmgr.test.junit.ArgumentBuilder;
import com.sitech.acctmgr.test.junit.BaseTestCase;
import com.sitech.jcfx.dt.MBean;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

/**
 * Created by wangyla on 2016/6/2.
 */
public class SBalanceTest extends BaseTestCase {
	IBalance balance = null;

	@Before
	public void setUp() throws Exception {
		balance = (IBalance) getBean("balanceSvc");
	}

	private String getInArgsString() {
		ArgumentBuilder builder = new ArgumentBuilder();
		Map<String, Object> busiMap = new HashMap<>();
		// busiMap.put("PHONE_NO","18663001484");
		// busiMap.put("CONTRACT_NO", "230850003001574521");
		// busiMap.put("PHONE_NO", "18846718878");
		// busiMap.put("CONTRACT_NO", "");
		busiMap.put("ID_NO", "220161000000008634");
		busiMap.put("QUERY_TYPE", "2");
		// busiMap.put("BLACK_TYPE", "0");
		builder.setBusiargs(busiMap);

		Map<String, Object> oprMap = new HashMap<>();
		oprMap.put("LOGIN_NO", "aan70W");
		oprMap.put("GROUP_ID", "230000");
		// oprMap.put("LOGIN_NO", "");
//		oprMap.put("OP_CODE", "1508");
		// oprMap.put("PROVINCE_ID", "220000");
		builder.setOperargs(oprMap);

		return builder.toString();
	}

	@Test
	public void testQuery() throws Exception {
		String inStr = this.getInArgsString();
		MBean mbean = new MBean(inStr);
		InDTO inDto = parseInDTO(mbean, SBalanceQueryInDTO.class);

		OutDTO outDto = balance.query(inDto);
		System.err.println(outDto.toJson());

	}

	private String getQryBack() {
		ArgumentBuilder builder = new ArgumentBuilder();
		Map<String, Object> busiMap = new HashMap<>();
		busiMap.put("PHONE_NO", "20904536540");
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
	public void testQryBackFee() throws Exception {
		String inStr = this.getQryBack();
		MBean mbean = new MBean(inStr);
		InDTO inDto = parseInDTO(mbean, SBalanceQryBackFeeInDTO.class);

		OutDTO outDto = balance.queryBackFee(inDto);
		System.err.println(outDto.toJson());

	}


}