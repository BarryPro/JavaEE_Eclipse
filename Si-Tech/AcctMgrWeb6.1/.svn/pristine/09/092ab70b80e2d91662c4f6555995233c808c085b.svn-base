/**
 *
 */
package com.sitech.acctmgr.test.atom.impl.acctmng;

import com.sitech.acctmgr.atom.dto.acctmng.*;
import com.sitech.acctmgr.inter.acctmng.I8225;
import com.sitech.acctmgr.test.junit.ArgumentBuilder;
import com.sitech.acctmgr.test.junit.BaseTestCase;
import com.sitech.jcfx.dt.MBean;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;
import org.junit.Before;
import org.junit.Ignore;
import org.junit.Test;

import java.util.HashMap;
import java.util.Map;

/**
 * @author wangyla
 */
public class S8225Test extends BaseTestCase {
    private I8225 bean = null;

    @Before
    public void before() {
        bean = (I8225) getBean("8225Svc");
    }

    public String getArgstringCollBill() {
        ArgumentBuilder builder = new ArgumentBuilder();
        Map<String, Object> busiargs = new HashMap<String, Object>();

        busiargs.put("CONTRACT_NO", "230880003002319801");
        busiargs.put("BILL_CYCLE", "201608");
        busiargs.put("PAGE_SIZE", "10");
        busiargs.put("PAGE_NUM", "1");
        busiargs.put("OP_TYPE", "NORMAL");
        //busiargs.put("OP_TYPE", "ERROR");
        busiargs.put("QRY_TYPE", "2");
        builder.setBusiargs(busiargs);
        Map<String, Object> operargs = new HashMap<String, Object>();
        operargs.put("OP_CODE", "8225");
        builder.setOperargs(operargs);
        String argstring = builder.toString();
        return argstring;
    }

    @Test
    public void testQryCollBill() throws Exception {
        String inString = getArgstringCollBill();
        MBean mbean = new MBean(inString);
        InDTO inParam = this.parseInDTO(mbean, S8225QryCollBillInDTO.class);
        OutDTO outDto = bean.qryCollBill(inParam);
        System.out.println(outDto.toJson());
    }

    public String getArgstringForCollBillByPhone() {
        ArgumentBuilder builder = new ArgumentBuilder();
        Map<String, Object> busiargs = new HashMap<String, Object>();

        busiargs.put("CONTRACT_NO", "230860003008049602");
        busiargs.put("BILL_CYCLE", "201607");
        busiargs.put("PHONE_NO", "18345642569");
        builder.setBusiargs(busiargs);
        Map<String, Object> operargs = new HashMap<String, Object>();
        operargs.put("OP_CODE", "8225");
        builder.setOperargs(operargs);
        String argstring = builder.toString();
        return argstring;
    }

    @Test
    public void testQryCollBillByPhone() throws Exception {
        String inString = getArgstringForCollBillByPhone();
        MBean mbean = new MBean(inString);
        InDTO inParam = this.parseInDTO(mbean, S8225QryCollBillByPhoneInDTO.class);
        OutDTO outDto = bean.qryCollBillByPhone(inParam);
        System.out.println(outDto.toJson());
    }


    public String getArgstringForCollBillByCon() {
        ArgumentBuilder builder = new ArgumentBuilder();
        Map<String, Object> busiargs = new HashMap<String, Object>();
        busiargs.put("CONTRACT_NO", "230880003002319801");
        busiargs.put("BILL_CYCLE", "201608");
        builder.setBusiargs(busiargs);
        Map<String, Object> operargs = new HashMap<String, Object>();
        operargs.put("OP_CODE", "8225");
        builder.setOperargs(operargs);
        String argstring = builder.toString();
        return argstring;
    }

    @Test
    public void testQryCollBillByCon() throws Exception {
        String inString = getArgstringForCollBillByCon();
        MBean mbean = new MBean(inString);
        InDTO inParam = this.parseInDTO(mbean, S8225QryCollBillByConInDTO.class);
        OutDTO outDto = bean.qryCollBillByCon(inParam);
        System.out.println(outDto.toJson());
    }

    public String getArgstringForCollCodeOpr(){
        String argstring = null;
        ArgumentBuilder builder = new ArgumentBuilder();
        Map<String, Object> busiargs = new HashMap<String, Object>();
        busiargs.put("OP_TYPE", "q");
        busiargs.put("CODE_ID", "");
        busiargs.put("CODE_VALUE", "");
        busiargs.put("STATUS", "");

		/*busiargs.put("OP_TYPE", "a");
		busiargs.put("CODE_ID", "99");
		busiargs.put("CODE_VALUE", "Test");
		busiargs.put("STATUS", "0");*/

		/*busiargs.put("OP_TYPE", "u");
		busiargs.put("CODE_ID", "99");
		busiargs.put("CODE_VALUE", "Test2");
		busiargs.put("STATUS", "1");*/

		/*busiargs.put("OP_TYPE", "d");
		busiargs.put("CODE_ID", "99");
		busiargs.put("CODE_VALUE", "");
		busiargs.put("STATUS", "");*/

        builder.setBusiargs(busiargs);
        Map<String, Object> operargs = new HashMap<String, Object>();
        operargs.put("LOGIN_NO", "aan70W");
        operargs.put("GROUP_ID", "13436");
        operargs.put("OP_CODE", "8225");
        builder.setOperargs(operargs);
        argstring = builder.toString();

        return argstring;
    }

    @Test
    public void testCollCodeOpr() {
        String inString = getArgstringForCollCodeOpr();
        MBean mbean = new MBean(inString);
        System.out.println(inString);
        InDTO inParam = this.parseInDTO(mbean, S8225CollCodeInDTO.class);
        OutDTO outDto = bean.collCodeOpr(inParam);
        System.out.println(outDto.toJson());

    }

    public String getArgstringCalBill(){
        String argstring = null;
        ArgumentBuilder builder = new ArgumentBuilder();
        Map<String, Object> busiargs = new HashMap<String, Object>();
        busiargs.put("BEGIN_CONTRACT_NO", "230880003002319801");
        busiargs.put("END_CONTRACT_NO", "230880003002319801");
        busiargs.put("BILL_CYCLE", "201608");
        busiargs.put("RETURN_CODE", "00"); //00
        busiargs.put("DIS_GROUP_ID", ""); //21

        builder.setBusiargs(busiargs);

        Map<String, Object> operargs = new HashMap<String, Object>();
        operargs.put("GROUP_ID", "13436");
        operargs.put("LOGIN_NO", "aan70W");
        builder.setOperargs(operargs);
        argstring = builder.toString();
        return argstring;
    }

    @Test
    public void testCalCollBill() throws Exception{
        String inString = getArgstringCalBill();
        MBean mbean = new MBean(inString);
        InDTO inParam = this.parseInDTO(mbean, S8225CalCollBillInDTO.class);
        OutDTO retOutDTO = bean.calCollBill(inParam);
        System.out.println(retOutDTO.toJson());

    }

}
