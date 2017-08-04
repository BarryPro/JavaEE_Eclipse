<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
  /*
   * 功能: 听取录音情况查询
　 * 版本: 1.0
　 * 日期: 2008/10/17
　 * 作者: hanjc
　 * 版权: sitech
   * update yinzx 20090826 修改角色  
   * modify by yinxz 20091117 sql 优化
 　*/
 %>
<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/callbosspage/public/constants.jsp" %>
<%@ include file="/npage/callbosspage/K098/checkpermission.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,com.sitech.boss.util.excel.*"%>

<%!
//导出Excel
    void toExcel(String[][] queryList,String[] strHead,HttpServletResponse response){
        XLSExport e  =   new  XLSExport(null);
        String headname = "听取录音情况查询";//Excel文件名
        try {
        OutputStream os = response.getOutputStream();//取得输出流
        response.reset();//清空输出流
        response.setContentType("application/ms-excel");//定义输出类型
        response.setHeader("Content-disposition", "attachment; filename="+XLSExport.gbToUtf8(headname)+".xls");//设定输出文件头
				int intMaxRow=5000+1;
				ArrayList datalist = new ArrayList();
				for(int i=0;i<queryList.length;i++){
				    String[] dateSour={queryList[i][0],queryList[i][1],queryList[i][2],queryList[i][3]};
				    datalist.add(dateSour);
		    }
				XLSExport.excelExport(e, os, strHead, datalist, intMaxRow);
           e.exportXLS(os);
        }catch  (Exception e1) {
        	e1.printStackTrace();
        } 
    }
   public  String getCurrDateStr(String str) {
		java.text.SimpleDateFormat objSimpleDateFormat = new java.text.SimpleDateFormat(
				"yyyyMMdd");
		return objSimpleDateFormat.format(new java.util.Date())+" "+str;
	}
    
%>

<%
    String opCode="K17C";
    String opName="综合查询-听取录音情况查询";
	  String loginNo = (String)session.getAttribute("workNo");  
	      /*midify by yinzx 20091113 公共查询服务替换*/
    String myParams=request.getParameter("para"); 
    String org_code = (String)session.getAttribute("orgCode");
 	  String regionCode = org_code.substring(0,2);
    String beginTime    =  request.getParameter("beginTime");        //开始时间
    String endTime      =  request.getParameter("endTime");          //结束时间
    String logNo        =  request.getParameter("logNo");            //工号
    String sysNo        =  request.getParameter("sysNo");            //流水号
	  String kf_longin_no=(String)session.getAttribute("kfWorkNo");	      
    String[][] dataRows = new String[][]{};
    int rowCount=0;
    int pageSize = 15;            // Rows each page
    int pageCount=0;               // Number of all pages
    int curPage=0;                 // Current page
    String strPage="";               // Transfered pages
    String sqlStr="";
    String action = request.getParameter("myaction");
    String expFlag = request.getParameter("exp"); 
    String[] strHead= {"流水号","工号","时间","文件路径","接触流水号"};
		String sqlFilter = request.getParameter("sqlFilter");

    if(sqlFilter==null || sqlFilter.trim().length()==0){
   	 if(beginTime!=null &&!beginTime.trim().equals("")&& endTime!=null&& !endTime.trim().equals("")){
       sqlFilter = " where listentime > to_date(:beginTime,'yyyyMMdd hh24:mi:ss') and listentime <  to_date(:endTime,'yyyyMMdd hh24:mi:ss')";
       myParams="beginTime="+beginTime.trim()+",endTime="+endTime.trim();
       //modified by liujied 20090921
       //sqlFilter += " and t1.kf_login_no = t2.kf_login_no(+) ";
       if(logNo!=null && !logNo.trim().equals("")){
          sqlFilter = sqlFilter+" and login_no = :logNo ";
          myParams+=",logNo="+logNo.trim();
       }
       if(sysNo!=null && !sysNo.trim().equals("")){
          sqlFilter = sqlFilter+" and contact_id =:sysNo ";
          myParams+=",sysNo="+sysNo.trim();
       }
     }
    }
    
    
  /*取当前登陆工号的角色ID，为逗号分割的字符串 hanjc add 20090423*/
	String  powerCode = (String)session.getAttribute("powerCodekf");
	if(powerCode==null) {
			powerCode = "";
	}
	String[]  powerCodeArr = powerCode.split(",");
  String isCommonLogin="N";	
	/*
	 *是否是话务员 update by hanjc 20090719
        *01120O04为培训角色id,01120O0E为质检角色id,011202为客户电话营业厅，01120O02是普通座席
        *01120O02011202和01120201120O02是客户电话营业厅和普通座席两个角色的拼接
        *话务员只有客户电话营业厅和普通座席两个角色,即01120O02011202和01120201120O02，不包括小组长。
	 */
	/* modify by yinzx 20090826 由于山西代码写的较乱，而且写死角色信息 所以改造，并运行时调整
      //add by hanjc 20090719 判断当前工号是否是话务员。
      if(powerCodeArr.length==2){
         String tempVal = powerCodeArr[0].trim()+powerCodeArr[1].trim();
         if("01120O02011202".equals(tempVal)||"01120201120O02".equals(tempVal)){
		isCommonLogin="Y";	
         }
       } 
   *//*add by yinzx 090826*/
   for(int i = 0; i < powerCodeArr.length; i++){
		for(int j=0; j<HUAWUYUAN_ID.length; j++){
			if(HUAWUYUAN_ID[j].equals(powerCodeArr[i])) {
				isCommonLogin="Y";
			}
		}
	}
    
    if ("doLoad".equals(action)) {
       String sqlTemp = "select to_char(count(*)) count  from dlistenrecord t1,dloginmsgrelation t2  "+sqlFilter;
%>	
					<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="1">
						<wtc:param value="<%=sqlTemp%>"/>
						<wtc:param value="<%=myParams%>"/>
					</wtc:service>
					<wtc:array id="rowsC4" scope="end"/>	
<% 
				if(rowsC4.length!=0){
	      	rowCount = Integer.parseInt(rowsC4[0][0]);
	      }
        strPage = request.getParameter("page");
        if ( strPage == null || strPage.equals("") || strPage.trim().length() == 0 ) {
          	curPage = 1;
        }
        else {
        	curPage = Integer.parseInt(strPage);
          	if( curPage < 1 ) curPage = 1;
        }
        pageCount = ( rowCount + pageSize - 1 ) / pageSize;
        if ( curPage > pageCount ) curPage = pageCount;
        //modified by liujied 20090921
        sqlStr = "select serial_no,login_no,to_char(listentime,'yyyy-MM-dd hh24:mi:ss'),filepath,decode(t.contact_id,null,'',t.contact_id) from dlistenrecord t "+sqlFilter+" order by listentime desc";
        //sqlStr = "select serial_no,t2.boss_login_no login_no,to_char(t1.listentime,'yyyy-MM-dd hh24:mi:ss') listentime,filepath,decode(t1.contact_id,null,'',t1.contact_id) from dlistenrecord t1,dloginmsgrelation t2 "+sqlFilter+" order by listentime desc";
        String querySql = PageFilterSQL.getOraQuerySQL(sqlStr,String.valueOf(curPage),String.valueOf(pageSize),String.valueOf(rowCount));
%>	
					<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="6">
						<wtc:param value="<%=querySql%>"/>
						<wtc:param value="<%=myParams%>"/>
					</wtc:service>
					<wtc:array id="queryList"  start="0" length="5" scope="end"/>	
<% 
					dataRows=queryList;
   } 
   
   //导出当前显示数据
   if("cur".equalsIgnoreCase(expFlag)){    
        //String sqlTemp = "select to_char(count(*)) count from dlistenrecord t "+sqlFilter;
        String sqlTemp = "select to_char(count(*)) count  from dlistenrecord t1,dloginmsgrelation t2"+sqlFilter;
%>	
					<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="1">
						<wtc:param value="<%=sqlTemp%>"/>
						<wtc:param value="<%=myParams%>"/>
					</wtc:service>
					<wtc:array id="rowsC4" scope="end"/>	
<% 
				if(rowsC4.length!=0){
	      	rowCount = Integer.parseInt(rowsC4[0][0]);
	      }
        strPage = request.getParameter("page");
        if ( strPage == null || strPage.equals("") || strPage.trim().length() == 0 ) {
          	curPage = 1;
        }
        else {
        	curPage = Integer.parseInt(strPage);
          	if( curPage < 1 ) curPage = 1;
        }
        pageCount = ( rowCount + pageSize - 1 ) / pageSize;
        if ( curPage > pageCount ) curPage = pageCount;
        //sqlStr = "select serial_no,kf_login_no,to_char(listentime,'yyyy-MM-dd hh24:mi:ss'),filepath,decode(t.contact_id,null,'',t.contact_id) from dlistenrecord t "+sqlFilter+" order by listentime desc";
        sqlStr = "select serial_no,t2.boss_login_no login_no,to_char(t1.listentime,'yyyy-MM-dd hh24:mi:ss') listentime,filepath,decode(t1.contact_id,null,'',t1.contact_id) from dlistenrecord t1,dloginmsgrelation t2 "+sqlFilter+" order by listentime desc";
        String querySql = PageFilterSQL.getOraQuerySQL(sqlStr,String.valueOf(curPage),String.valueOf(pageSize),String.valueOf(rowCount));

%>	
					<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="6">
						<wtc:param value="<%=querySql%>"/>
						<wtc:param value="<%=myParams%>"/>
					</wtc:service>
					<wtc:array id="queryList"  start="0" length="5" scope="end"/>	
<% 
				this.toExcel(queryList,strHead,response);
   }
   if("all".equalsIgnoreCase(expFlag)){    
        //sqlStr = "select serial_no,kf_login_no,to_char(listentime,'yyyy-MM-dd hh24:mi:ss'),filepath,decode(t.contact_id,null,'',t.contact_id) from dlistenrecord t "+sqlFilter+" order by listentime desc";
        sqlStr = "select serial_no,t2.boss_login_no login_no,to_char(t1.listentime,'yyyy-MM-dd hh24:mi:ss') listentime,filepath,decode(t1.contact_id,null,'',t1.contact_id) from dlistenrecord t1,dloginmsgrelation t2 "+sqlFilter+" order by listentime desc";
%>	
					<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="6">
						<wtc:param value="<%=sqlStr%>"/>
						<wtc:param value="<%=myParams%>"/>
					</wtc:service>
					<wtc:array id="queryList" start="0" length="6" scope="end"/>	
<% 
				this.toExcel(queryList,strHead,response);
   }   
%>

<html>
<head>
<style>
img{
   cursor:hand;
 }
 
input{
	height: 1.5em;
	width: 14.6em;
	font-size: 1em;
}

</style>	
<title>听取录音情况查询</title>
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
				$(this).css("color", "#159ee4");
			});
		}
	);

	function checkElement2() { 
				checkElement(this); 
		}	

function submitInput(){
   if( document.sitechform.beginTime.value == ""){
    	  showTip(document.sitechform.beginTime,"开始日期不能为空！请从新选择后输入");
        sitechform.beginTime.focus();
    }
	else if(document.sitechform.endTime.value == ""){
		showTip(document.sitechform.endTime,"结束日期不能为空！请从新选择后输入");
		sitechform.endTime.focus();
    } 
  else if(document.sitechform.endTime.value<=document.sitechform.beginTime.value){
		     showTip(document.sitechform.endTime,"结束时间必须大于开始时间"); 
    	   sitechform.endTime.focus(); 	
    }else if(document.sitechform.endTime.value.substring(0,6)>document.sitechform.beginTime.value.substring(0,6)){
		     showTip(document.sitechform.endTime,"只能查询一个月内的记录"); 
    	   sitechform.endTime.focus(); 	
    }  
  else if(document.sitechform.logNo.value == ""&&document.sitechform.sysNo.value==""){
		showTip(document.sitechform.logNo,"工号接触流水号不能同时为空！请从新选择后输入");
		sitechform.logNo.focus();
    }    
    else {
    	
    hiddenTip(document.sitechform.beginTime);
    hiddenTip(document.sitechform.endTime);
    hiddenTip(document.sitechform.logNo);
    window.sitechform.sqlFilter.value="";//清空已保存的sqlFilter的值
    window.sitechform.sqlWhere.value="<%=sqlFilter%>";  
    doSubmit();
    }
}
function doSubmit(){
	  window.sitechform.myaction.value="doLoad";
    window.sitechform.action="k1714_listenRecInfoQry.jsp";
    window.sitechform.method='post';
    window.sitechform.submit();
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
     window.location="k1714_listenRecInfoQry.jsp";
}


//跳转到指定页面
function jumpToPage(operateCode){
	//alert(operateCode);
	 if(operateCode=="jumpToPage")
   {
   	  var thePage=document.getElementById("thePage").value;
   	  if(trim(thePage)!=""){
   		 window.sitechform.page.value=parseInt(thePage);
   		 doLoad('0');
   	  }
   }
   else if(operateCode=="jumpToPage1")
   {
   	  var thePage=document.getElementById("thePage1").value;
   	  if(trim(thePage)!=""){
   		 window.sitechform.page.value=parseInt(thePage);
       doLoad('0');
      }
   }else if(trim(operateCode)!=""){
   	 window.sitechform.page.value=parseInt(operateCode);
   	 doLoad('0');
   }
}
function doLoad(operateCode){
   if(operateCode=="load")
   {
   	window.sitechform.page.value="";
   }
   else if(operateCode=="first")
   {
   	window.sitechform.page.value=1;
   }
   else if(operateCode=="pre")
   {
   	window.sitechform.page.value=<%=(curPage-1)%>;
   }
   else if(operateCode=="next")
   {
   	window.sitechform.page.value=<%=(curPage+1)%>;
   }
   else if(operateCode=="last")
   {
   	window.sitechform.page.value=<%=pageCount%>;
   }
   window.sitechform.myaction.value="doLoad";
   keepValue();
   window.sitechform.action="k1714_listenRecInfoQry.jsp";
   window.sitechform.method='post';
   window.sitechform.submit();
    }


//导出
function expExcel(expFlag){
	  document.sitechform.action="<%=request.getContextPath()%>/npage/callbosspage/k170/k1714_listenRecInfoQry.jsp?exp="+expFlag;
	  keepValue();
    window.sitechform.page.value=<%=curPage%>;
    document.sitechform.method='post';
    document.sitechform.submit();
}

function keepValue(){
	window.sitechform.sqlFilter.value="<%=sqlFilter%>";
	window.sitechform.beginTime.value="<%=beginTime%>";
	window.sitechform.endTime.value="<%=endTime%>";
	window.sitechform.logNo.value="<%=logNo%>";
	window.sitechform.sysNo.value="<%=sysNo%>";
	window.sitechform.para.value="<%=myParams%>";
}
/**	
function getCallListen(id){
	if(id==''){
		return;
		}
//var a=window.showModalDialog("k170_getCallListen.jsp?flag_id="+id,window,"dialogHeight: 650px; dialogWidth: 850px;");
openWinMid("k170_getCallListen.jsp?flag_id="+id,'录音听取',650,850);
}
*/

//居中打开窗口
function openWinMid(url,name,iHeight,iWidth)
{
  var iTop = (window.screen.availHeight-30-iHeight)/2; //获得窗口的垂直位置;
  var iLeft = (window.screen.availWidth-10-iWidth)/2; //获得窗口的水平位置;
  window.open(url,name,'height='+iHeight+',innerHeight='+iHeight+',width='+iWidth+',innerWidth='+iWidth+',top='+iTop+',left='+iLeft+',toolbar=no,menubar=no,scrollbars=yes,resizeable=no,location=no,status=no');
}

/**	*/
function doProcessNavcomring(packet)	 
	 {
	    var retType = packet.data.findValueByName("retType"); 
	    var retCode = packet.data.findValueByName("retCode"); 
	    var retMsg = packet.data.findValueByName("retMsg"); 
	    if(retType=="chkExample"){
	    	if(retCode=="000000"){
	    		//alert("处理成功!");
	    	}else{
	    		//alert("处理失败!");
	    		return false;
	    	}
	    }
	 } 
 
 function doLisenRecord(filepath,contact_id)
{
		   window.top.document.getElementById("recordfile").value=filepath;
		   window.top.document.getElementById("lisenContactId").value=contact_id;
		   window.top.document.getElementById("K042").click();
			var packet = new AJAXPacket("../../../npage/callbosspage/K042/lisenRecord.jsp","正在处理,请稍后...");
	     packet.data.add("retType" ,  "chkExample");
	     packet.data.add("filepath" ,  filepath);
	     packet.data.add("liscontactId" ,contact_id);
	    core.ajax.sendPacket(packet,doProcessNavcomring,true);
			packet =null;
}		
function checkCallListen(id,staffno){
		if(id==''){
		return;
		}
		if('<%=isCommonLogin%>'=='Y'){
			if('<%=kf_longin_no%>'!=staffno){
			  rdShowMessageDialog("您没有听取该录音的权限！");
			  return;
		  }
		}		
	var packet = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/k170/k170_checkIsListen_rpc.jsp","\u6b63\u5728\u5904\u7406,\u8bf7\u7a0d\u540e...");
	packet.data.add("contact_id",id);
	core.ajax.sendPacket(packet,doProcessGetPath,false);
	packet=null;
}		
function doProcessGetPath(packet){
   var file_path = packet.data.findValueByName("file_path");
   var flag = packet.data.findValueByName("flag");
   var contact_id = packet.data.findValueByName("contact_id"); 
   if(flag=='Y'){
   	doLisenRecord(file_path,contact_id);
   	}else{
   	getCallListen(contact_id)	;
   	}

}
function getCallListen(id){
	if(id==''){
		return;
		}		
//var a=window.showModalDialog("k170_getCallListen.jsp?flag_id="+id,window,"dialogHeight: 650px; dialogWidth: 850px;");
openWinMid("k170_getCallListen.jsp?flag_id="+id,'录音听取',650,850);
}

//导出窗口
	function showExpWin(flag){
		window.sitechform.page.value="<%=curPage%>";
	  window.sitechform.sqlWhere.value="<%=sqlFilter%>";
	  window.sitechform.para.value="<%=myParams%>";
		openWinMid('k1714_expSelect.jsp?flag='+flag,'选择导出列',340,320);
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
</script>
<script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js"></script>
</head>


<body >
<form id=sitechform name=sitechform>
<!--
<%@ include file="/npage/include/header.jsp"%>
-->
	<div id="Operation_Table">
		<table cellspacing="0">
    <tr><td colspan='4' ><div class="title"><div id="title_zi">听取录音情况查询</div></div></td></tr>
     <tr >
	    <td > 开始时间 </td>
	    <td >
				<input id="beginTime" name="beginTime" type="text"  value="<%=(beginTime==null)?getCurrDateStr("00:00:00"):beginTime%>" onclick="WdatePicker({dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});hiddenTip(document.sitechform.beginTime);">
				<img onclick="WdatePicker({el:$dp.$('beginTime'),dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});hiddenTip(document.sitechform.beginTime);" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
				<font color="orange">*</font>
	    </td>
     <td > 工号 </td>
	    <td >
	    <!--zhengjiang 20091010 增加onkeyup="value=value.replace(/[^kf\d]/g,'');"和onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^kf\d]/g,''))"-->
			  <input name="logNo" type="text" onkeyup="value=value.replace(/[^kf\d]/g,'');" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^kf\d]/g,''))" value=<%=(logNo==null)?"":logNo%>>
			  <font color="orange">*</font>
	    </td>
	   	
		</tr>
		   <tr >
     <td > 结束时间 </td>
	    <td>
			  <input name ="endTime" type="text" id="endTime"  value="<%=(endTime==null)?getCurrDateStr("23:59:59"):endTime%>" onclick="WdatePicker({dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});hiddenTip(document.sitechform.endTime);">
			  <img onclick="WdatePicker({el:$dp.$('endTime'),dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});hiddenTip(document.sitechform.endTime);" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
			  <font color="orange">*</font>
		  </td> 
		  <td> 接触流水号</td>
	    <td>
	    <!--zhengjiang 20091010添加onkeyup="value=value.replace(/[^a-zA-Z\d]/g,'');"和onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^a-zA-Z\d]/g,''))"-->
			  <input name ="sysNo" type="text" id="sysNo" onkeyup="value=value.replace(/[^a-zA-Z\d]/g,'');" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^a-zA-Z\d]/g,''))" value=<%=(sysNo==null)?"":sysNo%>>
           <font color="orange">*</font>
		  </td>  
	   </tr>
        <!-- ICON IN THE MIDDLE OF THE PAGE-->
    <tr >
      <td colspan="4" align="center" id="footer" style="width:50em">
       <!--zhengjiang 20091004 查询与重置换位置--> 
       <input name="search" type="button"  id="search" value="查询" onClick="submitInput()">
       <input name="clear" type="button"  id="clear" value="重置" onClick="clearValue()">
        <input name="export" type="button"  id="search" value="导出" <%if(dataRows.length!=0) out.print("onClick=\"showExpWin('cur')\"");%>>
       <input name="exportAll" type="button"  id="add" value="导出全部" <%if(dataRows.length!=0) out.print("onClick=\"showExpWin('all')\"");%>>  
      </td>
    </tr>
		</table>    
	</div>
  <div id="Operation_Table">
		<table  cellspacing="0">
    <tr >
      <td style="color:#0256B8" align="left" colspan="4">
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
        <!--modify hucw 20100829<a>快速选择</a>-->
		    <span>快速选择</span>
        <select onchange="jumpToPage(this.value)" style="width:3em;height:2em">
        <%for(int i=1;i<=pageCount;i++){
        	out.print("<option value='"+i+"'");
        	if(i==curPage){
        	 out.print("selected");
        	}
        	out.print(">"+i+"</option>");
        }%>
       </select>&nbsp;&nbsp;
       <!--modify hucw 20100829<a>快速跳转</a>-->
			<span>快速跳转</span>
        <input id="thePage" name="thePage" type="text" value="<%=curPage%>" style="height:18px;width:30px"  onkeyup="hiddenTip(this);value=value.replace(/[^\d]/g,'') "onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))"/><a href="#" onClick="jumpToPage('jumpToPage');return false;">
        	<font face=粗体>GO</font>        
        <%}%>
      </td>
    </tr>
  </table>
      <table  cellSpacing="0" >
        <input type="hidden" name="sqlFilter"  value="">
			  <input type="hidden" name="page" value="">
			  <input type="hidden" name="myaction" value="">
			  <input type="hidden" name="sqlWhere" value="">
			  <input type="hidden" name="para" value="">
			  
          <tr >
        <script>
       	var tempBool ='flase';
      	if(checkRole(K17CA_RolesArr)==true){	
      		document.write('<th align="center" class="blue" width="15%" > 操作 </th>');	
      		tempBool='true';
      	}
        </script>  
            <!--<th align="center" class="blue" width="30%" > 流水号 </th> -->
            <th align="center" class="blue" width="30%" > 接触流水号 </th>
            <th align="center" class="blue" width="15%" > 工号 </th>
            <th align="center" class="blue" width="20%" > 时间 </th>
            <th align="center" class="blue" width="30%" > 文件路径 </th>
          </tr>

          <% for ( int i = 0; i < dataRows.length; i++ ) {             
                String tdClass="";
           %>
          <%if((i+1)%2==1){
          tdClass="grey";
          %>
          <tr >
			<%}else{%>
	   <tr  >
	<%}%>
	      <script>
      	if(tempBool=='true'){
      		document.write('<td align="center" class="<%=tdClass%>"  >');
      	}
      	if(checkRole(K17CA_RolesArr)==true){	
      		document.write('<img style="cursor:hand" onclick="checkCallListen(\'<%=dataRows[i][4]%>\',\'<%=dataRows[i][1]%>\');return false;" alt="听取语音" src="<%=request.getContextPath()%>/nresources/default/images/callimage/operImage/1.gif" width="16" height="16" align="absmiddle">&nbsp;');	
      	}
        if(tempBool=='true'){
      		document.write('</td>');
      	}
      </script>
      <!--
      <td align="center" class="<%=tdClass%>"  >
         <img onclick="doLisenRecord('<%=i%>','<%=dataRows[i][4]%>')" alt="听取语音" src="<%=request.getContextPath()%>/nresources/default/images/callimage/operImage/1.gif" width="16" height="16" align="absmiddle">
      </td>
      -->
      <!--<td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][0].length()!=0)?dataRows[i][0]:"&nbsp;"%></td> -->
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][4].length()!=0)?dataRows[i][4]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][1].length()!=0)?dataRows[i][1]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][2].length()!=0)?dataRows[i][2]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][3].length()!=0)?dataRows[i][3]:"&nbsp;"%></td>
      <input type="hidden"  id="<%=i%>" value="<%=dataRows[i][3]%>">  
    </tr>
      <% } %>
    <tr >
      <td style="color:#0256B8" align="right" colspan="4">
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
        <!--modify hucw 20100829<a>快速选择</a>-->
		    <span>快速选择</span>
				<select onchange="jumpToPage(this.value)" style="width:3em;height:2em">
        <%for(int i=1;i<=pageCount;i++){
        	out.print("<option value='"+i+"'");
        	if(i==curPage){
        	 out.print("selected");
        	}
        	out.print(">"+i+"</option>");
        }%>
       </select>&nbsp;&nbsp;
       <!--modify hucw 20100829<a>快速跳转</a>-->
			<span>快速跳转</span>
        <input id="thePage1" name="thePage1" type="text" value="<%=curPage%>" style="height:18px;width:30px"  onkeyup="hiddenTip(this);value=value.replace(/[^\d]/g,'') "onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))"/><a href="#" onClick="jumpToPage('jumpToPage1');return false;">
        	<font face=粗体>GO</font>        
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

