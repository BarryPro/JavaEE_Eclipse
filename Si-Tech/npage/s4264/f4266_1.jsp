<%
/********************
 version v2.0
 ������: si-tech
 ����: dujl
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html  xmlns="http://www.w3.org/1999/xhtml">
	
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page language="java" import="java.sql.*" %>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%  
	response.setHeader("Pragma","No-Cache"); 
	response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0); 
	
  	String opCode = request.getParameter("opCode");
  	String opName = request.getParameter("opName");
            
	String loginNo = (String)session.getAttribute("workNo");
	String orgCode = (String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	
	String insql = "select a.type_code, nvl(b.region_name,'ʡ��˾') from sUseCenter a,sregioncode b,sUseUnit c  where a.type_code=b.region_code(+) and a.type_code='"+regionCode+"' and a.unit_code = c.unit_code group by a.type_code, nvl(b.region_name,'ʡ��˾')";
	System.out.println("insql4266====="+insql);

%>

<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="4">
<wtc:sql><%=insql%></wtc:sql>
</wtc:pubselect>
<wtc:array id="result" scope="end" />

<% 		
	if((result.length == 0) || (result == null)){
%>
		<script language="javascript">
	 	rdShowMessageDialog("������Ϣ:δ��ѯ��ʡ�б�־��");	
	 	removeCurrentTab();	
		</script>
<%		
		return;				 			
	}
%>	

<head>
<title>������Ժŵ�ǰ�û��嵥</title>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
<script language="JavaScript">
<!-- 
onload=function()
{
	self.status="";
}

//--------1---------doProcess����----------------

function doProcess(packet)
{
	self.status="";
    var vRetPage=packet.data.findValueByName("rpc_page");
	var retCode = packet.data.findValueByName("retCode");
	var retMsg =  packet.data.findValueByName("retMsg");
	var rpc_flag = packet.data.findValueByName("rpc_flag");
		
	if(retCode != "000000")
	{
		rdShowMessageDialog(retMsg);
		return;
	}
	if(rpc_flag == "chg_type")
	{
		var code = packet.data.findValueByName("code");
		var text =  packet.data.findValueByName("text");
		fillSelect(document.all.useUnit,code,text);
	}
	else if(rpc_flag == "chg_unit")
	{
		var code = packet.data.findValueByName("code");
		var text =  packet.data.findValueByName("text");
		fillSelect(document.all.useDepartment,code,text);
	}
	else if(rpc_flag == "chg_department")
	{
		var code = packet.data.findValueByName("code");
		var text =  packet.data.findValueByName("text");
		fillSelect(document.all.useCenter,code,text);
	}
	
    if(vRetPage == "qryAreaFlag")
    {    
    var retCode = packet.data.findValueByName("retCode");
    var retMsg = packet.data.findValueByName("retMsg");
    var area_flag = packet.data.findValueByName("area_flag");

		if(retCode == 000000)
		{
		    if(parseInt(area_flag)>0)
		    {
		       document.all.flagCodeTr.style.display="";
		       getFlagCode();
		    }
		}
		else
		{
			rdShowMessageDialog("����:"+ retCode + "->" + retMsg);
			return;
		}
	}
}

// ʡ�б�־--��λ
function chg_typeCode()
{
	if(document.all.typeCode.value != "")
	{
		var sql = "90000249";
		var sqlParam = document.all.typeCode.value+"|"+document.all.typeCode.value+"|";
		var rpc_flag = "chg_type";
		sendRpc(sql,sqlParam,rpc_flag);
	}
	document.all.useUnit.value = "";
	document.all.useDepartment.value = "";
	document.all.useCenter.value = "";
}

// ��λ--����
function unitchange()
{
	if(document.all.useUnit.value != "")
	{
		var sql = "90000250";
		var sqlParam = document.all.typeCode.value+"|"+document.all.useUnit.value+"|"+document.all.typeCode.value+"|"+document.all.useUnit.value+"|";
		var rpc_flag = "chg_unit";
		sendRpc(sql,sqlParam,rpc_flag);
	}
	document.all.useCenter.length = 1;
	document.all.useDepartment.value = "";
	document.all.useCenter.value = "";
}

// ����--����
function chg_department()
{
  alert(document.all.typeCode.value);
  alert(document.all.useUnit.value);
  alert(document.all.useDepartment.value);
	document.all.useCenter.value = "";
	if(document.all.useDepartment.value != "")
	{
		var sql = "90000251";
		var sqlParam = document.all.typeCode.value+"|"+document.all.useUnit.value+"|"+document.all.useDepartment.value+"|";
		var rpc_flag = "chg_department";
		sendRpc(sql,sqlParam,rpc_flag);
	}
}

function sendRpc(sql,sqlparam,rpc_flag)
{
	var myPacket = new AJAXPacket("/npage/s9387/rpc_select.jsp","���ڻ�ȡ��Ϣ�����Ժ�......");
	myPacket.data.add("sql",sql);
	myPacket.data.add("sqlParam",sqlparam);
	myPacket.data.add("rpc_flag", rpc_flag);
	core.ajax.sendPacket(myPacket);
	myPacket=null;  
}

function fillSelect(obj,code,text)
{
	obj.length=0;
	var option0 = new Option("--��ѡ��--","");
	obj.add(option0);
	for(var i=0; i<code.length; i++)
	{
		var option1 = new Option(text[i],code[i]);
        obj.add(option1);
	}
}

function resetJsp()
{
	document.all.typeCode.value="";
	document.all.useUnit.value="";
	document.all.useDepartment.value="";
	document.all.useCenter.value="";
}

function formCommit1()
{
	if(document.all.typeCode.value=="")
	{
		rdShowMessageDialog("������ʡ�б�־");
	  	return false;
	}
	if(check(frm)){
		var typeCode = document.all.typeCode.value;
	   	var useUnit = document.all.useUnit.value;
	   	var useDepartment = document.all.useDepartment.value;
	   	var useCenter = document.all.useCenter.value;
	   	location="f4266_2.jsp?typeCode="+typeCode+"&useUnit="+useUnit+"&useDepartment=" + useDepartment+"&useCenter="+useCenter;
   }
}

function formCommit()
{
	if(check(frm)){
		var typeCode = document.all.typeCode.value;
	   	var useUnit = document.all.useUnit.value;
	   	var useDepartment = document.all.useDepartment.value;
	   	var useCenter = document.all.useCenter.value;
	   	document.middle.location="f4266info.jsp?typeCode="+typeCode+"&useUnit="+useUnit+"&useDepartment=" + useDepartment+"&useCenter="+useCenter;
	   	tabBusi.style.display="";
   }
}

//-->
</script>
</head>
<body>
	<form name="frm" method="post" action="">
		<%@ include file="/npage/include/header.jsp" %>
		<div class="title">
			<div id="title_zi">������Ժŵ�ǰ�û��嵥</div>
		</div>
	<table cellspacing="0">
		<tr>
			<td class="blue">ʡ�б�־</td>
			<td>
				<select name="typeCode" class="button" id="select" onchange="chg_typeCode()" >
					<option value="" selected>--��ѡ��--</option>
					<option value="99">ʡ��˾</option>
		      		<option value="<%=result[0][0]%>"><%=result[0][1]%></option>
				</select>
			</td>
			<td class="blue">ʹ�õ�λ</td>
			<td>
				<select name="useUnit" id="useUnit" v_name="ʹ�õ�λ" onchange="unitchange()">
					<option value="">--��ѡ��--</option>	
				</select>
			</td>
		</tr>
		<tr>
			<td class="blue">ʹ�ò���</td>
			<td>
				<select name="useDepartment" id="useDepartment" v_name="ʹ�ò���" onchange="chg_department()">
					<option value="">--��ѡ��--</option>
				</select>
			</td>
			<td class="blue">ʹ������</td>
			<td>
				<select name="useCenter" id="useCenter" v_name="ʹ������" >
					<option value="">--��ѡ��--</option>
				</select>
			</td>
		</tr>
		<tr>
			<td id="footer" colspan="4">
				<div align="center">
				<input name="commit" id="commit" type="button" class="b_foot"   value="�û��嵥��ѯ" onClick="formCommit()"  >
                &nbsp; 
                <input name="commit2" id="commit2" type="button" class="b_foot"   value="���ø澯��ѯ" onClick="formCommit1()"  >
                &nbsp;
                <input type="button" name="reset" class="b_foot" value="���" onclick="resetJsp()">
				</div>
			</td>
		</tr>
	</table>
	<TABLE id="tabBusi" style="display:none" width="100%"  align="center" id="mainOne" cellspacing="0" border="0" >	
		<TR> 
			<td nowrap>
				<IFRAME frameBorder=0 id=middle name=middle scrolling="yes" 
				style="HEIGHT: 1500%; VISIBILITY: inherit; WIDTH: 99%; Z-INDEX: 1">
				</IFRAME>
			</td> 
		</TR>
	</TABLE>				
<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>
