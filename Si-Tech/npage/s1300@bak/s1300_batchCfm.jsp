<%
/********************
 version v2.0
开发商: si-tech
*
*update:zhanghonga@2008-08-15 页面改造,修改样式
*
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	
<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*"%>
 <%
	response.setHeader("Pragma","No-Cache"); 
	response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0); 
	
  String opCode = "1304";
  String opName = "缴费(托收)";

 	String batchNo = request.getParameter("TBatchNo");
	String contract_no = request.getParameter("TContractNo");
	String bill_date = request.getParameter("TBillDate");
	String ret_code = request.getParameter("returnCode");
	String payMoney = request.getParameter("TBusyMoney");
	String payNote = request.getParameter("TBackNote");

 	String payType="4";
 	
 	String workNo = (String)session.getAttribute("workNo");
	String workname = (String)session.getAttribute("workName");
	String orgCode = (String)session.getAttribute("orgCode");
	String regionCode = (String)session.getAttribute("regionCode");
	String nopass = (String)session.getAttribute("password");

	if (payNote.equals(""))
		{payNote="托收缴费:"+contract_no;}


	String[] inParas = new String[10];
	inParas[0] = workNo;
	inParas[1] = nopass;
	inParas[2] = orgCode;
  inParas[3] = opCode;
	inParas[4] = contract_no;
	inParas[5] = payMoney;
	inParas[6] = bill_date;
  inParas[7] = payType;
	inParas[8] = payNote;
	inParas[9] = batchNo;
	//CallRemoteResultValue  value  = viewBean.callService("1", orgCode.substring(0,2),  "s1300CfmCon", "3"  , inParas ) ;
%>
    <!-- chenhu add -->
<wtc:service name="bs_ChnPayLimit" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="5" >
	<wtc:param value="<%=workNo%>"/>
  <wtc:param value="<%=payMoney%>"/>
    </wtc:service>
    <wtc:array id="result4"   scope="end" />
    <wtc:array id="result5"  scope="end" /> 	
    <wtc:array id="result6"  scope="end" />
    <wtc:array id="result7"  scope="end" />
    <wtc:array id="result8"  scope="end" />
<%      
				 String t_return_code = result4[0][0].trim();
				String t_return_msg = result5[0][0].trim();
				String flag_status  = result6[0][0].trim(); 
				String pledge_fee  = result7[0][0].trim(); 
				String total_money = result8[0][0].trim(); 
				System.out.println("chenhu test ############################ test t_return_code is "+t_return_code);
				System.out.println("chenhu test ############################ test t_return_msg is "+t_return_msg);
				System.out.println("chenhu test ############################ test flag_status is "+flag_status);
				if(!t_return_code.equals("000000")){
%>
 <script language='jscript'>			
						rdShowMessageDialog("查代理商错误！<br>错误代码：'<%=t_return_code%>'。<br>错误信息：'<%=t_return_msg%>'。",0);
						history.go(-1);
	</script>	    
<%		
				}
%>	
    <!-- chenhu add end-->
<%
if(t_return_code.equals("000000")){
%>
	<wtc:service name="s1300CfmCon" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="3" >
	<wtc:param value="<%=inParas[0]%>"/>
	<wtc:param value="<%=inParas[1]%>"/>
	<wtc:param value="<%=inParas[2]%>"/>
	<wtc:param value="<%=inParas[3]%>"/>
	<wtc:param value="<%=inParas[4]%>"/>
	<wtc:param value="<%=inParas[5]%>"/>
	<wtc:param value="<%=inParas[6]%>"/>
	<wtc:param value="<%=inParas[7]%>"/>
	<wtc:param value="<%=inParas[8]%>"/>
	<wtc:param value="<%=inParas[9]%>"/>
	</wtc:service>
	<wtc:array id="result" scope="end"/>
<%
	 System.out.println("%%%%%%%调用统一接触开始%%%%%%%%");
	 String cnttOpCode = opCode;
	 String cttOpNamge = opName;
	 String cnttWorkNo = workNo;
	 String retCodeForCntt = result.length>0?result[0][0]:"999999";
	 //String cnttLoginAccept = result.length>0?result[0][0]:"";
	 String cnttLoginAccept = "";
	 System.out.println("--------------流水----:"+cnttLoginAccept);
	 String cnttContactId = contract_no;
	 String cnttUserType = "acc";
	 
	 String url = "/npage/contact/upCnttInfo_boss.jsp?opCode="+cnttOpCode+"&retCodeForCntt="+retCodeForCntt+"&opName="+cttOpNamge+"&workNo="+cnttWorkNo+"&loginAccept="+cnttLoginAccept+"&contactId="+cnttContactId+"&contactType="+cnttUserType;
	 System.out.println("%%%%%%%调用统一接触结束%%%%%%%%");
%>
		<jsp:include page="<%=url%>" flush="true" />
<%
	String return_code = "999999";
	if(result!=null&&result.length>0){
		return_code = result[0][0];
	}
	String error_msg = SystemUtils.ISOtoGB(ErrorMsg.getErrorMsg(return_code)); 
%>

<%if( !return_code.equals("000000"))
	{%>
<script language="JavaScript">
	rdShowMessageDialog("托收单确认失败。<br>错误代码:<%=return_code %>");
	window.history.go(-1);
</script>

<%}else{%>
<script language="JavaScript">
	rdShowMessageDialog("托收单确认成功!",2);
	document.location.replace("s1300_3.jsp");
</script>
<%}
}else{%>
		<SCRIPT LANGUAGE="JavaScript">
		<!--
			rdShowMessageDialog("查询错误!<br>错误代码：'<%=t_return_code%>'，错误信息：'<%=t_return_msg%>'。");
			window.history.go(-1);
		//-->
		</SCRIPT>
<%}%>