<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
   /*
   * ����:��������ƱԤ��
   * �汾: 1.0
   * ����: 2009/5/13
   * ����: wangjya
   * ��Ȩ: si-tech
   */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*"%>
<%@ page import="com.sitech.boss.util.page.*"%>
<%
	response.setHeader("Pragma","No-Cache"); 
	response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0); 
 
	String opCode = "6917";
	String opName = "��������ƱԤ��";
	String orgCode =(String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	String workNo = (String)session.getAttribute("workNo");

	Map errType = new HashMap();
	errType.put("00","�ɹ�");
	errType.put("01","Ʊ�ִ���");
	errType.put("02","Ʊ������");
	errType.put("03","��Ʊʱ�����");
	errType.put("04","Ʊ������");
	errType.put("05","�ͻ�δ������Ʊ");
	errType.put("06","�ѳ�Ʊ�������˶�");
	errType.put("98","��ط��ڲ�����");
	errType.put("99","��������");


	String  tktType = request.getParameter("tkt_type_array");
	String  tktSum = request.getParameter("tkt_sum_array");
	String  tktDate = request.getParameter("tkt_date_array");
	String  tktTag = request.getParameter("tkt_tag_array");
	String  inputParsm [] = new String[8];
	inputParsm[0] = workNo;
	inputParsm[1] = opCode;
	inputParsm[2] = "0";
	inputParsm[3] = "";
	inputParsm[4] = tktType;
	inputParsm[5] = tktSum;
	inputParsm[6] = tktDate;
	inputParsm[7] = tktTag;
%>	
    <wtc:service name="s6917Cfm" routerKey="region" routerValue="<%=regionCode%>" retcode="errCode" retmsg="errMsg" outnum="8">			
	<wtc:param value="<%=inputParsm[0]%>"/>	
	<wtc:param value="<%=inputParsm[1]%>"/>	
	<wtc:param value="<%=inputParsm[2]%>"/>
	<wtc:param value="<%=inputParsm[3]%>"/>	
	<wtc:param value="<%=inputParsm[4]%>"/>	
	<wtc:param value="<%=inputParsm[5]%>"/>	
	<wtc:param value="<%=inputParsm[6]%>"/>
	<wtc:param value="<%=inputParsm[7]%>"/>
	</wtc:service>	
	<wtc:array id="tempArr" start="0" length="8"  scope="end"/>
<% 		
	if(!(errCode.equals("000000"))){
%>
		<script language="javascript">
	 	rdShowMessageDialog("Ԥ��ʧ�ܣ�" + "<%=errMsg%>",0);	
	 	window.location="f6917_1.jsp?opCode=6917&opName=��������ƱԤ��";
		</script>
<%		
		return;				 			
	}
	if((tempArr[0][0].equals("0000"))){
%>
		<script language="javascript">
	 	rdShowMessageDialog("Ԥ���ɹ���",2);		
		</script>
<%		
	}
	else if(tempArr[0][0].equals("2998"))
	{
%>
		<script language="javascript">
	 	rdShowMessageDialog("Ԥ��ʧ�ܣ�",0);	
		</script>
<%		
	}
	else
	{
%>
		<script language="javascript">
	 	rdShowMessageDialog("Ԥ��ʧ�ܣ�" + "<%=tempArr[0][1]%>",0);	
	 	window.location="f6917_1.jsp?opCode=6917&opName=��������ƱԤ��";	
		</script>
<%		
		return;				 			
	}
	ArrayList tktTypeArray = new ArrayList();
	String[] tktTypeList = tempArr[0][4].split("[|]");
	String[] tktSumList = tempArr[0][5].split("[|]");
	String[] tktDateList = tempArr[0][6].split("[|]");
	Map tktTypeMap = new HashMap();
	if(tempArr[0][3].trim().equals("04"))//Ʊ�����㣬��ѯƱ������
	{
		StringBuffer  insql = new StringBuffer();
		insql.append("select tickettype_code,tickettype_name ");
		insql.append(" from sticketcode ");
		insql.append(" where use_flag='Y' and biz_type='01' ");
		insql.append(" order by tickettype_code  ");
		System.out.println("insql====="+insql);
		%>
		<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode2" retmsg="retMsg2" outnum="2">
		<wtc:sql><%=insql%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="roleDetailData" scope="end" />
		<%	
		if(retCode2.equals("000000"))
		{	
			for(int j = 0;j < roleDetailData.length;j++)
			{
				tktTypeMap.put(roleDetailData[j][0],roleDetailData[j][1]);
			}
		}
	}
%>
		
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<script language="JavaScript">
<!--	
function commitJsp()
{
	getAfterPrompt();
	document.all.opr_numb.value="<%=tempArr[0][2].trim()%>";
	form6917.submit();
}
function unOrder()
{
	window.location="f6918_1.jsp?oprnumb=<%=tempArr[0][2].trim()%>&tkt_type=<%=tktType%>&tkt_sum=<%=tktSum%>&tkt_Date=<%=tktDate%>&tkt_tag=<%=tktTag%>";	
}		
</script> 
 
<title>��������ƱԤ��</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta http-equiv="Expires" content="0">

</head>
<BODY>
<form name="form6917" method="post" action="f6920_1.jsp">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">��������ƱԤ��</div>
	</div>
		<table width="100%" id="tabList" border=0 align="center" cellspacing=0>			
			<tr>			
				<td nowrap align='center' class="blue"><b><%=null == errType.get(tempArr[0][3].trim()) ? "δ֪���ʹ���" : errType.get(tempArr[0][3].trim())%></b></td>
			</tr>
		
			</table>
			<table width="100%" id="tabList" border=0 align="center" cellspacing=0>
			<%
			if(tempArr[0][3].trim().equals("04"))
			{%>
			
				<tr>				
					<td nowrap align='center' class="blue"><div ><b>������ƱƱ��</b></div></td>
					<td nowrap align='center' class="blue"><div ><b>ʣ����ƱƱ��</b></div></td>
					<td nowrap align='center' class="blue"><div ><b>������Ʊ��Ʊʱ��</b></div></td>
				</tr>
				<%	
				if(tktTypeList.length >0)
				{
					for(int i = 0; i < tktTypeList.length; i++)
					{
					%>			
						<tr>				
							<td nowrap align='center'><%=tktTypeList[i].trim() + "->" + tktTypeMap.get(tktTypeList[i].trim())%>&nbsp;</td>
							<td nowrap align='center'><%=tktSumList[i].trim()%>&nbsp;</td>
							<td nowrap align='center'><%=tktDateList[i].trim()%>&nbsp;</td>
						</tr>
					<%
					}
				}	
			}
			else if(tempArr[0][3].trim().equals("00"))
			{%>
				<tr>				
				<td nowrap align='center' class="blue"><div ><b>Ԥ�����������ˮ��</b></div></td>
				<td nowrap align='center' class="blue"><div ><b><%=tempArr[0][2].trim()%></b></div></td>
				</tr>
				<tr>				
				<td nowrap align='center' class="blue"><div ><b>Ʊ��</b></div></td>
				<td nowrap align='center' class="blue"><div ><b><%=tempArr[0][7].trim()%>Ԫ</b></div></td>
				</tr>
			<%
			}%>
			
	<tr> 
		<td align="center" id="footer" colspan="3"> 
			<%
			if(tempArr[0][3].trim().equals("00"))//Ԥ���ɹ�
			{%>
				<input type="button" name="delete" class="b_foot" value="����" onclick=commitJsp();>
				&nbsp;
				<input type="button" name="delete" class="b_foot" value="�˶�" onclick=unOrder()>
			<%
			}
			else
			{%>
			<input type="button" name="add"  class="b_foot" value="����" onclick=history.go(-1);>
			&nbsp;
			<input type="button" name="delete" class="b_foot" value="�ر�" onclick=removeCurrentTab();>
			<%
			}
			%>
		</td>
	</tr>
		</table>		
<%@ include file="/npage/include/footer.jsp" %>
<input type="hidden" name="opr_numb" value="">
<input type="hidden" name="tkt_type" value="<%=tktType%>">
<input type="hidden" name="tkt_sum" value="<%=tktSum%>">
<input type="hidden" name="tkt_date" value="<%=tktDate%>">
<input type="hidden" name="tkt_tag" value="<%=tktTag%>">
<input type="hidden" name="price" value="<%=tempArr[0][7].trim()%>">
<input type="hidden" name="commit_type" value="0">
</form>
</BODY>
</HTML>
