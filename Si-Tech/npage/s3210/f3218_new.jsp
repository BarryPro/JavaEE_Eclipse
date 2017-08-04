<%
/********************
 * @ OpCode    :  3218
 * @ OpName    :  查询集团成员列表
 * @ CopyRight :  si-tech
 * @ Author    :  wangzn
 * @ Date      :  2011/7/22 8:41:29
 * @ Update    :  
 ********************/
%>
<%
  String opCode = "3218";
  String opName = "查询集团成员列表（BOSS侧信息）";
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
<title>查询集团成员列表（BOSS侧信息）</title>
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
    
	var cuPageNum = 1; //当前页数
	var pageRNum = 20; //每页显示记录数
	var beginNum = 1;  //开始记录数
	var endNum = 20;   //结束记录数
	var sumNum = 20;   //总记录数 初始化为20
	var sumPageNum = 1;//总页数

            
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
		//document.frm.GRPNAME.style.display = "none";		
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
	 
	    var path = "fPubSimpSer_new.jsp?grpId="+grpIdJ+"&grpName="+grpNameJ;
	    path = path + "&retQuence=" + retQuence;
	    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
	    path = path + "&selType=" + selType;  
	
	    retInfo = window.showModalDialog(path);
	    //retInfo = window.open(path);  return true;
	    
	    
		if(typeof(retInfo) == "undefined")     
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
	    
	    if($("#ZHWWFLAG").val()=='0'){
	    	$("#QRYTYPE").val('0');
	    	$("#QRYTYPE").find("option:not(:selected)").remove();
	    }
	    
	    $("#GRPIDQRY").attr("disabled",true);
	    $("#confirm").attr("disabled",false);
	    $("#getExecl").attr("disabled",false);
	    $("#GRPID").attr("readOnly",true);
	    
	    
	    
	    
	}
		
	function call_GRPIDQRY()
	{
	    var pageTitle = "集团号查询";               
	    var fieldName = "集团号|集团名称|综合V网标志|";
	    	    
	    if(!checkElement(document.all.GRPID)) return false;
	    				
		var grpIdJ = document.all.GRPID.value;
		var grpNameJ = document.all.GRPNAME.value;
		
	    var selType = "S";    //'S'单选；'M'多选      
	    var retQuence = "3|0|1|2|";             
	    var retToField = "GRPID|GRPNAME|ZHWWFLAG|"; 
	 	
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
	
	function setShowPage(num1,num2){
	
		$("#sumPageSpan").text(num1);
		
		$("#cuPageSpan").text(num2);
		
		$("#gotoPageNum").attr("v_maxvalue",num1);
	
	}
	function getMemberList(opType)
	{
		if(opType=='0')
		{
			$("#opNote").val("查询"+$("#GRPID").val()+$("#GRPNAME").val()+"成员列表");
		}
		$('#memberListDiv').css("display","none");
 		var memberList_Packet = new AJAXPacket("f3218_getMemberList.jsp","查询成员列表，请稍候......");

 		memberList_Packet.data.add("loginNo",$("#loginNo").val());
 		memberList_Packet.data.add("orgCode",$("#orgCode").val());
 		memberList_Packet.data.add("opCode",$("#opCode").val());
 		memberList_Packet.data.add("opNote",$("#opNote").val());
 		memberList_Packet.data.add("ACCEPTNO",$("#ACCEPTNO").val());
 		memberList_Packet.data.add("opType",opType);
 		memberList_Packet.data.add("GRPID",$("#GRPID").val());
 		memberList_Packet.data.add("QRYTYPE",$("#QRYTYPE").val());
 		memberList_Packet.data.add("beginNum",beginNum);
 		memberList_Packet.data.add("endNum",endNum);
 		memberList_Packet.data.add("true_code",$("#true_code").val());
		core.ajax.sendPacket(memberList_Packet,doGetMemberList,false);
		memberList_Packet=null;	
	}
	function doGetMemberList(packet){
		
		var returnCode = packet.data.findValueByName("returnCode"); 
		
		var returnMessage = packet.data.findValueByName("returnMessage"); 
		
		var resultArray = packet.data.findValueByName("resultArray");
		
		var resultCnt = packet.data.findValueByName("resultCnt");
	
		if(returnCode=="000000"){
			
			$("#memberList tr:gt(0)").remove();
		
			if(resultArray.length>0){				
				
				sumNum = resultCnt;
				
				sumPageNum = sumNum/pageRNum;
				
				if((sumPageNum+"").indexOf(".")!=-1){
				
					sumPageNum = (sumPageNum+"").substring(0,(sumPageNum+"").indexOf("."));
					
					sumPageNum = parseInt(sumPageNum)+1;
				
				}
			
			}
			else if(resultArray.length==0){
				
				sumPageNum = 1;
				cuPageNum = 1;
			}
			setShowPage(sumPageNum,cuPageNum);
		
			$('#memberListDiv').css("display","");
			for(var i=0;i<resultArray.length;i++){
			    //alert(resultArray[i][5]);
			    //alert(resultArray[i][6]);
			    //alert(resultArray[i][7]);
			    //alert(resultArray[i][8]);
				trObj ="<tr>"+
				 "<td>"+resultArray[i][0]+"</td>"+
				 "<td>"+resultArray[i][1]+"</td>"+
				 "<td>"+resultArray[i][2]+"</td>"+
				 "<td>"+resultArray[i][3]+"</td>"+
				 "<td>"+resultArray[i][4]+"</td>"+
			     "<td>"+resultArray[i][5]+"</td>"+   //diling add
			     "<td>"+resultArray[i][6]+"</td>"+
			     "<td>"+resultArray[i][7]+"</td>"+  
			     "<td>"+resultArray[i][9]+"</td>"+  
			     "<td>"+resultArray[i][10]+"</td>"+
			     "<td><a target='blank' href='f3218_showSurplusTime.jsp?v_phoneNo="+resultArray[i][0]+"&opCode=<%=opCode%>&opName=<%=opName%>'>剩余时长</a></td>"+
			     "<td>"+resultArray[i][8]+"</td>"+
			     "<td>"+resultArray[i][11]+"</td>"+
				 "</tr>";
				$("#memberList").append(trObj);			 
			}
		
		}else{
	
			rdShowMessageDialog("查询出错["+returnCode+"："+returnMessage+"]");
	
		} 
	
	}
	function changePage(pFlag){

  	//alert("当前页数|"+cuPageNum+"\n每页显示记录数|"+pageRNum+"\n开始记录数|"+beginNum+"\n结束记录数"+endNum+"\n总记录数"+sumNum+"\n总页数"+sumPageNum);

	  	if(pFlag=="S"){  																			//点击首页
	
			beginNum = 1;   
			
			endNum = pageRNum;     
			
			cuPageNum = 1;                             

		}else	if(pFlag=="E"){                                 //点击尾页

			beginNum = (sumPageNum-1)*pageRNum+1;

			endNum = sumNum;

			cuPageNum = sumPageNum;

		}else if(pFlag=="P"){                                 //上一页

			if(beginNum-pageRNum<=1){

				changePage("S");	//上一页为首页

			}else{

				beginNum = beginNum - pageRNum+1;

				if(beginNum==0) beginNum = 1;

				endNum = beginNum + pageRNum;	

				cuPageNum = cuPageNum-1;

			}	

		}else if(pFlag=="N"){																	//下一页

			if(endNum+pageRNum>sumNum){

				changePage("E");	//下一页为尾页	

			}else{

				endNum = endNum + pageRNum;

				beginNum = endNum - pageRNum+1; 

				if(beginNum==0) beginNum = 1;

				cuPageNum = cuPageNum+1;

			}

		}	

		

		//alert("beginNum|"+beginNum+"\n"+"endNum|"+endNum);

		getMemberList('1');

		setShowPage(sumPageNum,cuPageNum);

  	}
  	
  	function gotoPage(page){
  		if(!checkElement(document.all.gotoPageNum)) return false;
  		
  		cuPageNum = $('#gotoPageNum').val();
  		beginNum = (cuPageNum-1)*pageRNum + 1;
  		endNum = beginNum + pageRNum;
  		getMemberList('1');
  	}
  	
  	function getExeclFunc(){
 		$("#opNote").val("导出"+$("#GRPID").val()+$("#GRPNAME").val()+"成员列表");
 		var packet = new AJAXPacket("f3218_getExecl.jsp","正在下载文件，请稍候......");
		var _data = packet.data;
		_data.add("loginNo",$("#loginNo").val());
		_data.add("orgCode",$("#orgCode").val());
		_data.add("opCode",$("#opCode").val());
		_data.add("opNote",$("#opNote").val());
		_data.add("ACCEPTNO",$("#ACCEPTNO").val());
		_data.add("opType","2");
		_data.add("GRPID",$("#GRPID").val());
		_data.add("QRYTYPE",$("#QRYTYPE").val());
		_data.add("beginNum",$("#beginNum").val());
		_data.add("endNum",$("#endNum").val());
		core.ajax.sendPacket(packet,doPrintProcess);
		packet = null;	
  	}
	function doPrintProcess(packet) {
		var retCode = packet.data.findValueByName("retcode");
		var retMsg = packet.data.findValueByName("retmsg");
		if(retCode == "000000") {
			rdShowMessageDialog("导出申请记录成功，请到g079模块查询导出结果!");
		}else {
			rdShowMessageDialog("错误代码："+retCode+"，错误信息："+retMsg,0);
			return false;
		}	
	}
	
	$(document).ready(function(){
  		$("#opCode").val('<%=opCode%>');
  		$("#showID1").hide();
  		$("#showID2").hide();
  		$("#showID3").hide();
  		//$("#showID4").hide();
  		$("#confirm").attr("disabled",true);
  		$("#getExecl").attr("disabled",true);
  		$('#memberListDiv').css("display","none");
  		
	}); 	
	
	function qryTypeChg()
	{
		if ($("#QRYTYPE").val()=="0")
		{
			$("#showID5").show(300);
			$("#true_code").val("");
		}	
		else
		{
			$("#showID5").hide();
			$("#true_code").val("");
		}
	}		
				
//-->
</script>

<link rel="stylesheet" href="../../css/jl.css" type="text/css">
</head>


<body>
<form name="frm" method="post" action="">
	<%@ include file="/npage/include/header.jsp" %>                         
 
	<div class="title">
		<div id="title_zi">查询集团成员列表（BOSS侧信息）</div>
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
            <td> <input name="GRPID" type="text"  id="GRPID" size="10" maxlength="10" v_must=1 v_type=0_9 v_minlength=10  /> 
             <font class="orange">*</font>  
             <input name="GRPIDQRY" type="button"  id="GRPIDQRY" onClick="call_GRPIDQRY()" class="b_text" value="查询">
             
             </td>
             <td class="blue">集团名称</td>
             <td><input name="GRPNAME" type="text"  id="GRPNAME" maxlength="36" readonly class="InputGrey"/> </td>	
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
          <tr   id="showID3"> 
            <td class="blue">起始日期(格式YYYYMMDD)</td>
            <td class="blue"><input name="STARTDATE" type="text"  id="STARTDATE" maxlength=8 v_type=date v_minlength=8   v_name="起始日期"></td>
            <td class="blue">终止日期(格式YYYYMMDD)</td>
            <td><input name="ENDDATE" type="text"  id="ENDDATE" maxlength=8 v_type=date v_minlength=8   v_name="终止日期"></td>
          </tr>
          <tr   id="showID4"> 
            <td class="blue">查询类型</td>
            <td class="blue" colspan = '3' >
            	<select  id='QRYTYPE' name='QRYTYPE' onchange='qryTypeChg()' >
            		<option value='0'>网内</option>
            		<option value='1'>网外</option>
            	</select>
			</td>
          </tr>
          <tr id = "showID5"> 
			<TD class="blue" >实名制状态</TD>
            <TD class="blue" colspan = '3'  >
				<SELECT ID = 'true_code' NAME = 'true_code' >
					<OPTION VALUE = '' >---请选择---</OPTION>
					<OPTION VALUE = '1' >1-->实名</OPTION>
					<OPTION VALUE = '2' >2-->准实名</OPTION>
					<OPTION VALUE = '3' >3-->非实名</OPTION>
				</SELECT>
			</TD>	
          </tr>          
          <tr> 
            <td width="16%" class="blue">用户备注</td>
            <td colspan="3"><input name="opNote" type="text"  id="opNote" size="60" maxlength="60" readonly class="InputGrey" /></td>
          </tr>
       </table>
       <table>
          <tr> 
            <td colspan="4" id="footer"> <div align="center"> &nbsp; 
                <input name="confirm" id="confirm" type="button"   class="b_foot" value="确认" onClick="getMemberList('0');">
                &nbsp; 
                <input name="getExecl" id="getExecl" type="button"   class="b_foot_long" value="导出数据" onClick="getExeclFunc();" >
                &nbsp;
                <input name="reset" type="button" class="b_foot"  value="清除" onClick="window.location='f3218_new.jsp';">
                &nbsp; 
                <input name="back"  onClick="removeCurrentTab()" class="b_foot" type="button"  value="关闭">
                &nbsp; </div></td>
          </tr>
        </table>
       <div id="memberListDiv" >
			<table>
			
				<div  style="font-size:12px" align="center">
				
					<a href="#" onClick="changePage('S')"> 首页 </a>
					
					<a href="#" onClick="changePage('P')"> 上一页 </a>
					
					<a href="#" onClick="changePage('N')"> 下一页 </a>
					
					<a href="#" onClick="changePage('E')"> 尾页 </a>
				
					&nbsp;&nbsp;共<span id="sumPageSpan"></span>页&nbsp;&nbsp;&nbsp;
				
					&nbsp;&nbsp;&nbsp;当前第<span id="cuPageSpan"></span>页&nbsp;&nbsp;&nbsp;
				
					&nbsp;&nbsp;&nbsp;
					
					<input name="gotoPageBtn" type="button"  id="gotoPageBtn" onClick="gotoPage();" class="b_text" value="GOTO">
					<input name="gotoPageNum" type="text"  id="gotoPageNum"  v_must=1 v_type=0_9 v_minvalue=1  size="6"/> 
					
				
				</div>
			
			</table>
			<table cellspacing=0 id="memberList">
			
				<tr>
			
					<th>真实号码</th>
			
					<th>短号</th>
			
					<th>用户姓名</th>
			
					<th>证件号码</th>
					
					<th>开户时间</th>
					
                <%/** diling add@增加列表显示内容：集团主资费，个人套餐，操作工号，单位部门 begin**/%>
			        <th>集团主资费</th><%%>
					<th>个人套餐</th>
					
	        <th>操作工号</th>
	        <th>智能网编号</th>
    	    <th>闭合群资费</th>
    	    <th>智能网资费剩余分钟时长</th>
					<th>单位部门</th>
					<th>实名制状态</th>
			    <%/** diling add@增加列表显示内容：集团主资费，个人套餐，操作工号，单位部门 begin**/%>
				<tr>
			
				
			
			</table>
			<table>
	          <tr> 
	            <td colspan="4" id="footer"> <div align="center"> &nbsp; </td>
	          </tr>
	        </table>
			
		
		</div>   
       	
  
   
  
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
  	
  	<input type="hidden" name="ZHWWFLAG" id="ZHWWFLAG" value="0">
  	  	
	<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>
