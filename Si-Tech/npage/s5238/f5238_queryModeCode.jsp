<%
   /*
   * ����: ��ѯ�ʷѴ���
�� * �汾: v1.0
�� * ����: 2007/01/22
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
	
	String region_code = request.getParameter("region_code");
	String queryFlag = request.getParameter("queryFlag")==null?"":request.getParameter("queryFlag");
	String smCodeCond = request.getParameter("smCodeCond")==null?"":request.getParameter("smCodeCond");
	String modeCodeCond = request.getParameter("modeCodeCond")==null?"":request.getParameter("modeCodeCond");
	String modeNameCond = request.getParameter("modeNameCond")==null?"":request.getParameter("modeNameCond");
	
	SPubCallSvrImpl impl = new SPubCallSvrImpl();
	ArrayList retList1 = new ArrayList();  
	String sqlStr1="";
	String whereStr=" and 1=1 ";

    if(!(queryFlag.equals("Y")))
	{
	    whereStr = " and 1=2 ";
	}
    if(!(smCodeCond.equals("")))
	{
	    whereStr = whereStr +  " and sm_code='"+smCodeCond+"'";
	}

	whereStr = whereStr + " and mode_code like '%"+modeCodeCond+"%'";
	whereStr = whereStr + " and mode_name like '%"+modeNameCond+"%'";

	sqlStr1 ="select mode_code,mode_name from sBillModeCode where region_code='"+region_code+"'";
	sqlStr1 = sqlStr1+whereStr;
	retList1 = impl.sPubSelect("2",sqlStr1,"region",regionCode);
	String[][] retListString1 = (String[][])retList1.get(0);
	int errCode=impl.getErrCode();
	String errMsg=impl.getErrMsg();
%>

<html>
<head>
<title>�ʷѴ����ѯ</title>
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
<table width="99%" align="center" id="mainThree" bgcolor="#FFFFFF" cellspacing="1" border="0">
    <tr bgcolor="#F5F5F5" height="22">	    
		<TD width="16%">Ʒ�ƣ�</TD>
	  	<TD width="34%" colspan=3>
		  <input type=text  v_type="string"  v_must=0 v_minlength=1 v_maxlength=2 v_name="Ʒ�ƴ���"  name=smCodeCond value="" maxlength=10 size="10" readonly>
	  	  <input type=text  v_type="string"  v_must=0 v_minlength=1 v_maxlength=20 v_name="Ʒ�ƴ���"  name=smNameCond value="" maxlength=20 readonly>
		  <input class="button" type="button" name="query_smcode" onclick="querySmCode()" value="ѡ��">
		</TD>
	</tr>
	<tr bgcolor="#F5F5F5" height="22">	    
		<TD width="16%">�ʷѴ��룺</TD>
	  	<TD width="34%">
		  <input type=text  v_type="string"  v_must=0 v_minlength=0 v_maxlength=10 v_name="��ϸ����"  name=modeCodeCond maxlength=10 value="">
		  </input>
		</TD>
		<TD width="16%">�ʷ����ƣ�</TD>
	  	<TD width="34%">
		    <input type=text  v_type="string"  v_must=0 v_minlength=0 v_maxlength=25 v_name="��ϸ����"  name=modeNameCond maxlength=25 value="">
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
</table>
<table width="99%" id="tab1" border="0" align="center" cellpadding="1" cellspacing="1">
	<tr bgColor="#eeeeee">
		<td height="26" align="center">
			ѡ��
		</td>
		<td  align="center">
			��Ʒ����
		</td>
		<td align="center">
			��Ʒ����
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
			var str='<input type="hidden" name="mode_code" value="<%=retListString1[i][0]%>">';
			str+='<input type="hidden" name="mode_name" value="<%=retListString1[i][1]%>">';

						
			var rows = document.getElementById("tab1").rows.length;
			var newrow = document.getElementById("tab1").insertRow(rows);
			newrow.bgColor="#f5f5f5";
			newrow.height="20";
			newrow.align="center";
			newrow.insertCell(0).innerHTML ='<input type="radio" name="num" value="<%=i%>">'+str;
		  newrow.insertCell(1).innerHTML = '<%=retListString1[i][0]%>';
		  newrow.insertCell(2).innerHTML = '<%=retListString1[i][1]%>';
		<%}%>

		function doCommit(){
			if("<%=retListString1.length%>"=="0"){
				rdShowMessageDialog("��û��ѡ���Ʒ���룡");
				return false;
			}
			else if("<%=retListString1.length%>"=="1"){//ֵΪһ��ʱ����Ҫ������
				if(document.all.num.checked){
					window.opener.form1.next_mode.value=document.all.mode_code.value;
					window.opener.form1.next_mode_name.value=document.all.mode_name.value;
					window.close();
				}
				else{
					rdShowMessageDialog("��û��ѡ���Ʒ���룡");
					return false;
				}
			}
			else{//ֵΪ����ʱ��Ҫ������
				var a=-1;
				for(i=0;i<document.all.num.length;i++){
					if(document.all.num[i].checked){
						a=i;
						break;
					}
				}
				if(a!=-1){
					window.opener.form1.next_mode.value=document.all.mode_code[a].value;
					window.opener.form1.next_mode_name.value=document.all.mode_name[a].value;
					window.close();
				}
				else{
					rdShowMessageDialog("��û��ѡ���Ʒ���룡");
					return false;
				}
			}
		}
	
	function doClose(){
		window.close();
	}

function doQuery(){
	var smCodeCond = document.all.smCodeCond.value;
    var modeCodeCond = document.all.modeCodeCond.value;
	var modeNameCond = document.all.modeNameCond.value;
	this.location="f5238_queryModeCode.jsp?queryFlag=Y&region_code=<%=region_code%>"+"&smCodeCond="+smCodeCond+"&modeCodeCond="+modeCodeCond+"&modeNameCond="+modeNameCond;
}

function doReset(){
	document.all.smCodeCond.value="";
	document.all.smNameCond.value="";
	document.all.modeCodeCond.value="";
	document.all.modeNameCond.value="";
}

/**��ѯ�ʻ�����**/
function querySmCode()
{
    var pageTitle = "Ʒ�Ʋ�ѯ";
    var fieldName = "Ʒ�ƴ���|Ʒ������|";
    var sqlStr ="select sm_code,sm_name from sSmCode  where region_code='<%=region_code%>' order by sm_code ";
	
    var selType = "S";    //'S'��ѡ��'M'��ѡ
    var retQuence = "2|0|1|";
    var retToField = "smCodeCond|smNameCond|";
    if(!PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)) return false;

	return true;
}
function PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
{
    var path = "<%=request.getContextPath()%>/page/public/fPubSimpSel.jsp";
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType;  
    retInfo = window.showModalDialog(path);
    if(retInfo ==undefined)      
    { 
		return false;  
	}
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
</script>