<%
  /*
   * ����: ����Ӫ��������Ϣ����ͼ
�� * �汾: v1.0
�� * ����: 2011��05��10��
�� * ����: zhoujf
�� * ��Ȩ: sitech
   * �޸���ʷ
   * �޸�����      �޸���      �޸�Ŀ��
 ��*/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd>
<HTML xmlns="http://www.w3.org/1999/xhtml">
<%@ taglib uri="weblogic-tags.tld" prefix="wl" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html; charset=GBK" %>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%

	String unit_id =  request.getParameter("unit_id")==null?"":request.getParameter("unit_id");
	String implRegion= (String)session.getAttribute("regCode");	
  String workName = (String)session.getAttribute("workName");
  String ipAddr = (String)session.getAttribute("ipAddr");
  String orgCode = (String)session.getAttribute("orgCode");
  String regionCode = orgCode.substring(0,2);
  String opCode="";
  String opName="Ӫ��������Ϣ";
  String sqlStr="select a.chance_id,a.chance_name,a.demand_desc,a.anticipate_income,a.update_date,c.chance_channel_name,b.chance_status_name from dbsalesadm.dmktchance a,dbsalesadm.smktchancestatus b,dbsalesadm.smktchancechannel c where a.chance_status_code=b.chance_status_code and c.chance_channel_code=a.chance_channel_code and chance_id in (select chance_id from dbsalesadm.dmktchancecustrel where cust_id_no="+unit_id+")";
%>
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=implRegion%>"  retcode="retCode1" retmsg="retMsg1" outnum="7">
			<wtc:sql><%=sqlStr%></wtc:sql>
		</wtc:pubselect>
	<wtc:array id="result" scope="end" />
		
		<%
			System.out.println("result=====1023 begin=============\n"+sqlStr);
		System.out.println("result=================="+result.length);
		for(int ii=0;ii<result.length;ii++){
				for(int jj=0;jj<result[ii].length;jj++){
					System.out.println("result["+ii+"]["+jj+"]="+result[ii][jj]);
				}
		}
		
		System.out.println("result============1023  END======");
		%>
<HTML>
<HEAD>
<link href="s2002.css" rel="stylesheet" type="text/css">
</HEAD>
<BODY>
<FORM name="form1" method="post">
<%@ include file="/npage/include/header.jsp" %>

<div class="title"><div id="title_zi">�����̻���Ϣ</div></div>
  <table id="tabList"  cellspacing=0 >			
			<tr align='center'>				
				<th>�̻�����</th>
				<th>�̻�����</th>
				<th>��������</th>
				<th>�̻���ȡʱ��</th>
				<th>�̻���Դ����</th>
				<th>Ԥ������</th>
				<th>�̻�״̬</th>
			</tr>
		<%	
		for(int i = 0; i < result.length; i++)
		{		  
		%>			
			<tr>				
				<td nowrap align='center'><%=result[i][0].trim()%>&nbsp;</td>
				<td nowrap align='center'><%=result[i][1].trim()%>&nbsp;</td>
				<td nowrap align='center'><%=result[i][2].trim()%>&nbsp;</td>
				<td nowrap align='center'><%=result[i][4].trim()%>&nbsp;</td>
				<td nowrap align='center'><%=result[i][5].trim()%>&nbsp;</td>
				<td nowrap align='center'><%=result[i][3].trim()%>&nbsp;</td>
				<td nowrap align='center'><%=result[i][6].trim()%>&nbsp;</td>
			</tr>
		<%
		}
		%>				
</table>
</BODY>
</HTML>


