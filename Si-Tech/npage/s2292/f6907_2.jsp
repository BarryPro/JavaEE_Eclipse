<%
/********************
 * version v2.0
 * 开发商: si-tech
 * update by wangjya @ 2009-04-14
 ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%	

	String work_no = (String)session.getAttribute("workNo");
	String work_name = (String)session.getAttribute("workName");
	String org_code = (String)session.getAttribute("orgCode");
	String pass = (String)session.getAttribute("password");
	String ip_Addr = (String)session.getAttribute("ipAddr");

	String themob=request.getParameter("phone_no");
	String theop_code=request.getParameter("opcode");
	//  入口参数赋值 : 1操作流水 2手机号码 3操作工号 4操作代码 5用户类型  6操作备注  7IP地址
	String paraAray[] = new String[10];

//标准化入参 hejwa add 2013年12月16日14:13:13
paraAray[0] = "0";                                   //流水
paraAray[1] = "01";                                  //渠道代码
paraAray[2] = request.getParameter("opcode");        //操作代码
paraAray[3] = work_no;                               //工号
paraAray[4] = pass;                                  //工号密码
paraAray[5] = request.getParameter("phone_no");      //用户号码
paraAray[6] = "";                                    //用户密码
//原入参去掉标准化重复的部分
paraAray[7] = request.getParameter("opNote");
paraAray[8] = request.getParameter("ip_Addr");
paraAray[9] = request.getParameter("favour_type");
	for (int i=0;i<10;i++)
	{
	    System.out.println("hejwa paraAray["+i+"]=  "+paraAray[i]);
	}
%>
<wtc:service name="s6907Cfm" routerKey="phone" routerValue="<%=themob%>" retcode="errCode" retmsg="errMsg" outnum="2">
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
</wtc:service>
<wtc:array id="s6907CfmArr" scope="end" />

<%
	System.out.println("in f6907_2.jsp - s6907Cfm :  "+errCode+" : "+errMsg);
    System.out.println("%%%%%%%%调用统一接触开始%%%%%%%%");
    String url = "/npage/contact/upCnttInfo.jsp?opCode="+"6907"+"&retCodeForCntt="+errCode+"&opName="+"号簿管家包月申请"+"&workNo="+work_no+"&loginAccept="+paraAray[0]+"&pageActivePhone="+themob+"&retMsgForCntt="+errMsg+"&opBeginTime="+opBeginTime;
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
   rdShowMessageDialog("提交成功",2);
   window.location="f6907_login.jsp?activePhone=<%=themob%>&opCode=6907&opName=号簿管家包月申请";
 
</script>
<%
	}else{
%>   
<script language="JavaScript">
	rdShowMessageDialog("号簿管家包月申请失败!(<%=errMsg%>",0);
	window.location="f6907_login.jsp?activePhone=<%=themob%>&opCode=6907&opName=号簿管家包月申请";
</script>
<%}%>
