<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%

  /*
   * ����:ʹ����;����
   * �汾: 1.0
   * ����: 2009/3/19
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
     
	String opCode = "4247";
	String opName = "ʹ����;����";
	String dateStr = new java.text.SimpleDateFormat("yyyyMM").format(new java.util.Date());
	String orgCode =(String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	StringBuffer  insql = new StringBuffer();

	insql.append("select phone_type,application_code,application_name ");
	insql.append(" from sUseApplication ");
	insql.append(" where use_flag='Y'");
	insql.append(" order by phone_type,application_code  ");
	System.out.println("insql====="+insql);
%>
<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="3">
<wtc:sql><%=insql%></wtc:sql>
</wtc:pubselect>
<wtc:array id="applicationDetailData" scope="end" />

<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<script language="JavaScript">
<!--	
 
var oprType_Add = "a";
var oprType_Del = "d";
var oprType_Qry = "q";

var arrphonetype=new Array();
var arrpapercode=new Array();
var arrpapername=new Array(); 
    
<%  
  	for(int i=0;i<applicationDetailData.length;i++)
  	{
		out.println("arrphonetype["+i+"]='"+applicationDetailData[i][0]+"';\n");
		out.println("arrpapercode["+i+"]='"+applicationDetailData[i][1]+"';\n");
		out.println("arrpapername["+i+"]='"+applicationDetailData[i][2]+"';\n");
	}
%>

onload=function()
{		
	init();
}

function init()
{
	chg_opType();
}	

function chg_opType()
{
	with(document.frm4247)
	{
		var op_type = opType[opType.selectedIndex].value;

		if( op_type == oprType_Add )
		{
			showAdd.style.display="";
			showOther.style.display="none";	
			add.style.display="";
			other.style.display="none";		
		}
		else
		{
			showAdd.style.display="none";
			showOther.style.display="";
			add.style.display="none";
			other.style.display="";				
		}
		enabledInput();
		chg_sapplicationCode();
		
		if(( op_type == oprType_Del )||( op_type == oprType_Add ))
		{
			sapplicationCode.value = "";
			clearInput();			
		}
		if(op_type == oprType_Add)
		{
			aphoneType.value = "";
		}
	}
	document.frm4247.aapplicationCode.value="";
	document.frm4247.applicationName.value="";
	chg_phoneType();
}	

function enabledInput()
{
	with(document.frm4247)
	{
		var op_type = opType[opType.selectedIndex].value;
		if(op_type == oprType_Add)
		{
			applicationName.disabled =  false;
		}
		else
		{
			applicationName.disabled =  true;
		}						
	}
}
	
function clearInput()
{
	with(document.frm4247)
	{
		applicationName.value = "";
	}		
}
 
function judge_valid()
{
	with(document.frm4247)
	{
		var op_type = document.frm4247.opType[document.frm4247.opType.selectedIndex].value;
		if(op_type == oprType_Add){
    		if(aapplicationCode.value==""){
	  				rdShowMessageDialog("��������;����");
	  				return false;
				}
				if(aphoneType.value==""){
	  				rdShowMessageDialog("�������������!");
	  				return false;
				}
				if(applicationName.value==""){
	  				rdShowMessageDialog("��������;����!");
	  				return false;
				}
		}
		if(op_type == oprType_Del)
		{
			if(phoneType.value=="")
			{
	  			rdShowMessageDialog("�������������!");
	  			return false;
			}
		}
	return true
	}
}
function DoList()
{
	if (IList.style.display != "none")
	{
		IList.style.display = "none";
	}
	else
	{
		IList.style.display = "";
	}
}

function resetJsp()
{
	var op_type = document.frm4247.opType[document.frm4247.opType.selectedIndex].value;
	if( op_type == oprType_Add )
	{	
	document.frm4247.aapplicationCode.value = "";
	clearInput();
	}	
}

function commitJsp()
{
	var tmpStr="";
	var op_type = document.frm4247.opType[document.frm4247.opType.selectedIndex].value;
	var procSql = "";
	if( op_type == oprType_Qry )
	{
		rdShowMessageDialog("��ѯ����ȷ��!");
		return false;					
	}	
	if( !judge_valid() )
	{
		return false;
	}
	
	frm4247.submit();
}

function chg_sapplicationCode()
{
 	for ( x1 = 0 ; x1 < arrphonetype.length  ; x1++ )
 	{
 		if((arrphonetype[x1] == document.all.phoneType.value) && (arrpapercode[x1] == document.all.sapplicationCode.value))
 		{
 			document.all.applicationName.value=arrpapername[x1];
 		}
 	}
 	IList.style.display = "none";
}

function chg_phoneType()
{
	//���������
	document.all.sapplicationCode.length=0;
	for ( x1 = 0 ; x1 < arrphonetype.length  ; x1++ )
	{
		if((arrphonetype[x1] == document.all.phoneType.value))
		{	
			var option1 = new Option(arrpapercode[x1]+"--"+arrpapername[x1],arrpapercode[x1]);/*update ��������Ϊ����ѯ���͡�ɾ����ʱ�������еġ���;���롱չʾ��ʽ�޸�Ϊ����;����--��;���ơ� by diling@2012/5/14*/
        	document.all.sapplicationCode.add(option1);
		}
	}
	chg_sapplicationCode();
	
	if(document.frm4247.opType[document.frm4247.opType.selectedIndex].value == oprType_Add)
	{
		if( document.frm4247.aapplicationCode.value=="" )
		{
			document.frm4247.applicationName.value="";
		}
	}
}
 	
</script> 
 
<title>ʹ����;����</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
</head>
<BODY>
<form action="f4247Cfm.jsp" method="post" name="frm4247"  >
	<input type="hidden" name="opCode" value="<%=opCode%>">
	<input type="hidden" name="opName" value="<%=opName%>">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">ʹ����;����</div>
	</div>
<table cellspacing="0">             
	<tr> 
		<td class="blue" width="8%" nowrap>��������</td>
		<td width="35%"> 
			<select name="opType" class="button" id="select" onChange="chg_opType()">
				<option value="a">����</option>
        		<option value="d">ɾ��</option>
        		<option value="q" selected>��ѯ</option>
      		</select> 
    	</td>
    </tr>
    <tr id="other">
    	<td class="blue" width="8%" nowrap>��������</td>
    	<td>
    	<select name="phoneType" class="button" id="select" onchange="chg_phoneType()">
    		<option value="0">���Ժ�</option>
    		<option value="1">�����</option>
    	</select>
    	</td>
  	</tr>
  	</tr>
    <tr id="add">
    	<td class="blue" width="8%" nowrap>��������</td>
    	<td>
    	<select name="aphoneType" class="button" id="select" >
    		<option value="0">���Ժ�</option>
    		<option value="1">�����</option>
    	</select>
    	</td>
  	</tr>
	<tr id="showOther" >
		<td class="blue">��;����</td>
		<td> 
			<select name="sapplicationCode" id="applicationCode" onchange="chg_sapplicationCode()"> 
			    <%for (int i = 0; i < applicationDetailData.length; i++) {%>
			      <option value="<%=applicationDetailData[i][1]%>"><%=applicationDetailData[i][1]%>--<%=applicationDetailData[i][2]%>
			      </option>
			    <%}%>
      		</select>
    	</td>
	</tr>
	<tr id="showAdd" >
		<td class="blue">��;����:</td>
		<td><input name="aapplicationCode" type="text" class="button" id="aapplicationCode" v_type="0_9" maxlength="4" style="ime-mode:disabled" onKeyPress="return isKeyNumberdot(0)" v_must=1 v_name="��;����"> 
		</td>
	</tr>
	<tr>
		<td class="blue">��;����</td>
		<td><input name="applicationName" type="text" class="button" id="applicationName" size="60" v_must=1 v_type=string v_name="��;����"></td>
	</tr>
				
	<tr> 
		<td align="center" id="footer" colspan="4"> 
			<input type="button" name="IList"  class="b_foot" value="�б�" onclick="DoList()">
			&nbsp;
			<input type="button" name="confirm" class="b_foot" value="ȷ��" onclick="commitJsp()">
			&nbsp;
			<input type="button" name="reset" class="b_foot" value="���" onclick="resetJsp()">
		</td>
	</tr>
</table>
<table style="display='none'" id="IList" border="2" align="center" cellPadding=0 cellSpacing=0  width="95%">
   <tr>
   <td>
   <table align="center" valign="top" border="1" cellPadding=4 cellSpacing=0  width="100%">
 <%
 	out.println("<tr height=30>");
 	out.println("<th align='center'>��������</th>");
 	out.println("<th align='center'>��;����</th>");
 	out.println("<th align='center'>��;����</th>");
 	out.println("</tr>");
 	for(int i =0; i < applicationDetailData.length; i++)
 	{
	 		out.println("<tr align=center>");
	 		out.println("<td>" + applicationDetailData[i][0]  +  "</td>");
	 		out.println("<td>" + applicationDetailData[i][1]  +  "</td>");
	 		out.println("<td>" + applicationDetailData[i][2]  +  "</td>");
	 		out.println("</tr>");
 	} 
 %>
</table>

  <p>&nbsp;</p>
  <p>&nbsp;</p>
  <p>&nbsp;</p>

</td>
</tr>
</table>
	<%@ include file="/npage/include/footer.jsp" %>
</form>
</BODY>
</HTML>
