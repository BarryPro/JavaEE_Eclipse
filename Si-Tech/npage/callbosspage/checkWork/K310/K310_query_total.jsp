<%
  /*
   * 功能: 总计划查询展示
　 * 版本: 1.0
　 * 日期: 2008/10/17
　 * 作者:
　 * 版权: sitech
   *
 　*/
%>

<%
	String opCode = "K310";
	String opName = "总计划查询展示";
%>
 
<%@ page contentType="text/html;charset=gbk"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,com.sitech.boss.util.excel.*"%>
<%!
//导出Excel
    public void toExcel(String[][] queryList,String[] strHead,HttpServletResponse response){
        XLSExport e  =   new  XLSExport(null);
        String headname = "通知发送查询";//Excel文件名
        try {
        OutputStream os = response.getOutputStream();//取得输出流
        response.reset();//清空输出流
        response.setContentType("application/ms-excel");//定义输出类型
        response.setHeader("Content-disposition", "attachment; filename="+XLSExport.gbToUtf8(headname)+".xls");//设定输出文件头
				int intMaxRow=5000+1;
				ArrayList datalist = new ArrayList();
				for(int i=0;i<queryList.length;i++){
				    String[] dateSour={queryList[i][1],queryList[i][2],queryList[i][3],queryList[i][4],queryList[i][5]};
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
	  String loginNo = (String)session.getAttribute("workNo");  
	  String orgCode = (String)session.getAttribute("orgCode"); 
	  
  	String regionCode = orgCode.substring(0,2);
  	String myparams = request.getParameter("mparams");
   
    //查询DQCPLAN
    String beginTime   = request.getParameter("beginTime");            //开始时间
    String endTime     = request.getParameter("endTime");  
    String CHECK_TYPE   = request.getParameter("CHECK_TYPE");
    String CHECK_KIND   = request.getParameter("CHECK_KIND"); 
    
    String GROUP_FLAG   = request.getParameter("GROUP_FLAG"); 
    String CHECK_CLASS   = request.getParameter("CHECK_CLASS");
    String PLAN_ID   = request.getParameter("PLAN_ID"); 
    String PLAN_NAME   = request.getParameter("PLAN_NAME"); 
    
    //查询DQCLOGINPLAN
    String OBJECT_ID   = request.getParameter("OBJECT_ID"); 
    String CONTENT_ID   = request.getParameter("CONTENT_ID"); 
    String LOGIN_NO   = request.getParameter("LOGIN_NO"); 
    
    //查询DQCCHECKLOGINPLAN
    String CHECK_LOGIN_NO   = request.getParameter("CHECK_LOGIN_NO");    

    //发送内容
    String[][] dataRows = new String[][]{};
    String[][] dataTemp = new String[][]{};
    int rowCount=0;
    int pageSize = 10;            // Rows each page
    int pageCount=0;               // Number of all pages
    int curPage=0;                 // Current page
    String strPage="";               // Transfered pages
    String sqlStr="";
    String[] strHead= {"发送工号","接收工号","通知内容","发送时间","消息类别"};
    String action = request.getParameter("myaction");
	  String expFlag = request.getParameter("exp");        //导出标示
	  String sqlFilter = request.getParameter("sqlFilter");
	  String needt2 = "";
	  String needt3 = "";
	  String sqlFilter2 = "";

	  if(sqlFilter==null || sqlFilter.trim().length()==0){
	    if(beginTime!=null&&!beginTime.trim().equals("")&&endTime!=null&&!endTime.trim().equals("")){
	      //updated by tangsong 20100716 修改为：只要选择的日期范围跟计划的日期范围有交集，就应该查询出计划
	      //sqlFilter = "  and t1.begin_date >= to_date(:beginTime,'yyyyMMdd hh24:mi:ss')  and t1.end_date <= to_date(:endTime,'yyyyMMdd hh24:mi:ss') ";
	      sqlFilter = "  and not ((to_date(:beginTime,'yyyyMMdd hh24:mi:ss') > t1.end_date) or (to_date(:endTime,'yyyyMMdd hh24:mi:ss') < t1.begin_date)) ";
	      myparams = myparams + ",beginTime=" + beginTime.trim()+ ",endTime=" + endTime.trim();
			  if(CHECK_TYPE!=null && !CHECK_TYPE.trim().equals("")){
           sqlFilter = sqlFilter+" and trim(t1.CHECK_TYPE) = :CHECK_TYPE";
           myparams = myparams +",CHECK_TYPE="+CHECK_TYPE.trim();
         }
         if(CHECK_KIND!=null && !CHECK_KIND.trim().equals("")){
           sqlFilter = sqlFilter+" and trim(t1.CHECK_KIND) = :CHECK_KIND";
         	myparams = myparams +",CHECK_KIND="+CHECK_KIND.trim();
         }
         if(GROUP_FLAG!=null && !GROUP_FLAG.trim().equals("")){
           sqlFilter = sqlFilter+" and trim(t1.GROUP_FLAG) = :GROUP_FLAG";
           myparams = myparams +",GROUP_FLAG="+GROUP_FLAG.trim();
         }
         if(CHECK_CLASS!=null && !CHECK_CLASS.trim().equals("")){
           sqlFilter = sqlFilter+" and trim(t1.CHECK_CLASS) = :CHECK_CLASS";
           myparams = myparams +",CHECK_CLASS="+CHECK_CLASS.trim();
         }
         if(PLAN_ID!=null && !PLAN_ID.trim().equals("")){
           sqlFilter = sqlFilter+" and trim(t1.PLAN_ID) = :PLAN_ID";
           myparams = myparams +",PLAN_ID="+PLAN_ID.trim();
         }
         if(PLAN_NAME!=null && !PLAN_NAME.trim().equals("")){
           sqlFilter = sqlFilter+" and trim(t1.PLAN_NAME) = :PLAN_NAME";
         	 myparams = myparams +",PLAN_NAME="+PLAN_NAME.trim();
         }
         if(OBJECT_ID!=null && !OBJECT_ID.trim().equals("")){
           sqlFilter = sqlFilter+" and trim(t1.OBJECT_ID) = :OBJECT_ID";
         	 myparams = myparams +",OBJECT_ID="+OBJECT_ID.trim();
         }
         if(CONTENT_ID!=null && !CONTENT_ID.trim().equals("")){
           sqlFilter = sqlFilter+" and trim(t1.CONTENT_ID) = :CONTENT_ID";
           myparams = myparams +",CONTENT_ID="+CONTENT_ID.trim();
         }
         if(LOGIN_NO!=null && !LOGIN_NO.trim().equals("")){
         	sqlFilter = sqlFilter+" and trim(t2.LOGIN_NO) = :LOGIN_NO";
         	myparams = myparams +",LOGIN_NO="+LOGIN_NO.trim();
         }
         if(CHECK_LOGIN_NO!=null && !CHECK_LOGIN_NO.trim().equals("")){
           sqlFilter = sqlFilter+" and trim(t3.CHECK_LOGIN_NO) = :CHECK_LOGIN_NO";
           myparams = myparams +",CHECK_LOGIN_NO="+CHECK_LOGIN_NO.trim();
         }
      }
     }
     if(sqlFilter!=null&&(sqlFilter.indexOf("t2")!=-1||sqlFilter.indexOf("T2")!=-1)){
     		needt2 = ",dqcloginplan t2 ";
     		sqlFilter2 = sqlFilter2 + " and trim(t1.plan_id) = trim(t2.plan_id) ";
     }
     if(sqlFilter!=null&&(sqlFilter.indexOf("t3")!=-1||sqlFilter.indexOf("T3")!=-1)){
     		needt3 = ",dqccheckloginplan t3 ";
     		sqlFilter2 = sqlFilter2 + " and trim(t1.plan_id) = trim(t3.plan_id) ";
     }
    if ("doLoad".equals(action)) {
        String sqlTemp = "select to_char(count(*)) from (select distinct t1.plan_id, t1.object_id, t1.content_id  from dqcplan t1 "+needt2+needt3+" where 1=1  "+sqlFilter+sqlFilter2+")";

%>	
					<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="1">
						<wtc:param value="<%=sqlTemp%>"/>
						<wtc:param value="<%=myparams%>"/>
					</wtc:service>
					<wtc:array id="rowsC4" scope="end"/>	
<% 
				if(rowsC4.length!=0){
	      	rowCount = Integer.parseInt(rowsC4[0][0]);
	      }
	      System.out.println("rowCount:"+rowCount);
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
        
       sqlStr = "select distinct (t1.plan_id),t1.plan_name,"+
       					"to_char(t1.begin_date,'yyyyMMdd hh24:mi:ss') begin_date,"+
       					"to_char(t1.end_date,'yyyyMMdd hh24:mi:ss'), "+
                 "(select a.object_name from dqcobject a where trim(a.object_id) = trim(t1.object_id)), " + 
                 "t1.group_flag,"+
                 "(select b.name from dqccheckcontect b "+
                 "where trim(b.object_id) = trim(t1.object_id) "+
                 "and trim(b.contect_id) = trim(t1.content_id)),"+
                 "t1.check_type,t1.check_kind,to_char(t1.plan_time),to_char(t1.min_time),to_char(t1.max_time),"+
                 "t1.object_id,t1.content_id "+
                 "from dqcplan t1  "+ needt2 +
                  needt3 +
                 "where 1=1   "+sqlFilter+sqlFilter2+" order by  begin_date desc";         
        String querySql = PageFilterSQL.getOraQuerySQL(sqlStr,String.valueOf(curPage),String.valueOf(pageSize),String.valueOf(rowCount));   
%>	
					<wtc:service name="TlsPubSelCrm" outnum="15" routerKey="region" routerValue="<%=regionCode%>">
						<wtc:param value="<%=querySql%>"/>
						<wtc:param value="<%=myparams%>"/>
					</wtc:service>
					<wtc:array id="queryList"  start="0" length="14" scope="end"/>	
<% 				
					dataRows=queryList;
}

    //导出当前显示数据
   if("cur".equalsIgnoreCase(expFlag)){    
 				String sqlTemp = "select to_char(count(*)) from (select distinct t1.plan_id, t1.object_id, t1.content_id  from dqcplan t1, DQCLOGINPLAN t2, DQCCHECKLOGINPLAN t3 where t1.plan_id = t2.plan_id and t1.plan_id = t3.plan_id  "+sqlFilter+")";
%>	
					<wtc:service name="TlsPubSelCrm" outnum="1" routerKey="region" routerValue="<%=regionCode%>">
						<wtc:param value="<%=sqlTemp%>"/>
						<wtc:param value="<%=myparams%>"/>
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
        sqlStr = "select distinct (t1.plan_id),t1.PLAN_NAME,t1.begin_date, t1.end_date, t1.object_id,t1.group_flag,t1.content_id,t1.CHECK_TYPE,t1.CHECK_KIND,t1.plan_time,t1.min_time,t1.max_time  from dqcplan t1, DQCLOGINPLAN t2, DQCCHECKLOGINPLAN t3 where t1.plan_id = t2.plan_id and t1.plan_id = t3.plan_id  "+sqlFilter+" order by t1.begin_date desc";     
        String querySql = PageFilterSQL.getOraQuerySQL(sqlStr,String.valueOf(curPage),String.valueOf(pageSize),String.valueOf(rowCount));

%>	
					<wtc:service name="TlsPubSelCrm" outnum="13" routerKey="region" routerValue="<%=regionCode%>">
						<wtc:param value="<%=querySql%>"/>
						<wtc:param value="<%=myparams%>"/>
					</wtc:service>
					<wtc:array id="queryList"  start="0" length="12" scope="end"/>	
<% 
				this.toExcel(queryList,strHead,response);
   }
   if("all".equalsIgnoreCase(expFlag)){    
				sqlStr = "select distinct (t1.plan_id),t1.PLAN_NAME,t1.begin_date, t1.end_date, t1.object_id,t1.group_flag,t1.content_id,t1.CHECK_TYPE,t1.CHECK_KIND,t1.plan_time,t1.min_time,t1.max_time  from dqcplan t1, DQCLOGINPLAN t2, DQCCHECKLOGINPLAN t3 where t1.plan_id = t2.plan_id and t1.plan_id = t3.plan_id  "+sqlFilter+" order by t1.begin_date desc";     
%>	
					<wtc:service name="TlsPubSelCrm" outnum="12" routerKey="region" routerValue="<%=regionCode%>">
						<wtc:param value="<%=sqlStr%>"/>
						<wtc:param value="<%=myparams%>"/>
					</wtc:service>
					<wtc:array id="queryList" start="0" length="12" scope="end"/>	
<% 
				this.toExcel(queryList,strHead,response);
   }
%>

<html>
<head>
<title>通知发送查询</title>

<script type="text/javascript" src="<%=request.getContextPath()%>/njs/csp/checkWork_dialog.js"></script>
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
    } 
   else {
    hiddenTip(document.sitechform.beginTime);
    hiddenTip(document.sitechform.endTime);
    window.sitechform.sqlFilter.value="";//清空已保存的sqlFilter的值
    doSubmit();
    }
}
function doSubmit(){
    window.sitechform.myaction.value="doLoad";
    window.sitechform.action="K310_query_total.jsp";
    window.sitechform.method='post';
    window.sitechform.submit();
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
   window.sitechform.action="K310_query_total.jsp";
   window.sitechform.method='post';
   window.sitechform.submit();
    }
//清除表单记录
function clearValue(){
var e = document.forms[0].elements;
for(var i=0;i<e.length;i++){
  if(e[i].type=="select-one"||e[i].type=="text")
   e[i].value="";
 }
}

//导出
function expExcel(expFlag){
	  document.sitechform.action="<%=request.getContextPath()%>/npage/callbosspage/k180/K310_query_total.jsp?exp="+expFlag;
	  keepValue();
    window.sitechform.page.value=<%=curPage%>;
    document.sitechform.method='post';
    document.sitechform.submit();
}

function keepValue(){
	window.sitechform.sqlFilter.value="<%=sqlFilter%>";
	window.sitechform.mparams.value="<%=myparams%>";
	window.sitechform.beginTime.value="<%=beginTime%>";
	window.sitechform.endTime.value="<%=endTime%>";
}

function mendCheck(){
	var planNo=document.getElementById("checkPlanNo").value;
	var content_id=document.getElementById("content_id").value; 
  var object_id=document.getElementById("object_id").value;  
	if(planNo=='')
	{
	similarMSNPop("没有选择要修改的记录！");
	return false;
	}

	var time     = new Date();
	var winParam = 'dialogWidth=1000px;dialogHeight=800px';
	window.showModalDialog("../../../../npage/callbosspage/checkWork/K310/K310_mend_main.jsp?time="+time+"&plan_id="+planNo+"&content_id="+content_id+"&object_id="+object_id,window, winParam);
}

/**
  *删除前的校验
  */
function deleteCheck(){
	var planNo=document.getElementById("checkPlanNo").value;
	if(planNo=='')
	{
	similarMSNPop("没有选择要删除的记录！");
	return false;
	}
	if(rdShowConfirmDialog("你确定需要删除这条记录吗？")=="1"){
		deleteRec(planNo);
	}
}

/**
  *删除选定的质检总计划
  */
function deleteRec(msg_id){
	var mypacket = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/checkWork/K310/K310_delet_plan.jsp","正在删除相关记录，请稍候......");
	var contect_id=document.getElementById("content_id").value;  
	var object_id=document.getElementById("object_id").value;   
	mypacket.data.add("msg_id",msg_id);
	mypacket.data.add("contect_id",contect_id);
	mypacket.data.add("object_id",object_id);
	core.ajax.sendPacket(mypacket,doProcess,true);
	mypacket=null;
}

/**
  *删除之后的处理函数
  */
function doProcess(packet){
	var retCode = packet.data.findValueByName("retCode");
	if(retCode=="00000"){
		similarMSNPop("删除成功！");	
    	keepValue();
	    //刷新计划明细页面
	    parent.frames["frameCheckContent"].sitechform.action = "K310_query_detail.jsp";
	    parent.frames["frameCheckContent"].sitechform.method = "post";
	    parent.frames["frameCheckContent"].sitechform.myaction.value="doLoad";
	    parent.frames["frameCheckContent"].sitechform.submit();	    
	    window.sitechform.myaction.value="doLoad";
	    window.sitechform.action="K310_query_total.jsp";
	    window.sitechform.method='post';    
	    //document.sitechform.submit();
	    //等待2.5秒后执行操作，确保弹出框已经弹出 zengzq 20090526
	    setTimeout("document.sitechform.submit()",2500);
	}else{
		similarMSNPop("删除失败！");
	}
}
//复制质检计划 zengzq 20091016
function copyCheckPlan(){
		document.getElementById("copyOne").disabled=true;
		var plan_id = document.getElementById("checkPlanNo").value;
		var object_id = document.getElementById("object_id").value;
		var content_id = document.getElementById("content_id").value; 
  	
  	var chkPacket = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/checkWork/K310/K310_plan_copy.jsp","请稍后...");
  	chkPacket.data.add("plan_id", plan_id);
    chkPacket.data.add("object_id", object_id);
    chkPacket.data.add("content_id", content_id);
    core.ajax.sendPacket(chkPacket, doProcessCopyPlan, false);
		chkPacket =null;
}
/**
  *放弃返回处理函数
  */
function doProcessCopyPlan(packet) {
		//var retType = packet.data.findValueByName("retType");
		var retCode = packet.data.findValueByName("retCode");
		//var retMsg = packet.data.findValueByName("retMsg");
		if(retCode=="000000"){
			similarMSNPop("复制计划成功！");
			setTimeout("parent.window.document.getElementById('parSubmit').click()",500);
			//parent.window.document.getElementById("parSubmit").click();
			/*
			keepValue();
	    //刷新计划明细页面
	    parent.frames["frameCheckContent"].sitechform.action = "K310_query_detail.jsp";
	    parent.frames["frameCheckContent"].sitechform.method = "post";
	    parent.frames["frameCheckContent"].sitechform.myaction.value="doLoad";
	    parent.frames["frameCheckContent"].sitechform.submit();	    
	    window.sitechform.myaction.value="doLoad";
	    window.sitechform.action="K310_query_total.jsp";
	    window.sitechform.method='post';    
	    //document.sitechform.submit();
	    //等待2.5秒后执行操作，确保弹出框已经弹出 zengzq 20090526
	    setTimeout("document.sitechform.submit()",2500);
	    */
		}else{
			similarMSNPop("复制计划失败！");
		}
}
//选中行高亮显示
var hisObj="";//保存上一个变色对象
var hisColor=""; //保存上一个对象原始颜色

/**
   *hisColor ：当前tr的className
   *obj       ：当前tr对象
   */
function changeColor(color,obj,pid){
	document.getElementById(pid).click();
  //恢复原来一行的样式
  if(hisObj != ""){
	 for(var i=0; i<hisObj.cells.length; i++){
		var tempTd=hisObj.cells.item(i);
		//tempTd.className=hisColor; 还原字的颜色
		tempTd.style.backgroundColor = '#F7F7F7';		//还原行背景颜色
	 }
	}
		hisObj   = obj;
		hisColor = color;
  //设置当前行的样式
	for(var i=0; i<obj.cells.length; i++){
		var tempTd=obj.cells.item(i);
		//tempTd.className='green'; 改变字的颜色
		tempTd.style.backgroundColor='#00BFFF';	//改变行背景颜色
	}
}

</script>
<script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js"></script>
</head>

<body>
<form id=sitechform name=sitechform>
  <div id="Operation_Table">
	<table  cellspacing="0">
    <tr >
      <td class="blue"  align="left" width="720">
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
      <table  cellSpacing="0" style="width:98.5%">
        <input type="hidden" name="chkBoxNum"  value="<%=dataRows.length%>">
			  <input type="hidden" name="page" value="">
			  <input type="hidden" name="myaction" value="">
			  <input type="hidden" name="sqlFilter" value="">
			  <input type="hidden" name="mparams" value="">
			  
			  <!--页面变量-->
			  <input type="hidden" name="beginTime" value="<%=beginTime%>">
			  <input type="hidden" name="endTime" value="<%=endTime%>">
			  <input type="hidden" name="CHECK_TYPE" value="<%=CHECK_TYPE%>">
			  <input type="hidden" name="CHECK_KIND" value="<%=CHECK_KIND%>">
			  <input type="hidden" name="GROUP_FLAG" value="<%=GROUP_FLAG%>">
			  <input type="hidden" name="CHECK_CLASS" value="<%=CHECK_CLASS%>">
			  <input type="hidden" name="PLAN_ID" value="<%=PLAN_ID%>">
			  <input type="hidden" name="PLAN_NAME" value="<%=PLAN_NAME%>">
			  <input type="hidden" name="OBJECT_ID" value="<%=OBJECT_ID%>">
			  <input type="hidden" name="CONTENT_ID" value="<%=CONTENT_ID%>">
			  <input type="hidden" name="LOGIN_NO" value="<%=LOGIN_NO%>">
			  <input type="hidden" name="CHECK_LOGIN_NO" value="<%=CHECK_LOGIN_NO%>">	  
			  <!--选中的值联合主键-->
			  <input type="hidden" name="checkPlanNo" value="">
			  <input type="hidden" name="content_id" value="">
			  <input type="hidden" name="object_id" value="">		  
          <tr >
            <th align="center" class="blue" nowrap > 选择 </th>
            <th align="center" class="blue" nowrap > 计划ID号 </th>
            <th align="center" class="blue" nowrap > 标题 </th>
            <th align="center" class="blue" nowrap > 起始日期 </th>
            <th align="center" class="blue" nowrap > 截止日期 </th>
            <th align="center" class="blue" nowrap > 被检对象类别 </th>
            <th align="center" class="blue" nowrap > 计划类别 </th>
            <th align="center" class="blue" nowrap > 考评内容 </th>
            <th align="center" class="blue" nowrap > 考评类别 </th>
            <th align="center" class="blue" nowrap > 考评方式 </th>
            <th align="center" class="blue" nowrap > 计划次数 </th>
            <th align="center" class="blue" nowrap > 最低门限 </th>
            <th align="center" class="blue" nowrap > 最高门限 </th>
          </tr>

          <% for ( int i = 0; i < dataRows.length; i++ ) {             
                String tdClass="blue";
           %>
          <%if((i+1)%2==1){
          tdClass="blue";
          %>
          <tr onClick="changeColor('<%=tdClass%>',this,'pid<%=i%>');">
			<%}else{%>
	   <tr  onClick="changeColor('<%=tdClass%>',this,'pid<%=i%>');">
	<%}%>
      <td align="center" class="<%=tdClass%>"	 ><input type="radio" name="plan_id" id="pid<%=i%>" onclick="setPlanNo('<%=i%>');" value="<%=dataRows[i][0]%>"/></td>
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][0].length()!=0)?dataRows[i][0]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][1].length()!=0)?dataRows[i][1]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][2].length()!=0)?dataRows[i][2]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][3].length()!=0)?dataRows[i][3]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][4].length()!=0)?dataRows[i][4]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  >
      	<%
	      	if("0".equals(dataRows[i][5])){
	        	  	out.println("评语评分");
	        }else if("1".equals(dataRows[i][5])){
	        	  	out.println("评语");
	        }else if("2".equals(dataRows[i][5])){
	        	  	out.println("评分");
	        }else{
	        	  	out.print("&nbsp;");
	        }
      	%>
      </td>
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][6].length()!=0)?dataRows[i][6]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  >
      	<%
	      	if("0".equals(dataRows[i][7])){
	        	  	out.println("实时质检");	
	        }else if("1".equals(dataRows[i][7])){
	        	  	out.println("事后质检");
	        }else{
	        	  	out.print("&nbsp;");
	        }
      	%>
      	</td>
      <td align="center" class="<%=tdClass%>"  >
      	<%
	      	if("0".equals(dataRows[i][8])){
	        	  	out.println("自动分派");
	        }else if("1".equals(dataRows[i][8])){
	        	  	out.println("人工指定");
	        }else{
	        	  	out.print("&nbsp;");
	        }
      	%>
      	</td>
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][9].length()!=0)?dataRows[i][9]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][10].length()!=0)?dataRows[i][10]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][11].length()!=0)?dataRows[i][11]:"&nbsp;"%></td>
      <input type="hidden" name ="plan_id<%=i%>"  value="<%=dataRows[i][0]%>">
      <input type="hidden" name ="content_id<%=i%>"  value="<%=dataRows[i][13]%>">
      <input type="hidden" name ="object_id<%=i%>"  value="<%=dataRows[i][12]%>">    
      <% } %>
  </table>   
  <table  cellspacing="0">
    <tr >
      <td class="blue"  align="right" width="720">
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
  
       <table style="width:98.5%" border="0" cellpadding="0" cellspacing="0">
        <tr> 
          <td id="footer" style="width:60%;"> 
          <input class="b_foot" name="addContent" type="button" value="新增" onclick="add_plan()">
        	<input class="b_foot" name="modifyOne" type="button"  value="修改" onclick="mendCheck();" >
       		<input class="b_foot" name="deletOne" type="button"  value="删除" onclick="deleteCheck();" >
       		<input class="b_foot" id="copyOne" name="copyOne" type="button"  value="复制" onclick="copyCheckPlan();" >  
        </td>
       <td id="footer" style="text-align:left"> 
         <input class="b_foot_long" name="viewCheck11" type="button"  value="质检员信息" onclick="viewCheck1();" >		
      </td>
       </tr>   
     </table> 
</div>
</form>
</div>
</body>
</html>
<script language="javascript">
function setPlanNo(planNo){
		document.getElementById("checkPlanNo").value =document.getElementById("plan_id"+planNo).value;
		document.getElementById("content_id").value  =document.getElementById("content_id"+planNo).value;
		document.getElementById("object_id").value    =document.getElementById("object_id"+planNo).value;
}

/**
   *新增质检计划
   */
function add_plan(){
	var time     = new Date();
	var winParam = 'dialogWidth=920px;dialogHeight=800px';
	window.showModalDialog("<%=request.getContextPath()%>/npage/callbosspage/checkWork/K310/K310_qc_main.jsp?time="+time,window, winParam);	
}


function viewCheck1(){
	 var planNo=document.getElementById("checkPlanNo").value;
	if(planNo==''){
			similarMSNPop("没有选择要查看的记录！");
			return false;
	}
	var time     = new Date();
	var winParam = 'dialogWidth=420px;dialogHeight=260px';
	window.showModalDialog("../../../../npage/callbosspage/checkWork/K310/K310_query_detail_checkPerson.jsp?time="+time+"&plan_id="+planNo,window, winParam);
}
</script>