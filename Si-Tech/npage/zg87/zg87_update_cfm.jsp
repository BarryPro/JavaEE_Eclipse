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
    String opCode="zg87";
	String opName="积分计算要素管理";	
 
    String workNo=(String)session.getAttribute("workNo");
    String loginName = (String)session.getAttribute("workName");
    String regionCode=(String)session.getAttribute("regCode");
	String contextPath = request.getContextPath();
	String pass = (String)session.getAttribute("password");
	
	//服务入参 
	String dsxx = request.getParameter("dsxx");
	String ppxx = request.getParameter("ppxx");
	String jflx = request.getParameter("jflx");
	String jsys = request.getParameter("jsys");
	String sxzt = request.getParameter("sxzt");
	String beizhu = request.getParameter("beizhu");
	String jfjhmc = request.getParameter("jfjhmc");
	String wl_max = request.getParameter("wl_max");
	String wl_min = request.getParameter("wl_min");
	String jfbl = request.getParameter("jfbl1");
	String jsysz =  request.getParameter("jsysz");
	String shengxiao_time = request.getParameter("shengxiao_time");
	//[2015/04/11 20150302 00:00:01 2015/03/27
	if(shengxiao_time.length()==10)
	{
		shengxiao_time=shengxiao_time.substring(0,4)+shengxiao_time.substring(5,7)+shengxiao_time.substring(8,10);
	}
	
	//shengxiao_time=shengxiao_time.substring(0,4)+shengxiao_time.substring(5,7)+shengxiao_time.substring(8,10);
	String shixiao_time = request.getParameter("shixiao_time");
	if(shixiao_time.length()==10)
	{
		shixiao_time=shixiao_time.substring(0,4)+shixiao_time.substring(5,7)+shixiao_time.substring(8,10);
	}
	//shixiao_time=shixiao_time.substring(0,4)+shixiao_time.substring(5,7)+shixiao_time.substring(8,10);
	System.out.println("AAAAAAAAAAAAAAAAAA dsxx is "+dsxx+" and sxzt is "+sxzt);

	String paraAray[] = new String[16];
	paraAray[0]="u";
	paraAray[1]=dsxx;
	paraAray[2]=ppxx;
	paraAray[3]=jflx;
	paraAray[4]=jsys;
	paraAray[5]=jsysz;
	paraAray[7]=wl_max;
	paraAray[6]=wl_min;
	paraAray[8]=jfbl;
	paraAray[9]=shengxiao_time;
	paraAray[10]=shixiao_time;
	paraAray[11]="";//更新时间
	paraAray[12]=workNo;
	paraAray[13]=sxzt;
	paraAray[14]=beizhu;
	paraAray[15]=jfjhmc;
%>

<wtc:service name="sCompConf" routerKey="region" routerValue="<%=regionCode%>" retcode="g089CfmCode" retmsg="g089CfmMsg" outnum="16" >
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
	<wtc:param value="<%=paraAray[11]%>"/>
	<wtc:param value="<%=paraAray[12]%>"/>
	<wtc:param value="<%=paraAray[13]%>"/>
	<wtc:param value="<%=paraAray[14]%>"/>
	<wtc:param value="<%=paraAray[15]%>"/>
    
</wtc:service>
<wtc:array id="r_return_code" scope="end" start="0"  length="2" />
<wtc:array id="r_return_code" scope="end" start="2"  length="14" />
<%
	String retCode= g089CfmCode;
	String retMsg = g089CfmMsg;

	System.out.println("retCode === "+ retCode);
	System.out.println("retMsg === "+ retMsg);
%>
 
<%
   

	String errMsg = g089CfmMsg;
	if ( g089CfmCode.equals("000000"))
	{
 
%>
<script language="JavaScript">
	rdShowMessageDialog("修改成功！");
	window.location="zg87_update.jsp?opCode=g089&opName=集团红黑名单管理";
	</script>
<%
	}else{
%>   
<script language="JavaScript">
	rdShowMessageDialog("修改失败: <%=retMsg%>,<%=g089CfmCode%>",0);
	window.location="zg87_update.jsp?opCode=g089&opName=集团红黑名单管理";
	</script>
<%}
%>
