<%@ page import="java.util.*"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %> 
<%@ page import="com.sitech.boss.spubcallsvr.viewBean.SPubCallSvrImpl"%>
<%@page contentType="text/html;charset=GBK" errorPage=""%>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/common/redialog/redialog.js"></script>

<%
	//��ȡ�û�session��Ϣ
	ArrayList arrSession = (ArrayList)session.getAttribute("allArr");
	String[][] baseInfo = (String[][])arrSession.get(0);
	String workNo   = baseInfo[0][2];                 //����
	String workName = baseInfo[0][3];               	//��������
	String org_code = baseInfo[0][16];
	String ip_Addr  = request.getRemoteAddr();
	String[][] pass = (String[][])arrSession.get(4);
	String loginPwd  = pass[0][0];
	String regionCode = baseInfo[0][16].substring(0,2);
	String op_Note="��Ʒ���������Ա�ʷѶ�Ӧ";
			
	/* ����������� */
	String spCode = request.getParameter("spCode");
	String hidProdCode = request.getParameter("hidProdCode");
	String bizCode = request.getParameter("bizCode");
	
	String  mode_code	  =request.getParameter("mode_code");   //��Ա�ʷѴ�����
	String  mode_region	  =request.getParameter("mode_region");   //��Ա�ʷ����ڵ���
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
    	rdShowMessageDialog("��Ʒ���������ʷѶ�Ӧ��ϵ���óɹ���");
		window.close();
    </script>	
<%
}
%>
  
