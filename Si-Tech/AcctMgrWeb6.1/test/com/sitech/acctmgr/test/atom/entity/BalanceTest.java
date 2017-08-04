package com.sitech.acctmgr.test.atom.entity;

import com.sitech.acctmgr.atom.domains.balance.BalanceFlagEnum;
import com.sitech.acctmgr.atom.domains.balance.BookTypeEnum;
import com.sitech.acctmgr.atom.domains.base.LoginBaseEntity;
import com.sitech.acctmgr.atom.domains.pay.PayBookEntity;
import com.sitech.acctmgr.atom.domains.pay.PayUserBaseEntity;
import com.sitech.acctmgr.atom.entity.inter.IBalance;
import com.sitech.acctmgr.test.junit.BaseTestCase;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import java.util.Map;

import static org.junit.Assert.fail;

/**
 * <p>Title:   </p>
 * <p>Description:   </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 *
 * @author
 * @version 1.0
 */
public class BalanceTest extends BaseTestCase {

    private IBalance balance;

    @Before
    public void before() {
        balance = (IBalance) getBean("balanceEnt");
    }


    /**
     * 名称：
     *
     * @param
     * @return
     * @throws
     */
    @Before
    public void setUp() throws Exception {
    }

    /**
     * 名称：
     *
     * @param
     * @return
     * @throws
     */
    @After
    public void tearDown() throws Exception {
    }

    @Test
    public void testIsCrmCardInvPrint() {

        IBalance balance = (IBalance) getBean("balanceEnt");

        Map<String, Object> outMap = null;

        String cardId = "123456789";
        boolean result = true;
        try {
            result = balance.isCrmCardInvPrint(cardId);
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

        System.out.println("result = " + result);

    }

    @Test
    public void testSaveSource() throws Exception {

        LoginBaseEntity loginBase = new LoginBaseEntity();
        loginBase.setLoginNo("abgj30");
        loginBase.setGroupId("369");

        PayUserBaseEntity payUserBase = new PayUserBaseEntity();
        payUserBase.setIdNo(220121000000008245L);
        payUserBase.setContractNo(220101100000040004L);

        PayBookEntity inBook = new PayBookEntity();
        inBook.setBalanceId(10000000050010L);
        inBook.setBalanceType("0");
        inBook.setPayType("0");
        inBook.setPayFee(111L);
        inBook.setStatus("0");
        inBook.setYearMonth(201605);

        log.debug("几个入参对象： " + loginBase.toString() + payUserBase.toString());

        //balance.saveSource(loginBase, payUserBase, inBook);

        //baseDao.getConnection().commit();

    }


    @Test
    public void testGetInitialBalance() throws Exception {
        long conNo = 220101100000000002L;
        int yearMonth = 201602;
//        String balFlag = BalanceFlagEnum.CURRENT_VALID.getValue();
        System.out.println(balance.getInitialBalance(conNo,yearMonth,BalanceFlagEnum.CURRENT_VALID));

    }

    @Test
    public void testGetInitialBalance1() throws Exception {
        long conNo = 230830002001652381L;
        int yearMonth = 201605;
//        String balFlag = BalanceFlagEnum.CURRENT_VALID.getValue();
//        String balType = CommonConst.BOOK_TYPE_NORMAL;
//        System.out.println(balance.getInitialBalance(conNo,yearMonth,balFlag,balType));
        System.out.println(balance.getInitialBalanceGroupByPayType(conNo, yearMonth, BalanceFlagEnum.CURRENT_VALID,
                BookTypeEnum.NORAML));
//        System.out.println(balance.getInitialBalance(conNo, yearMonth, BalanceFlagEnum.CURRENT_VALID,
//                BookTypeEnum.SPECIAL, null));
    }

    @Test
    public void testGetSumBalacneByPayTypes() throws Exception {
        long conNo = 230880002013836806L;
        System.out.println(balance.getSumBalacneByPayTypes(conNo, "3,d,0"));
    }

}
