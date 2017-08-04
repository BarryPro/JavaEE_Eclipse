<%
/********************
 version v2.0
开发商: si-tech
*
*update:zhanghonga@2008-08-18 页面改造,修改样式
*
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*"%>
 
<%  
  String regionCode=(String)session.getAttribute("regCode");
  
  String[] inParas2 = new String[1];
  inParas2[0]="select region_code,region_name from sregioncode ";
  String phoneNos = request.getParameter("phoneNo");
%> 
	<wtc:service name="TlsPubSelBoss" outnum="2">
		<wtc:param value="<%=inParas2[0]%>"/>
	</wtc:service>
	<wtc:array id="SpecResult" scope="end" />         
<HTML>
<HEAD>
<TITLE>缴费记录查询</TITLE>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<style type="text/css">
#loadContainer{ 
	position: absolute;
	top: 30%;
	left: 40%;
	text-align: center;
	background-color:white;
}
#loadContainer img, #loadContainer p{
	display: inline; 
	vertical-align: middle; 
	font: bold 12px "宋体", serif; 
}
</style>
</head>
	<script type="text/javascript" src="../../js/selectDateNew.js" charset="utf-8"></script>
<script language = "javascript">
function disableOperate() {
	document.getElementById("zyenter").disabled=true;
	document.getElementById("lsenter").disabled=true;
	document.getElementById("loadContainer").style.display="";
}

function ableOperate() {
	document.getElementById("zyenter").disabled=false;
	document.getElementById("lsenter").disabled=false;
	document.getElementById("loadContainer").style.display="none";
}
	
function getMonths(startDate,endDate){
 number = 0;
 yearToMonth = (endDate.getFullYear() - startDate.getFullYear()) * 12;
 number += yearToMonth;
 monthToMonth = endDate.getMonth() - startDate.getMonth();
 number += monthToMonth;
 return number;
}
function query_online(type){
		var phoneNo= document.frm.phone_no.value;
		<!-- add by jiyk 查询近六个月的信息 2012-07-18-->
   var startDate = new Date(document.getElementById("bdate").value.replace(/^\s*(\d{4})(\d{2})(\d{2})/g, "$1/$2/$3"));
	 var endDate = new Date(document.getElementById("edate").value.replace(/^\s*(\d{4})(\d{2})(\d{2})/g, "$1/$2/$3"));
	 var month_interval = getMonths(startDate,endDate);
	 if(document.getElementById("edate").value<=document.getElementById("bdate").value){
		    showTip(document.getElementById("edate"),"结束时间必须大于开始时间");
   	   document.getElementById("edate").focus();
    	 return ;   
    }else if(month_interval > 5){
   	 showTip(document.getElementById("edate"),"只能查询6个月内的记录");
	 document.getElementById("edate").focus();
	     return;
	} else {
		hiddenTip(document.getElementById("edate"));
	}
	disableOperate();
		var iFeeType = document.frm.iFeeType.value;
		var path = 'f9127_1.jsp?phoneNo=<%=request.getParameter("phoneNo")%>'+'&beginDate='+document.frm.beginDate.value+'&endDate='+document.frm.endDate.value+'&iQryType='+type+'&iFeeType='+iFeeType;
		document.frames["iFrame1"].document.body.innerText = "";
		document.getElementById("iFrame1").src = path;   
		document.all.showCustWTab1.style.display="";
	 
}
function getDate(){
	var date = new Date();//.format("yyyyMMdd");
	//document.getElementById("edate").value = date.getYear()+date.getMonth()+date.getDate();
	//alert(date.getYear()+date.getMonth()+date.getDate);
}
//test
function GetDateT()
 {
	  var d,s,beginDate;
	  d = new Date();
	  s = d.getYear().toString() ;             //取年份
	  
	  //取月份
	  if(d.getMonth()<9){
		s = s + "0"+((d.getMonth() + 1).toString()) ;
	  }
	  else{
		s = s + ((d.getMonth() + 1).toString()) ;
	  }
    beginDate=s+"01";
      //取日期
	  if(d.getDate()<10){
		  s = s+"0"+d.getDate().toString() ;
	  }
	  else{
		  s = s+d.getDate().toString() ;
	  }
	  document.getElementById("edate").value=s ; 
	  document.getElementById("eYM").value= s;
	  document.getElementById("bdate").value=beginDate;
	  document.getElementById("bYM").value=beginDate;
	  //new tfhm
	   

 } 

//body onload :,query();//因为要求不直接显示查询结果，所以先不直接查
</script>
<BODY onload = "GetDateT()">
<div id="loadContainer" style="display:none">
	<img src='/nresources/default/images/blue-loading.gif'>
	<p class='orange'>正在查询，请稍候...</p>
</div>
	
<form name="frm" method="post" action="" >      

 
	<DIV id="Operation_Table">      	
		<div class="title">
			<div id="title_zi">SP及自有业务使用查询</div>
		</div>
      <table cellspacing="0">
      <tr align="center"> 
       <input name="phone_no" type="hidden" value = "<%=request.getParameter("phoneNo")%>" readonly="readonly" >
		 
		<td>开始日期</td>
		<td><input name="beginDate" type="text" id="bdate"  onclick="selectDateNew(beginDate)"  onkeydown ="if(event.keyCode==13)
     {
        document.getElementById('zyenter').focus();
	 }"></td>
		 
		<td>结束日期</td>
		<td><input name="endDate" type="text"  id="edate"  onclick="selectDateNew(endDate)"  onkeydown ="if(event.keyCode==13)
     {
        document.getElementById('zyenter').focus();
	 }"></td>

		<td>收费类型</td>
	 	<td>
			<select name="iFeeType" id="iFeeType" size=1 style="vertical-align: middle">
				<option value = "2" >全部</option>
				<option value = "0" >包月</option>
				<option value = "1" >按次</option>
			</select>
		</td>
	</tr>
	<tr>

		<td align=center colspan=6><input type="button" class="b_text" id="zyenter" value="在用查询" onclick="query_online(0);">
		
		<input type="button" class="b_text" id="lsenter" value="历史查询" onclick="query_online(1);">
	</td>
</tr>
     
  </table>
    </DIV>
	<div id="showCustWTab1" style="display:none">
		<!-- add by jiyk 2012-07-26 查询结果的宽度用滚动条来调节-->
		<iframe id="iFrame1" name="iFrame1" src=""  width="100%" height="100%" frameborder="0"  >
		</iframe>
		 
	</div>
	 

<!--xl add for sp退费记录查询 begin-->
	<DIV> 
		<img class='hideEl' src='jia.gif'   style='cursor:hand' width='15' height='15' onclick="show()">&nbsp;&nbsp;
		<img class='hideEl' src='jian.gif'   style='cursor:hand' width='15' height='15' onclick="hide()">
	</DIV>
	<div id="table">
	
	<div id="Operation_Table" > 
	<div class="title">
		<div id="title_zi">SP及自有业务退费记录查询</div>
	</div>	
	 
		<table  >
		   
			<tr >
				<td class="tabcontent">
					统计开始时间：<input type="text" name="beginYm" id="bYM" onclick="selectDateNew(beginYm)" maxlength=8>(YYYYMMDD)
				</td>
				<td>
					统计结束时间：<input type="text" name="endYm" id="eYM"  onclick="selectDateNew(endYm)" maxlength=8>(YYYYMMDD)
				</td>
			</tr>
			 
			<tr >
				<td>
					地市：<select name="ds" id="selOp">
							<option value="0" selected>请选择</option>
							 <%for(int i=0; i<SpecResult.length; i++)
							   {%>
												<option value="<%=SpecResult[i][0]%>">
												
												<%=SpecResult[i][0]%>--><%=SpecResult[i][1]%></option>
							 <%}%>
						  </select>
				</td>
				<td>
					退费区间：>=<input type="text" name="ks" value=""  > <=<input type="text" name="js" value=""  >
				</td>
				 
			</tr>
			<tr >
				<!--
				<td>
				 
					退费号码：<input type="hidden" name="tfhm" value="<%=request.getParameter("phoneNo")%>" readonly > 
				</td>
				
				-->
				<input type="hidden" name="tfhm" value="<%=request.getParameter("phoneNo")%>" readonly > 
				<td colspan=2>
					退费工号：<input type="text" name="tfgh" value="" maxlength=6> 
				</td>
				 
			</tr>
			<tr>
				<td align=center colspan=2><input type=button class="b_foot" name="check2" value="统计" id="cz" onclick="docfm()" >
				<!--
				<input type=button class="b_foot" value="生成报表" onclick="printTable(tabList)" >
				-->
				
				<input type="button" class="b_foot" value="重置" onclick="clears()">
				</td>
			 
			</tr>
			
		</table>
	</div>
		
		<div id="showCustWTab2" style="display:none">
		<iframe name="iFrame2" src=""  width="100%" height="600px" frameborder="0"  >
		</iframe>
		 
		</div>

	</div>
	<input type = "hidden" name = "contractNo" value = "<%=request.getParameter("contactNo")%>">
	<input type = "hidden" name = "phone_no" value = "<%=request.getParameter("phone_no")%>">
	<!--xl add for sp退费记录查询 end-->
</form>
</body>
</html>
<script language="javascript">
function clears()
{
	//alert("q tfgh");
	document.frm.beginYm.value=""; 
	document.frm.endYm.value=""; 
	document.frm.ks.value=""; 
	document.frm.js.value=""; 
	document.frm.tfgh.value=""; 
	document.getElementById("selOp").selectedIndex=0; 
}
function show()
{
	document.getElementById("table").style.display="block";
}
function hide()
{
	document.getElementById("table").style.display="none";
}
function docfm()
{
	
		var beginYm = document.all.beginYm.value;
		var objSel = document.getElementById("selOp");
		var ds= objSel.options(objSel.selectedIndex).value;
		var endYm = document.all.endYm.value;
		var tfhm = document.all.tfhm.value;
		var tfgh =  document.all.tfgh.value;	
		var ks = document.all.ks.value;
	    var js = document.all.js.value;
		// new 当前时间
		var nowDate1 = new Date();
		var nowMonth = nowDate1.getMonth();
		//rdShowMessageDialog("nowMonth "+nowMonth);
		if(tfhm=="")
		{
			rdShowMessageDialog("请输入查询号码");
			return false;
		}
		if(beginYm=="")
		{
			rdShowMessageDialog("请选择开始时间");
			return false;
		}
		if(endYm=="")
		{
			rdShowMessageDialog("请选择结束时间");
			return false;
		}
		  var year1 =  beginYm.substr(0,4);
		  var year2 =  endYm.substr(0,4); 
		  var month1 = beginYm.substr(4,2);
		  var month2 = endYm.substr(4,2);
		  
		  var len=(year2-year1)*12+(nowMonth-month1)+2;
          //alert(len);
		  if(len>6)
		  {
			  rdShowMessageDialog("仅可查询近6个月的退费记录!");
			  return false;
		  }	

		//test
		var path = "d223_2.jsp?ds="+ds+"&beginYm="+beginYm+"&endYm="+endYm+"&tfhm="+tfhm+"&tfgh="+tfgh+"&ks="+ks+"&js="+js;
	 
		document.frames["iFrame2"].document.body.innerText = "";
 
		var frame=document.getElementById("iFrame2");
	 
	  frame.src = path; 
	   
	  var showCustWTab21=document.getElementById("showCustWTab2");   
      showCustWTab21.style.display="block";
 
			
}
</script>