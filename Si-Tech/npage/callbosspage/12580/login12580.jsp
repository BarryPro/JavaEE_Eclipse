<%
  /*
   * ����: 12580��ҳ��
�� * �汾: 1.0.0
�� * ����: 2009/02/22
�� * ����: libin
�� * ��Ȩ: sitech
   * update:
�� */
%>

<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>
<%@ page import="java.util.*"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<html>
	<head>
		<style type="text/css">
		body {
			FONT: 12px Arial, Helvetica, sans-serif;
		}
		</style>
	</head>
	<%
		String phone_no = request.getParameter("")==null?"":request.getParameter("");
		
		String ynHasSql = "select to_char(count(*)) from dsrvmsg@ceshidb where id_no=(select id_no from dcustmsg@ceshidb where phone_no='"+phone_no+"') and service_code='tf32'";
  	
  	String ynAvaSql = "select to_char(count(*)) from dsrvmsg@ceshidb where id_no=(select id_no from dcustmsg@ceshidb where phone_no='"+phone_no+"') and service_code='tf32' and begin_time<=to_char(sysdate-1,'yyyy-mm-dd hh24:mi:mm') and end_time>=to_char(sysdate-1,'yyyy-mm-dd hh24:mi:mm')";
	%>
	<body>
		<wtc:service name="sKFCustMsg" outnum="27" routerKey="phone" routerValue="<%=phone_no %>">
			<wtc:param value="<%=phone_no %>"/>
		</wtc:service>
		<wtc:array id="rows" scope="end"/>
			<%
				
				String cust_name = "";
				String card_name = "";
				String town_name = "";
				String sm_name   = "";
				String region_code = "";
			  if(retCode.equals("000000"))
			  {
					cust_name      = rows[0][0];
					
					card_name      = rows[0][14];
					town_name      = rows[0][16];
					sm_name		     = rows[0][24];
					
			  }
			%>
			
			&nbsp;&nbsp;&nbsp;&nbsp;<%=phone_no %><br><br>
			
			&nbsp;&nbsp;&nbsp;&nbsp;�û�����:<%=cust_name%><br><br>
			
			&nbsp;&nbsp;&nbsp;&nbsp;������:<%=town_name%><br><br>
			
			&nbsp;&nbsp;&nbsp;&nbsp;�ͻ�����:<%=card_name%><br><br>
			
			&nbsp;&nbsp;&nbsp;&nbsp;�ͻ�Ʒ��:<%=null == sm_name?"" : sm_name%><br>
			
			<wtc:service name="s151Select" outnum="1">
				<wtc:param value="<%=ynAvaSql %>" />
			</wtc:service>
			<wtc:array id="queryList" start="0" length="1" scope="end" />
			<%
			String[][] dataRows = new String[][] {};
			dataRows = queryList;
			if(dataRows[0][0] != null && !"0".equals(dataRows[0][0])){
				out.println("<br/>&nbsp;&nbsp;&nbsp;&nbsp;���� "+phone_no+" �ѿ�ͨ�ƶ������������Ч��");
			}else{
			%>
				<wtc:service name="s151Select" outnum="1">
					<wtc:param value="<%=ynHasSql %>" />
				</wtc:service>
				<wtc:array id="queryList" start="0" length="1" scope="end" />
				<%
				dataRows = queryList;
				if(dataRows[0][0] != null && !"0".equals(dataRows[0][0])){
					out.println("<br/>&nbsp;&nbsp;&nbsp;&nbsp;���� "+phone_no+" �ѿ�ͨ�ƶ����������ʧЧ��");
				}else{
					out.println("<br/>&nbsp;&nbsp;&nbsp;&nbsp;���� "+phone_no+" ��δ��ͨ�ƶ��������");
				}
			}
			%>
			<%
			
			String lwSql = "select count(msg_content) from DTAKEMSG where accept_no = '"+phone_no+"'";
			String lwSqlv = "select msg_content from DTAKEMSG where accept_no = '"+phone_no+"'";
			%>
			<wtc:service name="s151Select" outnum="1">
					<wtc:param value="<%=lwSql %>" />
			</wtc:service>
			<wtc:array id="lwList" start="0" length="1" scope="end" />
			<%
				dataRows = lwList;
				if(dataRows[0][0] != null && !"0".equals(dataRows[0][0])){
			%>
			<wtc:service name="s151Select" outnum="1">
					<wtc:param value="<%=lwSqlv %>" />
			</wtc:service>
			<wtc:array id="lwListv" start="0" length="1" scope="end" />
			<%
					dataRows = lwListv;
					if(dataRows[0][0] != null){
						out.println("<br/><br/><br/>&nbsp;&nbsp;&nbsp;&nbsp;���������ԣ���������Ϊ��<span class='style1'>"+dataRows[0][0]+"</span>");
					}else{
						out.println("<br/><br/><br/>&nbsp;&nbsp;&nbsp;&nbsp;��δ��������");
					}			
				}else{
					out.println("<br/><br/><br/>&nbsp;&nbsp;&nbsp;&nbsp;��δ��������");
				}
								
			%>
	</body>
</html>
