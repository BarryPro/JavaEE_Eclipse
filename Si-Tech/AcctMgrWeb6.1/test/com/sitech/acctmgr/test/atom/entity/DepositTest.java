package com.sitech.acctmgr.test.atom.entity;

import java.util.List;

import org.junit.Before;
import org.junit.Test;

import com.sitech.acctmgr.atom.domains.deposit.DepositInfoEntity;
import com.sitech.acctmgr.atom.entity.inter.IDeposit;
import com.sitech.acctmgr.test.junit.BaseTestCase;

/**
 * Created by wangyla on 2016/6/14.
 */
public class DepositTest extends BaseTestCase {
	private IDeposit deposit;

	@Before
	public void setUp() {
		deposit = (IDeposit) getBean("depositEnt");
	}

	@Test
	public void testGetDepositInfo() throws Exception {
		String phoneno = "13623411842";
		long contractNo = 0L;
		List<DepositInfoEntity> result = deposit.getDepositInfo(phoneno, contractNo, null);
		System.out.println(result.toString());
	}
}