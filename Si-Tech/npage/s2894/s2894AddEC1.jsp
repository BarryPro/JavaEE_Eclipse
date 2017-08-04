<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page import="org.apache.log4j.Logger"%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import = "java.util.*" %>
<%@ page import="java.text.*"%>
<%
    String workNo   = WtcUtil.repNull((String)session.getAttribute("workNo"));            
    String workName = WtcUtil.repNull((String)session.getAttribute("workName"));
    String op_name = "SI/EC业务产品关系维护";
    String opName = op_name;
    String mode_code="";
    String mode_name="";  
    String org_code = WtcUtil.repNull((String)session.getAttribute("orgCode"));
    String regionCode=WtcUtil.repNull((String)session.getAttribute("regCode"));
    String region_code="";     
    /* 接收输入参数 */ 
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
	document.form1.action="s2894AddSuccess1.jsp"; 
	document.form1.submit();
}

function querySpCode()
{
	if(document.all.spCode.value == "")
 	 	{
 	 		rdShowMessageDialog("请输入SI/EC企业代码！");
 	 		document.all.spCode.focus();
 	 		return;
 	 	}
 	var spCode = document.all.spCode.value;
 	var bizType = document.all.sm_code.value;
	window.open("s2894_qrySpCode.jsp?spCode="+spCode+"&bizType="+bizType+"","","height=600,width=500,scrollbars=yes");
}

function queryBizCode()
{
	if(document.all.spCode.value == "")
 	 	{
 	 		rdShowMessageDialog("请输入业务代码！");
 	 		document.all.spCode.focus();
 	 		return;
 	 	}
 	       var spCode = document.all.spCode.value;    
 	       var bizCode = document.all.bizCode.value; 
 	       var bizType = document.all.sm_code.value;
 
	window.open("s2894_qryBizCode.jsp?spCode="+spCode+"&bizType="+bizType+"","","height=600,width=400,scrollbars=yes");
  }

function checkBizCode(bizCode){
    var subBizCode = bizCode.substring(0,1);
    if(subBizCode == "M"||subBizCode == "1"){
        $("#sm_code").empty();
        $("<option  value='ML'>本地MAS</option>").appendTo("#sm_code");
    }else{
        $("#sm_code").empty();
        $("<option  value='AD'>ADC</option>").appendTo("#sm_code");
    }
}

function queryProdCode()
{
	var smCode="ZZ";
	for(i = 0 ; i < document.form1.sm_code.length ; i ++){
			if(document.form1.sm_code.options[i].selected){
				smCode = document.form1.sm_code.options[i].value;	
			}
	}

 	 	
 	var prodCode = document.all.prodCode.value;
	window.open("s2894_qryProdCode.jsp?prodCode="+prodCode+"&smCode="+smCode+"","","height=600,width=400,scrollbars=yes");
}

function queryIdNumber()
{
	if(document.all.id_Number.value == "")
 	 	{
 	 		rdShowMessageDialog("请输入证件号！");
 	 		document.all.id_Number.focus();
 	 		return;
 	 	}

 	var id_number = document.all.id_Number.value;
 	window.open("s2894_qryidNumber.jsp?id_Number="+id_number+"","","height=600,width=400,scrollbars=yes");
}
//调用公共界面，进行资费选择
function checkModeCode()
{ 
    var pageTitle = "个人产品选择";
    var fieldName = "产品代码|产品名称|地市归属|";
    var sqlStr = "";
    var selType = "M";    //'S'单选；'M'多选
    var retQuence = "3|0|1|2|";
    var retToField = "mode_code|mode_name|mode_region|";
    
    // if(document.all.mode_code.value.length==0){
	//	rdShowMessageDialog("请输入产品代码,进行模糊查询！");
 	//	document.all.mode_code.focus();
 	//	return;
	//}

    if(PubSimpSelModeCode(pageTitle,fieldName,sqlStr,selType,retQuence,retToField));
}

function PubSimpSelModeCode(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
{
  var path = "<%=request.getContextPath()%>/npage/s2894/fqueryModeCode.jsp";
  path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
  path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
  path = path + "&selType=" + selType + "&retToField=" + retToField+ "&mode_code=" + document.all.mode_code.value;
  path = path + "&sm_code=" + $("#sm_code").val();
     retInfo = window.open(path,"newwindow2","height=450, width=850,top=50,left=200,scrollbars=yes, resizable=no,location=no, status=yes");
   return true;
}

function getValueModeCode(retInfo)
{
    var retToField = "mode_code|mode_name|mode_region|";
    if(retInfo ==undefined)      
    {   return false;   }

    var mode_code="";
    var mode_name="";
    var mode_region="";
    var flag=0;
    var chPos_retInfo = retInfo.indexOf("|");
    var chPos_retStr;
    var valueStr;
    var obj;
    while(chPos_retInfo > -1)
    {
        //obj = retToField.substring(0,chPos_field);
        valueStr = retInfo.substring(0,chPos_retInfo);
        if(flag==0)
        {
        	mode_code =mode_code+ valueStr+"|";
            flag=1;
        }
        else if(flag==1)
        {
          mode_name =mode_name+ valueStr+"|";
        	flag=2;       	        	
        }
        else if(flag==2)
        {
        	mode_region=mode_region+valueStr+"|";
        	flag=0;
        }
        else
        {
        	alert("成员资费返回参数错误!");
        	return false;
        }
        //retToField = retToField.substring(chPos_field + 1);
        retInfo = retInfo.substring(chPos_retInfo + 1);
        chPos_retInfo = retInfo.indexOf("|");
        //chPos_field = retToField.indexOf("|");        
    }
     document.form1.mode_code.value=mode_code;
     document.form1.mode_name.value=mode_name;
     document.form1.mode_region.value=mode_region;
     
     //document.form1.checkMC.disabled=true;
     document.form1.mode_code.readOnly=true;     
}

function changebizType()
{
	var rbiztype = document.form1.sm_code.value;

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
		var ln=document.form1.sm_code.options.length;
    while(ln--)
    {
      	document.form1.sm_code.options[ln] = null;
  	}
  	var option =new Option("--请选择--","*");  
  	document.form1.sm_code.add(option); 
  	var option =new Option("ADC","AD");  
  	document.form1.sm_code.add(option); 	  
	}
	else{
		var ln=document.form1.sm_code.options.length;
    while(ln--)
    {
      	document.form1.sm_code.options[ln] = null;
  	}
  	var option =new Option("本地MAS","ML");  
  	document.form1.sm_code.add(option); 
  	var option =new Option("全网MAS","MA");  
  	document.form1.sm_code.add(option);                        		
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
	  <TD class='blue'>业务类型</TD>
        <TD colspan="3">
            <select id="sm_code" name="sm_code" onChange="changebizType()">
						    <option value="1">本地MAS</option> 
              	<option value="0">ADC</option> 
						</select> <font class='orange'>*</font>							
					</TD>	
				
	  </tr>	
    <tr>	
        <TD class="blue"><span id='biznameA' style='display:none;'>SI企业代码</span>
        	<span id='biznameM' style='display:none;'>集团编码</span></TD>
        <TD>
            <input type=text name=spCode v_must=1 v_type="string" size=20 /> 
            <font class='orange'>*</font>
            <input class="b_text" type="button" name="qrySpCode" onclick="querySpCode()" value="查询">
        </td>
        <td class='blue' nowrap>企业名称</td>
        <td>
            <input type=text name=spName readonly size=40/>
        </TD>
    </tr>
    
    <tr>	
        <TD class="blue">业务代码</TD>
        <TD>
            <input type=text name=bizCode id="bizCode" v_type="string" v_must=1 size=20 onchange="findSm()" readonly/> 
            <font class='orange'>*</font>
            <input class="b_text" type="button" name="qryBizCode" onclick="queryBizCode()" value="查询">
            <input type="hidden"  name="hidProdCode"/>
        </td>
        <TD class="blue">业务名称</td>
        <td>
            <input type=text name=bizName readonly size=40/>
        </TD>
    </tr>  
    
    <tr>	
        <TD class="blue">对应成员资费</TD>
        <TD>
            <input name="mode_code" type="text" value="<%=mode_code%>" size="15" v_must=1 maxlength=18 v_type="string"  >
            <font class='orange'>*</font>
            <input type="button" class="b_text name="checkMC" value="查询" onClick="checkModeCode()" >
        </td>
        <TD class="blue">对应资费名称</td>
        <td>
            <input name="mode_name" type="text" value="<%=mode_name%>" size="30"  maxlength=30 Readonly>
        </TD>
    </tr>
</TABLE>
<table cellspacing=0>
    <TR id="footer">
        <TD>
            <input name="nextButton" type="button" class="b_foot" value="确  定" onClick="doSubmit()" >
            <input name="" type="button" style="cursor:hand" class="b_foot" value="重  置" onclick="javascript:location.reload();">
            <input name="reset" type="button" class="b_foot" value="关  闭" onClick="window.close()" >
        </TD>
    </TR>
</TABLE>
<%@ include file="/npage/include/footer_pop.jsp" %>
</form>
</body>
</html>