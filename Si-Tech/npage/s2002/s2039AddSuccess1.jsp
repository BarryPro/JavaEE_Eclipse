<%@ page import="java.util.*"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %> 
<%@ page import="com.sitech.boss.spubcallsvr.viewBean.SPubCallSvrImpl"%>
<%@page contentType="text/html;charset=GBK" errorPage=""%>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/common/redialog/redialog.js"></script>

<%
	//读取用户session信息
	ArrayList arrSession = (ArrayList)session.getAttribute("allArr");
	String[][] baseInfo = (String[][])arrSession.get(0);
	String workNo   = baseInfo[0][2];                 //工号
	String workName = baseInfo[0][3];               	//工号姓名
	String org_code = baseInfo[0][16];
	String ip_Addr  = request.getRemoteAddr();
	String[][] pass = (String[][])arrSession.get(4);
	String loginPwd  = pass[0][0];
	String regionCode = baseInfo[0][16].substring(0,2);
	String op_Note="产品规格代码与成员资费对应";
			
	/* 接受输入参数 */
	String spCode = request.getParameter("spCode");
	String hidProdCode = request.getParameter("hidProdCode");
	String bizCode = request.getParameter("bizCode");
	
	String  mode_code	  =request.getParameter("mode_code");   //成员资费代码列
	String  mode_region	  =request.getParameter("mode_region");   //成员资费所在地区
	String	planCode = request.getParameter("planCode");
	String	smCode = request.getParameter("sm_code");
	
	System.out.println("spCode="+spCode);
	System.out.println("bizcode="+bizCode);
	System.out.println("mode_code="+mode_code);
	System.out.println("mode_region="+mode_region);
	System.out.println("planCode="+planCode);
	System.out.println("smCode="+smCode);
	
	
%>

<wtc:service name="s2039Cfm" outnum="2" routerKey="region" routerValue="<%=regionCode%>" retcode="Code" retmsg="Msg">
	<wtc:param value="<%=workNo%>"/>
	<wtc:param value="<%=loginPwd%>"/>
	<wtc:param value="2039"/>
	<wtc:param value="<%=op_Note%>"/>
	<wtc:param value="<%=ip_Addr%>"/>
	<wtc:param value=""/>
	<wtc:param value="<%=spCode%>"/>
	<wtc:param value="<%=bizCode%>"/>
	<wtc:param value="<%=planCode%>"/>
	<wtc:param value="<%=smCode%>"/>
	<wtc:param value=""/>
	<wtc:param value=""/>
	<wtc:param value="<%=mode_code%>"/>	
	<wtc:param value="<%=mode_region%>"/>	
</wtc:service>
<wtc:array id="result"  scope="end" />
<%

  if(!Code.equals("000000"))
  {  
%>
<script language='javascript'>
    	rdShowMessageDialog("<%=Code%>" + "[" + "<%=Msg%>" + "]" ,0);
      	history.go(-1);
    </script>
<%}
else
{
%>
<script language='javascript'>
    	rdShowMessageDialog("产品规格编码与资费对应关系配置成功！");
		window.close();
    </script>	
<%
}
%>
  
