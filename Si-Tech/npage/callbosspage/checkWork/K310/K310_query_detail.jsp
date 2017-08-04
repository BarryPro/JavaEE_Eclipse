<%
  /*
   * 功能: 详细计划展示页面
　 * 版本: 1.0
　 * 日期: 2008/10/17
　 * 作者:
　 * 版权: sitech
   *
 　*/
%>

<%
	String opCode = "K310";
	String opName = "详细计划展示页面";
%>
<%@ page contentType="text/html;charset=gbk"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,com.sitech.boss.util.excel.*"%>
<%@ include file="/npage/callbosspage/public/hashlisttoarray.jsp" %>
<%@page import="com.sitech.crmpd.kf.ejb.client.KFEjbClient"%>
<%@page import="java.util.HashMap"%>
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
	String needt3 = "";
	String sqlFilter2 = "";
    
	
    
    //符合条件的记录条数
    if ("doLoad".equals(action)) {
       HashMap pMap=new HashMap();
				pMap.put("beginTime",beginTime);
				pMap.put("endTime",endTime);
				pMap.put("CHECK_TYPE",CHECK_TYPE);
				pMap.put("CHECK_KIND",CHECK_KIND);
				pMap.put("GROUP_FLAG",GROUP_FLAG);
				pMap.put("CHECK_CLASS",CHECK_CLASS);
				pMap.put("PLAN_ID",PLAN_ID);
				pMap.put("PLAN_NAME",PLAN_NAME);
				pMap.put("OBJECT_ID",OBJECT_ID);
				pMap.put("CONTENT_ID",CONTENT_ID);
				pMap.put("LOGIN_NO",LOGIN_NO);
				pMap.put("CHECK_LOGIN_NO",CHECK_LOGIN_NO); 
        rowCount = ( ( Integer )KFEjbClient.queryForObject("query_K310_detail_strCountSql",pMap)).intValue();
	
	//分页处理
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
        int start = (curPage - 1) * pageSize + 1;
				int end = curPage * pageSize;
				pMap.put("start", ""+start);
				pMap.put("end", ""+end);
		    
		    List queryList =(List)KFEjbClient.queryForList("query_K310_detail_sqlStr",pMap); 
	      dataRows = getArrayFromListMap(queryList ,1,18);        
	
}


%>

<html>
<head>
<title>质检计划明细页面</title>

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

//=========================================================================
// SUBMIT INPUTS TO THE SERVELET
//=========================================================================
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
    window.sitechform.action="K310_query_detail.jsp";
    window.sitechform.method='post';
    window.sitechform.submit();
}

//=========================================================================
// LOAD PAGES.
//=========================================================================
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
   window.sitechform.action="K310_query_detail.jsp";
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
	  document.sitechform.action="<%=request.getContextPath()%>/npage/callbosspage/k180/K310_query_detail.jsp?exp="+expFlag;
	  keepValue();
    window.sitechform.page.value=<%=curPage%>;
    document.sitechform.method='post';
    document.sitechform.submit();
}

/**
  *保持查询条件
  */
function keepValue(){
	window.sitechform.sqlFilter.value="<%=sqlFilter%>";
	window.sitechform.beginTime.value="<%=beginTime%>";
	window.sitechform.endTime.value="<%=endTime%>";
}

/**
  *修改一条计划明细
  */
function mendCheck(){
   var primarykeys = document.getElementsByName("primarykey");
	var primarykey = "";
	for(var i = 0; i < primarykeys.length; i++){
		if(primarykeys[i].checked){
			primarykey = primarykeys[i].value;
			break;
		}
	}
	if(primarykey==''){
	similarMSNPop("没有选择要修改的记录！");
	return false;
	}
	var time     = new Date();
	var winParam = 'dialogWidth=500px;dialogHeight=380px';
        //modified by liujied 20091015
        var return_value = window.showModalDialog("../../../../npage/callbosspage/checkWork/K310/K310_query_detail_mend.jsp?time="+time+"&primarykey="+primarykey,window, winParam);
        
        if(return_value == "reload")
        {
             window.location.reload();
        }
}

/**
  *删除计划明细前的判断
  */
function deleteCheck(){
	var primarykeys = document.getElementsByName("primarykey");
	var primarykey = "";
	for(var i = 0; i < primarykeys.length; i++){
		if(primarykeys[i].checked){
			primarykey = primarykeys[i].value;
			break;
		}
	}
	if(primarykey == ''){
		similarMSNPop("没有选择要删除的记录！");
		return false;
	}
	
	if(rdShowConfirmDialog("你确定需要删除这条记录吗？")=="1"){
		deleteRec(primarykey);
	}
}

/**
  *删除一条计划明细
  */
function deleteRec(primarykey){
	var mypacket = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/checkWork/K310/K310_delet_login_plan.jsp","...");
	mypacket.data.add("primarykey",primarykey);
	core.ajax.sendPacket(mypacket,doProcess,true);
	mypacket=null;
}

/**
  *删除之后返回处理函数
  */
function doProcess(packet){
	var retCode = packet.data.findValueByName("retCode");
	if(retCode=="00000"){
		similarMSNPop("删除成功！");
		window.sitechform.myaction.value="doLoad";
	    keepValue();
	    window.sitechform.action="K310_query_detail.jsp";
	    window.sitechform.method='post';
	    //document.sitechform.submit();
	    //等待2.5秒后执行操作，确保弹出框已经弹出 zengzq 20090526
	    setTimeout("document.sitechform.submit()",2500);    
	}else{
		similarMSNPop("删除失败！");
	}
}

//选中行高亮显示
var hisObj="";//保存上一个变色对象
var hisColor=""; //保存上一个对象原始颜色

/**
   *hisColor ：当前tr的className
   *obj       ：当前tr对象
   */
function changeColor(color,obj,pkey){
	document.getElementById(pkey).click();
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

<script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js"></script>
</head>

<body>
<form id="sitechform" name="sitechform">

  <div id="Operation_Table" style="width:100%">
	<table  cellspacing="0">
    <tr>
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
    <table  cellSpacing="0" >
		<input type="hidden" name="chkBoxNum"  value="<%=dataRows.length%>">
		<input type="hidden" name="page" value="">
		<input type="hidden" name="myaction" value="">
		<input type="hidden" name="sqlFilter" value="">
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
		<input type="hidden" name="login_id" value="">

		<tr>
		<th align="center" class="blue" nowrap > 选择 </th>
		<th align="center" class="blue" nowrap> 计划ID号 </th>
		<th align="center" class="blue" nowrap> 标题 </th>
		<th align="center" class="blue" nowrap> 起始日期 </th>
		<th align="center" class="blue" nowrap> 截止日期 </th>
		<th align="center" class="blue" nowrap> 被质检工号/流水号 </th>
		<th align="center" class="blue" nowrap> 被检对象类别 </th>
		<th align="center" class="blue" nowrap> 计划类别 </th>
		<th align="center" class="blue" nowrap> 考评内容 </th>
		<th align="center" class="blue" nowrap> 考评类别 </th>
		<th align="center" class="blue" nowrap> 考评方式 </th>
		<th align="center" class="blue" nowrap> 计划次数 </th>
		<th align="center" class="blue" nowrap> 最低门限 </th>
		<th align="center" class="blue" nowrap> 最高门限 </th>
		</tr>

          <% for ( int i = 0; i < dataRows.length; i++ ) {
                String tdClass="blue";
           %>
          <%if((i+1)%2==1){
          tdClass="blue";
          %>
          <tr onClick="changeColor('<%=tdClass%>',this,'primarykey<%=i%>');">
			<%}else{%>
	   <tr onClick="changeColor('<%=tdClass%>',this,'primarykey<%=i%>');">
	<%}%>
      <td align="center" class="<%=tdClass%>">
      	<input type="radio" name="primarykey" id="primarykey<%=i%>" value="<%=dataRows[i][14]%>"/>
      </td>
      <td align="center" class="<%=tdClass%>"><%=(dataRows[i][0].length()!=0)?dataRows[i][0]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"><%=(dataRows[i][1].length()!=0)?dataRows[i][1]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"><%=(dataRows[i][2].length()!=0)?dataRows[i][2]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"><%=(dataRows[i][3].length()!=0)?dataRows[i][3]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"><%=(dataRows[i][15].length()!=0)?dataRows[i][15]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"><%=(dataRows[i][4].length()!=0)?dataRows[i][4]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>">
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
      <td align="center" class="<%=tdClass%>"><%=(dataRows[i][6].length()!=0)?dataRows[i][6]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>">
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
      <td align="center" class="<%=tdClass%>">
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
      <td align="center" class="<%=tdClass%>"><%=(dataRows[i][9].length()!=0)?dataRows[i][9]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"><%=(dataRows[i][10].length()!=0)?dataRows[i][10]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"><%=(dataRows[i][11].length()!=0)?dataRows[i][11]:"&nbsp;"%></td>      
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

	<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
	  <td id="footer"  align=left>
	
		<input class="b_foot" name="modifyOne" type="button"  value="修改" onclick="mendCheck();" >
		<input class="b_foot" name="deletOne" type="button"  value="删除" onclick="deleteCheck();" >
	</td>
	</tr>
	</table>

</div>
</form>
</div>
</body>
</html>

<script language="javascript">

function setPlanNo(planNo)
{
  document.getElementById("checkPlanNo").value = document.getElementById("plan_id"+planNo).value;
  document.getElementById("content_id").value  = document.getElementById("content_id"+planNo).value;
  document.getElementById("object_id").value   = document.getElementById("object_id"+planNo).value;
  document.getElementById("login_id").value    = document.getElementById("login_id"+planNo).value;
}

function submitQcContent(){
		var height = 700;
		var width = 1000;
		var top = screen.availHeight/2 - height/2;
		var left=screen.availWidth/2 - width/2;
		var winParam = "height=" + height + ",width=" + width + ",top=" + top + ",left= " + left + ",toolbar=yes,menubar=no,scrollbars=yes, resizable=yes,location=no, status=no";
	  window.open("../../../../npage/callbosspage/checkWork/K310/K310_qc_main.jsp", "outHelp", winParam);
}

function viewCheck1(){
	 var planNo=document.getElementById("checkPlanNo").value;

	if(planNo=='')
	{
	similarMSNPop("没有选择要查看的记录！");
	return false;
	}
	var height = 300;
	var width = 420;
	var top = screen.availHeight/2 - height/2;
	var left=screen.availWidth/2 - width/2;
	var winParam = "height=" + height + ",width=" + width + ",top=" + top + ",left= " + left + ",toolbar=yes,menubar=no,scrollbars=yes, resizable=yes,location=no, status=no";
	window.open("../../../../npage/callbosspage/checkWork/K310/K310_query_detail_checkPerson.jsp?plan_id="+planNo, "outHelp", winParam);
}
</script>