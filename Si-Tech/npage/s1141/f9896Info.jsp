<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
   /*
   * ����: sp��ֵҵ���ײ�����
�� * �汾: 
�� * ����: 2009-09-22
�� * ����: dujl
�� * ��Ȩ: sitech
   * �޸���ʷ
   * �޸�����      �޸���      �޸�Ŀ��
 ��*/
%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%

String opCode = "9896";
String opName = "sp��ֵҵ���ײ�����";

/**��ҪregionCode���������·��**/
String regionCode  = (String)session.getAttribute("regCode");
String groupId = (String)session.getAttribute("groupId");

String orgCode =(String)session.getAttribute("orgCode");
String workNo = (String)session.getAttribute("workNo");
String pass = (String)session.getAttribute("password");
String saleCode = WtcUtil.repNull(request.getParameter("saleCode"));

String checkSql = "SELECT a.sale_code,a.sale_name,a.sp_type,b.type_name FROM sspsaledetail a,sSpSaleDetType b where a.sp_type = b.sp_type and a.sale_code= '"+saleCode+"'";
System.out.println("22222 checkSql->"+checkSql);

%>
<wtc:pubselect  name="sPubSelect"  routerKey="region"  routerValue="<%=regionCode%>" outnum="4"> 
<wtc:sql><%=checkSql%></wtc:sql>
</wtc:pubselect> 
<wtc:array id="result" scope="end"/>

<html>
<head>
<title><%=opName%></title>
<meta content=no-cache http-equiv=Pragma>
<meta content=no-cache http-equiv=Cache-Control>
<script language="javascript">
<!--

//-->
</script>
</head>
<body>
	<div id="Operation_Table">
		<table cellspacing="0" id="tabList">
			<tr align="center">
				<th nowrap>Ӫ��������</th>
				<th nowrap>Ӫ��������</th>
				<th nowrap>��ֵҵ������</th>
			</tr>
	<%
			if(result.length==0)
			{
				out.println("<tr height='25' align='center'><td colspan='4'>");
				out.println("<font class='orange'>û���κμ�¼��</font>");
				out.println("</td></tr>");
				
			}else if(result.length>0)
			{
				String tbclass = "";
				for(int i=0;i<result.length;i++)
				{
					tbclass = (i%2==0)?"Grey":"";
	%>
					<tr align="center" length="500">
						<td class="<%=tbclass%>"><%=result[i][0]%>&nbsp;</td>
						<td class="<%=tbclass%>"><%=result[i][1]%>&nbsp;</td>
						<td class="<%=tbclass%>"><%=result[i][3].trim()%>&nbsp;</td>
					</tr>
	<%				
				}
			}
	%>
 		</table>
  	</div>
</body>
</html>    

