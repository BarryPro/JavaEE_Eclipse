<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * ����:һ�˶࿨��ѯ
   * ����: 2009/3/31
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

	String opCode = "4268";
	String opName = "һ�˶࿨��ѯ";
	String dateStr = new java.text.SimpleDateFormat("yyyyMM").format(new java.util.Date());
	String orgCode =(String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);

	StringBuffer  insql = new StringBuffer();
	insql.append("select a.type_code, nvl(b.region_name,'ʡ��˾') ");
	insql.append("  from sUseCenter a,sregioncode b ");
	insql.append(" where a.USE_FLAG = 'Y' ");
	insql.append(" and a.type_code in ('" + regionCode + "','99')");
	insql.append(" and a.type_code=b.region_code(+) ");
	insql.append(" group by a.type_code,nvl(b.region_name,'ʡ��˾') ");
	insql.append(" order by a.type_code ");
	System.out.println("insql====="+insql);
%>

<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="2">
<wtc:sql><%=insql%></wtc:sql>
</wtc:pubselect>
<wtc:array id="result" scope="end" />

<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<script language="JavaScript">
<!--

// ʡ�б�־--��λ
function typechange()
{
	if(document.all.typeCode.value != "")
	{
		var sql = "select a.unit_code,b.unit_name from sUseCenter a,sUseUnit b "+
			  "where a.use_flag='Y' and a.unit_code = b.unit_code "+
			  "and a.type_code = :region_code "+
			  "group by a.unit_code,b.unit_name ";
		var sqlParam = "region_code="+document.all.typeCode.value;
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
		var sql = "select a.department_code,b.department_name from sUseCenter a,sUseDepartment b "+
			  "where a.use_flag='Y' and a.department_code = b.department_code "+
			  " and a.type_code = :region_type "+
			  "and a.unit_code = :region_code "+
			  "group by a.department_code,b.department_name ";
		var sqlParam = "region_type="+document.all.typeCode.value+",region_code="+document.all.useUnit.value;
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
	if(document.all.useDepartment.value != "")
	{
		var sql = "select center_code,center_name from sUseCenter  "+
			  "where use_flag='Y'  "+
			  "and type_code = :region_type "+
			  "and unit_code = :region_unit  "+
			  "and department_code = :region_code "+
			  "group by center_code,center_name ";
		var sqlParam = "region_type="+document.all.typeCode.value+",region_unit="+document.all.useUnit.value+",region_code="+document.all.useDepartment.value;
		var rpc_flag = "chg_department";
		sendRpc(sql,sqlParam,rpc_flag);
	}
}

function sendRpc(sql,sqlparam,rpc_flag)
{
	var myPacket = new AJAXPacket("rpc_select.jsp","���ڻ�ȡ��Ϣ�����Ժ�......");
	myPacket.data.add("sql",sql);
	myPacket.data.add("sqlParam",sqlparam);
	myPacket.data.add("rpc_flag", rpc_flag);
	core.ajax.sendPacket(myPacket);
	myPacket=null;
}

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

function judge_valid()
{
	with(document.frm){
		if(typeCode.value=="")
		{
  			rdShowMessageDialog("������ʡ�б�־");
  			return false;
		}
		else if(useUnit.value=="")
		{
			rdShowMessageDialog("������ʹ�õ�λ");
  			return false;
		}
		else if(useDepartment.value=="")
		{
			rdShowMessageDialog("������ʹ�ò���");
  			return false;
		}
		else if(useCenter.value=="")
		{
			rdShowMessageDialog("������ʹ������");
  			return false;
		}
		else if(custName.value=="")
		{
			rdShowMessageDialog("������ͻ�����");
  			return false;
		}

		return true
	}
}

function resetJsp()
{
	document.frm.typeCode.value="";
	document.frm.useUnit.value="";
	document.frm.useDepartment.value="";
	document.frm.useCenter.value="";
	document.frm.custName.value="";
}

function commitJsp()
{
	if(judge_valid()){
		if(check(frm)){
		   	var typeCode = document.frm.typeCode.value;
		   	var useUnit = document.frm.useUnit.value;
		   	var useDepartment = document.frm.useDepartment.value;
		   	var useCenter = document.frm.useCenter.value;
		   	var custName = document.frm.custName.value;
		   	document.middle.location="f4268info.jsp?typeCode="+typeCode+"&useUnit=" + useUnit+"&useDepartment="+useDepartment+"&useCenter=" + useCenter+"&custName="+custName;
		   	tabBusi.style.display="";
	    }
	}
}

</script>

<title>һ�˶࿨��ѯ</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
</head>
<BODY>
<form action="" method="post" name="frm"  >
	<input type="hidden" name="opCode" value="<%=opCode%>">
	<input type="hidden" name="opName" value="<%=opName%>">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">һ�˶࿨��ѯ</div>
	</div>
<table cellspacing="0">
	<tr>
    	<td class="blue" width="8%" nowrap>ʡ�б�־</td>
    	<td>
    	<select name="typeCode" class="button" id="select" onchange="typechange()" >
    		<option value="">--��ѡ��--</option>
    		<%for (int i = 0; i < result.length; i++) {%>
	      		<option value="<%=result[i][0]%>"><%=result[i][1]%>
	      		</option>
	    	<%}%>
    	</select>
    	</td>
    	<td class="blue" width="8%">ʹ�õ�λ</td>
		<td>
			<select name="useUnit" id="useUnit" onchange="unitchange()">
				<option value="">--��ѡ��--</option>
			</select>
		</td>
	</tr>
	<tr>
		<td class="blue" width="8%">ʹ�ò���</td>
		<td>
			<select name="useDepartment" id="useDepartment" onchange="chg_department()">
			    <option value="">--��ѡ��--</option>
      		</select>
		</td>
		<td class="blue" width="8%">ʹ������</td>
		<td>
			<select name="useCenter" id="useCenter" >
			    <option value="">--��ѡ��--</option>
      		</select>
    	</td>
	</tr>
	<tr>
		<td class="blue" width="8%">�ͻ�����</td>
		<td>
			<input name="custName" id="custName" size="20" maxlength="60" type="text" class="button" value="">
		</td>
		<td>&nbsp;</td>
    	<td>&nbsp;</td>
	</tr>
	<tr>
		<td align="center" id="footer" colspan="4">
			<input type="button" name="confirm" class="b_foot" value="��ѯ" onclick="commitJsp()">
			&nbsp;
			<input type="button" name="reset" class="b_foot" value="���" onclick="resetJsp()">
			&nbsp;
		</td>
	</tr>
</table>
<TABLE id="tabBusi" style="display:none" width="100%"  align="center" id="mainOne" cellspacing="0" border="0" >
	<TR>
		<td nowrap>
			<IFRAME frameBorder=0 id=middle name=middle scrolling="yes"
			style="HEIGHT: 1000%; VISIBILITY: inherit; WIDTH: 99%; Z-INDEX: 1">
			</IFRAME>
		</td>
	</TR>
</TABLE>
<%@ include file="/npage/include/footer.jsp" %>
</form>
</BODY>
</HTML>

