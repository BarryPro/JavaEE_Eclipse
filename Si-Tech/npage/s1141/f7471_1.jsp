<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%

  /*
   * ����:spҵ�����Ӫ���������ѯ
   * �汾: 1.0
   * ����: 2009/10/30
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
    
	String opCode = "7471";
	String opName = "spҵ�����Ӫ���������ѯ";
	String dateStr = new java.text.SimpleDateFormat("yyyyMM").format(new java.util.Date());
	String orgCode =(String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	
	StringBuffer  sql = new StringBuffer();
	sql.append("select sale_type,type_name ");
	sql.append("  from sspsalecode   ");
	sql.append(" where region_code='"+regionCode+"' and flag='Y' group by sale_type,type_name ");
	System.out.println("sql====="+sql);
	
%>
<wtc:pubselect name="sPubSelect"  routerKey="region" routerValue="<%=regionCode%>" outnum="2">
<wtc:sql><%=sql%></wtc:sql>
</wtc:pubselect>
<wtc:array id="result" scope="end" />

<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<script language="JavaScript">
<!--

onload=function()
{		
	
}

function selQry()
{	
	if(document.all.beginDt.value.trim()=="")
	{
		rdShowMessageDialog("�����뿪ʼʱ�䣡");
		return;
	}
	if(document.all.endDt.value.trim()=="")
	{
		rdShowMessageDialog("���������ʱ�䣡");
		return;
	}
	if(document.all.spType.value.trim()=="")
	{
		rdShowMessageDialog("������Ӫ�������");
		return;
	}
	if(document.all.spCode.value.trim()=="")
	{
		rdShowMessageDialog("������Ӫ�������룡");
		return;
	}
	frm.submit();
}

function sendRpc(sql,sqlparam,rpc_flag)
{
	var myPacket = new AJAXPacket("f9898qry.jsp","���ڻ�ȡ��Ϣ�����Ժ�......");
	myPacket.data.add("sql",sql);
	myPacket.data.add("sqlParam",sqlparam);
	myPacket.data.add("rpc_flag", rpc_flag);
	core.ajax.sendPacket(myPacket);
	myPacket=null;  
}

function typeChg()
{
	if(document.all.spType.value != "")
	{
		var sql = "select sale_code, sale_name from sspsalecode  "+
			  "where flag='Y' "+
			  "and region_code = :region_code "+
			  "and sale_type = :sale_type "+
			  "group by sale_code, sale_name";
		var sqlParam = "region_code="+document.all.regionCode.value+",sale_type="+document.all.spType.value;
		var rpc_flag = "chg_typeCode";
		sendRpc(sql,sqlParam,rpc_flag);
	}
}

function doProcess(packet)
{
	var retCode = packet.data.findValueByName("retCode");
	var retMsg =  packet.data.findValueByName("retMsg");
	var rpc_flag = packet.data.findValueByName("rpc_flag");
	self.status="";
	
	if(retCode != "000000")
	{
		rdShowMessageDialog(retMsg);
		return;
	}
	if(rpc_flag == "chg_typeCode")
	{
		var code = packet.data.findValueByName("code");
		var text =  packet.data.findValueByName("text");
		fillSelectAdd(document.all.spCode,code,text);
	}
}

function fillSelectAdd(obj,code,text)
{
	obj.length=0;
	var option0 = new Option("--��ѡ��--","");
	obj.add(option0);
	for(var i=0; i<code.length; i++)
	{
		var option1 = new Option(code[i]+"-->"+text[i],code[i]);
        obj.add(option1);
	}
}

function resetJsp()
{
	document.all.beginDt.value="";
	document.all.endDt.value="";
	document.all.spType.value="";
	document.all.spCode.value="";
}

</script> 
 
<title>spҵ�����Ӫ���������ѯ</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
</head>
<BODY>
<form action="f9898_3.jsp" method="post" name="frm"  >
	<input type="hidden" name="opCode" value="<%=opCode%>">
	<input type="hidden" name="opName" value="<%=opName%>">
	<input type="hidden" name="regionCode" value="<%=regionCode%>">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">��Ӫ������ѯ</div>
	</div>
<table cellspacing="0">
  	<tr>
		<td class="blue" nowrap>��ʼʱ��<font color="orange">(YYYYMMDD)</font></td>
		<td>
    		<input name="beginDt" type="text" class="button" id="beginDt" size="25" v_must=1 v_type=string v_name="��ʼʱ��" onKeyPress="return isKeyNumberdot(1)" onKeyDown="if(event.keyCode==13) doprint();">
    	</td>
    	<td class="blue" nowrap>����ʱ��<font color="orange">(YYYYMMDD)</font></td>
    	<td>
    		<input name="endDt" type="text" class="button" id="endDt" size="25" v_must=1 v_type=string v_name="����ʱ��" onKeyPress="return isKeyNumberdot(1)" onKeyDown="if(event.keyCode==13) doprint();">
    	</td>
	</tr>
	<tr>
		<td class="blue">Ӫ�������</td>
		<td>
			<select name="spType" class="button" id="spType" onChange="typeChg()">
    		<option value="">--��ѡ��--</option>
			<%for (int i = 0; i < result.length; i++) {%>
	      	<option value="<%=result[i][0]%>"><%=result[i][0]%>-><%=result[i][1]%>
	      	</option>
	    	<%}%>
    	</select>
		</td>
		<td class="blue">Ӫ��������</td>
		<td>
			<select name="spCode" class="button" id="spCode">
	    		<option value="">--��ѡ��--</option>
    		</select>
		</td>
	</tr>
	<tr> 
		<td align="center" id="footer" colspan="4">
			<input type="button" name="select" class="b_foot" value="��ѯ" onclick="selQry()">
			&nbsp;
			<input type="button" name="reset" class="b_foot" value="���" onclick="resetJsp()">
		</td>
	</tr>
</table>
	 <%@ include file="/npage/include/footer.jsp" %>
</form>
</BODY>
</HTML>
