<%@ page import="java.util.*"%>
<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%@ page contentType= "text/html;charset=GBK" %>
<%
     String workNo = (String)session.getAttribute("workNo");
     String org_code = (String)session.getAttribute("orgCode");
		 String regionCode=org_code.substring(0,2);
%>

<wtc:service name="sIndexFuncSel" outnum="6" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:param value="<%=workNo%>"/>
</wtc:service>
<wtc:array id="result" scope="end" />
	
<%	 
	 String strSql=" SELECT count(*) " 
								+" FROM dservordermsg e,sServOrderState f "
								+" WHERE  e.LOGIN_NO='"+workNo.trim()+"' AND e.order_status = f.status " 
								+" AND f.status in(100,110) and rownum<500 ";
	 System.out.println("strSql=="+strSql);
%>
<wtc:pubselect name="sPubSelect" outnum="1" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:sql><%=strSql%></wtc:sql>
</wtc:pubselect>
<wtc:array id="retCustOrder" scope="end"/>	
	
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">	
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK" />
<title>�ҵĹ�����</title>
<script type="text/javascript" src="/njs/extend/jquery/jquery123_pack.js"></script>
<script type="text/javascript" src="/njs/si/core_sitech_pack.js"></script>	
<script>	
	<%
	if(retCode.equals("000000"))
	{
		String length = retCustOrder[0][0];
    if(Integer.parseInt(length)>0){
	  %>
		 //alert("�˹�����<%=length%>��δ�����������봦�������ҪΪ�û�����������ͨ���ϵ�ָ�����ɡ� ����˱�ҵ����Ҫ����������ͨ�����ŵ�¼�������½Ǵ���'δ��������ѯ->�쳣������ѯ'���г�����������ӪҵԱ��ÿ��Ӫҵ����ǰͨ��'�쳣������ѯ'���ܲ鿴�Ƿ���δ��������");	
    <%
    }
	}
 %>		
</script>	
<style type="text/css">

body {
	height: 100%;
	width: 100%;
	font-family: Arial, Helvetica, sans-serif;
	font-size: 11px;
	background-position: left top;
	margin-top: 0px;
	margin-right: auto;
	margin-bottom: 0px;
	margin-left: auto;
	padding: 0px;
	background:#fff;
}

.notice .notice_header{
	height:26px;	
	margin :30px 1px 0;
}
.notice .notice_header .text{
	height:26px;
	line-height:26px;
	display:block;
	width:167px;
	text-indent:35px;
	color:#003399;
	font-weight:bold;
	color:#F7693F;
	font-size:14px;
	font-weight:bold;
}
.notice{padding-left:30px; line-height:2em; text-align:left; }
.notice a:link,.notice a:visited{color:#333; text-decoration:none;}
.notice a:hover,.notice a:active{
	text-decoration:underline;}
.notice dt{color:#2E5B88; font-size:13px;}
.notice dd{text-indent:2em;}

</style>
</head>
<body>
<div class="notice">
	<div class="notice_header">
		<span class="text">ϵͳ����:</span>
	</div>
	<div id="mydiv5" name="mydiv5" class="notice_content"></div>
</div>
<script language="javascript">
$(document).ready(function () {
    $("#mydiv5").load("getNotice.jsp");
});
</script>
</body>
</html>
