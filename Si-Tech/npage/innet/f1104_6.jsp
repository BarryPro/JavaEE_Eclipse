<%
/********************
 version v2.0
开发商: si-tech
*
*update:zhanghonga@2008-08-25 页面改造,修改样式
*
********************/
%>

<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
   
	    String retType = request.getParameter("retType");
	    String checkNo = request.getParameter("checkNo");
	    String sqlStr = "select a.BANK_CODE,c.BANK_NAME," + 
               "b.CHECK_PREPAY from DCHECKMSG a ,dCheckPrepay b,sBankCode c" + 
               " where a.BANK_CODE  = b.BANK_CODE and a.CHECK_NO  = b.CHECK_NO " +
               " and a.BANK_CODE = c.BANK_CODE " + 
               " and a. CHECK_STATUS = 'Y' and a.CHECK_NO='" + checkNo + "'";
      System.out.println(sqlStr);
	 
      String bankCode = "";
      String bankName = "";
      String checkPrePay = "";
%>
    	<wtc:pubselect name="sPubSelect"  retcode="ret_code" retmsg="ret_message"  outnum="3" >
			<wtc:sql><%=sqlStr%></wtc:sql>
			</wtc:pubselect>
			<wtc:array id="result" scope="end" />    
<%
      int recordNum=0;
			if(ret_code.equals("000000")){
			 			   ret_code="000000";
			 			   recordNum = 1;
								if(result==null){ 
									recordNum=0;
								}else{
										if(result.length!=1){
												recordNum=0; 
											}
								}
			 			
			}
			System.out.println("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"+recordNum);   
      if(recordNum == 1)
      {   
          bankCode = result[0][0];
          bankName = result[0][1];
          checkPrePay = result[0][2];
          ret_code  = "000000";
          ret_message  = "支票验证成功！";                
      }else{
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

