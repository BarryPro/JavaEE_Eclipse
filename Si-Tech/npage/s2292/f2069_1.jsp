<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%

  /*
   * ����:��������0Ԫ���°�����
   * �汾: 1.0
   * ����: 2009/5/11
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
    
	String opCode = "2069";
	String opName = "��������0Ԫ���°�����";
	String dateStr = new java.text.SimpleDateFormat("yyyyMM").format(new java.util.Date());
	String orgCode =(String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	String loginGroup = (String)session.getAttribute("workGroupId");
	String vGroupId = (String)session.getAttribute("groupId");
	String offer_code = regionCode +"fj@@Mdz0";
	String sqlOffer = "select offer_id from product_offer where offer_code='"+offer_code+"'";
	StringBuffer  insql = new StringBuffer();
	insql.append("select region_code,mode_code,add_mode,note from sMusicModeCfg order by region_code");
	System.out.println("insql====="+sqlOffer);
	
%>
<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="4">
<wtc:sql><%=insql%></wtc:sql>
</wtc:pubselect>
<wtc:array id="result" scope="end" />
<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="4">
<wtc:sql><%=sqlOffer%></wtc:sql>
</wtc:pubselect>
<wtc:array id="result1" scope="end" />

<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<script language="JavaScript">
<!--	
var oprType_Add = "a";
var oprType_Del = "d";
var oprType_Qry = "q";

var regionCode=new Array();
var modeCode=new Array();
var gMode=new Array();
var note=new Array();
    
<%  
  	for(int i=0;i<result.length;i++)
  	{
		out.println("regionCode["+i+"]='"+result[i][0]+"';\n");
		out.println("modeCode["+i+"]='"+result[i][1]+"';\n");
		out.println("gMode["+i+"]='"+result[i][2]+"';\n");
		out.println("note["+i+"]='"+result[i][3]+"';\n");
	}
%>

onload=function()
{		
	init();
}

// ��ʼ��
function init()
{
	chg_opType();
	ILista.style.display = "none";
	onCtrlCode();
}

// ��������
function chg_opType()
{
	with(document.frm)
	{
		var op_type = opType[opType.selectedIndex].value;

		if( op_type == oprType_Add )
		{
			moAdd.style.display="";
			moDel.style.display="none";
			g3Add.style.display="";
			g3Del.style.display="none";
			ctrlAdd.style.display="";
			noAdd.style.display="";
			noDel.style.display="none";
			buttonA.style.display="";
			buttonB.style.display="none";
			tabBusi.style.display="none";
			ILista.style.display="none";
			
			mode_code.value="";
			mode_name.value="";
		}
		else if( op_type == oprType_Del )
		{
			moAdd.style.display="none";
			moDel.style.display="";
			g3Add.style.display="none";
			g3Del.style.display="";
			ctrlAdd.style.display="none";
			noAdd.style.display="none";
			noDel.style.display="";
			buttonA.style.display="";
			buttonB.style.display="none";
			tabBusi.style.display="none";
			ILista.style.display="none";
			
			mode_code1.value="";
			mode_name1.value="";
			g3Mode1.value="";
			opNote1.value="";
		}
		else if( op_type == oprType_Qry )
		{
			moAdd.style.display="none";
			moDel.style.display="";
			g3Add.style.display="none";
			g3Del.style.display="none";
			ctrlAdd.style.display="none";
			noAdd.style.display="none";
			noDel.style.display="none";
			buttonA.style.display="none";
			buttonB.style.display="";
			tabBusi.style.display="none";
			ILista.style.display="none";
		}
		
		region_code.value="";
		region_name.value="";
	}
}

// ������ѯ
function queryRegionCode()
{
	var pageTitle = "������ѯ";
    var fieldName = "��������|��������";//����������ʾ���С����� 
    var sqlStr ="select  region_code, region_name from sRegionCode where region_code between '01' and '13'  order by region_code " ;
    var selType = "S";    //'S'��ѡ��'M'��ѡ
    var retQuence = "0|1";//�����ֶ�
    var retToField = "region_code|region_name";//���ظ�ֵ����    
    if(PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField));
    
    with(document.frm)
	{
		var op_type = document.frm.opType[document.frm.opType.selectedIndex].value;
		if(op_type == oprType_Add)
		{
    		selMode();
    	}
    }
}

// ����_�ʷѲ�ѯ
function queryModeCode()
{
	if(document.frm.region_code.value=="���ѡ��")
	{
		rdShowMessageDialog("���������������!");
		return false;
	}
	
	var regionCode = document.frm.region_code.value;	
	var modeCode=document.frm.mode_code.value;	
	var pageTitle = "�ʷѲ�ѯ";
    var fieldName = "���ʷѴ���|���ʷ�����|��־|";//����������ʾ���С����� 
 
    
    var sqlStr = "SELECT to_char(a.offer_id),trim(a.offer_name),a.offer_type FROM product_offer a, region b ,sregioncode d WHERE a.offer_id = b.offer_id";
    sqlStr = sqlStr+" and d.REGION_CODE = '"+document.all.region_code.value+"'  AND a.offer_type = '10'";
    sqlStr = sqlStr+" AND a.offer_id LIKE '%"+codeChg(modeCode).trim()+"%'";
    sqlStr = sqlStr+" AND sysdate between a.eff_date and a.exp_date ";
    sqlStr = sqlStr+" AND a.offer_id NOT IN (SELECT to_number(mode_code) FROM smusicmodecfg where region_code = '"+document.frm.region_code.value+"')";
    var selType = "S";    //'S'��ѡ��'M'��ѡ
    var retQuence = "3|0|1|2|";//�����ֶ�
    var retToField = "mode_code|mode_name|mode_flag|";//���ظ�ֵ���� 
    if(PubSimpSelTwo(pageTitle,fieldName,sqlStr,selType,retQuence,retToField));
}

// ��ѯ/ɾ��_�ʷѲ�ѯ
function queryModeCode1()
{
	if(document.frm.region_code.value=="���ѡ��")
	{
		rdShowMessageDialog("���������������!");
		return false;
	} 
	
	var regionCode = document.frm.region_code.value;
	var modeCode1=document.frm.mode_code1.value;
	var pageTitle = "�ʷѲ�ѯ";
    var fieldName = "���ʷѴ���|���ʷ�����|��־|";//����������ʾ���С����� 
    var sqlStr ="SELECT TO_CHAR (offer_id), TRIM (a.offer_name), a.offer_type FROM product_offer a, smusicmodecfg b WHERE a.offer_id = b.mode_code AND b.region_code = '" + document.frm.region_code.value + "' and a.offer_id like '";
    sqlStr = sqlStr+"%" +codeChg(modeCode1) + "%".trim() ;
    sqlStr = sqlStr+"' " ;
    var selType = "S";    //'S'��ѡ��'M'��ѡ
    var retQuence = "3|0|1|2|";//�����ֶ�
    var retToField = "mode_code1|mode_name1|mode_flag1|";//���ظ�ֵ����

    if(PubSimpSelTwo(pageTitle,fieldName,sqlStr,selType,retQuence,retToField));

    with(document.frm)
	{
		var op_type = opType[opType.selectedIndex].value;

		if( op_type == oprType_Del )
		{
			mode();
			g3_mode1();
		}
	}
}

function PubSimpSelTwo(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
{
    var path = "<%=request.getContextPath()%>/npage/public/fPubSimpSel_1270.jsp";
    path = path + "?sqlStr=" + codeChg(sqlStr) + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType + "&opCode=2069";  
    retInfo = window.showModalDialog(path,"","dialogWidth:60");
    if(retInfo ==undefined)      
    {   return false;   }
    var chPos_field = retToField.indexOf("|");
    var chPos_retStr;
    var valueStr;
    var obj;
    while(chPos_field > -1)
    {
        obj = retToField.substring(0,chPos_field);
        chPos_retInfo = retInfo.indexOf("|");
        valueStr = retInfo.substring(0,chPos_retInfo);
        document.all(obj).value = valueStr;
        retToField = retToField.substring(chPos_field + 1);
        retInfo = retInfo.substring(chPos_retInfo + 1);
        chPos_field = retToField.indexOf("|");
    }
	return true;
}

// �б�
function DoList()
{
	if (ILista.style.display != "none")
	{
		ILista.style.display = "none";
	}
	else
	{
		ILista.style.display = "";
	}
}

// ���
function resetJsp()
{
	var op_type = document.frm.opType[document.frm.opType.selectedIndex].value;
	if( op_type == oprType_Add )
	{	
		document.frm.region_code.value="���ѡ��";
		document.frm.region_name.value="";
		document.frm.mode_code.value="";
		document.frm.mode_name.value="";
		document.frm.ctrlCode.value="0";
		document.frm.opNote.value="";
	}	
	if( op_type == oprType_Del )
	{	
		document.frm.region_code.value="���ѡ��";
		document.frm.region_name.value="";
		document.frm.mode_code1.value="";
		document.frm.mode_name1.value="";
		document.frm.g3Mode1.value="";
		document.frm.opNote1.value="";
	}
}

// AJAXPacket
function sendRpc(sql,sqlparam,rpc_flag)
{
	var myPacket = new AJAXPacket("/npage/s9387/rpc_select.jsp","���ڻ�ȡ��Ϣ�����Ժ�......");
	myPacket.data.add("sql",sql);
	myPacket.data.add("sqlParam",sqlparam);
	myPacket.data.add("rpc_flag", rpc_flag);
	core.ajax.sendPacket(myPacket);
	myPacket=null;  
}

// ���ʷ�
function mode()
{
	if(document.all.mode_code1.value != "")
	{
		var sql = "90000236";
		var sqlParam = document.all.region_code.value+"|"+document.all.mode_code1.value + "|";
		var rpc_flag = "chg_addMode";
		sendRpc(sql,sqlParam,rpc_flag);
	}
}

// ��ע
function g3_mode1()
{
		var sql = "90000237";
		var sqlParam = document.all.region_code.value+"|"+document.all.mode_code1.value + "|";
		var rpc_flag = "chg_opNote";
		sendRpc(sql,sqlParam,rpc_flag);
}

// �ж�rpc_select��Ǩ��
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
	if(rpc_flag == "chg_addMode")
	{
		var code = packet.data.findValueByName("code");
		var text =  packet.data.findValueByName("text");
		document.all.g3Mode1.value=packet.data.findValueByName("code");
	}
	else if(rpc_flag == "chg_opNote")
	{
		var code = packet.data.findValueByName("code");
		var text =  packet.data.findValueByName("text");
		document.all.opNote1.value=packet.data.findValueByName("code");
	}
	else if(rpc_flag == "chg_selMode")
	{
		var code = packet.data.findValueByName("code");
		var text =  packet.data.findValueByName("text");
		document.all.g3Mode.value=packet.data.findValueByName("code");
	}
}

// check
function judge_valid()
{
	with(document.frm)
	{
		var op_type = document.frm.opType[document.frm.opType.selectedIndex].value;
		if(op_type == oprType_Add)
		{
			if(document.frm.region_code.value=="")
			{
				rdShowMessageDialog("�������������!");
			  	return false;
			}
			if(document.frm.mode_code.value.trim()=="")
			{
				rdShowMessageDialog("���������ʷѴ���!");
			  	return false;
			}
			if(document.frm.g3Mode.value.trim()=="")
			{
				rdShowMessageDialog("���ʷѲ���Ϊ��!");
			  	return false;
			}
			if(document.frm.opNote.value.trim()=="")
			{
				rdShowMessageDialog("�����뱸ע!");
			  	return false;
			}
		}
		if(op_type == oprType_Del)
		{
			if(document.frm.region_code.value=="")
			{
				rdShowMessageDialog("�������������!");
			  	return false;
			}
			if(document.frm.mode_code1.value.trim()=="")
			{
				rdShowMessageDialog("���������ʷѴ���!");
			  	return false;
			}
			if(document.frm.g3Mode1.value.trim()=="")
			{
				rdShowMessageDialog("��������ʷ�!");
			  	return false;
			}
		}
	return true
	}
}

// ��ѯ
function sel()
{
	if(check(frm))
	{
		var regionCode = document.all.region_code.value;
	   	var modeCode1 = document.all.mode_code1.value;
	   	document.middle.location="f2069info.jsp?regionCode="+regionCode+"&modeCode1="+modeCode1;
	   	tabBusi.style.display="";
	}
}

// ȷ��
function commitJsp()
{
	if( !judge_valid() )
	{
		return false;
	}
	
	frm.submit();
}

// ������ע
function onCtrlCode()
{
	if(document.all.ctrlCode.value == "1")
	{
		document.all.opNote.value="ֻ��ָ���ʷѿ��԰���0Ԫ��������ҵ��";
	}
	else if(document.all.ctrlCode.value == "0")
	{
		document.all.opNote.value="ֻ��ָ���ʷѿ��԰���0Ԫ�������ֺͲ���ҵ��";
	}
}

function selMode()
{
	if(document.all.region_code.value != "")
	{
		var sql = "90000238";
		var sqlParam = document.all.region_code.value+"|"+document.all.musicModeCode.value+"|";
		var rpc_flag = "chg_selMode";
		sendRpc(sql,sqlParam,rpc_flag);
	}
}

</script> 
 
<title>��������0Ԫ���°�����</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
</head>
<BODY>
<form action="f2069Cfm.jsp" method="post" name="frm"  >
	<input type="hidden" name="opCode" value="<%=opCode%>">
	<input type="hidden" name="opName" value="<%=opName%>">
	<input type="hidden" name="musicModeCode" value="fj@@Mdz0">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">��������0Ԫ���°�����</div>
	</div>
<table cellspacing="0">           
	<tr>
		<td class="blue" width="12%" nowrap>��������</td>
		<td width="35%"> 
			<select name="opType" class="button" id="select" onChange="chg_opType()">
				<option value="q" selected>��ѯ</option>
				<option value="a">����</option>
        		<option value="d">ɾ��</option>
      		</select>
    	</td>
    	<td>&nbsp;</td>
    	<td>&nbsp;</td>
    </tr>
    <tr>
		<td class="blue">��������</td>
		<td>
			<input class="button" type=text  v_type="string" size="8" v_must=0 v_minlength=0 v_maxlength=10 v_name="��������"  name="region_code" value="���ѡ��"  maxlength=20 readonly>
			<input class="b_text" type="button" name="query_regioncode" onclick="queryRegionCode()" value="ѡ��">
		</td>
		<td class="blue">��������</td>
		<td>
			<input name="region_name" type="text" class="InputGrey" id="region_name" maxlength=20 size="30" v_must=1 v_minlength=1 v_maxlength=30 readonly>    
    	</td>
    </tr>
    <tr id="moAdd">
		<td class="blue">���ʷѴ���</td>
        <td>
			<input name="mode_code" type="text" class="button" id="mode_code" size="9" maxlength=8 >
			<input class="b_text" type="button" name="query_modecode" onclick="queryModeCode()" value="��ѯ">
		</td>
		<td class="blue">���ʷ�����</td>
		<td>
			<input name="mode_name" type="text" class="InputGrey" id="mode_name" maxlength=30 size="30" v_must=1 v_minlength=1 v_maxlength=30 readonly >
			<input name="mode_flag" type="hidden" class="button" id="mode_flag" maxlength=30 size="30" v_must=1 v_minlength=1 v_maxlength=30 readonly >    
    	</td>
    </tr>
    <tr id="moDel">
    	<td class="blue">���ʷѴ���</td>
        <td>
			<input name="mode_code1" type="text" class="button" id="mode_code1" size="9" maxlength=8 >
			<input class="b_text" type="button" name="query_modecode1" onclick="queryModeCode1()" value="��ѯ">
		</td>
		<td class="blue">���ʷ�����</td>
		<td>
			<input name="mode_name1" type="text" class="InputGrey" id="mode_name1" maxlength=30 size="30" v_must=1 v_minlength=1 v_maxlength=30 readonly >
			<input name="mode_flag1" type="hidden" class="button" id="mode_flag1" maxlength=30 size="30" v_must=1 v_minlength=1 v_maxlength=30 readonly >    
    	</td>
    </tr>
    <tr id="g3Add">
    	<td class="blue">���ʷ�</td>
    	<td>
    		<input name="g3Mode" type="text" class="InputGrey" id="g3Mode" maxlength="8"  readonly>
    	</td>
    	<td>&nbsp;</td>
    	<td>&nbsp;</td>
    </tr>
    <tr id="ctrlAdd">
    	<td class="blue">ǰ�������</td>
    	<td>
    		<select name="ctrlCode" class="button" id="ctrlCode" onChange="onCtrlCode()">
				<option value="1">������������</option>
        		<option value="0">�����������ֺͲ���</option>
      		</select>
    	</td>
    	<td>&nbsp;</td>
    	<td>&nbsp;</td>
    </tr>
    <tr id="g3Del">
    	<td class="blue">���ʷ�</td>
    	<td>
			<input name="g3Mode1" type="text" class="InputGrey" id="g3Mode1" maxlength="8" readonly>
    	</td>
    	<td>&nbsp;</td>
    	<td>&nbsp;</td>
    </tr>
    <tr id="noDel">
    	<td class="blue" width="12%">��ע</td>
    	<td>
			<input name="opNote1" type="text" class="InputGrey" id="opNote1" maxlength="60" readonly>
    	</td>
    	<td>&nbsp;</td>
    	<td>&nbsp;</td>
    </tr>
</table>
<table>
    <tr id="noAdd">
    	<td class="blue" width="12%">��ע</td>
    	<td>
    		<input name="opNote" type="text" class="button" id="opNote" maxlength="60" size="60" value="">
    	</td>
    </tr>
	<tr id="buttonA"> 
		<td align="center" id="footer" colspan="4"> 
			<input type="button" name="IList"  class="b_foot" value="�б�" onclick="DoList()">
			&nbsp;
			<input type="button" name="confirm" class="b_foot" value="ȷ��" onclick="commitJsp()">
			&nbsp;
			<input type="button" name="reset" class="b_foot" value="���" onclick="resetJsp()">
		</td>
	</tr>
	<tr id="buttonB">
		<td align="center" id="footer" colspan="4"> 
			<input type="button" name="select"  class="b_foot" value="��ѯ" onclick="sel()">
		</td>
	</tr>
</table>
<table style="display='none'" id="ILista" border="2" align="center" cellPadding=0 cellSpacing=0  width="95%">
   <tr>
   	<td>
   <table align="center" valign="top" id="IListb" border="1" cellPadding=4 cellSpacing=0  width="100%">
 <%
 	out.println("<tr height=30>");
 	out.println("<th align='center'>��������</th>");
 	out.println("<th align='center'>���ʷѴ���</th>");
 	out.println("<th align='center'>���ʷ�</th>");
 	out.println("<th align='center'>��ע</th>");
 	out.println("</tr>");
 	for(int i =0; i < result.length; i++)
 	{
	 		out.println("<tr align=center>");
	 		out.println("<td>" + result[i][0]  +  "</td>");
	 		out.println("<td>" + result[i][1]  +  "</td>");
	 		out.println("<td>" + result[i][2]  +  "</td>");
	 		out.println("<td>" + result[i][3]  +  "</td>");
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
</BODY>
</HTML>
