<%
/********************
 version v2.0
 开发商: si-tech
 update zhaohaitao at 2009.01.19
 模块:EC产品订购
********************/
%>


<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>

<%
    //得到输入参数
    String regCode = (String)session.getAttribute("regCode");
    String return_code,return_message;
    String[][] result = new String[][]{};
    //--------------------------
    String retType = request.getParameter("retType");
    String checkNo = request.getParameter("checkNo");
    String sqlStr = "select a.BANK_CODE,c.BANK_NAME," + 
           "b.CHECK_PREPAY from DCHECKMSG a ,dCheckPrepay b,sBankCode c" + 
           " where a.BANK_CODE  = b.BANK_CODE and a.CHECK_NO  = b.CHECK_NO " +
           " and a.BANK_CODE = c.BANK_CODE " + 
           " and a. CHECK_STATUS = '0' and a.CHECK_NO='" + checkNo + "'";
    String[] inParams = new String[2];
    inParams[0] = "select a.BANK_CODE,c.BANK_NAME," + 
           "b.CHECK_PREPAY from DCHECKMSG a ,dCheckPrepay b,sBankCode c" + 
           " where a.BANK_CODE  = b.BANK_CODE and a.CHECK_NO  = b.CHECK_NO " +
           " and a.BANK_CODE = c.BANK_CODE " + 
           " and a. CHECK_STATUS = '0' and a.CHECK_NO=:checkNo";
    inParams[1] = "checkNo="+checkNo;
    String ret_code  = "";
    String ret_message  = "";
    String bankCode = "";
    String bankName = "";
    String checkPrePay = "";
    try
    {
    
  		//retArray = callView.sPubSelect("3",sqlStr); 
%>
		<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regCode%>" retcode="retCode1" retmsg="retMsg1" outnum="3">			
		<wtc:param value="<%=inParams[0]%>"/>	
		<wtc:param value="<%=inParams[1]%>"/>	
		</wtc:service>	
		<wtc:array id="resultTemp"  scope="end"/>
<%
        result = resultTemp;
        int recordNum = 1;//Integer.parseInt((String)retArray.get(1));
		if(result==null || resultTemp.length==0) 
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

response.data.add("retType",retType);
response.data.add("retCode",retCode);
response.data.add("retMessage",retMessage);
response.data.add("bankCode",bankCode);
response.data.add("bankName",bankName);
response.data.add("checkPrePay",checkPrePay);
core.ajax.receivePacket(response);

