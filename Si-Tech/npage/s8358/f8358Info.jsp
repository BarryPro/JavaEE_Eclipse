<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * ����:��ѯ�����û���Ϣ������ƽ̨��
   * ����: 2009/11/09
   * ����: dujl
   * ��Ȩ: si-tech
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*"%>

<%
	response.setHeader("Pragma","No-Cache"); 
	response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0); 

	String opCode = "8358";
	String opName = "��ѯ�����û���Ϣ������ƽ̨��";
	String dateStr = new java.text.SimpleDateFormat("yyyyMM").format(new java.util.Date());
	String orgCode =(String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	String workNo = (String)session.getAttribute("workNo");
	String phoneNo = request.getParameter("phoneNo");
	String sInCreateType = "9";	  //ҵ����������:00:BOSS
	String vstatus=""; //�û�ҵ��״̬
	String vshow=""; //�Ƿ��ǲ������û�
	
	String  inputParsm [] = new String[5];
	inputParsm[0] = workNo;
	inputParsm[1] = orgCode;
	inputParsm[2] = opCode;
	inputParsm[3] = phoneNo;
	inputParsm[4] = sInCreateType;
%>	
    <wtc:service name="s8358Qry" routerKey="phone" routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2" outnum="13">			
	<wtc:param value="<%=inputParsm[0]%>"/>
	<wtc:param value="<%=inputParsm[1]%>"/>
	<wtc:param value="<%=inputParsm[2]%>"/>
	<wtc:param value="<%=inputParsm[3]%>"/>
	<wtc:param value="<%=inputParsm[4]%>"/>
	</wtc:service>
	<wtc:array id="tempArr" start="2" length="11"  scope="end"/>
	<wtc:array id="tempArr1" start="0" length="2"  scope="end"/>
<%
	if(!(tempArr1[0][0].equals("000000"))){
%>
		<script language="JavaScript">
			rdShowMessageDialog("������Ϣ:<%=tempArr1[0][1]%>");
		</script>
<%
		return;
	}
	else
	{
		for(int i = 0; i < tempArr.length; i++)
		{
			if((tempArr[i][7].trim()).equals("1"))
			{
				vstatus="���忪ͨ";
			}
			else if((tempArr[i][7].trim()).equals("2"))
			{
				vstatus="����ȡ��";
			}
			else
			{
				vstatus="";
			}
			
			if((tempArr[i][8].trim()).equals("0"))
			{
				vshow="��";
			}
			else if((tempArr[i][8].trim()).equals("1"))
			{
				vshow="��";
			}
			else
			{
				vshow="";
			}
		}
	}
%>
	
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<script language="JavaScript">
<!--
</script>

<title>��ѯ�����û���Ϣ������ƽ̨��</title>
<meta content=no-cache http-equiv=Pragma>
<meta content=no-cache http-equiv=Cache-Control>

</head>
<BODY>
	<div id="Operation_Table">
		<table id="tabList" cellspacing=0>			
			<tr>
				<td  align='center' class="blue"><div ><b>�������</b></div></td>
				<td  align='center' class="blue"><div ><b>��ǰ��Ʒ��ʶ</b></div></td>
				<td  align='center' class="blue"><div ><b>ԤԼ��Ʒ��ʶ</b></div></td>
				<td  align='center' class="blue"><div ><b>��ǰ��Ʒ��ʼʱ��</b></div></td>
				<td  align='center' class="blue"><div ><b>��ǰ��Ʒ����ʱ��</b></div></td>
				<td  align='center' class="blue"><div ><b>ԤԼ��Ʒ��ʼʱ��</b></div></td>
				<td  align='center' class="blue"><div ><b>ԤԼ��Ʒ����ʱ��</b></div></td>
				<td  align='center' class="blue"><div ><b>�û�ҵ��״̬</b></div></td>
				<td  align='center' class="blue"><div ><b>�Ƿ�������û�</b></div></td>
				<td  align='center' class="blue"><div ><b>ҵ�����ʱ��</b></div></td>
				<td  align='center' class="blue"><div ><b>����ID</b></div></td>
			</tr>
	<%
		for(int i = 0; i < tempArr.length; i++)
		{
	%>
			<tr>
				<td nowrap align='center'><%=tempArr[i][0].trim()%>&nbsp;</td>
				<td nowrap align='center'><%=tempArr[i][1].trim()%>&nbsp;</td>
				<td nowrap align='center'><%=tempArr[i][2].trim()%>&nbsp;</td>
				<td nowrap align='center'><%=tempArr[i][3].trim()%>&nbsp;</td>
				<td nowrap align='center'><%=tempArr[i][4].trim()%>&nbsp;</td>
				<td nowrap align='center'><%=tempArr[i][5].trim()%>&nbsp;</td>
				<td nowrap align='center'><%=tempArr[i][6].trim()%>&nbsp;</td>
				<td nowrap align='center'><%=vstatus%>&nbsp;</td>
				<td nowrap align='center'><%=vshow%>&nbsp;</td>
				<td nowrap align='center'><%=tempArr[i][9].trim()%>&nbsp;</td>
				<td nowrap align='center'><%=tempArr[i][10].trim()%>&nbsp;</td>
			</tr>
	<%
		}
	%>
			
		</table>
	</div>
</BODY>
</HTML>
