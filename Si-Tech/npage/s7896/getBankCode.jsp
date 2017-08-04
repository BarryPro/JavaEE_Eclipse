<%
/********************
 * version v2.0
 * 开发商: si-tech
 * update by qidp @ 2009-01-16
 ********************/
%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%@ page import="com.sitech.boss.pub.*" %>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="com.sitech.boss.pub.conn.*" %>
<%@ page import="com.sitech.boss.pub.exception.*" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="com.sitech.boss.pub.wtc.*" %>
<%@ page import="java.util.ArrayList" %>
<%
        //得到输入参数
        ArrayList retArray = new ArrayList();
        String return_code,return_message;
        String[][] result = new String[][]{};
        String orgCode = (String)session.getAttribute("orgCode");
        String regionCode = orgCode.substring(0,2);
 		//SPubCallSvrImpl callView = new SPubCallSvrImpl();
	    //--------------------------
	    String retType = request.getParameter("retType");
	    String checkNo = request.getParameter("checkNo");
	    String sqlStr = "select a.BANK_CODE,c.BANK_NAME," + 
               "b.CHECK_PREPAY from DCHECKMSG a ,dCheckPrepay b,sBankCode c" + 
               " where a.BANK_CODE  = b.BANK_CODE and a.CHECK_NO  = b.CHECK_NO " +
               " and a.BANK_CODE = c.BANK_CODE " + 
               " and a. CHECK_STATUS = '0' and a.CHECK_NO=:checkNo";
        System.out.println(sqlStr);
	    String ret_code  = "";
        String ret_message  = "";
        String bankCode = "";
        String bankName = "";
        String checkPrePay = "";
        try
        {
        
      		//retArray = callView.sPubSelect("3",sqlStr); 
      		
            String [] paraIn = new String[2];
        	paraIn[0] = sqlStr;    
            paraIn[1]="checkNo="+checkNo;
            System.out.println("checkNo="+checkNo);
    %>
            <wtc:service name="TlsPubSelBoss" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2" outnum="3" >
            	<wtc:param value="<%=paraIn[0]%>"/>
            	<wtc:param value="<%=paraIn[1]%>"/> 
            </wtc:service>
            <wtc:array id="retArr2" scope="end"/>
    <%
            if(retCode2.equals("000000")){
                result = retArr2;
            }
            //result = (String[][])retArray.get(0);
            int recordNum = 1;//Integer.parseInt((String)retArray.get(1));
			if(result==null) 
			  recordNum=0;
			else
			{
              if(result.length!=1)
                recordNum=0;  
			}

            if(result[0][0]!="")
            {   
                bankCode = result[0][0];
				System.out.println("bankCode="+bankCode);
                bankName = result[0][1];
				System.out.println("bankName="+bankName);
                checkPrePay = result[0][2];
				System.out.println("checkPrePay="+checkPrePay);
                ret_code  = "000000";
                ret_message  = "支票验证成功！";                
            }
            else
            {
                ret_code = "000001";
                ret_message = "支票验证失败，没有该支票号码信息！";
				System.out.println(ret_message);
            }
            
        }catch(Exception e){
            ret_code = "000001";
            ret_message = "支票验证失败，没有该支票号码信息！";
            
        }
		
%>
var response = new AJAXPacket();
var retType = "";
var retCode = "";
var retMessage = "";
var bankCode = "";
var bankName = "";
var checkPrePay = "";
retType = "<%=retType%>";
retCode = "<%=ret_code%>";
retMessage = "<%=ret_message%>";
bankCode = "<%=bankCode%>";
bankName = "<%=bankName%>";
checkPrePay = "<%=checkPrePay%>";

response.guid = '<%=request.getParameter("guid") %>';
response.data.add("retType",retType);
response.data.add("retCode",retCode);
response.data.add("retMessage",retMessage);
response.data.add("bankCode",bankCode);
response.data.add("bankName",bankName);
response.data.add("checkPrePay",checkPrePay);
core.ajax.receivePacket(response);

