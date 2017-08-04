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
	String regionCode = baseInfo[0][16].substring(0,2);		
	/* 接受输入参数 */
	String spCode = request.getParameter("spCode");
	String bizcodeadd = request.getParameter("bizCode");
	String PospecType = request.getParameter("PospecType");
	String prodCode = request.getParameter("prodCode");
	String planCode = request.getParameter("planCode");
	String smCode = request.getParameter("sm_code");
	
	System.out.println("spCode="+spCode);
	System.out.println("bizcode="+bizcodeadd);
	System.out.println("PospecType="+PospecType);
	System.out.println("prodCode="+prodCode);
	System.out.println("planCode="+planCode);
	System.out.println("planCode="+smCode);
	
	String tmpNumber="";
	//if("1".equals(PospecType))
	//{
	//	tmpNumber=spCode;
	//	System.out.println("[1]tmpNumber="+tmpNumber);
	//}
 //else
 //	{
 //		tmpNumber=bizcodeadd;
 //		System.out.println("[2]tmpNumber="+tmpNumber);
 //	}
	
	
%>

<wtc:service name="sProductOpr" outnum="2" routerKey="region" routerValue="<%=regionCode%>" retcode="Code" retmsg="Msg">
	<wtc:param value="<%=workNo%>"/>
	<wtc:param value="<%=spCode%>"/>
	<wtc:param value="<%=bizcodeadd%>"/>	
  <wtc:param value="<%=planCode%>"/>
	<wtc:param value="<%=prodCode%>"/>
	<wtc:param value="<%=smCode%>"/>
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
    	rdShowMessageDialog("规格编码与资费对应关系配置成功！");
		window.close();
    </script>	
<%
}
%>
  
