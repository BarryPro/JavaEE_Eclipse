<%
  /*
   * 功能: 计划执行结果查询
　 * 版本: 1.0
　 * 日期: 2008/11/10
　 * 作者: hanjc 
　 * 版权: sitech
   * 
   *  
 　*/
 %>
<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@page import="com.sitech.crmpd.kf.ejb.client.KFEjbClient"%>
<%@page import="java.util.HashMap"%>
<%@ include file="/npage/callbosspage/public/hashlisttoarray.jsp" %>
<%@ page import="javax.servlet.http.HttpServletRequest,com.sitech.crmpd.core.wtc.util.*,com.sitech.boss.util.excel.*"%>
<%!

    public  String getCurrDateStr(String str) {
				java.text.SimpleDateFormat objSimpleDateFormat = new java.text.SimpleDateFormat(
						"yyyyMMdd");
				return objSimpleDateFormat.format(new java.util.Date())+" "+str;
		}
%>

<%
      String opCode="K215";
      String opName="质检查询-计划执行结果查询";
	  String loginNo = (String)session.getAttribute("workNo");  
	  String orgCode = (String)session.getAttribute("orgCode"); 
	  String regionCode = "";
	  if(orgCode!=null){
	  	regionCode = orgCode.substring(0,2);
	  }
		
  	  
      String start_date    =  request.getParameter("start_date");      
      String end_date      =  request.getParameter("end_date");  
      String beQcObjId     = request.getParameter("0_=_t1.object_id");      

      String evterno   = request.getParameter("4_=_t3.check_login_no");                                                         
      String staffno = request.getParameter("5_=_t2.login_no");                                                       
      String plan_id   = request.getParameter("6_=_t1.plan_id"); 
      
      String qcobjectid         = request.getParameter("3_=_t1.content_id"        );
      String qcGroupId        = request.getParameter("qcGroupId");
      String beQcGroupId      = request.getParameter("beQcGroupId");
      
      String qcobjectName     = request.getParameter("qcobjectName");
      String qcGroupName   = request.getParameter("qcGroupName");                                                         
      String beQcGroupName = request.getParameter("beQcGroupName");                                                       
      String beQcObjName   = request.getParameter("beQcObjName"); 
      String current_times     = request.getParameter("2_<>=_t2.current_times");//此条存在问题
      
      String[][] dataRows = new String[][]{};
      int rowCount =0;
      int pageSize = 15;            // Rows each page
      int pageCount=0;               // Number of all pages
      int curPage=0;                 // Current page
      String strPage;               // Transfered pages
      String sqlTemp ="";
      String action = request.getParameter("myaction");
      String[] strHead= {"计划流水号","流水号","被检对象","质检内容","被检工号","质检工号","考评方式","考评类别","计划次数","最低门限","最高门限","实际次数","报警间隔","报警标志","开始日期","截止日期"};
	  String expFlag = request.getParameter("exp"); 
	  
%>
			
<%	
	if ("doLoad".equals(action)) {
		HashMap pMap=new HashMap();
		pMap.put("start_date"     , start_date);
		pMap.put("end_date"       , end_date);
		pMap.put("qcGroupId"      , qcGroupId);
		pMap.put("beQcGroupId"    ,beQcGroupId);
		pMap.put("beQcObjId"      ,beQcObjId);
		pMap.put("evterno"        ,evterno);
		pMap.put("staffno"        ,staffno);
		pMap.put("plan_id"        ,plan_id);
		pMap.put("qcobjectid"     ,qcobjectid);
		//pMap.put("qcobjectName"   ,qcobjectName);
		//pMap.put("qcGroupName"    ,qcGroupName);
		//pMap.put("beQcGroupName"  ,beQcGroupName);
		//pMap.put("beQcObjName"    ,beQcObjName);
		pMap.put("current_times"  ,current_times);
		
		
		
		rowCount = ( ( Integer )KFEjbClient.queryForObject("query_k215_planOprResult_strCountSql",pMap)).intValue();
		strPage = request.getParameter("page");
		if (strPage == null || strPage.equals("")
		|| strPage.trim().length() == 0) {
			curPage = 1;
		} else {
			curPage = Integer.parseInt(strPage);
			if (curPage < 1)
		curPage = 1;
		}
		pageCount = (rowCount + pageSize - 1) / pageSize;
		if (curPage > pageCount)
			curPage = pageCount;
		
		int start = (curPage - 1) * pageSize + 1;
		int end = curPage * pageSize;
		pMap.put("start", ""+start);
		pMap.put("end", ""+end);
    
    List queryList =(List)KFEjbClient.queryForList("query_k215_planOprResult_sqlStr",pMap);     
    dataRows = getArrayFromListMap(queryList ,1,18);  

}
   
%>


<html>
<head>
<title>计划执行结果查询</title>
<style>
		img{
				cursor:hand;
		}
</style>
<script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js"></script>
<script language=javascript>
	$(document).ready(
		function()
		{
	    $("td").not("[input]").addClass("blue");
			$("#footer input:button").addClass("b_foot");
			$("td:not(#footer) input:button").addClass("b_text");
			$("input:text[@v_type]").blur(checkElement2);	
		
			$("a").hover(function() {
				$(this).css("color", "orange");
			}, function() {
				$(this).css("color", "blue");
			});
		}
	);

function checkElement2() { 
		checkElement(this); 
}	

function submitInputCheck(){
   if( document.sitechform.start_date.value == ""){
    	   showTip(document.sitechform.start_date,"开始时间不能为空"); 
    	   sitechform.start_date.focus(); 	

    }else if(document.sitechform.end_date.value == ""){
		     showTip(document.sitechform.end_date,"结束时间不能为空"); 
    	   sitechform.end_date.focus(); 	

    }else if(document.sitechform.end_date.value<=document.sitechform.start_date.value){
		     showTip(document.sitechform.end_date,"结束时间必须大于开始时间"); 
    	   sitechform.end_date.focus(); 	

    }else{
		    hiddenTip(document.sitechform.start_date);
		    hiddenTip(document.sitechform.end_date);
		    
		    submitMe();
    }
}

function submitMe(){
   window.sitechform.myaction.value="doLoad";
   window.sitechform.action="K215_planOprResultQry.jsp";
   window.sitechform.method='post';
   window.sitechform.submit(); 
}

function doLoad(operateCode){
   if(operateCode=="load"){
   		window.sitechform.page.value="";
   }
   else if(operateCode=="first"){
   		window.sitechform.page.value=1;
   }else if(operateCode=="pre"){
   		window.sitechform.page.value=<%=(curPage-1)%>;
   }
   else if(operateCode=="next"){
   		window.sitechform.page.value=<%=(curPage+1)%>;
   }
   else if(operateCode=="last"){
   		window.sitechform.page.value=<%=pageCount%>;
   }
   keepValue();
   submitMe(); 
}

//清除表单记录
function clearValue(){
		var e = document.forms[0].elements;
		for(var i=0;i<e.length;i++){
				if(e[i].type=="select-one"||e[i].type=="text"||e[i].type=="hidden"){
							if(e[i].id=="start_date"){
						  		e[i].value='<%=getCurrDateStr("00:00:00")%>';
						  }else if(e[i].id=="end_date"){
						  		e[i].value='<%=getCurrDateStr("23:59:59")%>';
						  }else{
						  		e[i].value="";
						  }
				}else if(e[i].type=="checkbox"){
						e[i].checked=false;
				}
		}
}

function keepValue(){
    window.sitechform.end_date.value="<%=end_date%>";
    
    window.sitechform.qcGroupName.value="<%=qcGroupName%>";        
    window.sitechform.beQcGroupName.value="<%=beQcGroupName%>";          
    window.sitechform.beQcObjName.value="<%=beQcObjName%>";
    
    window.sitechform.staffno.value="<%=staffno%>";
    window.sitechform.evterno.value="<%=evterno%>";
    window.sitechform.plan_id.value="<%=plan_id%>";
    
    window.sitechform.current_times.value="<%=current_times%>";
    window.sitechform.qcGroupId.value="<%=qcGroupId%>";
    window.sitechform.beQcGroupId.value="<%=beQcGroupId%>";
     
    window.sitechform.beQcObjId.value="<%=beQcObjId%>";      
    window.sitechform.qcobjectid.value="<%=qcobjectid%>";
    window.sitechform.qcobjectName.value="<%=qcobjectName%>";  
    
}

//显示通话详细信息
function getCallDetail(contact_id,start_date){
		var path="<%=request.getContextPath()%>/npage/callbosspage/k170/k170_getCallDetail.jsp";
    path = path + "?contact_id=" + contact_id;
    path = path + "&start_date=" + start_date;
    window.open(path,"newwindow","height=768, width=1072,top=50,left=100,scrollbars=yes, resizable=no,location=no, status=yes");
		return true;
}

//质检内容
function getQcContentTree(){
		var path="../K211/K211_getQcContent.jsp";
    window.open(path,"选择质检内容","height=450, width=620,top=100,left=150,scrollbars=no, resizable=no,location=no, status=yes");
		
		/*
		var param  = 'dialogWidth=700px;dialogHeight=550px';
		window.showModalDialog(path,'选择质检内容',param);
		*/
		return true;
}

//被检对象
function showObjectCheckTree(){
		var path="../K211/K211_beQcObjTree_1.jsp";
	  var param  = 'dialogWidth=300px;dialogHeight=250px';
	  var returnValue =window.showModalDialog(path,'选择被检对象',param);
		if(typeof(returnValue) != "undefined"){
				 var beQcObjId = document.getElementById("beQcObjId");
				 var beQcObjName   = document.getElementById("beQcObjName");
				 var temp = returnValue.split('_');
				 beQcObjId.value = trim(temp[0]);
				 beQcObjName.value   = trim(temp[1]);
		}
}

//质检群组
function getQcGroupTree(){
		var path="K215_qcGroTree.jsp";
	  var param  = 'dialogWidth=300px;dialogHeight=250px';
	  var returnValue =window.showModalDialog(path,'选择质检群组',param);
	  
		if(typeof(returnValue) != "undefined"){
				 var qcGroupId = document.getElementById("qcGroupId");
				 var qcGroupName   = document.getElementById("qcGroupName");
				 var temp = returnValue.split('_');
				 qcGroupId.value = trim(temp[0]);
				 qcGroupName.value   = trim(temp[1]);
		}
}

//被检群组
function getBeQcGroTree(){
		var path="K215_beQcGroTree.jsp";
		var param  = 'dialogWidth=300px;dialogHeight=250px';
	  var returnValue =window.showModalDialog(path,'选择被检群组',param);
		if(typeof(returnValue) != "undefined"){
				 var beQcGroupId = document.getElementById("beQcGroupId");
				 var beQcGroupName   = document.getElementById("beQcGroupName");
				 var temp = returnValue.split('_');
				 beQcGroupId.value = trim(temp[0]);
				 beQcGroupName.value   = trim(temp[1]);
		 }
}


function openWinMid(url,name,iHeight,iWidth) {
	  var iTop = (window.screen.availHeight-30-iHeight)/2; //获得窗口的垂直位置;
	  var iLeft = (window.screen.availWidth-10-iWidth)/2; //获得窗口的水平位置;
	  window.open(url,name,'height='+iHeight+',innerHeight='+iHeight+',width='+iWidth+',innerWidth='+iWidth+',top='+iTop+',left='+iLeft+',toolbar=no,menubar=no,scrollbars=yes,resizeable=no,location=no,status=no');
}

//去左空格;
function ltrim(s){
  	return s.replace( /^\s*/, "");
}
//去右空格;
function rtrim(s){
		return s.replace( /\s*$/, "");
}
//去左右空格;
function trim(s){
		return rtrim(ltrim(s));
}


//导出窗口
function showExpWin(flag){
		window.sitechform.page.value="<%=curPage%>";
	 
		openWinMid('k215_expSelect.jsp?flag='+flag,'选择导出列',340,320);
}

//选中行高亮显示 行变色
var hisObj="";//保存上一个变色对象
var hisColor=""; //保存上一个对象原始颜色

/**
   *hisColor ：当前tr的className
   *obj       ：当前tr对象
   */
function changeColor(color,obj){
  //恢复原来一行的样式
  if(hisObj != ""){
	 for(var i=0;i<hisObj.cells.length;i++){
		var tempTd=hisObj.cells.item(i);
		//tempTd.className=hisColor; 还原字的颜色
		tempTd.style.backgroundColor = '#F7F7F7';		//还原行背景颜色
	 }
	}
		hisObj   = obj;
		hisColor = color;
  //设置当前行的样式
	for(var i=0;i<obj.cells.length;i++){
		var tempTd=obj.cells.item(i);
		//tempTd.className='green'; 改变字的颜色
		tempTd.style.backgroundColor='#00BFFF';	//改变行背景颜色
	}
}
</script>
</head>


<body >
<form id=sitechform name=sitechform>
<!--
<%@ include file="/npage/include/header.jsp"%>
-->
	<div id="Operation_Table"  style="width: 100%;">
		<table cellspacing="0" >
			<tr><td colspan='6' ><div class="title"><div id="title_zi">计划执行结果查询</div></div></td></tr>
     <tr >
      <td > 开始时间 </td>
      <td >
				<input  id="start_date" name="start_date" type="text"  onclick="WdatePicker({dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});hiddenTip(this);"   value="<%=(start_date==null)?getCurrDateStr("00:00:00"):start_date%>">
        <img onclick="WdatePicker({el:$dp.$('start_date'),dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});hiddenTip(document.sitechform.start_date);" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
        <font color="orange">*</font>
      </td>
      <td > 质检群组 </td>
      <td >
				<input id="qcGroupName" name="qcGroupName" size="20" type="text" readOnly value="<%=(qcGroupName==null)?"":qcGroupName%>">
  			<!-- <input id="qcGroupId" name="qcGroupId" size="20"  type="hidden" value="<%=(qcGroupId==null)?"":qcGroupId%>"> -->
        <img onclick="getQcGroupTree()" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
      </td>
      <td >被检群组 </td>
      <td >
        <input id="beQcGroupName" name="beQcGroupName" size="20" type="text" readOnly value="<%=(beQcGroupName==null)?"":beQcGroupName%>">
  			<!-- <input id="beQcGroupId" name="beQcGroupId" size="20"  type="hidden" value="<%=(beQcGroupId==null)?"":beQcGroupId%>"> -->
        <img onclick="getBeQcGroTree()" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
      </td>
    </tr>
    <tr >
      <td > 结束时间 </td>
      <td >
			  <input id="end_date" name ="end_date" type="text" onclick="WdatePicker({dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});hiddenTip(this);"   value="<%=(end_date==null)?getCurrDateStr("23:59:59"):end_date%>" onclick="WdatePicker({dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});hiddenTip(document.sitechform.end_date);">
		    <img onclick="WdatePicker({el:$dp.$('end_date'),dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});hiddenTip(document.sitechform.end_date);" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
		    <font color="orange">*</font>
		  </td> 
      <td > 质检内容 </td>
      <td >
      	<input id="qcobjectName" name="qcobjectName" size="20" type="text" readOnly value="<%=(qcobjectName==null)?"":qcobjectName%>">
				<!-- <input  id="qcobjectid" name="3_=_t1.content_id" type="hidden"  onclick="getQcContentTree()"   value="<%=(qcobjectid==null)?"":qcobjectid%>"> -->
        <img onclick="getQcContentTree()" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
      </td>
      <td > 被检对象 </td>
      <td >
			  <input id="beQcObjName" name="beQcObjName" size="20" type="text" readOnly value="<%=(beQcObjName==null)?"":beQcObjName%>">
  			<!-- <input id="beQcObjId" name="0_=_t1.object_id" size="20"  type="hidden" value="<%=(beQcObjId==null)?"":beQcObjId%>"> -->
        <img onclick="showObjectCheckTree()" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
      </td>
     </tr>
     <tr>
     	
      <td > 质检工号 </td>
      <td >
      <!--zhengjiang 20091010 增加onkeyup="value=value.replace(/[^kf\d]/g,'');"和onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^kf\d]/g,''))"-->
			  <input name ="4_=_t3.check_login_no" type="text" id="evterno" onkeyup="value=value.replace(/[^kf\d]/g,'');" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^kf\d]/g,''))" maxlength="10" value="<%=(evterno==null)?"":evterno%>">
      </td> 
      
      <td > 被检工号 </td>
      <td >
			  <input name ="5_=_t2.login_no" type="text" id="staffno" onkeyup="value=value.replace(/[^kf\d]/g,'');" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^kf\d]/g,''))" maxlength="10" value="<%=(staffno==null)?"":staffno%>">
      </td> 
      <td > 计划流水号 </td>
      <td >
      <!--zhengjiang 20091010添加onkeyup="value=value.replace(/[^a-zA-Z\d]/g,'');"和onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^a-zA-Z\d]/g,''))"-->
			  <input name ="6_=_t1.plan_id" type="text" id="plan_id" onkeyup="value=value.replace(/[^a-zA-Z\d]/g,'');" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^a-zA-Z\d]/g,''))" maxlength="10" value="<%=(plan_id==null)?"":plan_id%>">
      </td> 
    <tr >

      <td > 执行进度 </td>
      <td >
				<select name="2_<>=_t2.current_times" id="current_times" size="1" >
      	 	<option value="" selected >2-全部</option>
					<option value="0" <%="0".equals(current_times)?"selected":""%>>0-未完成</option>
					<option value="1" <%="1".equals(current_times)?"selected":""%>>1-已完成</option>
        </select> 
      </td> 
      <td colspan="4">&nbsp;</td>
     </tr>
    <tr >
      <td colspan="6" align="center" id="footer" style="width:420px">
       <!--zhengjiang 20091004 查询与重置换位置-->
       <input name="search" type="button"  id="search" value="查询" onClick="submitInputCheck();return false;">
			 <input name="delete_value" type="button"  id="add" value="重置" onClick="clearValue();return false;">
			 <input name="export" type="button"  id="search" value="导出" <%if(dataRows.length!=0) out.print("onClick=\"showExpWin('cur')\"");%>>
        <!--<input name="exportAll" type="button"  id="add" value="导出全部" onClick="showExpWin('all')">-->  
      </td>
    </tr>
		</table>    
	</div>
  <div id="Operation_Table">
  	<table  cellspacing="0">
    <tr >
    <!--zhengjiang 20090930 delete width="720" add colspan="17"-->
      <td class="blue"  align="left" colspan="17">
        <%if(pageCount!=0){%>
        第<%=curPage%>页 共 <%=pageCount%>页 共 <%=rowCount%>条
        <%} else{%>
        <font color="orange">当前记录为空！</font>
        <%}%>
        <%if(pageCount!=1 && pageCount!=0){%>
        <a href="#"   onClick="doLoad('first');return false;">首页</a>
        <%}%>
        <%if(curPage>1){%>
        <a href="#"  onClick="doLoad('pre');return false;">上一页</a>
        <%}%>
        <%if(curPage<pageCount){%>
        <a href="#" onClick="doLoad('next');return false;">下一页</a>
        <%}%>
        <%if(pageCount>1){%>
        <a href="#" onClick="doLoad('last');return false;">尾页</a>
        <%}%>
      </td>
    </tr>
    <!--zhengjiang 20090930
  </table>
      <table  cellSpacing="0" >
      -->
        <input id="qcGroupId" name="qcGroupId" size="20"  type="hidden" value="<%=(qcGroupId==null)?"":qcGroupId%>">
<input id="beQcGroupId" name="beQcGroupId" size="20"  type="hidden" value="<%=(beQcGroupId==null)?"":beQcGroupId%>">
<input  id="qcobjectid" name="3_=_t1.content_id" type="hidden"  onclick="getQcContentTree()"   value="<%=(qcobjectid==null)?"":qcobjectid%>">
<input id="beQcObjId" name="0_=_t1.object_id" size="20"  type="hidden" value="<%=(beQcObjId==null)?"":beQcObjId%>">
			  <input type="hidden" name="page" value="">
			  <input type="hidden" name="myaction" value="">
			  <input type="hidden" name="sqlWhere" value="">
          <tr >
            <th align="center" class="blue" width="30%" ><nobr> 计划流水号 </th>
            <th align="center" class="blue" width="30%" ><nobr> 计划名称 </th>
            <th align="center" class="blue" width="25%" ><nobr> 被检对象 </th>
            <th align="center" class="blue" width="30%" ><nobr> 质检内容 </th>
            <th align="center" class="blue" width="25%" ><nobr> 被检工号 </th>
            <th align="center" class="blue" width="25%" ><nobr> 质检工号 </th>
            <th align="center" class="blue" width="25%" ><nobr> 考评方式 </th>
            <th align="center" class="blue" width="25%" ><nobr> 考评类别 </th>
            <th align="center" class="blue" width="30%" ><nobr> 计划次数 </th>
            <th align="center" class="blue" width="25%" ><nobr> 最低门限 </th>
            <th align="center" class="blue" width="25%" ><nobr> 最高门限 </th>
            <th align="center" class="blue" width="25%" ><nobr> 实际次数 </th>
            <th align="center" class="blue" width="30%" ><nobr> 报警间隔 </th>
            <th align="center" class="blue" width="30%" ><nobr> 报警值 </th>            
            <th align="center" class="blue" width="25%" ><nobr> 报警标志 </th>
            <th align="center" class="blue" width="30%" ><nobr> 开始日期 </th>
            <th align="center" class="blue" width="25%" ><nobr> 截止日期 </th>                           
          </tr>

          <% for ( int i = 0; i < dataRows.length; i++ ) {             
                String tdClass="blue";
           %>
          <%if((i+1)%2==1){
          tdClass="blue";
          %>
          <tr onClick="changeColor('<%=tdClass%>',this);" >
			<%}else{%>
	   <tr onClick="changeColor('<%=tdClass%>',this);" >
	<%}%>
      <td align="center" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][0].length()!=0)?dataRows[i][0]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][16].length()!=0)?dataRows[i][16]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][1].length()!=0)?dataRows[i][1]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][2].length()!=0)?dataRows[i][2]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][3].length()!=0)?dataRows[i][3]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][4].length()!=0)?dataRows[i][4]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][5].length()!=0)?dataRows[i][5]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][6].length()!=0)?dataRows[i][6]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][7].length()!=0)?dataRows[i][7]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][8].length()!=0)?dataRows[i][8]:"&nbsp;"%></td>      
      <td align="center" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][9].length()!=0)?dataRows[i][9]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][10].length()!=0)?dataRows[i][10]:"0"%></td>
      <td align="center" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][11].length()!=0)?dataRows[i][11]:"0"%></td>
      <td align="center" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][12].length()!=0)?dataRows[i][12]:"0"%></td>
      <td align="center" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][13].length()!=0)?dataRows[i][13]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][14].length()!=0)?dataRows[i][14]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  > <nobr> <%=(dataRows[i][15].length()!=0)?dataRows[i][15]:"&nbsp;"%></td>
      
    </tr>
      <% } %>
      <!--zhengjiang 20090930
  </table>
  
  <table  cellspacing="0">
  delete width="720" add colspan="17"-->
    <tr >
      <td class="blue"  align="right" colspan="17">
        <%if(pageCount!=0){%>
        第<%=curPage%>页 共 <%=pageCount%>页 共 <%=rowCount%>条
        <%} else{%>
        <font color="orange">当前记录为空！</font>
        <%}%>
        <%if(pageCount!=1 && pageCount!=0){%>
        <a href="#"   onClick="doLoad('first');return false;">首页</a>
        <%}%>
        <%if(curPage>1){%>
        <a href="#"  onClick="doLoad('pre');return false;">上一页</a>
        <%}%>
        <%if(curPage<pageCount){%>
        <a href="#" onClick="doLoad('next');return false;">下一页</a>
        <%}%>
        <%if(pageCount>1){%>
        <a href="#" onClick="doLoad('last');return false;">尾页</a>
        <%}%>
      </td>
    </tr>
  </table>
</div>
</form>
<!--
<%@ include file="/npage/include/footer.jsp"%>
-->
</body>
</html>

