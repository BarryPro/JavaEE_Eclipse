<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%

  /*
   * ����:ʹ�ò�������
   * �汾: 1.0
   * ����: 2009/3/20
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
    
	String opCode = "4243";
	String opName = "ʹ�ò�������";
	String dateStr = new java.text.SimpleDateFormat("yyyyMM").format(new java.util.Date());
	String orgCode =(String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	
	StringBuffer  insql = new StringBuffer();
	insql.append("select type_code,UNIT_CODE,DEPARTMENT_CODE,DEPARTMENT_NAME ");
	insql.append("  from sUseDepartment  ");
	insql.append(" where USE_FLAG = 'Y' ");
	insql.append(" order by type_code,unit_code,DEPARTMENT_CODE ");
	System.out.println("insql====="+insql);
	
	StringBuffer  sql = new StringBuffer();
	sql.append("select a.type_code,a.unit_code,nvl(b.region_name,'ʡ��˾') ,a.unit_name  ");
	sql.append(" from sUseUnit a, sregioncode b  ");
	sql.append(" where a.USE_FLAG = 'Y' ");
	sql.append(" and  a.type_code=b.region_code(+)  ");
	sql.append(" order by type_code, unit_code");
	System.out.println("sql====="+sql);
	
	StringBuffer  stypesql = new StringBuffer();
	stypesql.append("select type_code, nvl(b.region_name,'ʡ��˾') ");
	stypesql.append("  from sUseDepartment a, sregioncode b  ");
	stypesql.append(" where a.USE_FLAG = 'Y'  ");
	stypesql.append(" and  a.type_code=b.region_code(+) ");
	stypesql.append(" group by type_code,nvl(b.region_name,'ʡ��˾') ");
	stypesql.append(" order by type_code ");
	System.out.println("stypesql====="+stypesql);
	
	StringBuffer  sunitsql = new StringBuffer();
	sunitsql.append("select type_code, nvl(b.region_name,'ʡ��˾') ");
	sunitsql.append("  from sUseUnit a, sregioncode b  ");
	sunitsql.append(" where a.USE_FLAG = 'Y'  ");
	sunitsql.append(" and  a.type_code=b.region_code(+) ");
	sunitsql.append(" group by type_code,nvl(b.region_name,'ʡ��˾') ");
	sunitsql.append(" order by type_code ");
	System.out.println("sunitsql====="+sunitsql);
	
%>
<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="4">
<wtc:sql><%=insql%></wtc:sql>
</wtc:pubselect>
<wtc:array id="departmentDetailData" scope="end" />

<wtc:pubselect name="sPubSelect"  routerKey="region" routerValue="<%=regionCode%>" outnum="4">
<wtc:sql><%=sql%></wtc:sql>
</wtc:pubselect>
<wtc:array id="result" scope="end" />

<wtc:pubselect name="sPubSelect"  routerKey="region" routerValue="<%=regionCode%>" outnum="2">
<wtc:sql><%=stypesql%></wtc:sql>
</wtc:pubselect>
<wtc:array id="result1" scope="end" />

<wtc:pubselect name="sPubSelect"  routerKey="region" routerValue="<%=regionCode%>" outnum="2">
<wtc:sql><%=sunitsql%></wtc:sql>
</wtc:pubselect>
<wtc:array id="result2" scope="end" />

<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<script language="JavaScript">
<!--	
var oprType_Add = "a";
var oprType_Del = "d";
var oprType_Qry = "q";

var arrtypeCode=new Array();
var arrunitcode=new Array();
var arrdepartmentcode=new Array();
var arrdepartmentname=new Array();

var atypeCode=new Array();
var aunitCode=new Array();
var regionName=new Array();
var aunitName=new Array();
    
<%  
  	for(int i=0;i<departmentDetailData.length;i++)
  	{
		out.println("arrtypeCode["+i+"]='"+departmentDetailData[i][0]+"';\n");
		out.println("arrunitcode["+i+"]='"+departmentDetailData[i][1]+"';\n");
		out.println("arrdepartmentcode["+i+"]='"+departmentDetailData[i][2]+"';\n");
		out.println("arrdepartmentname["+i+"]='"+departmentDetailData[i][3]+"';\n");
	}
%>

<%  
  	for(int i=0;i<result.length;i++)
  	{
		out.println("atypeCode["+i+"]='"+result[i][0]+"';\n");
		out.println("aunitCode["+i+"]='"+result[i][1]+"';\n");
		out.println("regionName["+i+"]='"+result[i][2]+"';\n");
		out.println("aunitName["+i+"]='"+result[i][3]+"';\n");
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

// ��������
function chg_opType()
{
	with(document.frm4243)
	{
		var op_type = opType[opType.selectedIndex].value;

		if( op_type == oprType_Add )
		{
			add.style.display="";
			other.style.display="none";
			showAdd.style.display="";
			showOther.style.display="none";				
		}
		else
		{
			add.style.display="none";
			other.style.display="";
			showAdd.style.display="none";
			showOther.style.display="";				
		}
		enabledInput();
		chg_sdepartmentCode();
		
		if(( op_type == oprType_Del )||( op_type == oprType_Add ))
		{
			sdepartmentCode.value = "";
			clearInput();			
		}
		if(op_type == oprType_Add)
		{
			typeCode.value = "";
			adepartmentCode.value = "";
			departmentName.value = "";
		}
		stypeCode.value = "";
		sunitCode.value = "";
	}
	if(op_type == oprType_Add)
	{
		chg_addtypeCode();
		document.frm4243.unitCode.value = "";
	}
	else
	{
		chg_typeCode();
	}
}	


// ���ƻ��Կ���
function enabledInput()
{
	with(document.frm4243)
	{
		var op_type = opType[opType.selectedIndex].value;
		if(op_type == oprType_Add)
		{
			departmentName.disabled =  false;
		}
		else
		{
			departmentName.disabled =  true;
		}						
	}
}

// �������	
function clearInput()
{
	with(document.frm4243)
	{
		departmentName.value = "";
	}		
}
 
// check
function judge_valid()
{
	with(document.frm4243){
		var op_type = document.frm4243.opType[document.frm4243.opType.selectedIndex].value;
		if(op_type == oprType_Add){
    		if(typeCode.value==""){
	  				rdShowMessageDialog("������ʡ�б�־!");
	  				return false;
				}
    		if(adepartmentCode.value==""){
	  				rdShowMessageDialog("�����벿�Ŵ���");
	  				return false;
				}
				if(departmentName.value==""){
	  				rdShowMessageDialog("�����벿������!");
	  				return false;
				}
		}
		if(op_type == oprType_Del)
		{
			if(stypeCode.value=="")
			{
	  			rdShowMessageDialog("������ʡ�б�־!");
	  			return false;
			}
			if(sunitCode.value=="")
			{
	  			rdShowMessageDialog("�����뵥λ����!");
	  			return false;
			}
			if(sdepartmentCode.value=="")
			{
	  			rdShowMessageDialog("�����벿�Ŵ���!");
	  			return false;
			}
		}
	return true
	}
}

// �б�
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

// ���
function resetJsp()
{
	var op_type = document.frm4243.opType[document.frm4243.opType.selectedIndex].value;
	if( op_type == oprType_Add )
	{	
	document.frm4243.adepartmentCode.value = "";
	clearInput();
	}	
}

// ȷ��
function commitJsp()
{
	var tmpStr="";
	var op_type = document.frm4243.opType[document.frm4243.opType.selectedIndex].value;
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
	
	frm4243.submit();
}

// code��������
function chg_sdepartmentCode()
{
 	for ( x1 = 0 ; x1 < arrtypeCode.length  ; x1++ )
 	{
 		if((arrtypeCode[x1] == document.all.stypeCode.value) && (arrdepartmentcode[x1] == document.all.sdepartmentCode.value))
 		{
 			document.all.departmentName.value=arrdepartmentname[x1];
 		}
 	}
 	IList.style.display = "none";
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
function fillSelect(obj,code,text)
{
	obj.length=0;
	var option0 = new Option("--��ѡ��--","");
	obj.add(option0);
	for(var i=0; i<code.length; i++)
	{
		/*update ��������Ϊ����ѯ���͡�ɾ����ʱ,�����Ŵ��롱չʾ��ʽ�޸�Ϊ�����Ŵ���--�������ơ� by diling@2012/5/16
		  var option1 = new Option(text[i],code[i]);
		*/
		var option1 = new Option(code[i]+"--"+text[i],code[i]);
        obj.add(option1);
	}
}

// ʡ�б�־--��λ����(other)
function chg_typeCode()
{
	if(document.all.stypeCode.value != "")
	{
		var sql = "90000245";
		var sqlParam = document.all.stypeCode.value+"|"+document.all.stypeCode.value+"|";
		var rpc_flag = "chg_typeCode";
		sendRpc(sql,sqlParam,rpc_flag);
	}
	document.all.sdepartmentCode.value = "";
	document.all.departmentName.value = "";
}

// �ж�rpc_select��Ǩ��
function doProcess(packet){
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
		fillSelectAdd(document.all.sunitCode,code,text);
	}
	else if(rpc_flag == "chg_suitCode")
	{
		var code = packet.data.findValueByName("code");
		var text =  packet.data.findValueByName("text");
		/*update ��������Ϊ����ѯ���͡�ɾ����ʱ,�����Ŵ��롱չʾ��ʽ�޸�Ϊ�����Ŵ���--�������ơ� by diling@2012/5/14
		  fillSelect(document.all.sdepartmentCode,code,code);
		 */
		fillSelect(document.all.sdepartmentCode,code,text);
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

// ��λ����--���Ŵ���(other)
function chg_suitCode()
{
	if(document.all.sunitCode.value != "")
	{
		var sql = "90000244";/*update ��������Ϊ����ѯ���͡�ɾ����ʱ,�����Ŵ��롱չʾ��ʽ�޸�Ϊ�����Ŵ���--�������ơ� by diling@2012/5/16*/
		var sqlParam = document.all.stypeCode.value+"|"+document.all.sunitCode.value+"|";
		var rpc_flag = "chg_suitCode";
		sendRpc(sql,sqlParam,rpc_flag);
	}
	document.all.departmentName.value = "";
}

// ʡ�б�־--��λ����(add)
function chg_addtypeCode()
{
	//���������
	document.all.unitCode.length=1;
	for ( x3 = 0 ; x3 < atypeCode.length  ; x3++ )
	{
		if((atypeCode[x3] == document.all.typeCode.value))
		{	
			var option1 = new Option(aunitCode[x3]+"-->"+aunitName[x3],aunitCode[x3]);
        	document.all.unitCode.add(option1);
		}
	}
}

</script> 
 
<title>ʹ�ò�������</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
</head>
<BODY>
<form action="f4243Cfm.jsp" method="post" name="frm4243"  >
	<input type="hidden" name="opCode" value="<%=opCode%>">
	<input type="hidden" name="opName" value="<%=opName%>">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">ʹ�ò�������</div>
	</div>
<table cellspacing="0">           
	<tr> 
		<td class="blue" width="10%" nowrap>��������</td>
		<td width="35%"> 
			<select name="opType" class="button" id="select" onChange="chg_opType()">
				<option value="a">����</option>
        		<option value="d">ɾ��</option>
        		<option value="q" selected>��ѯ</option>
      		</select>
    	</td>
    	<td>&nbsp;</td>
    	<td>&nbsp;</td>
    </tr>
    <tr id="other">
    	<td class="blue" width="10%" nowrap>ʡ�б�־</td>
    	<td>
    	<select name="stypeCode" class="button" id="select" onchange="chg_typeCode()" >
    		<option value="">--��ѡ��--</option>
    		<%for (int i = 0; i < result1.length; i++) {%>
	      		<option value="<%=result1[i][0]%>"><%=result1[i][1]%>
	      		</option>
	    	<%}%>
    	</select>
    	</td>
	    <td class="blue" width="20%">��λ����</td>
			<td>
				<select name="sunitCode" id="unitCode1" onchange="chg_suitCode()">
					<option value="">--��ѡ��--</option>
				</select>
			</td>
	  	</tr>
  	<tr id="add">
  		<td class="blue" width="10%" nowrap>ʡ�б�־</td>
  		<td>
    	<select name="typeCode" class="button" id="select" onchange="chg_addtypeCode()" >
    		<option value="">--��ѡ��--</option>
			<%for (int i = 0; i < result2.length; i++) {%>
	      	<option value="<%=result2[i][0]%>"><%=result2[i][1]%>
	      	</option>
	    	<%}%>
    	</select>
    	</td>
		<td class="blue" width="20%">��λ����</td>
		<td>
			<select name="unitCode" id="unitCode">
				<option value="">--��ѡ��--</option>
				<%for (int i = 0; i < result.length; i++) {%>
			      <option value="<%=result[i][1]%>"><%=result[i][1]%>
			      </option>
			    <%}%>
			</select>
		</td>
	</tr>
	<tr id="showOther" >
		<td class="blue">���Ŵ���</td>
		<td> 
			<select name="sdepartmentCode" id="departmentCode" onchange="chg_sdepartmentCode()"> 
			    <option value="">--��ѡ��--</option>
      		</select>
    	</td>
    	<td>&nbsp;</td>
    	<td>&nbsp;</td>
	</tr>
	<tr id="showAdd" >
		<td class="blue">���Ŵ���</td>
		<td><input name="adepartmentCode" type="text" class="button" id="adepartmentCode" v_type="0_9" maxlength="4" style="ime-mode:disabled" onKeyPress="return isKeyNumberdot(0)" v_must=1 v_name="���Ŵ���"> 
		</td>
		<td>&nbsp;</td>
    	<td>&nbsp;</td>
	</tr>
	<tr>
		<td class="blue">��������</td>
		<td><input name="departmentName" type="text" class="button" id="departmentName" size="60" v_must=1 v_type=string v_name="��������"></td>
		<td>&nbsp;</td>
    	<td>&nbsp;</td>
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
 	out.println("<th align='center'>ʡ�б�־</th>");
 	out.println("<th align='center'>��λ����</th>");
 	out.println("<th align='center'>���Ŵ���</th>");
 	out.println("<th align='center'>��������</th>");
 	out.println("</tr>");
 	for(int i =0; i < departmentDetailData.length; i++)
 	{
	 		out.println("<tr align=center>");
	 		out.println("<td>" + departmentDetailData[i][0]  +  "</td>");
	 		out.println("<td>" + departmentDetailData[i][1]  +  "</td>");
	 		out.println("<td>" + departmentDetailData[i][2]  +  "</td>");
	 		out.println("<td>" + departmentDetailData[i][3]  +  "</td>");
	 		out.println("</tr>");
 	} 
 %>
 </table>

  <p>&nbsp;</p>
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
