<%
   /*
   * ����: ��ѯ������Ŀ�����
�� * �汾: v1.0
�� * ����: 2007/01/23
�� * ����: shibo
�� * ��Ȩ: sitech
   * �޸���ʷ
   * �޸�����      �޸���      �޸�Ŀ��
 ��*/
%>
<%@page contentType="text/html;charset=gb2312"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.boss.pub.*" %>
<%@ page import="com.sitech.boss.util.*"%>
<%@ page errorPage="/page/common/error.jsp" %>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.boss.spubcallsvr.viewBean.SPubCallSvrImpl" %>
<%@ page import="org.apache.log4j.Logger"%>
<%
	ArrayList retArray = new ArrayList();
	String[][] result = new String[][]{};
	 
	ArrayList arrSession = (ArrayList)session.getAttribute("allArr");
	String[][] baseInfoSession = (String[][])arrSession.get(0);
	String[][] otherInfoSession = (String[][])arrSession.get(2);
	String loginName = baseInfoSession[0][3];
	String orgCode = baseInfoSession[0][16];
	String loginNo = baseInfoSession[0][2];
	String ip_Addr = request.getRemoteAddr();
	String org_code = baseInfoSession[0][16];
	String[][] pass = (String[][])arrSession.get(4);
	String nopass  = pass[0][0];
	String regionCode=org_code.substring(0,2);
	
	String str="";
	String first_favour_object   = request.getParameter("first_favour_object");
    String[] first_favour_object_array = first_favour_object.split(",");
    for(int i=0;i<first_favour_object_array.length;i++)
    {
    	System.out.println("first_favour_object="+first_favour_object_array[i]);
    	str+="'"+first_favour_object_array[i]+"',";
    }
    System.out.println("str="+str);
    str=str.substring(0,str.length()-1);
    System.out.println("str="+str);
	
	
	SPubCallSvrImpl impl = new SPubCallSvrImpl();
	ArrayList retList1 = new ArrayList();  
	String sqlStr1="";
	sqlStr1 ="SELECT a.fee_code,fee_name,detail_code,detail_name FROM sfeecode a,sfeecodedetail b WHERE a.fee_code=b.fee_code AND b.fee_code IN ("+str+") order by a.fee_code asc";
	retList1 = impl.sPubSelect("4",sqlStr1,"region",regionCode);
	String[][] retListString1 = (String[][])retList1.get(0);
	int errCode=impl.getErrCode();
	String errMsg=impl.getErrMsg();
%>

<html>
<head>
<title>������Ŀ���б�</title>
<META content="text/html; charset=gb2312" http-equiv=Content-Type>
<meta http-equiv="Expires" content="0">
<SCRIPT LANGUAGE=javascript FOR=document EVENT=onkeydown>
window.onkeydown(window.event) 
</SCRIPT>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/common/common_image.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/common/common_single.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/common/common_util.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/common/common_check.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/common/redialog/redialog.js"></script>
<script type="text/javascript"  src="<%=request.getContextPath()%>/js/rpc/src/core_c.js"></script>
<link href="<%=request.getContextPath()%>/css/jl.css"  rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/tablabel.css">
</head>
<body>
<form name="frm" method="POST" >
<table width="99%" id="tab1" border="0" align="center" cellpadding="1" cellspacing="1">
	<tr bgColor="#eeeeee">
		<td height="26" align="center">
			ѡ��
		</td>
		<td  align="center">
			һ����Ŀ�����
		</td>
		<td align="center">
			һ����Ŀ������
		</td>
		<td  align="center">
			������Ŀ�����
		</td>
		<td align="center">
			������Ŀ������
		</td>
	</tr>
</table>
<table width="99%" border="0" align="center" cellpadding="1" cellspacing="1">
	<tr>
		<td>
			<div align="center">
			   <input type="button" name="commit" onClick="doCommit();" value=" ȷ�� ">
			   &nbsp;
			   <input type="button" name="back" onClick="doClose();" value=" �ر� ">
		    </div>
		</td>
	</tr>
</table>
</form>
</body>
</html>

<script>
	  
		<%	for(int i=0;i < retListString1.length;i++)
			{ 
		%>
			var str='<input type="hidden" name="fee_code" value="<%=retListString1[i][0]%>">';
			str+='<input type="hidden" name="fee_name" value="<%=retListString1[i][1]%>">';
			str+='<input type="hidden" name="detail_code" value="<%=retListString1[i][2]%>">';
			str+='<input type="hidden" name="detail_name" value="<%=retListString1[i][3]%>">';
			
			var rows = document.getElementById("tab1").rows.length;
			var newrow = document.getElementById("tab1").insertRow(rows);
			newrow.bgColor="#f5f5f5";
			newrow.height="20";
			newrow.align="center";
			newrow.insertCell(0).innerHTML ='<input type="checkbox" name="num" value="<%=i%>">'+str;
		  	newrow.insertCell(1).innerHTML = '<%=retListString1[i][0]%>';
		  	newrow.insertCell(2).innerHTML = '<%=retListString1[i][1]%>';
		  	newrow.insertCell(3).innerHTML = '<%=retListString1[i][2]%>';
		  	newrow.insertCell(4).innerHTML = '<%=retListString1[i][3]%>';
		<%	}
		%>

	function doCommit()
	{
		if("<%=retListString1.length%>"=="0"){
			rdShowMessageDialog("��û��ѡ�������Ŀ����룡");
			return false;
		}
		else if("<%=retListString1.length%>"=="1")   //ֵΪһ��ʱ����Ҫ������
		{
			if(document.all.num.checked)
			{
				window.opener.form1.second_favour_object.value=document.all.detail_code.value+",";
				//window.opener.form1.acc_detail_name.value=document.all.fee_name.value;
			}
			else
			{
				window.opener.form1.second_favour_object.value="";
			}
		}
		else   //ֵΪ����ʱ��Ҫ������
		{
			var detail_codes = new Array();
			
			var j=0;
			for(i=0;i<document.all.num.length;i++)
			{
				if(document.all.num[i].checked)
				{
					detail_codes[j]=document.all.detail_code[i].value;
					j++;
				}
			}
			if(j>0)
			{
				window.opener.form1.second_favour_object.value=detail_codes+",";
				//window.opener.form1.acc_detail_name.value=document.all.fee_name[a].value;
			}
			else
			{
				window.opener.form1.second_favour_object.value="";
			}
		}
		window.close();
	}
	
	function doClose()
	{
		window.close();
	}
</script>