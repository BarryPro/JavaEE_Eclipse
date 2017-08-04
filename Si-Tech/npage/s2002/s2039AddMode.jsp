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
  String op_name = "产品规格编码与资费对应关系";
  String opName = op_name;
	String mode_code="";
  String mode_name="";  
  String org_code = baseInfo[0][16];
  String regionCode=org_code.substring(0,2);
    String region_code="";     
  /* 接收输入参数 */ 
%>
<html>
<head>
<base target="_self">
<title><%=op_name%></title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<link href="/css/jl.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="<%=request.getContextPath()%>/js/common/common_util.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/common/common_check.js"></script>
<script language="JavaScript"> 
	
	function doSubmit()
{	
	if(!check(form1)){
		return;
	} 
	document.form1.action="s2039AddSuccess1.jsp"; 
	document.form1.submit();
}


	function querySpCode()
{
	if(document.all.spCode.value == "")
 	 	{
 	 		rdShowMessageDialog("请输入商品规格编码！");
 	 		document.all.spCode.focus();
 	 		return;
 	 	}
 	var spCode = document.all.spCode.value;
	window.open("s2039_qrySpCode.jsp?spCode="+spCode+"","","height=600,width=400,scrollbars=yes");
}

function queryBizCode()
{
	if(document.all.spCode.value == "")
 	 	{
 	 		rdShowMessageDialog("请输入商品规格编码！");
 	 		document.all.spCode.focus();
 	 		return;
 	 	}
 	       var spCode = document.all.spCode.value;    
 	       var bizCode = document.all.bizCode.value; 
 
	window.open("s2039_qryBizCode.jsp?spCode="+spCode+"&bizCode="+bizCode+"","","height=600,width=500,scrollbars=yes");
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
    /*delete by qidp @ 2009-12-14
     if(document.all.mode_code.value.length==0){
		rdShowMessageDialog("请输入产品代码,进行模糊查询！");
 		document.all.mode_code.focus();
 		return;
	}
    */
    if(PubSimpSelModeCode(pageTitle,fieldName,sqlStr,selType,retQuence,retToField));
}

function PubSimpSelModeCode(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
{
  var path = "<%=request.getContextPath()%>/npage/s2002/fqueryModeCode.jsp";
  path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
  path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
  path = path + "&selType=" + selType + "&retToField=" + retToField+ "&mode_code=" + document.all.mode_code.value+"&sm_code="+$("#sm_code").val();
     retInfo = window.open(path,"newwindow2","height=450, width=650,top=50,left=200,scrollbars=yes, resizable=no,location=no, status=yes");
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
		rdShowMessageDialog("请选择一个产品规格！");
 	 	return;
	}
	if(smCode == "ZZ")
 	{
 	 		rdShowMessageDialog("请选择业务类型！");
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


<body>
<%@ include file="/npage/include/header_pop.jsp" %> 
<form name="form1"  method="post">
	     <input type="hidden" name="mode_region" value="<%=region_code%>" > 
<table>
	
	
						<tr>	
	  					<TD width="20%" height="22" class="blue">&nbsp;&nbsp;商品规格编码： </TD>
	  					<TD width="60%" class="blue">
	  						<input type=text  name=spCode v_must=1 v_type="string" v_maxlength=9 v_name="商品规格编码"  /> 
								<font color="orange">*</font>
								<input class=b_text type="button" name="qrySpCode" onclick="querySpCode()"  value="查询">
							  &nbsp;&nbsp;商品规格名称： 
	  						<input type=text name=spName readonly size=40/>
							</TD>
						
						</tr>
					

						<tr>	
	  					<TD width="20%" height="22" class="blue">&nbsp;&nbsp;产品规格编码： </TD>
	  					<TD width="80%" class="blue">
	  						<input type="hidden"  name="hidProdCode"/><input type=text  name=bizCode  v_name="产品规格编码"  v_maxlength=7 v_type="string" v_must=1  onchange="findSm()" readonly/> 
	  						<font color="orange">*</font>
								<input class=b_text type="button" name="qryBizCode" onclick="queryBizCode()" value="查询">
							  &nbsp;&nbsp;产品规格名称： 
	  						<input type=text name=bizName readonly size=40/>
							</TD>
							
						</tr>
						
						<tr id="trSmCode" style="display:none;">	
	  					<TD width="20%" height="22" class="blue">&nbsp;&nbsp;业务类型： </TD>
	  					<TD width="80%" class="blue">
	  						<select name="sm_code" id="sm_code" v_type="string" v_must=1>
	  				
		                    </select>
									<font color="orange">*</font>
						 </select>
						 </TD>
						</tr>
						
						<tr>	
	  					<TD class="blue" width="20%" height="22">&nbsp;&nbsp;资费计划标识： </TD>
	  					<TD class="blue" width="80%">
	  						<input type=text v_must=1 v_type="string" name=planCode v_name="资费计划标识：" size=20 readonly /> 
								<font color="orange">*</font>
								<input  type="button" name="qryPlanCode" onclick="queryPlanCode()" class='b_text' value="查询">
							  &nbsp;&nbsp;资费计划描述： 
	  						<input type=text name=planName readonly size=40/>
							</TD>
						</tr>				  
	
	
						<tr>	
	  					<TD class="blue" width="20%" height="22">&nbsp;&nbsp;对应成员资费 </TD>
	  					<TD class="blue" width="80%">
	  					<input name="mode_code" type="text" value="<%=mode_code%>" size="15" maxlength=18 v_type="string"  >
								<font color="orange">*</font>
								<input type="button" name="checkMC" class='b_text' value="查询" onClick="checkModeCode()" >
							  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;对应资费名称：
	  						<input name="mode_name" type="text" value="<%=mode_name%>" size="30"  maxlength=30 Readonly>
							</TD>
						</tr>
						  

				   	  
          </TBODY>
	          	</TABLE>
	          	
	        <TABLE width="100%" border=0 align="center" cellSpacing=1 >
	  			  <TR>
	  					<TD class="blue" height="30" align="center" id="footer">
	          	 	    <input name="nextButton" type="button" class="b_foot" value="确  定" onClick="doSubmit()" >
	          	 	    &nbsp;
		         	    	<input name="" type="button" style="cursor:hand" class="b_foot" value="重  置" onclick="javascript:location.reload();">
	          	 	    &nbsp;
	          	 	    <input name="reset" type="button" class="b_foot" value="关  闭" onClick="window.close()" >
	          	 	    &nbsp;
	  					</TD>
	  			  </TR>
	  	    </TABLE>
	  			<BR>
	  			<BR>		
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
