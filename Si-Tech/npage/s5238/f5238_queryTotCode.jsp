<%
   /*
   * ����: ��ѯ�ʵ��Żݴ���
�� * �汾: v1.0
�� * ����: 2007/01/16
�� * ����: shibo
�� * ��Ȩ: sitech
   * �޸���ʷ
   * �޸�����      �޸���      �޸�Ŀ��
 ��*/
%>
<%@page contentType="text/html;charset=gb2312"%>
<%@ page errorPage="/page/common/errorpage.jsp" %>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.boss.pub.*" %>
<%@ page import="com.sitech.boss.util.*"%>
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
	
	String detail_type = request.getParameter("detail_type");   //�Ż�����
	String region_code = request.getParameter("region_code");   //�Ż�����
	
	SPubCallSvrImpl impl = new SPubCallSvrImpl();
	ArrayList retList1 = new ArrayList();  
	String sqlStr1="";
	String whereSql="";
	String totalCodeCond="",totalNameCond="",queryFlag="";
	String cycleUnitCond="",  favourCycleCond="",  typeModeCond="",  favourTypeCond="", orderCodeCond="",step_val1="",favour1="",step_val2="",favour2="",step_val3="",favour3="";

    String retToField = request.getParameter("retToField");
    queryFlag = request.getParameter("queryFlag")==null?"":request.getParameter("queryFlag");
	totalCodeCond = request.getParameter("totalCodeCond")==null?"":request.getParameter("totalCodeCond");
	totalNameCond = request.getParameter("totalNameCond")==null?"":request.getParameter("totalNameCond");
	cycleUnitCond = request.getParameter("cycleUnitCond")==null?"":request.getParameter("cycleUnitCond");
	favourCycleCond = request.getParameter("favourCycleCond")==null?"":request.getParameter("favourCycleCond");
	typeModeCond = request.getParameter("typeModeCond")==null?"":request.getParameter("typeModeCond");
	favourTypeCond = request.getParameter("favourTypeCond")==null?"":request.getParameter("favourTypeCond");
	orderCodeCond = request.getParameter("orderCodeCond")==null?"":request.getParameter("orderCodeCond");
	step_val1 = request.getParameter("curstep_val1")==null?"":request.getParameter("curstep_val1");
	favour1 = request.getParameter("curfavour1")==null?"":request.getParameter("curfavour1");
	step_val2 = request.getParameter("curstep_val2")==null?"":request.getParameter("curstep_val2");
	favour2 = request.getParameter("curfavour2")==null?"":request.getParameter("curfavour2");
	step_val3 = request.getParameter("curstep_val3")==null?"":request.getParameter("curstep_val3");
	favour3 = request.getParameter("curfavour3")==null?"":request.getParameter("curfavour3");


	if(!(queryFlag.equals("Y")))
	{
	    whereSql = whereSql + " and 1=2";
	}

    if(!(totalCodeCond.equals("")))
	{
	    whereSql = whereSql + " and total_code like '%"+totalCodeCond+"%' ";
	}

	if(!(totalNameCond.equals("")))
	{
	    whereSql = whereSql + " and code_name like '%"+totalNameCond+"%' ";
	} 

	if(!(favourTypeCond.equals("")))
	{
	    whereSql = whereSql + " and favour_type = '"+favourTypeCond+"' ";
	}

	if(!(typeModeCond.equals("")))
	{
	    whereSql = whereSql + " and type_mode = '"+typeModeCond+"' ";
	}

	if(!(favourCycleCond.equals("")))
	{
	    whereSql = whereSql + " and favour_cycle = "+favourCycleCond+" ";
	}

	if(!(cycleUnitCond.equals("")))
	{
	    whereSql = whereSql + " and cycle_unit = "+cycleUnitCond+" ";
	}

	if(!(orderCodeCond.equals("")))
	{
	    whereSql = whereSql + " and order_code = "+orderCodeCond+" ";
	}

	if(!(step_val1.equals("")))
	{
	    whereSql = whereSql + " and step_val1 = "+step_val1+" ";
	}
	if(!(favour1.equals("")))
	{
	    whereSql = whereSql + " and favour1 = "+favour1+" ";
	}
	if(!(step_val2.equals("")))
	{
	    whereSql = whereSql + " and step_val2 = "+step_val2+" ";
	}
	if(!(favour2.equals("")))
	{
	    whereSql = whereSql + " and favour2 = "+favour2+" ";
	}
	if(!(step_val3.equals("")))
	{
	    whereSql = whereSql + " and step_val3 = "+step_val3+" ";
	}
	if(!(favour3.equals("")))
	{
	    whereSql = whereSql + " and favour3 = "+favour3+" ";
	}

	whereSql = whereSql + " and rownum < 51 order by total_code";

	sqlStr1 ="select total_code,code_name,order_code,favour_object,decode(favour_type,'1', '1->����','0','0->�ͷ�','3', '3->����'),step_val1,favour1,step_val2,favour2,step_val3,favour3 from sBillTotCode where region_code='"+region_code+"'";

	sqlStr1 = sqlStr1+whereSql;
	
	retList1 = impl.sPubSelect("11",sqlStr1,"region",regionCode);
	String[][] retListString1 = (String[][])retList1.get(0);
	int errCode=impl.getErrCode();
	String errMsg=impl.getErrMsg();
%>

<html>
<head>
<title>�ʵ��Żݴ����б�</title>
<META content="text/html; charset=gb2312" http-equiv=Content-Type>
<meta http-equiv="Expires" content="0">
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
<table width="99%" align="center" id="mainThree" bgcolor="#FFFFFF" cellspacing="1" border="0">
	<tr bgcolor="#F5F5F5" height="22">	    
		<TD width="16%">�Żݴ��룺</TD>
	  	<TD width="34%">
		  <input type=text  v_type="string"  v_must=0 v_minlength=0 v_maxlength=4 v_name="����"  name=totalCodeCond maxlength=4 value="">
		  </input>
		</TD>
		<TD width="16%">�Ż����ƣ�</TD>
	  	<TD width="34%">
		    <input type=text  v_type="string"  v_must=0 v_minlength=0 v_maxlength=25 v_name="����"  name=totalNameCond maxlength=25 value="">
		  </input>
		</TD>
	</tr>
	<tr bgcolor="#F5F5F5" height="22">	    
		<TD width="16%">�Żݷ�ʽ��</TD>
	  	<TD width="34%">
		  <select name="favourTypeCond" class="button">
				<option value="">--��ѡ��--</option>
				<option value="0">0->�ͷ�</option>
				<option value="1">1->����</option>
				<option value="3">3->����</option>
           </select>
		</TD>
		<TD width="16%">�ͷѷ�ʽ��</TD>
	  	<TD width="34%">
		    <select name="typeModeCond" class="button">
				<option value="">--��ѡ��--</option>
				<option value="0">0->����ͷ�</option>
				<option value="1">1->�����ͷ�</option>
           </select>
		</TD>  
	</tr>
	<tr bgcolor="#F5F5F5" height="22">	    
		<TD width="16%">���ڵ�λ��</TD>
	  	<TD width="34%">
		   <select name="cycleUnitCond" class="button">
				<option value="">--��ѡ��--</option>
				<option value="0">0->��</option>
				<option value="2">2->������</option>
           </select>
		  </input>
		</TD>
		<TD width="16%">�Ż����ڣ�</TD>
	  	<TD width="34%">
		  <input type=text  v_type="int"  v_must=0 v_minlength=0 v_maxlength=10 v_name="�Ż�����"  name=favourCycleCond maxlength=10 value="">
		  </input><font color="red">(�����������ֵΪ9999)</font>
		</TD>
	</tr>
	<tr bgcolor="#F5F5F5" height="22">	    
		<TD width="16%">�Ż�˳��</TD>
	  	<TD width="34%">
		  <input type=text  v_type="int"  v_must=0 v_minlength=0 v_maxlength=10 v_name="�Ż�˳��"  name=orderCodeCond maxlength=10 value="">
		  </input>
		</TD>
		<TD width="16%"> </TD>
	  	<TD width="34%"> </TD>
	</tr>
	<tr bgcolor="#F5F5F5" height="22">	    
		<TD width="16%">STEP_VAL1��</TD>
	  	<TD width="34%">
		  <input type=text  v_type="string"  v_must=0 v_minlength=0 v_maxlength=10 v_name="����"  name=step_val1 maxlength=10 value="">
		  </input>
		</TD>
		<TD width="16%">FAVOUR1��</TD>
	  	<TD width="34%">
		    <input type=text  v_type="string"  v_must=0 v_minlength=0 v_maxlength=25 v_name="����"  name=favour1 maxlength=25 value="">
		  </input>
		</TD>
	</tr>
	<tr bgcolor="#F5F5F5" height="22">	    
		<TD width="16%">STEP_VAL2��</TD>
	  	<TD width="34%">
		  <input type=text  v_type="string"  v_must=0 v_minlength=0 v_maxlength=10 v_name="����"  name=step_val2 maxlength=10 value="">
		  </input>
		</TD>
		<TD width="16%">FAVOUR2��</TD>
	  	<TD width="34%">
		    <input type=text  v_type="string"  v_must=0 v_minlength=0 v_maxlength=25 v_name="����"  name=favour2 maxlength=25 value="">
		  </input>
		</TD>
	</tr>
	<tr bgcolor="#F5F5F5" height="22">	    
		<TD width="16%">STEP_VAL3��</TD>
	  	<TD width="34%">
		  <input type=text  v_type="string"  v_must=0 v_minlength=0 v_maxlength=10 v_name="����"  name=step_val3 maxlength=10 value="">
		  </input>
		</TD>
		<TD width="16%">FAVOUR3��</TD>
	  	<TD width="34%">
		    <input type=text  v_type="string"  v_must=0 v_minlength=0 v_maxlength=25 v_name="����"  name=favour3 maxlength=25 value="">
		  </input>
		</TD>
	</tr>
	<tr>
		<td colspan=4>
		    <div align="center">
			  <input type="button" name="commit" onClick="doQuery();" value=" ��ѯ ">
			  &nbsp;
			  <input type="button" name="back" onClick="doReset();" value=" ���� ">
		    </div>
		</td>
	</tr>
	<tr>
		<td colspan=4 align="center"><font color="red"><<-����ѯ��¼Ϊ50����->></font></td>
	</tr>
	
</table>
<table width="99%" id="tab1" border="0" align="center" cellpadding="1" cellspacing="1">
	<tr bgColor="#eeeeee">
		<td height="26" align="center" width="10%">
			ѡ��
		</td>
		<td  align="center" width="10%">
			�ʵ�����
		</td>
		<td align="center" width="10%">
			�ʵ�����
		</td>
		<td align="center" width="10%">
			�Ż�˳��
		</td>
		<td align="center" width="10%">
			�Ż���Ŀ��
		</td>
		<td align="center" width="10%">
			�Żݷ�ʽ
		</td>
		<td align="center" width="10%">
			STEP_VAL1
		</td>
		<td align="center" width="10%">
			FAVOUR1
		</td>
		<td align="center" width="10%">
			STEP_VAL2
		</td>
		<td align="center" width="10%">
			FAVOUR2
		</td>
		<td align="center" width="10%">
			STEP_VAL3
		</td>
		<td align="center" width="10%">
			FAVOUR3
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
	  
		<%for(int i=0;i < retListString1.length;i++){ %>
			var str='<input type="hidden" name="sel_code" value="<%=retListString1[i][0]%>">';
			str+='<input type="hidden" name="sel_name" value="<%=retListString1[i][1]%>">';

						
			var rows = document.getElementById("tab1").rows.length;
			var newrow = document.getElementById("tab1").insertRow(rows);
			newrow.bgColor="#f5f5f5";
			newrow.height="20";
			newrow.align="center";
			newrow.insertCell(0).innerHTML ='<input type="radio" name="num" value="<%=i%>">'+str;
		  newrow.insertCell(1).innerHTML = '<%=retListString1[i][0]%>';
		  newrow.insertCell(2).innerHTML = '<%=retListString1[i][1]%>';
		  newrow.insertCell(3).innerHTML = '<%=retListString1[i][2]%>';
		  newrow.insertCell(4).innerHTML = '<%=retListString1[i][3]%>';
		  newrow.insertCell(5).innerHTML = '<%=retListString1[i][4]%>';
		  newrow.insertCell(6).innerHTML = '<%=retListString1[i][5]%>';
		  newrow.insertCell(7).innerHTML = '<%=retListString1[i][6]%>';
		  newrow.insertCell(8).innerHTML = '<%=retListString1[i][7]%>';
		  newrow.insertCell(9).innerHTML = '<%=retListString1[i][8]%>';
		  newrow.insertCell(10).innerHTML = '<%=retListString1[i][9]%>';
		  newrow.insertCell(11).innerHTML = '<%=retListString1[i][10]%>';
		<%}%>

		function doCommit(){
			if("<%=retListString1.length%>"=="0"){
				rdShowMessageDialog("��û��ѡ���ʵ��Żݴ��룡");
				return false;
			}
			
			var selCodeArr = document.getElementsByName("sel_code");
			var selNameArr = document.getElementsByName("sel_name");
			var numArr = document.getElementsByName("num");

			var a=-1;
			for(i=0;i<numArr.length;i++){
			  if(numArr[i].checked){
			      a=i;
				  break;
			  }
			}
            var retInfo=selCodeArr[a].value+"|"+selNameArr[a].value+"|";
			var retToField = "<%=retToField%>";

			var chPos_field = retToField.indexOf("|");
            var chPos_retStr;
            var valueStr;
            var obj;
            while(chPos_field > -1)
            {
               obj = retToField.substring(0,chPos_field);
               chPos_retInfo = retInfo.indexOf("|");
               valueStr = retInfo.substring(0,chPos_retInfo);
               window.opener.document.all(obj).value = valueStr;
               retToField = retToField.substring(chPos_field + 1);
               retInfo = retInfo.substring(chPos_retInfo + 1);
               chPos_field = retToField.indexOf("|");        
             }

			 window.close();
		}
	
	function doClose(){
		window.close();
	}
function doQuery(){
    var totalCodeCond = document.all.totalCodeCond.value;
	var totalNameCond = document.all.totalNameCond.value;
	var favourTypeCond = document.all.favourTypeCond.value;
	var typeModeCond = document.all.typeModeCond.value;
	var favourCycleCond = document.all.favourCycleCond.value;
	var cycleUnitCond = document.all.cycleUnitCond.value;  
	var orderCodeCond = document.all.orderCodeCond.value;
	
	var curstep_val1 = document.all.step_val1.value;
	var curfavour1 = document.all.favour1.value;
	var curstep_val2 = document.all.step_val2.value;
	var curfavour2 = document.all.favour2.value;
	var curstep_val3 = document.all.step_val3.value;
	var curfavour3 = document.all.favour3.value;

	this.location="f5238_queryTotCode.jsp?queryFlag=Y&retToField=<%=retToField%>&region_code=<%=region_code%>&detail_type=<%=detail_type%>"+"&totalCodeCond="+totalCodeCond+"&totalNameCond="+totalNameCond+"&favourTypeCond="+favourTypeCond+"&typeModeCond="+typeModeCond+"&favourCycleCond="+favourCycleCond+"&cycleUnitCond="+cycleUnitCond+"&orderCodeCond="+orderCodeCond+"&curstep_val1="+curstep_val1+"&curfavour1="+curfavour1+"&curstep_val2="+curstep_val2+"&curfavour2="+curfavour2+"&curstep_val3="+curstep_val3+"&curfavour3="+curfavour3;
}

function doReset(){
	document.all.totalCodeCond.value="";
	document.all.totalNameCond.value="";
}
</script>