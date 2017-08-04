<%
/********************
 version v2.0
开发商: si-tech
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=gbk"%>
<%@ include file="/npage/include/public_title_name.jsp" %>


<%

	String opCode = request.getParameter("opCode");
	String opName = request.getParameter("opName");

	String group_id = (String)session.getAttribute("groupId");
	String work_no = (String)session.getAttribute("workNo");
	String work_name = WtcUtil.repNull((String)session.getAttribute("workName"));	
	String org_code = (String)session.getAttribute("orgCode");
	String pass = WtcUtil.repNull((String)session.getAttribute("password"));
	String ip_Addr =(String)session.getAttribute("ipAddr");
	String regionCode = WtcUtil.repNull((String)session.getAttribute("regCode"));
	String paraAray[] = new String[6];
	paraAray[0] = request.getParameter("login_accept");
	paraAray[1] = request.getParameter("flag");
	paraAray[2] = work_no;
	paraAray[3] = "4928";
	paraAray[4] = org_code;
	paraAray[5] = group_id;

	for (int i =0;i<paraAray.length;i++)
	{
		System.out.println("wanghyd------paraAray[]"+i+"="+paraAray[i]);
	}

  String begin_time = request.getParameter("begin_time");
	String end_time = request.getParameter("end_time");
%>
		<wtc:service name="s4929Cfm" routerKey="region" routerValue="<%=regionCode%>"
					 retcode="retCode" retmsg="retMsg" outnum="2">
				<wtc:param value="<%=paraAray[0]%>"/>
				<wtc:param value="<%=paraAray[1]%>"/>
				<wtc:param value="<%=paraAray[2]%>"/>
				<wtc:param value="<%=paraAray[3]%>"/>
				<wtc:param value="<%=paraAray[4]%>"/>
				<wtc:param value="<%=paraAray[5]%>"/>
	  </wtc:service>
		<wtc:array id="ret" scope="end"/>
<%

	System.out.println("wanghyd----4928---retCode="+retCode);
	System.out.println("wanghyd----4928---retMsg="+retMsg);

	if (retCode.equals("000000") || retCode.equals("0"))
	{
%>
<script language="JavaScript">
   rdShowMessageDialog("提交成功! ",2);
   window.location="f4928Qry.jsp?begin_time=<%=begin_time%>&end_time=<%=end_time%>&opCode=<%=opCode%>&opName=<%=opName%>";
</script>
<%
	}else{
%>
<script language="JavaScript">
	rdShowMessageDialog("提交失败!(<%=retMsg%>",0);
	window.location="f4928Qry.jsp?begin_time=<%=begin_time%>&end_time=<%=end_time%>&opCode=<%=opCode%>&opName=<%=opName%>";
</script>
<%

}%>
