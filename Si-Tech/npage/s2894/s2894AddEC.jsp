<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page import="org.apache.log4j.Logger"%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import = "java.util.*" %>
<%@ page import="java.text.*"%>
<%
    String workNo   = WtcUtil.repNull((String)session.getAttribute("workNo"));  
    String workName = WtcUtil.repNull((String)session.getAttribute("workName"));
    String op_name = "SI/ECҵ���Ʒ��ϵά��";
    String opCode = "2894";
    String opName = op_name;
    String mode_code="";
    String mode_name="";  
    String org_code = WtcUtil.repNull((String)session.getAttribute("orgCode"));
    String regionCode=WtcUtil.repNull((String)session.getAttribute("regCode"));
    String region_code="";
    /* ����������� */ 
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base target="_self">
<title><%=op_name%></title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<script language="JavaScript"> 
onload=function(){
	changebizType();
	}
function doSubmit()
{	
	if(!check(form1)){
		return;
	} 
	document.form1.action="s2894AddSuccess.jsp"; 
	document.form1.submit();
}

function querySpCode()
{
	if(document.all.spCode.value == "")
 	 	{
 	 		rdShowMessageDialog("������SI/EC��ţ�");
 	 		document.all.spCode.focus();
 	 		return;
 	 	}
 	var spCode = document.all.spCode.value;
 	var bizType = document.all.bizType.value;
	window.open("s2894_qrySpCode.jsp?spCode="+spCode+"&bizType="+bizType+"","","height=600,width=500,scrollbars=yes");
}

function queryBizCode()
{
	if(document.all.spCode.value == "")
 	 	{
 	 		rdShowMessageDialog("������SI/EC��ţ�");
 	 		document.all.spCode.focus();
 	 		return;
 	 	}
 	       var spCode = document.all.spCode.value;    
 	       var bizCode = document.all.bizCode.value;
 	       var bizType = document.all.bizType.value; 
 
	window.open("s2894_qryBizCode.jsp?spCode="+spCode+"&bizType="+bizType+"","","height=600,width=400,scrollbars=yes");
  }

function checkBizCode(bizCode){
    var subBizCode = bizCode.substring(0,1);
    if(subBizCode == "M"||subBizCode == "1"){
        $("#bizType").empty();
        $("<option  value='ML'>����MAS</option>").appendTo("#bizType");
    }else{
        $("#bizType").empty();
        $("<option  value='AD'>ADC</option>").appendTo("#bizType");
    }
}

function queryProdCode()
{
  var smCode="";
	for(i = 0 ; i < document.form1.bizType.length ; i ++){
			if(document.form1.bizType.options[i].selected){
				smCode = document.form1.bizType.options[i].value;	
			}
	}	
 	 	
 	var prodCode = document.all.prodCode.value;
	window.open("s2894_qryProdCode.jsp?prodCode="+prodCode+"&smCode="+smCode+"","","height=600,width=400,scrollbars=yes");
}

function queryIdNumber()
{
	if(document.all.id_Number.value == "")
 	 	{
 	 		rdShowMessageDialog("������֤���ţ�");
 	 		document.all.id_Number.focus();
 	 		return;
 	 	}

 	var id_number = document.all.id_Number.value;
 	window.open("s2894_qryidNumber.jsp?id_Number="+id_number+"","","height=600,width=400,scrollbars=yes");
}

function changebizType()
{
	var rbiztype = document.form1.bizType.value;

		if(rbiztype=="0")
	{
		$("#biznameA").css("display","");
    $("#biznameM").css("display","none");
	}
	else{		
		$("#biznameA").css("display","none");
    $("#biznameM").css("display","");
	}
	
}

</script>

<script>
	function findSm(){
		var bizCode = document.all.bizCode.value;	

       var biz_code=bizCode.substring(0,1);

  if (biz_code=="A"){
		var ln=document.form1.bizType.options.length;
    while(ln--)
    {
      	document.form1.bizType.options[ln] = null;
  	}
  	var option =new Option("--��ѡ��--","*");  
  	document.form1.bizType.add(option); 
  	var option =new Option("ADC","AD");  
  	document.form1.bizType.add(option); 	  
	}
	else{
		var ln=document.form1.bizType.options.length;
    while(ln--)
    {
      	document.form1.bizType.options[ln] = null;
  	}
  	var option =new Option("����MAS","ML");  
  	document.form1.bizType.add(option); 
  	var option =new Option("ȫ��MAS","MA");  
  	document.form1.bizType.add(option);                        		
		}
	
	}


	</script>	
</head>

<body>
<form name="form1"  method="post">
<%@ include file="/npage/include/header_pop.jsp" %>
<div class="title">
	<div id="title_zi"><%=opName%></div>
</div>
<input type="hidden" name="mode_region" value="<%=region_code%>" > 
<table cellspacing=0>
	<tr>
	  <TD class='blue'>ҵ������</TD>
        <TD colspan="3">
            <select id="bizType" name="bizType" onChange="changebizType()">
						    <option value="1">����MAS</option> 
              	<option value="0">ADC</option> 
						</select> <font class='orange'>*</font>							
					</TD>	
				
	  </tr>	
    <tr>	
        <TD class="blue"><span id='biznameA' style='display:none;'>SI��ҵ����</span>
        	<span id='biznameM' style='display:none;'>���ű���</span></TD>
        <TD>
            <input type=text name=spCode v_must=1 v_type="string" size=20 /> 
            <font class='orange'>*</font>
            <input class="b_text" type="button" name="qrySpCode" onclick="querySpCode()" value="��ѯ">
        </td>
        <td class='blue' nowrap>��ҵ����</td>
        <td>
            <input type=text name=spName readonly size=40/>
        </TD>
    </tr>
    
    <tr>	
        <TD class="blue">ҵ�����</TD>
        <TD>
            <input type=text name=bizCode v_type="string" v_must=1 size=20 onchange="findSm()" readonly/> 
            <font class='orange'>*</font>
            <input class="b_text" type="button" name="qryBizCode" onclick="queryBizCode()" value="��ѯ">
            <input type="hidden"  name="hidProdCode"/>
        </td>
        <td class="blue">ҵ������</td>
        <td>
            <input type=text name=bizName readonly size=40/>
        </TD>
    </tr>   
   
    <tr>	
        <TD class='blue'>��Ʒ����</TD>
        <TD>
            <input type=text v_must=1 v_type="string" name=prodCode size=20 readonly/> 
            <font class='orange'>*</font>
            <input class="b_text" type="button" name="qryProdCode" onclick="queryProdCode()" value="��ѯ">
        </td>
        <td class='blue'>��Ʒ����</td>
        <td>
            <input type=text name=prodName readonly size=40/>
        </TD>
    </tr>
    <tr>	
        <TD class='blue'>��Ʒ����</TD>
        <TD colspan='3'> 
            <input type=text name=prodNote readonly size=60/>
        </TD>
    </tr>						  
</TABLE>
<table cellspacing=0>
    <TR id='footer'>
        <TD>
            <input name="nextButton" type="button" class="b_foot" value="ȷ  ��" onClick="doSubmit()" >
            <input name="" type="button" style="cursor:hand" class="b_foot" value="��  ��" onclick="javascript:location.reload();">
            <input name="reset" type="button" class="b_foot" value="��  ��" onClick="window.close()" >
        </TD>
    </TR>
</TABLE>
<%@ include file="/npage/include/footer_pop.jsp" %>
</form>
</body>
</html>

