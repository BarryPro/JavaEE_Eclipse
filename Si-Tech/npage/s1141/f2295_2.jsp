   
<%
/********************
 version v2.0
 开发商 si-tech
 update hejw@2009-2-24
********************/
%>
              
<%
  String opCode = "2294";
  String opName = "集团客户预存送礼";
%>              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 

<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.sitech.boss.spubcallsvr.viewBean.*" %>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
 <%@ page import="com.sitech.boss.s1210.pub.Pub_lxd"%>
  <%@ page import="com.sitech.boss.s1100.viewBean.*" %>


<%	
	
	String work_no = (String)session.getAttribute("workNo");
	String work_name = (String)session.getAttribute("workName");
	String regionCode = (String)session.getAttribute("regCode");
	
	String cust_name=request.getParameter("cust_name");
	String gift_name=request.getParameter("gift_name");
	String prepay_money=request.getParameter("prepay_money");
	String vUnitName=request.getParameter("vUnitName");
	String paraAray[] = new String[7];
	

	paraAray[0] =request.getParameter("login_accept");
	paraAray[1] = request.getParameter("phone_no");
	paraAray[2] = request.getParameter("opcode");
	paraAray[3] = work_no;
	paraAray[4] = request.getParameter("oldaccept");
	paraAray[5] = request.getParameter("opNote");
	paraAray[6] = request.getRemoteAddr();
    
%>

    <wtc:service name="s2295Cfm" outnum="2" retmsg="msg1" retcode="code1" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=paraAray[0]%>" />
			<wtc:param value="<%=paraAray[1]%>" />	
			<wtc:param value="<%=paraAray[2]%>" />	
			<wtc:param value="<%=paraAray[3]%>" />
			<wtc:param value="<%=paraAray[4]%>" />
			<wtc:param value="<%=paraAray[5]%>" />
			<wtc:param value="<%=paraAray[6]%>" />		
		</wtc:service>
		<wtc:array id="result_t" scope="end" />	

<%    	
	
              
%>

<%String url ="/npage/contact/upCnttInfo.jsp?opCode="+opCode+
							"&retCodeForCntt="+code1+
							"&opName="+opName+
							"&workNo="+work_no+
							"&loginAccept="+paraAray[0]+
							"&pageActivePhone="+paraAray[1]+
							"&retMsgForCntt="+msg1+
							"&opBeginTime="+opBeginTime; %>
<jsp:include page="<%=url%>" flush="true" />


<%
	//String[] ret = impl.callService("s2295Cfm",paraAray,"2","region",org_code.substring(0,2));
	String errCode = code1;
	String errMsg = msg1;
	
	if (errCode.equals("000000") )
	{
S1100View callView = new S1100View();
String chinaFee = ((String[][])(callView.view_sToChinaFee(Pub_lxd.formatNumber(prepay_money,2)).get(0)))[0][2];//大写金额
System.out.print(chinaFee);
%>
<script language="JavaScript">
   rdShowMessageDialog("提交成功! 下面将打印发票！",2);
   var infoStr="";
   infoStr+="<%=work_no%>  <%=work_name%>"+"       集团客户预存送礼冲正"+"|";//工号  
   infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";
   infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
   infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
   infoStr+='<%=cust_name%>'+"|";
   infoStr+=" "+"|";
   infoStr+='<%=paraAray[1]%>'+"|";
   infoStr+=" "+"|";//协议号码   
   infoStr+=" "+"|";//协议号码     
   infoStr+="<%=chinaFee%>"+"|";//合计金额(大写)
   infoStr+="<%=Pub_lxd.formatNumber(prepay_money,2)%>"+"|";//小写 
   
                                                       
  
   
   infoStr+="集团名称：  <%=vUnitName.trim()%>    "+"~"+
		 "客户预存款: <%=Pub_lxd.formatNumber(prepay_money,2)%>"+"~"+
   "赠送礼品名称："+"<%=gift_name%>"+"|";//手机型号 		

	 infoStr+="<%=work_name%>"+"|";//开票人
	 infoStr+=" "+"|";//收款人
  // location="/page/s1210/chkPrint.jsp?retInfo="+infoStr+"&dirtPage=/page/s1775/f1775_1.jsp";
   //location="/npage/public/hljBillPrint.jsp?retInfo="+infoStr+"&dirtPage=/npage/s1141/f2294_login.jsp?ph_no=<%=paraAray[1]%>";
   location="/npage/public/hljBillPrintNew.jsp?retInfo="+infoStr+"&op_code=2295&loginAccept=<%=paraAray[0]%>&dirtPage=/npage/s1141/f2294_login.jsp?ph_no=<%=paraAray[1]%>";
</script>
<%
	}else{
%>   
<script language="JavaScript">
	rdShowMessageDialog("集团客户预存送礼冲正失败!(<%=errMsg%>",0);
	window.location="f2294_login.jsp?ph_no=<%=paraAray[1]%>";
</script>
<%}%>
