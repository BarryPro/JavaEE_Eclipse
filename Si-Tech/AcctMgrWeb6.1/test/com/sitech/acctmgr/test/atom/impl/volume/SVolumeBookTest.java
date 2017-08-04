package com.sitech.acctmgr.test.atom.impl.volume;

import com.sitech.acctmgr.atom.domains.volume.TransferOtherEntity;
import com.sitech.acctmgr.atom.dto.volume.*;
import com.sitech.acctmgr.inter.volume.IVolumeBook;
import com.sitech.acctmgr.test.junit.ArgumentBuilder;
import com.sitech.acctmgr.test.junit.BaseTestCase;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * Created by wangyla on 2017/2/18.
 */
public class SVolumeBookTest extends BaseTestCase {
    private IVolumeBook bean;

    @Before
    public void setUp() {
        bean = (IVolumeBook)getBean("volumeBookSvc");
    }

    @After
    public void tearDown() {
        bean = null;
    }

    private String getSysdate(){
        DateFormat df = new SimpleDateFormat("yyyyMMddHHmmssSSS");
        String dateStr = df.format(new Date());

        return dateStr;
    }

    public static void main(String[] args) {
        DateFormat df = new SimpleDateFormat("yyyyMMddHHmmssSSS");
        String dateStr = df.format(new Date());
        System.out.println(dateStr);
    }

    // 000189~!~01~!~01~!~20160711~!~18249070556~!~18249070556~!~03~!~04~!~1~!~1~!~1~!~9900000000000084~!~
    // 65~!~~!~50008~!~30001~!~~!~1~!~10000~!~1~!~1~!~20170101000000~!~20170711000000~!~1~!~1~!~1
    private String getRequestForPay() {
        ArgumentBuilder builder = new ArgumentBuilder();
        Map<String, Object> busiMap = new HashMap<>();
        busiMap.put("MSISDN", "18249070556");
        busiMap.put("TRADE_SEQ", "20160714");
        busiMap.put("USER_ID", "18249070556");
        busiMap.put("REGION_ID", "00");
        busiMap.put("PART_ID", "00");
        busiMap.put("OPER_SOURCE", "1");
        busiMap.put("OPER_CHANNEL", "1");
        busiMap.put("OPER_ID", "1"); //请求头信息
        busiMap.put("ACCT_ID", "9900000000000084");
        busiMap.put("ACCT_TYPE", "65");
        busiMap.put("BALANCE_ID", "");
        busiMap.put("BALANCE_TYPE", "50008");
        busiMap.put("BALANCE_ATTR", "30001");
        busiMap.put("ADD_ATTR_CODE", "");
        busiMap.put("SHARE_FLAG", "1");
        busiMap.put("CHARGE_VALUE", "10000");
        busiMap.put("PAY_VALUE", "1");
        busiMap.put("PAY_UNIT", "1");
        busiMap.put("EFF_DATE", "20170101000000");
        busiMap.put("EXP_DATE", "20170711000000");
        busiMap.put("QUERY_FLAG", "1");
        busiMap.put("PRODUCT_ID", "1");
        busiMap.put("GROUP_ID", "1");
        builder.setBusiargs(busiMap);

        Map<String, Object> oprMap = new HashMap<>();
        builder.setOperargs(oprMap);

        return builder.toString();
    }

    @Test
    public void testPay() throws Exception {

        String inStr = this.getRequestForPay();
        InDTO inDto = parseInDTO(inStr, VolumeBookPayInDTO.class);
        OutDTO outDto = bean.pay(inDto);
        System.out.println(outDto.toJson());

    }

    private String getRequestForRollback() {
        ArgumentBuilder builder = new ArgumentBuilder();
        Map<String, Object> busiMap = new HashMap<>();
        busiMap.put("MSISDN", "18249070556");
        busiMap.put("TRADE_SEQ", "20160714ff");
        busiMap.put("USER_ID", "18249070556");
        busiMap.put("REGION_ID", "00");
        busiMap.put("PART_ID", "00");
        busiMap.put("OPER_SOURCE", "1");
        busiMap.put("OPER_CHANNEL", "1");
        busiMap.put("OPER_ID", "1"); //请求头信息
        busiMap.put("OPER_SESSION", "20160714");

        builder.setBusiargs(busiMap);

        Map<String, Object> oprMap = new HashMap<>();
        builder.setOperargs(oprMap);

        return builder.toString();
    }

    @Test
    public void testRollback() throws Exception {

        String inStr = this.getRequestForRollback();
        InDTO inDto = parseInDTO(inStr, VolumeBookRollbackInDTO.class);
        OutDTO outDto = bean.rollback(inDto);
        System.out.println(outDto.toJson());

    }

    private String getRequestForDeduct() {
        ArgumentBuilder builder = new ArgumentBuilder();
        Map<String, Object> busiMap = new HashMap<>();
        busiMap.put("MSISDN", "18249070556");
        busiMap.put("TRADE_SEQ", getSysdate());
        busiMap.put("USER_ID", "18249070556");
        busiMap.put("REGION_ID", "00");
        busiMap.put("PART_ID", "00");
        busiMap.put("OPER_SOURCE", "1");
        busiMap.put("OPER_CHANNEL", "1");
        busiMap.put("OPER_ID", "1"); //请求头信息

        busiMap.put("ACCT_ID", "9900000000000084");
        busiMap.put("ACCT_TYPE", "65");
        busiMap.put("BALANCE_ID", "8800000000000150");
        busiMap.put("BALANCE_TYPE", "50008");
        busiMap.put("ADD_ATTR_CODE", "");
        busiMap.put("CHARGE_VALUE", "100");
        busiMap.put("PAY_VALUE", "1");
        busiMap.put("PAY_UNIT", "1");
        busiMap.put("QUERY_FLAG", "0");
        builder.setBusiargs(busiMap);

        Map<String, Object> oprMap = new HashMap<>();
        builder.setOperargs(oprMap);

        return builder.toString();
    }

    @Test
    public void testDeduct() throws Exception {

        String inStr = this.getRequestForDeduct();
        InDTO inDto = parseInDTO(inStr, VolumeBookDeductInDTO.class);
        OutDTO outDto = bean.deduct(inDto);
        System.out.println(outDto.toJson());

    }

    private String getRequestForPreHold() {
        ArgumentBuilder builder = new ArgumentBuilder();
        Map<String, Object> busiMap = new HashMap<>();
        busiMap.put("CHANGE_REASON", "09");
        busiMap.put("MSISDN", "18249070556");
        busiMap.put("TRADE_SEQ", getSysdate());
        busiMap.put("USER_ID", "18249070556");
        busiMap.put("REGION_ID", "00");
        busiMap.put("PART_ID", "00");
        busiMap.put("OPER_SOURCE", "1");
        busiMap.put("OPER_CHANNEL", "1");
        busiMap.put("OPER_ID", "1"); //请求头信息

        busiMap.put("ACCT_ID", "9900000000000084");
        busiMap.put("ACCT_TYPE", "65");
        busiMap.put("BALANCE_ID", "8800000000000150");
        busiMap.put("BALANCE_TYPE", "50008");
        busiMap.put("ADD_ATTR_CODE", "30001");
        busiMap.put("CHARGE_VALUE", "100");
        busiMap.put("EFF_DATE", "20170217000000");
        busiMap.put("EXP_DATE", "20990125000000");
        builder.setBusiargs(busiMap);

        Map<String, Object> oprMap = new HashMap<>();
        builder.setOperargs(oprMap);

        return builder.toString();
    }

    @Test
    public void testPreHold() throws Exception {

        String inStr = this.getRequestForPreHold();
        InDTO inDto = parseInDTO(inStr, VolumeBookPreHoldingInDTO.class);
        OutDTO outDto = bean.preholding(inDto);
        System.out.println(outDto.toJson());

    }

    private String getRequestForPreHoldRealease() {
        ArgumentBuilder builder = new ArgumentBuilder();
        Map<String, Object> busiMap = new HashMap<>();
        busiMap.put("CHANGE_REASON", "09");
        busiMap.put("MSISDN", "18249070556");
        busiMap.put("TRADE_SEQ", getSysdate());
        busiMap.put("USER_ID", "18249070556");
        busiMap.put("REGION_ID", "00");
        busiMap.put("PART_ID", "00");
        busiMap.put("OPER_SOURCE", "1");
        busiMap.put("OPER_CHANNEL", "1");
        busiMap.put("OPER_ID", "1"); //请求头信息

        busiMap.put("RESERVE_SESSION", "20170220214948408");;
        builder.setBusiargs(busiMap);

        Map<String, Object> oprMap = new HashMap<>();
        builder.setOperargs(oprMap);

        return builder.toString();
    }

    @Test
    public void testPreHoldRealease() throws Exception {

        String inStr = this.getRequestForPreHoldRealease();
        InDTO inDto = parseInDTO(inStr, VolumeBookPreholdingReleaseInDTO.class);
        OutDTO outDto = bean.preholdingRelease(inDto);
        System.out.println(outDto.toJson());

    }

    private String getRequestForPreHoldDeduct() {
        ArgumentBuilder builder = new ArgumentBuilder();
        Map<String, Object> busiMap = new HashMap<>();
        busiMap.put("CHANGE_REASON", "09");
        busiMap.put("MSISDN", "18249070556");
        busiMap.put("TRADE_SEQ", getSysdate());
        busiMap.put("USER_ID", "18249070556");
        busiMap.put("REGION_ID", "00");
        busiMap.put("PART_ID", "00");
        busiMap.put("OPER_SOURCE", "1");
        busiMap.put("OPER_CHANNEL", "1");
        busiMap.put("OPER_ID", "1"); //请求头信息

        busiMap.put("RESERVE_SESSION", "20170220214800799");
        busiMap.put("CHARGE_VALUE", "30");
        busiMap.put("CHARGE_FLAG", "0");
        busiMap.put("CHARGE_MSISDN", "");
        busiMap.put("CHARGE_USERID", "");
        busiMap.put("PRODUCT_ID", "1");
        busiMap.put("GROUP_ID", "1");
        builder.setBusiargs(busiMap);

        Map<String, Object> oprMap = new HashMap<>();
        builder.setOperargs(oprMap);

        return builder.toString();
    }

    @Test
    public void testPreHoldDeduct() throws Exception {

        String inStr = this.getRequestForPreHoldDeduct();
        InDTO inDto = parseInDTO(inStr, VolumeBookPreholdingDeductInDTO.class);
        OutDTO outDto = bean.preholdingDeduct(inDto);
        System.out.println(outDto.toJson());

    }

    private String getRequestForTranfer() {
        ArgumentBuilder builder = new ArgumentBuilder();
        Map<String, Object> busiMap = new HashMap<>();
        busiMap.put("MSISDN", "18249070556");
        busiMap.put("TRADE_SEQ", getSysdate());
        busiMap.put("USER_ID", "18249070556");
        busiMap.put("REGION_ID", "00");
        busiMap.put("PART_ID", "00");
        busiMap.put("OPER_SOURCE", "1");
        busiMap.put("OPER_CHANNEL", "1");
        busiMap.put("OPER_ID", "1"); //请求头信息

        busiMap.put("ACCT_ID", "9900000000000084");
        busiMap.put("ACCT_TYPE", "65");
        busiMap.put("BALANCE_ID", "8800000000000150");
        busiMap.put("BALANCE_TYPE", "50008");
        busiMap.put("ADD_ATTR_CODE", "");
        busiMap.put("CHARGE_VALUE", "100");
        busiMap.put("COUNT", "2");

        List<TransferOtherEntity> otherList = new ArrayList<>();
        TransferOtherEntity other = new TransferOtherEntity();
        other.setOtherParty("1");
        other.setOtherValue("50");
        other.setUserId("1");
        otherList.add(other);

        other = new TransferOtherEntity();
        other.setOtherParty("2");
        other.setOtherValue("50");
        other.setUserId("2");
        otherList.add(other);
        busiMap.put("OTHERS", otherList);
        busiMap.put("EFF_DATE", "20170217000000");
        busiMap.put("EXP_DATE", "20990301000000");
        busiMap.put("QUERY_FLAG", "0");
        builder.setBusiargs(busiMap);

        Map<String, Object> oprMap = new HashMap<>();
        builder.setOperargs(oprMap);

        return builder.toString();
    }

    @Test
    public void testTranfer() throws Exception {

        String inStr = this.getRequestForTranfer();
        InDTO inDto = parseInDTO(inStr, VolumeBookTransferInDTO.class);
        OutDTO outDto = bean.transfer(inDto);
        System.out.println(outDto.toJson());

    }

    private String getRequestForDelay() {
        ArgumentBuilder builder = new ArgumentBuilder();
        Map<String, Object> busiMap = new HashMap<>();
        busiMap.put("CHANGE_REASON", "07");
        busiMap.put("MSISDN", "18249070556");
        busiMap.put("TRADE_SEQ", getSysdate());
        busiMap.put("USER_ID", "18249070556");
        busiMap.put("REGION_ID", "00");
        busiMap.put("PART_ID", "00");
        busiMap.put("OPER_SOURCE", "1");
        busiMap.put("OPER_CHANNEL", "1");
        busiMap.put("OPER_ID", "1"); //请求头信息

        busiMap.put("ACCT_ID", "9900000000000084");
        busiMap.put("ACCT_TYPE", "65");
        busiMap.put("BALANCE_ID", "8803000000000168");
        busiMap.put("CHANGE_VALUE", "100");
        busiMap.put("EXP_DATE", "20990325000000");
        busiMap.put("PRODUCT_ID", "");
        builder.setBusiargs(busiMap);

        Map<String, Object> oprMap = new HashMap<>();
        builder.setOperargs(oprMap);

        return builder.toString();
    }

    @Test
    public void testDelay() throws Exception {

        String inStr = this.getRequestForDelay();
        InDTO inDto = parseInDTO(inStr, VolumeBookDelayInDTO.class);
        OutDTO outDto = bean.delay(inDto);
        System.out.println(outDto.toJson());

    }

    private String getRequestForQuery() {
        ArgumentBuilder builder = new ArgumentBuilder();
        Map<String, Object> busiMap = new HashMap<>();
        busiMap.put("MSISDN", "18249070556");
        busiMap.put("TRADE_SEQ", getSysdate());
        busiMap.put("USER_ID", "18249070556");
        busiMap.put("REGION_ID", "00");
        busiMap.put("PART_ID", "00");
        busiMap.put("OPER_SOURCE", "1");
        busiMap.put("OPER_CHANNEL", "1");
        busiMap.put("OPER_ID", "1"); //请求头信息

        busiMap.put("ACCT_TYPE", "65");
        busiMap.put("BALANCE_TYPE", "50008");
        busiMap.put("BALANCE_ATTR", "30001");
        busiMap.put("ADD_ATTR_CODE", "");
        busiMap.put("BALANCE_STATE", "");
        busiMap.put("QUERY_TIME", "201702");
        busiMap.put("TIME_TYPE", "1");
        busiMap.put("QUERY_TYPE", "1");
        busiMap.put("PRODUCT_ID", "");
        builder.setBusiargs(busiMap);

        Map<String, Object> oprMap = new HashMap<>();
        builder.setOperargs(oprMap);

        return builder.toString();
    }

    @Test
    public void testQuery() throws Exception {

        String inStr = this.getRequestForQuery();
        InDTO inDto = parseInDTO(inStr, VolumeBookQueryInDTO.class);
        OutDTO outDto = bean.query(inDto);
        System.out.println(outDto.toJson());

    }

    private String getRequestForInOutQuery() {
        ArgumentBuilder builder = new ArgumentBuilder();
        Map<String, Object> busiMap = new HashMap<>();
        busiMap.put("MSISDN", "18204675660");
        busiMap.put("CHANGE_REASON", "00");
        busiMap.put("TRADE_SEQ", "O" + getSysdate());
        busiMap.put("USER_ID", "230700003013725088");
        busiMap.put("REGION_ID", "00");
        busiMap.put("PART_ID", "00");
        busiMap.put("OPER_SOURCE", "00000");
        busiMap.put("OPER_CHANNEL", "00000");
        busiMap.put("OPER_ID", "hljtest"); //请求头信息

        busiMap.put("QUERY_TIME", "201702");
        busiMap.put("PRODUCT_ID", "");
        builder.setBusiargs(busiMap);

        Map<String, Object> oprMap = new HashMap<>();
        builder.setOperargs(oprMap);

        return builder.toString();
    }

    @Test
    public void testinAndOutQuery() throws Exception {

        String inStr = this.getRequestForInOutQuery();
        InDTO inDto = parseInDTO(inStr, VolumeBookInAndOutQueryInDTO.class);
        OutDTO outDto = bean.inAndOutQuery(inDto);
        System.out.println(outDto.toJson());

    }
}
