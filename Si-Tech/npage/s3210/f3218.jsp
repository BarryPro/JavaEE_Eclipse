<%/********************
 version v2.0
 开发商 si-tech
 update hejw@ 2009-10-10
********************/
%>
              
<%
  String opCode = "3218";
  String opName = "查询集团成员列表";
%>              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 

<%@ page contentType="text/html;charset=gb2312"%>
<%@ page import="java.util.*"%>

<%
		

	    String loginNo = (String)session.getAttribute("workNo");
	    String loginName = (String)session.getAttribute("workName");
	    String orgCode = (String)session.getAttribute("orgCode");
	    String ip_Addr = (String)session.getAttribute("ipAddr");
	    
	    String regionCode = (String)session.getAttribute("regCode");
	    String regionName = regionCode;
	    
	    
 
	int		LISTROWS=16;
			
	//进行工号权限检验
%>

<%
	List al = null;



	int		isGetDataFlag = 1;	//0正确,其他错误. add by yl.
	String errorMsg ="";
	String tmpStr="";

	
	StringBuffer  insql = new StringBuffer();
	
	
dataLabel:
	while(1==1){	

			
	
	isGetDataFlag = 0;
 break;
 }	


	 errorMsg = "取数据错误"+Integer.toString(isGetDataFlag);	    
	 //System.out.println(errorMsg);
%>

<%if( isGetDataFlag != 0 ){%>
<script language="JavaScript">
<!--
	rdShowMessageDialog("<%=errorMsg%>");
	window.close();
	window.opener.focus();
//-->
</script>
<%}%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>查询集团成员列表</title>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="../../css/jl.css" rel="stylesheet" type="text/css">


<script language="JavaScript">
<!--
	//定义应用全局的变量
	var SUCC_CODE	= "0";   		//自己应用程序定义
	var ERROR_CODE  = "1";			//自己应用程序定义
	var YE_SUCC_CODE = "0000";		//根据营业系统定义而修改
	var dynTbIndex=1;				//用于动态表数据的索引位置,开始值为1.考虑表头
	
	var oprType_Add = "a";
    var oprType_Upd = "u";
    var oprType_Del = "d";
    var oprType_Qry = "q";

            
	onload=function()
	{		
		init();
	}

	function reset_globalVar()
	{
	  dynTbIndex=1;							
	}
	
	function init()
	{	
		//将查询去掉style.display="none"; by yl.2004-2-10.
		//document.frm.GRPIDQRY.style.display = "none";
		document.frm.GRPNAME.style.display = "none";		
	}

		
	//---------1------RPC处理函数------------------
	function doProcess(packet){
		//使用RPC的时候,以下三个变量作为标准使用.
		error_code = packet.data.findValueByName("errorCode");
		error_msg =  packet.data.findValueByName("errorMsg");
		verifyType = packet.data.findValueByName("verifyType");
		backArrMsg = packet.data.findValueByName("backArrMsg");
	
		self.status="";
		
	}
			
	function fillSelectUseValue_noArr(fillObject,indValue)
	{	
			for(var i=0;i<document.all(fillObject).options.length;i++){
				if(document.all(fillObject).options[i].value == indValue){
					document.all(fillObject).options[i].selected = true;
					break;
				}
			}							
	}


	
	function PubSimpSel_self(pageTitle,fieldName,selType,retQuence,retToField,grpIdJ,grpNameJ)
	{
	 
	    var path = "fPubSimpSer.jsp?grpId="+grpIdJ+"&grpName="+grpNameJ;
	    path = path + "&retQuence=" + retQuence;
	    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
	    path = path + "&selType=" + selType;  
	
	    //retInfo = window.showModalDialog(path);
	    retInfo = window.open(path);  return true;
	    
	    
		if(typeof(retInfo) == "undefined")     
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
	}
		
	function call_GRPIDQRY()
	{
	    var pageTitle = "集团号查询";               
	    var fieldName = "集团号|集团名称|";
	    				
		  var grpIdJ = document.all.GRPID.value;
		  var grpNameJ = document.all.GRPNAME.value;
		
	    var selType = "S";    //'S'单选；'M'多选      
	    var retQuence = "2|0|1|";             
	    var retToField = "GRPID|GRPNAME|"; 
	 	
	    PubSimpSel_self(pageTitle,fieldName,selType,retQuence,retToField,grpIdJ,grpNameJ); 	
	}

 
	
	function judge_valid()
	{


		//1.检查单独的域
	 	
	 	if(!checkElement(document.all.GRPID)) return false;
	 	
	 	if( document.frm.OVERDUE.value !="" )
	 	{
	 		if(!checkElement(document.all.OVERDUE)) return false;
	 	}
	 	
	 	if( document.frm.STARTDATE.value !="" )
	 	{
	 		if(!checkElement(document.all.STARTDATE)) return false;
	 	}

	 	if( document.frm.ENDDATE.value !="" )
	 	{
	 		if(!checkElement(document.all.ENDDATE)) return false;
	 	}
	 		 		 	
		return true;
	}



	function isNullMy(obj)
	{
		if( document.all(obj).value == "" )
		{
			document.all(obj).focus();
			return true;
		}
		else{
			return false;			
			}		
	}

		
	function resetJsp()
	{

	
		init();
		
	 with(document.frm)
	 {
	 	GRPID.value			= "";
	 	GRPNAME.value		= "";
		DEPT.value			= "";
		OVERDUE.value		= "";
		STARTDATE.value		= "";
		ENDDATE.value		= "";
		opNote.value		= "";	 	


	 }
	
		reset_globalVar();	
		
	}
	
	function commitJsp()
	{
	    var ind1Str ="";
	    var ind2Str ="";
	    var ind3Str ="";
	    var ind4Str ="";
	    var ind5Str ="";
	  
		var tmpStr="";

		var procSql = "";
		var dept="";
		var owePay="";
		var start_date="";
		var end_date="";
		
		

			
		if( !judge_valid() )
		{
			return false;
		}

		owePay =  document.frm.OVERDUE.value;
		if( document.frm.DEPT.value == "" )
		{
			document.frm.tmpDEPT.value ="%";
		}
		
		if( document.frm.STARTDATE.value != "" )
		{
			start_date = document.frm.STARTDATE.value.substring(0,4)+"-"+
					 	 document.frm.STARTDATE.value.substring(4,6)+"-"+
					 	 document.frm.STARTDATE.value.substring(6,8);
			document.frm.tmpSTARTDATE.value = start_date;					 	
		}
		if( document.frm.ENDDATE.value != "" )
		{
			end_date = document.frm.ENDDATE.value.substring(0,4)+"-"+
					 	 document.frm.ENDDATE.value.substring(4,6)+"-"+
					 	 document.frm.ENDDATE.value.substring(6,8);
			document.frm.tmpENDDATE.value = end_date;
					 	
		}		//2.对form的隐含字段赋值
		
		document.all.tmpR1.value = ind1Str;

		//4.提交页面

	 	tmpStr = "查询 " + ",集团号码"+document.all.GRPID.value+"";
	 	
	 	document.frm.opCode.value="3218";	 
		 
		document.frm.opNote.value =  tmpStr;
										
		//8.提交页面

		page = "f3218_confirm.jsp";
		frm.action=page;
		frm.method="post";
	  	frm.submit();
						 		
	
	}
				
				
//-->
</script>

<link rel="stylesheet" href="../../css/jl.css" type="text/css">
</head>


<body>
<form name="frm" method="post" action="">
	<%@ include file="/npage/include/header.jsp" %>                         
 
	<div class="title">
		<div id="title_zi">查询集团成员列表</div>
	</div>
        
        <table cellspacing="0"   >
          <tr> 
            <td class="blue">操作类型</td>
            <td class="blue"> <input name="noUse" type="text" id="noUse" value="查询"  readonly class="InputGrey"> 
            </td>
            <td width="16%" class="blue">地市代码</td>
            <td width="34%"><input name="regionName" type="text"  id="regionName" value="<%=regionName%>" maxlength="2" readonly class="InputGrey"> 
            </td>
          </tr>
          <tr> 
            <td class="blue">集团号</td>
            <td colspan="3"> <input name="GRPID" type="text"  id="GRPID" size="10" maxlength="10" v_must=1 v_type=0_9 v_minlength=10  /> 
              <input name="GRPNAME" type="text"  id="GRPNAME" maxlength="36"/> 
             <font class="orange">*</font>  
             <input name="GRPIDQRY" type="button"  id="GRPIDQRY" onClick="call_GRPIDQRY()" class="b_text" value="查询">
             
             </td>
          </tr>
          <tr  id="showID1"> 
            <td class="blue">用户部门</td>
            <td class="blue"><input name="DEPT" type="text"  id="DEPT" maxlength="36"> 
            </td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
          </tr>
          <tr bgcolor="F5F5F5" id="showID2"> 
            <td class="blue">欠费金额</td>
            <td><input name="OVERDUE" type="text"  id="OVERDUE"  v_type=cfloat v_maxlength=10 v_name="欠费金额" maxlength="10"> 
            </td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
          </tr>
          <tr   id="showID2"> 
            <td class="blue">起始日期(格式YYYYMMDD)</td>
            <td class="blue"><input name="STARTDATE" type="text"  id="STARTDATE" maxlength=8 v_type=date v_minlength=8   v_name="起始日期"></td>
            <td class="blue">终止日期(格式YYYYMMDD)</td>
            <td><input name="ENDDATE" type="text"  id="ENDDATE" maxlength=8 v_type=date v_minlength=8   v_name="终止日期"></td>
          </tr>
          <tr> 
            <td width="16%" class="blue">用户备注</td>
            <td colspan="3"><input name="opNote" type="text"  id="opNote" size="60" maxlength="60"></td>
          </tr>
          <tr> 
            <td colspan="4" id="footer"> <div align="center"> &nbsp; 
                <input name="confirm" type="button"   class="b_foot" value="确认" onClick="commitJsp()">
                &nbsp; 
                <input name="reset" type="button" class="b_foot"  value="清除" onClick="resetJsp()">
                &nbsp; 
                <input name="back"  onClick="removeCurrentTab()" class="b_foot" type="button"  value="关闭">
                &nbsp; </div></td>
          </tr>
        </table>
  
   
  
  	<input type="hidden" name="loginNo" id="loginNo" value="<%=loginNo%>">
  	<input type="hidden" name="loginName" id="loginName" value="">
  	<input type="hidden" name="opCode" id="opCode" value="">
  	<input type="hidden" name="orgCode" id="orgCode" value="<%=orgCode%>">
  	<input type="hidden" name="regionCode" id="regionCode" value="<%=regionCode%>">
  	<input type="hidden" name="IpAddr" id="IpAddr" value="<%=ip_Addr%>">


	<input type="hidden" name="tmpDEPT" id="tmpDEPT" value="">
	<input type="hidden" name="tmpSTARTDATE" id="tmpSTARTDATE" value="">
	<input type="hidden" name="tmpENDDATE" id="tmpENDDATE" value="">
	
  	<input type="hidden" name="tmpLOCKFLAG" id="tmpLOCKFLAG" value="">
  	<input type="hidden" name="tmpUSERTYPE" id="tmpUSERTYPE" value="">
  	<input type="hidden" name="tmpCURFEETYPE" id="tmpCURFEETYPE" value="">
  	<input type="hidden" name="tmpFEETYPE" id="tmpFEETYPE" value="">
  	  	
  	<input type="hidden" name="STATUS" id="STATUS" value="">
  	<input type="hidden" name="FEEFLAG" id="FEEFLAG" value="">
  	<input type="hidden" name="USERPIN" id="USERPIN" value="">
  	
  	<input type="hidden" name="tmpR1" id="tmpR1" value="">
  	<input type="hidden" name="tmpR2" id="tmpR2" value="">
  	<input type="hidden" name="tmpR3" id="tmpR3" value="">
  	<input type="hidden" name="tmpR4" id="tmpR4" value="">
  	<input type="hidden" name="tmpR5" id="tmpR5" value="">
  	
  	<input type="hidden" name="tmpAddShortNo" id="tmpAddShortNo" value="">
	<input type="hidden" name="tmpAddRealNo" id="tmpAddRealNo" value="">
  	
  	<input type="hidden" name="NUMLIST" id="NUMLIST" value=""> 
  	
  	<input type="hidden" name="QRYTYPE" id="QRYTYPE" value="0">
  	<input type="hidden" name="ACCEPTNO" id="ACCEPTNO" value="0">
  	<input type="hidden" name="BEGINPOSI" id="BEGINPOSI" value="0">
  	  	
	<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>
