<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%

  /*
   * ����:ʹ�õ�λ����
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
    
	String opCode = "4251";
	String opName = "ʹ�õ�λ����";
	String dateStr = new java.text.SimpleDateFormat("yyyyMM").format(new java.util.Date());
	String orgCode =(String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	StringBuffer  insql = new StringBuffer();

	insql.append("select type_code,unit_code,unit_name,nvl(b.region_name,'ʡ��˾') ");
	insql.append(" from sUseUnit a,sregioncode b   ");
	insql.append(" where a.use_flag='Y' and a.type_code=b.region_code(+) ");
	insql.append(" order by type_code,unit_code ");
	System.out.println("insql====="+insql);
	
	StringBuffer  sql = new StringBuffer();
	sql.append("select region_code,region_name ");
	sql.append("  from sregioncode  ");
	sql.append(" where (region_code between '01' and '13') ");
	sql.append(" order by region_code ");
	System.out.println("sql====="+sql);
	
	StringBuffer  stypesql = new StringBuffer();
	stypesql.append("select type_code, nvl(b.region_name,'ʡ��˾') ");
	stypesql.append("  from sUseUnit a, sregioncode b  ");
	stypesql.append(" where a.USE_FLAG = 'Y' ");
	stypesql.append(" and  a.type_code=b.region_code(+)  ");
	stypesql.append(" group by type_code , nvl(b.region_name,'ʡ��˾') ");
	stypesql.append(" order by type_code ");
	System.out.println("stypesql====="+stypesql);
%>
<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="4">
<wtc:sql><%=insql%></wtc:sql>
</wtc:pubselect>
<wtc:array id="unitDetailData" scope="end" />

<wtc:pubselect name="sPubSelect"  routerKey="region" routerValue="<%=regionCode%>" outnum="2">
<wtc:sql><%=sql%></wtc:sql>
</wtc:pubselect>
<wtc:array id="result" scope="end" />

<wtc:pubselect name="sPubSelect"  routerKey="region" routerValue="<%=regionCode%>" outnum="2">
<wtc:sql><%=stypesql%></wtc:sql>
</wtc:pubselect>
<wtc:array id="result1" scope="end" />

<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<script language="JavaScript">
<!--	
var oprType_Add = "a";
var oprType_Del = "d";
var oprType_Qry = "q";

var arrtypeCode=new Array();
var arrunitcode=new Array();
var arrunitname=new Array();
var arregionname=new Array();

var regionCode=new Array();
var regionName=new Array();
    
<%  
  	for(int i=0;i<unitDetailData.length;i++)
  	{
		out.println("arrtypeCode["+i+"]='"+unitDetailData[i][0]+"';\n");
		out.println("arrunitcode["+i+"]='"+unitDetailData[i][1]+"';\n");
		out.println("arrunitname["+i+"]='"+unitDetailData[i][2]+"';\n");
		out.println("arregionname["+i+"]='"+unitDetailData[i][3]+"';\n");
	}
%>

<%  
  	for(int i=0;i<result.length;i++)
  	{
		out.println("regionCode["+i+"]='"+result[i][0]+"';\n");
		out.println("regionName["+i+"]='"+result[i][1]+"';\n");
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
	with(document.frm4251)
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
		chg_sunitCode();
		
		if(( op_type == oprType_Del )||( op_type == oprType_Add ))
		{
			sunitCode.value = "";
			clearInput();			
		}
		if(op_type == oprType_Add)
		{
			typeCode.value = "";
			aunitCode.value = "";
			unitName.value = "";
		}
	}
	chg_typeCode();
}	


function enabledInput()
{
	with(document.frm4251)
	{
		var op_type = opType[opType.selectedIndex].value;
		if(op_type == oprType_Add)
		{
			unitName.disabled =  false;
		}
		else
		{
			unitName.disabled =  true;
		}						
	}
}
	
function clearInput()
{
	with(document.frm4251)
	{
		unitName.value = "";
	}		
}
 
function judge_valid()
{
	with(document.frm4251)
	{
		var op_type = document.frm4251.opType[document.frm4251.opType.selectedIndex].value;
		if(op_type == oprType_Add){
    		if(typeCode.value==""){
	  				rdShowMessageDialog("������ʡ�б�־!");
	  				return false;
				}
    		if(aunitCode.value==""){
	  				rdShowMessageDialog("�����뵥λ����");
	  				return false;
				}
				if(unitName.value==""){
	  				rdShowMessageDialog("�����뵥λ����!");
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
var op_type = document.frm4251.opType[document.frm4251.opType.selectedIndex].value;
	if( op_type == oprType_Add )
	{	
	document.frm4251.aunitCode.value = "";
	clearInput();
	}	
}

function commitJsp()
{
	var tmpStr="";
	var op_type = document.frm4251.opType[document.frm4251.opType.selectedIndex].value;
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
	
	frm4251.submit();
}

function chg_sunitCode()
{
 	for ( x1 = 0 ; x1 < arrtypeCode.length  ; x1++ )
 	{
 		if((arrtypeCode[x1] == document.all.stypeCode.value) && (arrunitcode[x1] == document.all.sunitCode.value))
 		{
 			document.all.unitName.value=arrunitname[x1];
 		}
 	}
 	IList.style.display = "none";
}

function chg_typeCode()
{
	//���������
	document.all.sunitCode.length=0;
	for ( x1 = 0 ; x1 < arrtypeCode.length  ; x1++ )
	{
		if((arrtypeCode[x1] == document.all.stypeCode.value))
		{	
			var option1 = new Option(arrunitcode[x1]+"--"+arrunitname[x1],arrunitcode[x1]);/*update ��������Ϊ����ѯ���͡�ɾ����ʱ�������еġ���λ���롱չʾ��ʽ�޸�Ϊ����λ����--��λ���ơ���by diling@2012/5/16*/
        	document.all.sunitCode.add(option1);
		}
	}
	chg_sunitCode();
	
	if(document.frm4251.opType[document.frm4251.opType.selectedIndex].value == oprType_Add)
	{
		if( document.frm4251.aunitCode.value=="" )
		{
			document.frm4251.unitName.value="";
		}
	}
}
 	
</script> 
 
<title>ʹ�õ�λ����</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
</head>
<BODY>
<form action="f4251Cfm.jsp" method="post" name="frm4251"  >
	<input type="hidden" name="opCode" value="<%=opCode%>">
	<input type="hidden" name="opName" value="<%=opName%>">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">ʹ�õ�λ����</div>
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
    </tr>
    <tr id="other">
    	<td class="blue" width="10%" nowrap>ʡ�б�־</td>
    	<td>
    	<select name="stypeCode" class="button" id="select" onchange="chg_typeCode()" >
    		<%for (int i = 0; i < result1.length; i++) {%>
	      	<option value="<%=result1[i][0]%>"><%=result1[i][1]%>
	      	</option>
	    	<%}%>
    	</select>
    </td>
  	</tr>
  	<tr id="add">
  		<td class="blue" width="10%" nowrap>ʡ�б�־</td>
  		<td>
    	<select name="typeCode" class="button" id="select" >
    		<option value='99'>ʡ��˾</option>
			<%for (int i = 0; i < result.length; i++) {%>
	      	<option value="<%=result[i][0]%>"><%=result[i][1]%>
	      	</option>
	    	<%}%>
    	</select>
    	</td>
	</tr>
	<tr id="showOther" >
		<td class="blue">��λ����</td>
		<td> 
			<select name="sunitCode" id="unitCode" onchange="chg_sunitCode()"> 
			    <%for (int i = 0; i < unitDetailData.length; i++) {%>
			      <option value="<%=unitDetailData[i][1]%>"><%=unitDetailData[i][1]%>--<%=unitDetailData[i][2]%>
			      </option>
			    <%}%>
      		</select>
    	</td>
	</tr>
	<tr id="showAdd" >
		<td class="blue">��λ����</td>
		<td><input name="aunitCode" type="text" class="button" id="aunitCode" v_type="0_9" maxlength="4" style="ime-mode:disabled" onKeyPress="return isKeyNumberdot(0)" v_must=1 v_name="��λ����"> 
		</td>
	</tr>
	<tr>
		<td class="blue">��λ����</td>
		<td><input name="unitName" type="text" class="button" id="unitName" size="60" v_must=1 v_type=string v_name="��λ����"></td>
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
 	out.println("<th align='center'>��λ����</th>");
 	out.println("</tr>");
 	for(int i =0; i < unitDetailData.length; i++)
 	{
	 		out.println("<tr align=center>");
	 		out.println("<td>" + unitDetailData[i][0]  +  "</td>");
	 		out.println("<td>" + unitDetailData[i][1]  +  "</td>");
	 		out.println("<td>" + unitDetailData[i][2]  +  "</td>");
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
