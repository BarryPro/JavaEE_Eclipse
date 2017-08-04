<%
  /*
   * 功能: 考评计划制定主页面
　 * 版本: 1.0.0
　 * 日期: 2008/11/05
　 * 作者: tancf
　 * 版权: sitech
   * update:
　 */
%>
<%
	String opCode = "K310";
	String opName = "制定考评计划";
%>
<%@page contentType="text/html;charset=GBK"%>

<%! 
String start_date;
String end_date;
public  String getCurrDateStr(String str) {
	java.text.SimpleDateFormat objSimpleDateFormat = new java.text.SimpleDateFormat("yyyyMMdd");
	return objSimpleDateFormat.format(new java.util.Date())+" "+str;
}
%>

<html>
<head>
<title>制定质检总计划</title>

<meta http-equiv=Content-Type content="text/html; charset=GBK">
<link href="<%=request.getContextPath()%>/nresources/default/css/FormText.css" rel="stylesheet" type="text/css"></link>
<link href="<%=request.getContextPath()%>/nresources/default/css/font_color.css" rel="stylesheet" type="text/css"></link>
<link href="<%=request.getContextPath()%>/nresources/default/css/ValidatorStyle.css" rel="stylesheet" type="text/css"></link>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/extend/jquery/jquery123_pack.js"></script>	
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/si/core_sitech_pack.js"></script>	
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/redialog/redialog.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/extend/jquery/block/jquery.blockUI.js"></script>
<script language="JavaScript" src="<%=request.getContextPath()%>/njs/si/validate_pack.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/extend/jquery/hotkey/jquery.hotkeys_jsa.js"></script>
<script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js"></script>

<script type="text/javascript" src="<%=request.getContextPath()%>/njs/csp/checkWork_dialog.js"></script>
<style>
.content_02
{
	font-size:12px;
}
#tabtit_ts
{
	height:23px;
	padding:0px 0 0 12px;
} 
#tabtit_ts ul
{
	height:23px;
	position:absolute;
} 
#tabtit_ts ul li
{
	float:left;
	margin-right:2px;
	display:inline;
	text-align:center;
	padding-top:7px;
	cursor:pointer;
	height:22px;
	width:160px;
}
#tabtit_ts .normaltab
{
	color:#3161b1;
	background:url(../../../../nresources/default/images/callimage/tab_long.gif) no-repeat left top;
	height:23px;
}
#tabtit_ts .hovertab 
{ 
	color:#3161b1;
	background:url(../../../../nresources/default/images/callimage/tab_long.gif) no-repeat left top;
	height:24px;
}
.dis
{
	display:block;
	border-top:1px solid #6c90ca;
	background:#fff url(../../../../nresources/default/images/callimage/tab_cont.gif) repeat-x 0px 0px;
	padding:8px 12px;
}
.undis
{
	display:none;
}
.content_02 .dis li
{
	line-height:1.8em;
	padding-left:12px;
}
		img{
				cursor:hand;
		}
</style>


<script>
/**
	当修改计划考评次数等时自动刷新考评内容页面
**/	
function changeVal(){

    window.frames["frameCheckContent"].window.location.href=window.frames["frameCheckContent"].window.location.href; 

}
/**
	当输入计划考评次数时自动赋值考评最低门限和最高门限
**/
function grantVal(){
    var tmpPlanTime = document.getElementById("PLAN_TIME").value;
    if(tmpPlanTime!=undefined&&tmpPlanTime!=''){
	document.getElementById("MIN_TIME").value = tmpPlanTime ;
  	document.getElementById("MAX_TIME").value = tmpPlanTime ;
    }
}
function checkPlanTimes(plan_times,min_times,max_times){
    var errorCode = 0;//错误码,0正常
    var planTimes = plan_times-0;
    var minTimes  = min_times-0;
    var maxTimes  = max_times-0;

    if(planTimes > maxTimes)
    {
        return 1;
    }else if(minTimes > planTimes)
    {
         
        return 2;
    }else
    {
        return errorCode;
    }
}
/**
  *质检计划添加完毕处理函数
  *
  */
function doProcessAddQcContent(packet)
{
    var retType = packet.data.findValueByName("retType");
    var retCode = packet.data.findValueByName("retCode");
    var retMsg = packet.data.findValueByName("retMsg");
    if(retCode=="000000"){
	
	//if(rdShowConfirmDialog("质检计划添加成功，是否继续添加",2) != 1){
	//		window.opener = null;
	//		window.close();
	//}
	
	similarMSNPop("质检计划添加成功！");
        setTimeout("window.close()",1500);
	//window.close();
	
    }else{
	similarMSNPop("质检计划添加失败！");
	return false;
    }
}


/**
  *
  *确定frame已经加载完成,获取数据
  *
  */

function beforeSubmit(){
		var bqc_no_ser_Type = document.getElementById("bqc_no_ser_Type").value;
		var CHECK_KIND  = document.getElementById("CHECK_KIND").value;
		if(bqc_no_ser_Type == "1" && CHECK_KIND != "0"){
				similarMSNPop("计划选择的被检组成员为流水号时，考评方式只能是自动分派！");
				return false;
		}
    var contect_num = "";
    var tmpFrame1 = window.frames["frameCheckContent"];
    if(tmpFrame1.document.readyState == "complete")  { 
				contect_num = tmpFrame1.document.getElementById("contect_num").value;	
				submitQcContent(contect_num,bqc_no_ser_Type);
    } else{
				setTimeout("beforeSubmit();",300);
    }
}
  
/**
  *
  *添加质检计划
  *
  */
function submitQcContent(contect_num,bqc_no_ser_Type){
	
  var minTime = document.getElementById("MIN_TIME").value;
  var maxTime = document.getElementById("MAX_TIME").value;
  var planTime = document.getElementById("PLAN_TIME").value;
  var planName = document.getElementById("PLAN_NAME").value;
  
    if(minTime == ''){
				similarMSNPop("没有输入计划考评最低门限！");
				return false;
    }
    if( maxTime== ''){
				similarMSNPop("没有输入计划考评最高门限！");
				return false;
    }
    
    //add wangyong 20091002 增加门槛值比对
    //comment by liujied 20091019
    //we do need to compare minTime and maxTime
    //since we have the 
    //if( minTime*1 > maxTime*1)
    //{
    //similarMSNPop("计划考评最低门限超出计划考评最高门限！");
    //return false;
    //}
    
    //added by liujied 20091015
    if(checkPlanTimes(planTime,minTime,maxTime) == 1)
    {
        similarMSNPop("计划考评次数超出计划考评最高门限！");
        return false;
    }
    if(checkPlanTimes(planTime,minTime,maxTime) == 2)
    {
        similarMSNPop("计划最低门限超出计划考评次数！");
        return false;
    }
    if(document.sitechform.end_date.value<=document.sitechform.start_date.value){
	showTip(document.sitechform.end_date,"结束时间必须大于开始时间");
        sitechform.endTime.focus();
    }
    if(planName == ''){
	similarMSNPop("没有输入计划标题！");
	return false;
    }
    if(planTime == ''){
	similarMSNPop("没有输入计划考评次数！");
	return false;
    } 
    var chkPacket = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/checkWork/K310/K310_plan_insert.jsp","请稍后...");
    var select_object=window.frames["frameCheckNo"].frames["leftFrame"].document.getElementById("select_object_id").value;
    if(select_object=='')
    {
  	similarMSNPop("请选择被检工号组！");
  	return false;
  }
  var bqcArray = new Array();
  var bqcObject=window.frames["frameCheckNo"].frames["leftFrame"].document.getElementsByName('bqc');
  if(bqcObject!=undefined&&bqcObject.length>0)
  {
		 	for(var i=0;i<bqcObject.length;i++)
		 	{
		 		if (bqcObject[i].checked==true)
				{
					bqcArray.push(bqcObject[i].value);
				}
		 	}
   }
   else if(bqcObject!=undefined){
   	if(bqcObject.checked==true){
				bqcArray.push(bqcObject.value);
		}
   }
   
	if(bqcArray.length<1){
			similarMSNPop("选择的被检组最少必须存在一个被检工号,请重新选择被检组！");
			return false;
	}
	
   var qc_select_object=window.frames["frameCheckNo"].frames["rightFrame"].document.getElementById("select_object_id").value;
   if(qc_select_object=='')
  {
  	similarMSNPop("请选择质检工号组！");
  	return false;
  }
  var qcArray = new Array();
   var qcObject=window.frames["frameCheckNo"].frames["rightFrame"].document.getElementsByName('qc');
   if(qcObject!=undefined&&qcObject.length>0){
			 for(var i=0;i<qcObject.length;i++)
			 {
			 	if (qcObject[i].checked==true)
				{
					qcArray.push(qcObject[i].value);
					
					}
			 	}
	}else if(qcObject!=undefined){
		if(qcObject.checked==true){
				qcArray.push(qcObject.value);
		}
	}
 	if(qcArray.length<1){
			similarMSNPop("选择的质检组最少必须存在一个被检工号,请重新选择质检组！");
			return false;
	}
  if('' == contect_num||"0" == contect_num)
  {
  	similarMSNPop("被质检组没有质检内容！");
  	return false;
  }
  if("-1" == contect_num)
  {
  	similarMSNPop("数据加载中，请稍后再点击确认按钮！");
  	return false;
  }
  
  var content_id = new Array();
  var object_id = new Array();
   
 for(var i=0;i<contect_num*1;i++)
 {
 	
 	  var temp_content_id=window.frames["frameCheckContent"].document.getElementById("content_id"+i).value;
		var temp_object_id=window.frames["frameCheckContent"].document.getElementById("object_id"+i).value;
		content_id.push(temp_content_id);
		object_id.push(temp_object_id);
		
 	}

 //本页变量
 var CHECK_TYPE  = document.getElementById("CHECK_TYPE").value;
 var CHECK_CLASS = document.getElementById("CHECK_CLASS").value;
 var MIN_TIME    = document.getElementById("MIN_TIME").value;
 var CHECK_KIND  = document.getElementById("CHECK_KIND").value;
 var start_date  = document.getElementById("start_date").value;
 var MAX_TIME    = document.getElementById("MAX_TIME").value;
 var PLAN_NAME   = document.getElementById("PLAN_NAME").value;
 var end_date    = document.getElementById("end_date").value;
 var PRIORITY    = document.getElementById("PRIORITY").value;
 var GROUP_FLAG  = document.getElementById("GROUP_FLAG").value;
 var PLAN_TIME   = document.getElementById("PLAN_TIME").value;
    
    chkPacket.data.add("bqcArray", bqcArray);
    chkPacket.data.add("qcArray", qcArray);  
    chkPacket.data.add("content_id", content_id);
    chkPacket.data.add("object_id", object_id); 
    //本页变量  
    chkPacket.data.add("CHECK_TYPE",CHECK_TYPE);
    chkPacket.data.add("CHECK_CLASS", CHECK_CLASS);
    chkPacket.data.add("MIN_TIME", MIN_TIME);
    chkPacket.data.add("CHECK_KIND", CHECK_KIND);
    chkPacket.data.add("start_date", start_date);
    chkPacket.data.add("MAX_TIME", MAX_TIME);
    chkPacket.data.add("PLAN_NAME", PLAN_NAME);
    chkPacket.data.add("end_date", end_date);
    chkPacket.data.add("PRIORITY", PRIORITY);
    chkPacket.data.add("GROUP_FLAG", GROUP_FLAG);
    chkPacket.data.add("PLAN_TIME", PLAN_TIME);
    chkPacket.data.add("bqc_no_ser_Type", bqc_no_ser_Type);
    //点击确定按钮后，将按钮置为不可用
		document.getElementById('submit').disabled=true;
    core.ajax.sendPacket(chkPacket,doProcessAddQcContent,true);
	  chkPacket =null;
}
	
	
	
	function g(o)
{
	return document.getElementById(o);
}

function HoverLi(n){
	for(var i=1;i<=2;i++)
	{
		g('tb_'+i).className='normaltab';
		g('tbc_0'+i).className='undis';
	}
	g('tbc_0'+n).className='dis';
	g('tb_'+n).className='hovertab';
}

//自动考评只对应于个人 added by liujied 20090929
function check_kind_change(param)
{
    //alert("param:"+param);
    if(param == "CHECK_KIND")
    {
        var check_kind = document.getElementById(param).value;
        if(check_kind == 0)
        {
            //alert("action invoke!");
            document.getElementById("GROUP_FLAG").value = 0;
        }
    }
    if(param == "GROUP_FLAG")
    {
        var group_flag = document.getElementById(param).value;
        if(group_flag == 1)
        {
            //alert("check kind change to 1 !");
            document.getElementById("CHECK_KIND").value = 1;
        }
    }
}

</script>

</head>

<body>
<form  name="sitechform" id="sitechform">
	<!--bqc_no_ser_Type 值为0表示导入被检组的成员为工号，为1标识被检组成员为流水号 zengzq add 20091105-->
	<input id="bqc_no_ser_Type" name="bqc_no_ser_Type" type="hidden" value="0">
<div id="Main">
<table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td width="20" valign="top" background="<%=request.getContextPath()%>/nresources/default/images/DotGray.jpg" class="LeftFixBg"><img src="<%=request.getContextPath()%>/nresources/default/images/CornerLeft.jpg" width="20" height="75" /></td>
	<!--updated by tangsong 20100831 新样式下该背景不美观
	<td valign="top" background="<%=request.getContextPath()%>/nresources/default/images/MainTopBg.jpg" class="TopFixBg">
	-->
	<td valign="top">
	<div id="Operation_Title"><B>制定质检计划</B></div>
    <div id="Operation_Table" style="width:100%;">
    <div class="title"></div>  
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
    	
      <tr>
      	<td width="" class="blue" nowrap >考评类别</td>
        <td width="">
			<select name="CHECK_TYPE" id="CHECK_TYPE">
			<option value="0">实时质检</option>
			<option value="1" selected>事后质检</option>
        	</select> 
        </td>
        <td width="" class="blue" nowrap>计划类别</td>
        <td width="" nowrap >  
	 	    <select name="CHECK_CLASS" id="CHECK_CLASS">
	 				<option value="0">评语评分</option>
	 				<option value="1">评语</option>
	 				<option value="2">评分</option>
        	</select>         
        </td>
         <td width="" class="blue" nowrap>计划考评最低门限</td>
        <td width="">  
	 	    <input id="MIN_TIME" name="MIN_TIME" maxlength="4" v_must="1" v_type="int" onBlur="checkElement(this);changeVal();"/><font class="orange">*</font>     
        </td>
      </tr>
       
             <tr>
      	<td width="" class="blue" nowrap >考评方式</td>
        <td width="">
     <select name="CHECK_KIND" id="CHECK_KIND" onchange="check_kind_change('CHECK_KIND');">
       <option value="0">自动分派</option>
       <option value="1" selected>人工指定</option>
     </select> 
        </td>
        <td width="" class="blue" nowrap >起始日期</td>
        <td width="" nowrap >  
	 	    <input id="start_date" name ="start_date" type="text"  value="<%=(start_date==null)?getCurrDateStr("00:00:00"):start_date%>" onclick="WdatePicker({dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});hiddenTip(document.sitechform.start_date);">
		    <img onclick="WdatePicker({el:$dp.$('start_date'),dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}})" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
		    <font color="orange">*</font>       
        </td>
         <td width="" class="blue" nowrap >计划考评最高门限</td>
        <td width="">  
	 	    <input id="MAX_TIME" name="MAX_TIME" maxlength="4" v_must="1" v_type="int" onBlur="checkElement(this);changeVal();"/><font class="orange">*</font>     
        </td>
      </tr>
       <tr>
      	<td width="" class="blue" nowrap >计划标题</td>
        <td width="">
			<input id="PLAN_NAME" name="PLAN_NAME" maxlength="25" v_must="1" v_type="string" onBlur="checkElement(this)" value=""/><font class="orange">*</font>
        </td>
        <td width="" class="blue" nowrap >截止日期</td>
        <td width="" nowrap >
	 	    <input id="end_date" name ="end_date" type="text"   value="<%=(end_date==null)?getCurrDateStr("23:59:59"):end_date%>" onclick="WdatePicker({dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});hiddenTip(document.sitechform.end_date);">
		    <img onclick="WdatePicker({el:$dp.$('end_date'),dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}})" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
		    <font color="orange">*</font>       
        </td>
         <td width="" class="blue" nowrap >优先级别</td>
        <td width="">  
	 	   	 	    <select name="PRIORITY" id="PRIORITY">
	 				<option value="0">一般</option>
	 				<option value="1">重要</option>
	 				<option value="2">非常重要</option>
        	</select> 
        </td>
      </tr>
       <tr>
      	<td width="" class="blue" nowrap >计划层次</td>
        <td width="">
          <select name="GROUP_FLAG" id="GROUP_FLAG" onchange="check_kind_change('GROUP_FLAG')">
	    <option value="0">个人</option>
	    <option value="1">团队</option>
          </select>  
						
        </td>
        <td width="" class="blue" nowrap >计划考评次数</td>
        <td width="">  
	       <input id="PLAN_TIME" name="PLAN_TIME" maxlength="4" v_must="1" v_type="int" onBlur="checkElement(this);grantVal();changeVal();" ><font class="orange">*</font>
        </td>
         <td width="" class="blue" colspan="2">
         <!--<input type="checkbox" name="isNotice">通知所有执行计划的质检员-->&nbsp;
         	</td>
      </tr>
       
      </table>


  <table width="100%" border="0" cellpadding="0" cellspacing="0">
    	<tr>
         <td width="100%">  
        &nbsp;
         </td>
 			</tr>   	
   </table>
   
   
<div class="content_02" width="100%">
	<div id="tabtit_ts" width="100%">
		<ul>
			<li id="tb_1" class="hovertab" onclick="HoverLi(1);" nowrap>1 指定被检工号、质检工号</li>
			<li id="tb_2" class="normaltab" onclick="HoverLi(2);">2 考评内容指定</li>
		</ul>
	</div>
	<div  class="dis" id="tbc_01" width="80%">
	  <iframe style="height:80%" name="frameCheckNo" src="K310_qc_leftMain.jsp" FRAMEBORDER="0" SCROLLING="auto" width="100%"></iframe>
	</div>
	<div  class="undis" id="tbc_02" width="80%">
		 <iframe  style="height:80%" name="frameCheckContent" src="K310_qc_content.jsp"  FRAMEBORDER="0" SCROLLING="auto" width="100%"></iframe>
	</div>
</div>
      <table width="100%" border="0" cellpadding="0" cellspacing="0" align="center" border="1px">
        <tr> 
          <td id="footer"  align=center>
            <input class="b_foot" id="submit" name="submit" type="button" value="确认" onclick="beforeSubmit()">
        	<input class="b_foot" name="reset1" type="button"  onclick="window.close()" value="退出">
        </td>
       </tr>  
     </table>
    </div>
    <br/>          
    </td>
    <td  valign="top" background="<%=request.getContextPath()%>/nresources/default/images/DotGray.jpg" class="RightFixBg"><img src="<%=request.getContextPath()%>/nresources/default/images/CornerRight.jpg" width="20" height="45" /></td>
  </tr>
        
  <tr>
    <td><img src="<%=request.getContextPath()%>/nresources/default/images/CornerLeftDown.gif" width="20" height="20" /></td>
    <td valign="bottom">
    <table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#D8D8D8">
      <tr>
        <td height="1"></td>
      </tr>
    </table>
    </td>
    <td><img src="<%=request.getContextPath()%>/nresources/default/images/CornerRightDown.gif" width="20" height="20" /></td>
  </tr>
</table>

</div>

</form>
</body>
</html>
 




