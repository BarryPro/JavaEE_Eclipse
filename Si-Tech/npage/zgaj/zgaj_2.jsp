<%
/********************
 * version v2.0
 * 开发商: si-tech
 * update by zhangshuaia @ 2009-08-05
 ********************/
%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%	
    String org_Code = (String)session.getAttribute("orgCode");
    String regionCode = org_Code.substring(0,2);				   
	String op_code = "zgaj";              //操作代码
	
	String work_no = (String)session.getAttribute("workNo"); 
	String phone_no = request.getParameter("phone_no");
	String beginTime = request.getParameter("beginTime");
	String endTime = request.getParameter("endTime");
	String searchType = request.getParameter("searchType");
	String tsdzls =  request.getParameter("tsdzls");
	/*
	工号	字符串	6		
	电话号码	字符串	15		Yyyymm
	查询类型	字符串	2		11-35  或者0 
	时间类型	字符串	1		默认传 0 
	时间字符串	字符串	60		Yyyymmdd^ Yyyymmdd^

	*/
	//String sjzfc = beginTime+"^"+endTime+"^";//只要月份
	String sjzfc = beginTime;
%>
<wtc:service name="s4141_spec" routerKey="phone" routerValue="<%=phone_no%>" retcode="s4141CfmCode" retmsg="s4141CfmMsg" outnum="2" >
    <wtc:param value="<%=work_no%>"/>
    <wtc:param value="<%=phone_no%>"/>
	<wtc:param value="<%=searchType%>"/> 
	<wtc:param value="1"/> 
	<wtc:param value="<%=sjzfc%>"/> 
</wtc:service>
<wtc:array id="s4141CfmArr" scope="end"/>
<%
	String retCode= s4141CfmCode;
	String retMsg = s4141CfmMsg;

	System.out.println("fffffffffffffffffffffffffdddddddddddddddddddddaaaaaaaaaaaaaaaaaaaaaa retCode === "+ retCode+" and s4141CfmCode is "+s4141CfmCode);
	System.out.println("retMsg === "+ retMsg);
	
    System.out.println("%%%%%%%%调用统一接触结束%%%%%%%%");

	String errMsg = s4141CfmMsg;
	if (s4141CfmCode=="000000"||s4141CfmCode.equals("000000"))
	{
	  
	System.out.println("success");
%>
<script language="JavaScript">
	//rdShowMessageDialog("文件处理成功！",2);
	window.location="zgaj_3.jsp?phone_no=<%=phone_no%>&beginTime=<%=beginTime%>&endTime=<%=endTime%>&searchType=<%=searchType%>&tsdzls=<%=tsdzls%>";
	</script>
<%
	}else{
%>   
<script language="JavaScript">
	rdShowMessageDialog("文件处理失败,错误代码:<%=s4141CfmCode%>,错误原因:<%=s4141CfmMsg%>",0);//这个页面是为了调用详单入表后查询的 到时候颠倒下 成功和失败的返回页面 
	history.go(-1);
	//alert(window.location);
	</script>
<%}
%>

