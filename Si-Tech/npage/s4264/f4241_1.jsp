<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * ����:ְ�񼶱�����
   * �汾: 1.0
   * ����: 2009/3/17
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
 
	String opCode = "4241";
	String opName = "ְ�񼶱�����";
	String dateStr = new java.text.SimpleDateFormat("yyyyMM").format(new java.util.Date());
	String orgCode =(String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	StringBuffer  insql = new StringBuffer();

	insql.append("select level_code,level_name ");
	insql.append(" from sUseLevel ");
	insql.append(" where use_flag='Y' ");
	insql.append(" order by level_code  ");
	System.out.println("insql====="+insql);
%>
<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="2">
<wtc:sql><%=insql%></wtc:sql>
</wtc:pubselect>
<wtc:array id="roleDetailData" scope="end" />


<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<script language="JavaScript">
<!--	

var oprType_Add = "a";
var oprType_Del = "d";
var oprType_Qry = "q";

var arrpapername=new Array(); 
var arrpapercode =new Array();    
<%  
	for(int i=0;i<roleDetailData.length;i++)
  	{
		out.println("arrpapercode["+i+"]='"+roleDetailData[i][0]+"';\n");
		out.println("arrpapername["+i+"]='"+roleDetailData[i][1]+"';\n");
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

function clearInput()
{
	with(document.frm4241)
	{
		roleName.value = "";
	}		
}

function chg_opType()
	{
		with(document.frm4241)
		{
			var op_type = opType[opType.selectedIndex].value;

			if( op_type == oprType_Add )
			{
				showAdd.style.display="";
				showOther.style.display="none";				
			}
			else
			{
				showAdd.style.display="none";
				showOther.style.display="";				
			}
			enabledInput();
			chg_sRoleCode();
			
			if(( op_type == oprType_Del )||( op_type == oprType_Add ))
			{
				sRoleCode.value = "";
				clearInput();			
			}
		}
	}	

function enabledInput()
	{
		with(document.frm4241)
		{
			var op_type = opType[opType.selectedIndex].value;
			if(op_type == oprType_Add)
			{
				roleName.disabled =  false;
			}
			else
			{
				roleName.disabled =  true;
			}						
		}
	}
	
function judge_valid()
	{
		with(document.frm4241){
		var op_type = document.frm4241.opType[document.frm4241.opType.selectedIndex].value;
		if(op_type == oprType_Add){
    		if(aRoleCode.value==""){
	  				rdShowMessageDialog("�����뼶�����");
	  				return false;
				}
				if(roleName.value==""){
	  				rdShowMessageDialog("�����뼶������!");
	  				return false;
				}
			}
		if(op_type == oprType_Del)
		{
			if(sRoleCode.value==""){
	  			rdShowMessageDialog("�����뼶�����");
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
	var op_type = document.frm4241.opType[document.frm4241.opType.selectedIndex].value;
		if( op_type == oprType_Add )
		{	
		document.frm4241.aRoleCode.value = "";
		clearInput();
		}	
	}

function commitJsp()
	{
		var tmpStr="";
		var op_type = document.frm4241.opType[document.frm4241.opType.selectedIndex].value;
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
		
		frm4241.submit();
}

function chg_sRoleCode()
 {
 	document.all.roleName.value="";
 	
 	for ( x1 = 0 ; x1 < arrpapername.length  ; x1++ )
 	{
			if ( arrpapercode[x1] == document.all.sRoleCode.value)
			{
	  				document.all.roleName.value=arrpapername[x1] ;
 			}
 	}
 } 
 		
</script> 
 
<title>ְ�񼶱�����</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
</head>
<BODY>
<form action="f4241Cfm.jsp" method="post" name="frm4241"  >
	<input type="hidden" name="opCode" value="<%=opCode%>">
	<input type="hidden" name="opName" value="<%=opName%>">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">ְ�񼶱�����</div>
	</div>
<table cellspacing="0">             
	<tr> 
		<td class="blue" nowrap>��������</td>
		<td> 
			<select name="opType" class="button" id="select" onChange="chg_opType()">
				<option value="a">����</option>
        		<option value="d">ɾ��</option>
        		<option value="q" selected>��ѯ</option>
      		</select> 
    	</td>
  	</tr>
	<tr id="showOther" >
		<td class="blue">�������</td>
		<td> 
			<select type="text" name="sRoleCode" class="button" id="sRoleCode" v_must=1 onchange="chg_sRoleCode()"> 
			    <%for (int i = 0; i < roleDetailData.length; i++) {%>
			    <%/*update ����������Ϊ����ѯ���͡�ɾ����ʱ����������롱չʾ��ʽ�޸�Ϊ���������--�������ơ� by diling@2012/5/15*/%>
			      <option value="<%=roleDetailData[i][0]%>"><%=roleDetailData[i][0]%>--<%=roleDetailData[i][1]%>
			      </option>
			    <%}%>
      		</select>
    	</td>
	</tr>
	<tr id="showAdd" >
		<td class="blue">�������:</td>
		<td><input name="aRoleCode" type="text" class="button" id="aRoleCode" v_type="0_9" maxlength="4" style="ime-mode:disabled" onKeyPress="return isKeyNumberdot(0)" v_name="�������"> 
		</td>
	</tr>
	<tr>
		<td class="blue">��������</td>
		<td><input name="roleName" type="text" class="button" id="roleName" size="60" maxlength="20"  v_must=1 v_type=string v_name="��������"></td>
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
 	out.println("<th>�������</th>");
 	out.println("<th>��������</th>");
 	out.println("</tr>");
 	for(int i =0; i < roleDetailData.length; i++)
 	{
	 		out.println("<tr align=center>");
	 		out.println("<td>" + roleDetailData[i][0]  +  "</td>");
	 		out.println("<td>" + roleDetailData[i][1]  +  "</td>");
	 		out.println("</tr>");
 	} 
 %>
 </table>

  <p>&nbsp;</p>
  <p>&nbsp;</p>

</td>
</tr>
</table>
	 <%@ include file="/npage/include/footer.jsp" %>
</form>
</BODY>
</HTML>
