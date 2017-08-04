<%
/********************
 * version v2.0
 * 开发商: si-tech
 * update by wangjya @ 2009-04-16
 ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>

<%	
 	String work_no = (String)session.getAttribute("workNo");
	String work_name = (String)session.getAttribute("workName");
	String org_code = (String)session.getAttribute("orgCode");
	String pass = (String)session.getAttribute("password");
	String ip_Addr = (String)session.getAttribute("ipAddr");
	String cust_name=request.getParameter("cust_name");
	String card_info=request.getParameter("cardy");
	String card_money=request.getParameter("card_money");
	
	String prepay_fee=request.getParameter("pay_money");
	String print2=request.getParameter("print2");
	String phone_typename=request.getParameter("phone_typename");
	String gift_name=request.getParameter("gift_name");
	String stream=request.getParameter("login_accept");
	String thework_no=work_no;
	String themob=request.getParameter("phone_no");
	String theop_code=request.getParameter("opcode");
  	//  操作流水      手机号码       操作工号        操作代码         旧流水   专款回退金额
// 用户当前类型   用户下个类型  用户原状态       操作备注         IP地址
	String paraAray[] = new String[11];
    paraAray[0] =request.getParameter("login_accept");
    paraAray[1] = request.getParameter("phone_no");
    paraAray[2] = work_no;
    paraAray[3] = theop_code;
    paraAray[4] = request.getParameter("back_accept");
    paraAray[5] = request.getParameter("pay_fee");
    paraAray[6] = request.getParameter("cur_level");
    paraAray[7] = request.getParameter("next_level");
    paraAray[8] = request.getParameter("old_level");
	paraAray[9] = request.getParameter("opNote");
	paraAray[10] = request.getParameter("ipAddr");
%>

<wtc:service name="s6910Cfm" routerKey="region" routerValue="<%=org_code.substring(0,2)%>" retcode="errCode" retmsg="errMsg" outnum="2">
	<wtc:param value="<%=paraAray[0]%>"/> 
	<wtc:param value="<%=paraAray[1]%>"/> 
    <wtc:param value="<%=paraAray[2]%>"/> 
    <wtc:param value="<%=paraAray[3]%>"/>
    <wtc:param value="<%=paraAray[4]%>"/>
    <wtc:param value="<%=paraAray[5]%>"/>
    <wtc:param value="<%=paraAray[6]%>"/>
    <wtc:param value="<%=paraAray[7]%>"/>
    <wtc:param value="<%=paraAray[8]%>"/>
    <wtc:param value="<%=paraAray[9]%>"/>
    <wtc:param value="<%=paraAray[10]%>"/>
</wtc:service>
<wtc:array id="s6910CfmArr" scope="end" />

<%
	System.out.println("in f6910_2.jsp - s6910Cfm :  "+errCode+" : "+errMsg);
    System.out.println("%%%%%%%%调用统一接触开始%%%%%%%%");
    String url = "/npage/contact/upCnttInfo.jsp?opCode="+"6910"+"&retCodeForCntt="+errCode+"&opName="+"号簿管家包年申请冲正"+"&workNo="+work_no+"&loginAccept="+paraAray[0]+"&pageActivePhone="+themob+"&retMsgForCntt="+errMsg+"&opBeginTime="+opBeginTime;
%>
    <jsp:include page="<%=url%>" flush="true" />
<%

    System.out.println("%%%%%%%%调用统一接触结束%%%%%%%%");
    
	if (errCode.equals("000000"))
	{
	    String chinaFee = "";
 %>
    <wtc:service name="sToChinaFee" routerKey="phone" routerValue="<%=themob%>" retcode="sToChinaFeeCode" retmsg="sToChinaFeeMsg" outnum="3">
        <wtc:param value="0"/>
    </wtc:service>
    <wtc:array id="result" scope="end"/>
<%
        if(result.length>0 && sToChinaFeeCode.equals("0")){
            chinaFee = result[0][2];
        }
        System.out.print("chinaFee   ===   "+chinaFee);
%>
<script language="JavaScript">
   rdShowMessageDialog("提交成功！",2);
   window.location="f6909_login.jsp?activePhone=<%=themob%>&opCode=6910&opName=号簿管家包年申请冲正";
 
</script>
<%
	}else{
%>   
<script language="JavaScript">
	rdShowMessageDialog("号簿管家包年申请冲正失败!(<%=errMsg%>");
	window.location="f6909_login.jsp?activePhone=<%=themob%>&opCode=6910&opName=号簿管家包年申请冲正";
</script>
<%}%>
