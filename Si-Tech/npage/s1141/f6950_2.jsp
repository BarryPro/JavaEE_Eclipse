<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * 功能: 集团统一预存赠礼冲正6950
   * 版本: 1.0
   * 日期: 2009/8/19
   * 作者: sunaj
   * 版权: si-tech
   * update:
  */
%>
<%@ page contentType="text/html;charset=gbk"%>
<%@ page import="com.sitech.boss.spubcallsvr.viewBean.*" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.s1100.viewBean.*" %>

<%	
//	SPubCallSvrImpl impl = new SPubCallSvrImpl();
	String opCode="6950";
	String opName="集团统一预存赠礼冲正";
	String work_no = (String)session.getAttribute("workNo");
	String work_name = (String)session.getAttribute("workName");
	String cust_name = request.getParameter("cust_name"); 
	String sum_money = request.getParameter("sum_money");
	String regionCode = (String)session.getAttribute("regCode");			//地市
	String chinaFee = "";													//大写金额
	String phoneNo = (String)request.getParameter("phone_no");				//手机号码
	
	String paraAray[] = new String[7];
	paraAray[0] = request.getParameter("login_accept");						//流水
	paraAray[1] = request.getParameter("phone_no");							//手机号码
	paraAray[2] = request.getParameter("opcode");
    paraAray[3] = work_no;
    paraAray[4] = request.getParameter("backaccept");
	paraAray[5] = request.getParameter("opNote");
	paraAray[6] = request.getParameter("preFlag");

%>
	<wtc:service name="s6950Cfm" routerKey="region" routerValue="<%=regionCode%>" outnum="2" retcode="retCode" retmsg="retMsg">
		<wtc:param value="<%=paraAray[0]%>"/>
		<wtc:param value="<%=paraAray[1]%>"/>
		<wtc:param value="<%=paraAray[2]%>"/>
		<wtc:param value="<%=paraAray[3]%>"/>
		<wtc:param value="<%=paraAray[4]%>"/>
		<wtc:param value="<%=paraAray[5]%>"/>
		<wtc:param value="<%=paraAray[6]%>"/>
	</wtc:service>
	<wtc:array id="result" scope="end"/>
<%
	String errCode = retCode;
	String errMsg = retMsg;
	if (errCode.equals("000000") )
	{
%>
	<wtc:service name="sToChinaFee" routerKey="region" routerValue="<%=regionCode%>" retcode="sToChinaFeeCode" retmsg="sToChinaFeeMsg" outnum="3">
		<wtc:param value="<%=WtcUtil.formatNumber(sum_money,2)%>"/>
	</wtc:service>
	<wtc:array id="result" scope="end"/>
<%
    if(result.length>0 && sToChinaFeeCode.equals("0")){
        chinaFee = result[0][2];
    }
    
	System.out.print(chinaFee);
%>
<%
	String url ="/npage/contact/upCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+retCode+"&opName="+opName+"&workNo="+work_no+"&loginAccept="+paraAray[0]+"&pageActivePhone="+phoneNo+"&retMsgForCntt="+retMsg+"&opBeginTime="+opBeginTime;
	System.out.println("url===="+url);
%>
	<jsp:include page="<%=url%>" flush="true" />	
		<script language="JavaScript">
		   rdShowMessageDialog("确认成功!",2);
		   var infoStr="";
		   //infoStr+="<%=work_no%>  <%=work_name%>"+"       集团统一预存赠礼冲正"+"|";//工号  
		   //infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";
		   //infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
		   //infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
		   //infoStr+='<%=cust_name%>'+"|";
		   //infoStr+=" "+"|";
		   //infoStr+='<%=paraAray[1]%>'+"|";
		   //infoStr+=" "+"|";//协议号码                                                          
		   //infoStr+=" "+"|";
		   //infoStr+="<%=chinaFee%>"+"|";//合计金额(大写)
		   //infoStr+="<%=WtcUtil.formatNumber(sum_money,2)%>"+"|";//小写 
		   //infoStr+="退预存款：  <%=sum_money%>元"+"|";
				
			//infoStr+="<%=work_name%>"+"|";//开票人
			//infoStr+=" "+"|";//收款人
			//dirtPate = "/npage/s1141/f6949_login.jsp;
			window.location="f6949_login.jsp?activePhone=<%=phoneNo%>&opCode=6950&opName=集团统一预存赠礼冲正";
		   //location="/npage/public/hljBillPrint.jsp?retInfo="+infoStr+"&dirtPage="+codeChg(dirtPate);
		</script>
<%
	}else{
%>   
<script language="JavaScript">
	rdShowMessageDialog("集团统一预存赠礼冲正失败!(<%=errMsg%>",0);
	window.location="f6949_login.jsp?activePhone=<%=phoneNo%>&opCode=6950&opName=集团统一预存赠礼冲正";
</script>
<%}%>
