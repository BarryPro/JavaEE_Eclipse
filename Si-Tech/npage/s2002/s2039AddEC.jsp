<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page import="com.sitech.boss.spubcallsvr.viewBean.SPubCallSvrImpl" %>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ page import = "java.util.*" %>
<%@ page import="java.text.*"%>

<%@ include file="/npage/include/public_title_name.jsp"%>

<%
	ArrayList arrSession = (ArrayList)session.getAttribute("allArr");	
	String[][] baseInfo = (String[][])arrSession.get(0);   
  String workNo   = baseInfo[0][2];                 
	String workName = baseInfo[0][3]; 
  String op_name = "��Ʒ��Ʒ���������ʷѹ�ϵά��";
  String opName = op_name;
  String opCode = "";
	String mode_code="";
  String mode_name="";  
  String org_code = baseInfo[0][16];
  String regionCode=org_code.substring(0,2);
    String region_code="";     
  /* ����������� */ 
%>
<HTML xmlns="http://www.w3.org/1999/xhtml">
<head>
<base target="_self">
<title><%=op_name%></title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">

<link href="/css/jl.css" rel="stylesheet" type="text/css">

<script type="text/javascript" src="<%=request.getContextPath()%>/js/common/common_util.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/common/common_check.js"></script>

<script language="JavaScript"> 
	
/*	
function change_I()
{
	
	document.all.change_II.checked=true;
	document.all.change_aa.checked=false;
	document.all.qryBizCode.disabled=true;
	document.all.PospecType.value="1";
	document.all.spCode.value="";
	document.all.spName.value="";
	document.all.bizCode.value="";
	document.all.bizName.value="";
	
}	
function change_a()
{

	document.all.change_aa.checked=true;
	document.all.change_II.checked=false;
	document.all.qryBizCode.disabled=false;
	document.all.PospecType.value="2";
	document.all.spName.value="";
	document.all.spCode.value="";
	document.all.bizCode.value="";
	document.all.bizName.value="";
}
*/


function querySpCode()
{
	if(document.all.spCode.value == "")
 	 	{ 
 	 		rdShowMessageDialog("��������Ʒ�����룡");
 	 		document.all.spCode.focus();
 	 		return;
 	 	}
 	var spCode = document.all.spCode.value;
	window.open("s2039_qrySpCode.jsp?spCode="+spCode+"","","height=600,width=400,scrollbars=yes");
	
}
	
function queryBizCode()
{
	if((document.all.spCode.value == ""))
 	 	{
 	 		rdShowMessageDialog("��������Ʒ�����룡");
 	 		document.all.spCode.focus();
 	 		return;
 	 	}
 	if((document.all.spName.value==""))
 	{
 		rdShowMessageDialog("��ѡ��һ����Ʒ�����룡");
 	 	document.all.spCode.focus();
 	 	return;
 	}
 	       var spCode = document.all.spCode.value;    
 	       var bizCode = document.all.bizCode.value; 
 
	window.open("s2039_qryBizCode.jsp?spCode="+spCode+"&bizCode="+bizCode+"","","height=600,width=500,scrollbars=yes");
  }

function queryProdCode()
{
	var smCode="ZZ";
	for(i = 0 ; i < document.form1.sm_code.length ; i ++){
			if(document.form1.sm_code.options[i].selected){
				smCode = document.form1.sm_code.options[i].value;	
			}
	}
	if(document.form1.bizCode.value=="")
	{
		  rdShowMessageDialog("��ѡ��һ����Ʒ���");
 	 		return;
	}
	if(document.form1.planCode.value=="")
	{
			rdShowMessageDialog("��ѡ���ʷѼƻ���ʶ��");
 	 		return;
	}
	if(smCode == "ZZ")
 	{
 	 		rdShowMessageDialog("��ѡ��ҵ�����ͣ�");
 	 		document.all.sm_code.focus();
 	 		return;
 	}
 	 	
 	var prodCode = document.all.prodCode.value;
	window.open("s2039_qryProdCode.jsp?prodCode="+prodCode+"&smCode="+smCode+"","","height=600,width=400,scrollbars=yes");
}

function doSubmit()
{	
	if(!check(form1)){
		return;
	}
	if( (document.all.PospecType.value=="2")&&(document.all.bizCode.value==""))
	{
		rdShowMessageDialog("��ѡ��һ����Ʒ�����룡");
		return;
	}
	
	
		document.form1.action="s2039AddSuccess.jsp"; 
    
	document.form1.submit();
}

function queryPlanCode()
{
	var smCode="ZZ";
	for(i = 0 ; i < document.form1.sm_code.length ; i ++){
			if(document.form1.sm_code.options[i].selected){
				smCode = document.form1.sm_code.options[i].value;	
			}
	}
	if(document.form1.bizCode.value=="")
	{
		  rdShowMessageDialog("��ѡ��һ����Ʒ���");
 	 		return;
	}
	if(smCode == "ZZ")
 	{
 	 		rdShowMessageDialog("��ѡ��ҵ�����ͣ�");
 	 		document.all.sm_code.focus();
 	 		return;
 	}
 	 	
 	var planCode = document.all.planCode.value;
 	var spCode =document.all.spCode.value;
 	var bizCode =document.all.bizCode.value;
	window.open("s2039_qryPlanCode.jsp?planCode="+planCode+"&smCode="+smCode+"&spCode="+spCode+"&bizCode="+bizCode+"","","height=600,width=400,scrollbars=yes");
}

</script>

</head>

<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<body>
	
	<%@ include file="/npage/include/header_pop.jsp" %> 
	
<form name="form1"  method="post">
	     <input type="hidden" name="mode_region" value="<%=region_code%>" > 
	     <input type="hidden" name="PospecType" value="1">

	  <TABLE width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
	  	<TR >
	  		<TD class="blue">
	  		  	<TABLE width="100%"  id="mainOne" cellspacing="1" border="0">

	            	
	          <tr>	
	  					<TD width="20%" height="22" class="blue">&nbsp;&nbsp;��Ʒ�����룺 </TD>
	  					<TD width="60%" class="blue">
	  						<input type=text  name=spCode   v_must=1 v_type="string" v_name="��Ʒ������"  /> 
								<font class="orange">*</font>
								<input class="b_text" type="button" name="qrySpCode" onclick="querySpCode()" value="��ѯ">
							  &nbsp;&nbsp;��Ʒ������ƣ� 
	  						<input type=text name=spName readonly size=40/>
							</TD>
						
						</tr>
					

						<tr>	
	  					<TD class="blue" width="20%" height="22">&nbsp;&nbsp;��Ʒ�����룺</TD>
	  					<TD class="blue" width="80%">
	  						<input type="hidden"  name="hidProdCode"/><input type=text  name=bizCode   v_name="��Ʒ������"  v_type="string"  size=20 onchange="findSm()" readonly/> 
	  						<font class="orange">*</font>
								<input class="b_text" type="button" name="qryBizCode" onclick="queryBizCode()" value="��ѯ">
							  &nbsp;&nbsp;��Ʒ������ƣ� 
	  						<input type=text name=bizName readonly size=40/>
							</TD>
							
						</tr>
						
						<tr id="trSmCode" style="display:none;">	
	  					<TD class="blue" width="20%" height="22">&nbsp;&nbsp;ҵ�����ͣ� </TD>
	  					<TD class="blue" width="80%">
	  						<select name="sm_code" id='sm_code' v_type="string" v_must=1>
	  				
		                    </select>
									<font class="orange">*</font>
						 </TD>
						</tr>
						<tr>	
	  					<TD class="blue" width="20%" height="22">&nbsp;&nbsp;�ʷѼƻ���ʶ�� </TD>
	  					<TD class="blue" width="80%">
	  						<input type=text    v_must=1 v_type="string" name=planCode v_name="�ʷѼƻ���ʶ��" size=20 readonly/> 
								<font class="orange">*</font>
								<input class="b_text" type="button" name="qryPlanCode" onclick="queryPlanCode()" value="��ѯ">
							  &nbsp;&nbsp;�ʷѼƻ������� 
	  						<input type=text name=planName readonly size=40/>
							</TD>
						</tr>	
						
						<tr>	
	  					<TD class="blue" width="20%" height="22">&nbsp;&nbsp;��Ʒ���룺 </TD>
	  					<TD class="blue" width="80%">
	  						<input type=text    v_must=1 v_type="string" name=prodCode v_name="��Ʒ����" size=20 readonly/> 
								<font class="orange">*</font>
								<input class="b_text" type="button" name="qryProdCode" onclick="queryProdCode()" value="��ѯ">
							  &nbsp;&nbsp;��Ʒ���ƣ� &nbsp;&nbsp;&nbsp;
	  						<input type=text name=prodName readonly size=40/>
							</TD>
						</tr>
						<tr>	
	  					<TD class="blue" width="20%" height="22">&nbsp;&nbsp;��Ʒ������ </TD>
	  					<TD class="blue" width="80%"> 
	  						<input type=text name=prodNote readonly size=60/>
							</TD>
						</tr>			
	        </TABLE>
	          	
	        <TABLE width="100%" border=0 align="center" cellSpacing=1 >
	  			  <TR>
	  					<TD class="blue" height="30" align="center" id="footer">
	          	 	    <input name="nextButton" class="b_foot" type="button"  value="ȷ  ��" onClick="doSubmit()" >
	          	 	    &nbsp;
		         	    	<input name="" type="button" class="b_foot" value="��  ��" onclick="javascript:location.reload();">
	          	 	    &nbsp;
	          	 	    <input name="reset" type="button"  class="b_foot" value="��  ��" onClick="window.close()" >
	          	 	    &nbsp;
	  					</TD>
	  			  </TR>
	  	    </TABLE>
	  		</TD>
	  	</TR>
	  </TABLE>
 </form>
<script type="text/javascript">
    function doSmCode(vSmCode,vSmName){
        // alert(vSmCode + "|" + vSmName);
        $("#trSmCode").show();
        $("<option value='"+vSmCode+"'>"+vSmCode+"-->"+vSmName+"</option>").appendTo("#sm_code");
    }
</script>
</body>
</html>

