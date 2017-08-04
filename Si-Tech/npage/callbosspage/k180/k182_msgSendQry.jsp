<%
  /*
   * 功能: 通知发送查询
　 * 版本: 1.0
　 * 日期: 2008/10/17
　 * 作者: hanjc
　 * 版权: sitech
   * modify by yinzx 20091124 sql 语句优化
 　*/
 %>
<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/callbosspage/K098/checkpermission.jsp" %>
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
    String opCode="k182";
    String opName="媒体查询-通知发送查询";
	  String loginNo = (String)session.getAttribute("workNo");  
	      /*midify by yinzx 20091113 公共查询服务替换*/
    String myParams=request.getParameter("para");     
    String orgCode = (String)session.getAttribute("orgCode");
 	  String regionCode = orgCode.substring(0,2);

    String beginTime   = request.getParameter("beginTime");            //开始时间
    String endTime     = request.getParameter("endTime");              //结束时间
    String sendLogno   = request.getParameter("sendLogno");            //发送工号
    String recvLogno   = request.getParameter("recvLogno");            //接受工号
    String sendContent = request.getParameter("sendContent");          //通知内容
    String[][] dataRows = new String[][]{};
    String[][] dataTemp = new String[][]{};
    int rowCount=0;
    int pageSize = 15;            // Rows each page
    int pageCount=0;               // Number of all pages
    int curPage=0;                 // Current page
    String strPage="";               // Transfered pages
    String sqlStr="";
    String[] strHead= {"发送工号","接收工号","通知内容","发送时间","消息类别"};
    String action = request.getParameter("myaction");
	  String expFlag = request.getParameter("exp");        //导出标示
	  String sqlFilter = request.getParameter("sqlFilter");
	  if(sqlFilter==null || sqlFilter.trim().length()==0){
	    if(beginTime!=null&&!beginTime.trim().equals("")&&endTime!=null&&!endTime.trim().equals("")){
	      sqlFilter = " where send_time >  to_date(:beginTime ,'yyyyMMdd hh24:mi:ss') and send_time < to_date(:endTime,'yyyyMMdd hh24:mi:ss')  ";
			  myParams="beginTime="+beginTime.trim()+",endTime="+endTime.trim();
			  if(sendLogno!=null && !sendLogno.trim().equals("")){
           sqlFilter = sqlFilter+" and send_login_no = :sendLogno";
           myParams+=",sendLogno="+sendLogno.trim();
         }
         if(recvLogno!=null && !recvLogno.trim().equals("")){
           sqlFilter = sqlFilter+" and receive_login_no =:recvLogno";
           myParams+=",recvLogno="+recvLogno.trim();
         }
         if(sendContent!=null && !sendContent.trim().equals("")){
           sqlFilter = sqlFilter+" and content like '%'||:sendContent||'%'";
           myParams+=",sendContent="+sendContent.trim();
         }
      }
     }
    if ("doLoad".equals(action)) {
        String sqlTemp = "select to_char(count(*)) count  from dnoticecontent "+sqlFilter;
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
        sqlStr = "select msg_id,send_login_no,receive_login_no,content,to_char(send_time,'yyyy-MM-dd hh24:mi:ss'),decode(msg_type,'0','一般通知','1','请求通知') from dnoticecontent "+sqlFilter+" order by send_time desc";     
        String querySql = PageFilterSQL.getOraQuerySQL(sqlStr,String.valueOf(curPage),String.valueOf(pageSize),String.valueOf(rowCount));
%>	
					<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="7">
						<wtc:param value="<%=querySql%>"/>
						<wtc:param value="<%=myParams%>"/>
					</wtc:service>
					<wtc:array id="queryList"  start="0" length="6" scope="end"/>	
<% 
					dataRows=queryList;
    
}


    //导出当前显示数据
   if("cur".equalsIgnoreCase(expFlag)){    
 				String sqlTemp = "select to_char(count(*)) count  from dnoticecontent "+sqlFilter;
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
        sqlStr = "select msg_id,send_login_no,receive_login_no,content,to_char(send_time,'yyyyMMdd hh24:mi:ss'),msg_type from dnoticecontent "+sqlFilter+" order by send_time desc";     
        String querySql = PageFilterSQL.getOraQuerySQL(sqlStr,String.valueOf(curPage),String.valueOf(pageSize),String.valueOf(rowCount));
%>	
					<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="7">
						<wtc:param value="<%=querySql%>"/>
						<wtc:param value="<%=myParams%>"/>
					</wtc:service>
					<wtc:array id="queryList"  start="1" length="6" scope="end"/>	
<% 
				this.toExcel(queryList,strHead,response);
   }
   if("all".equalsIgnoreCase(expFlag)){    
				sqlStr = "select msg_id,send_login_no,receive_login_no,content,to_char(send_time,'yyyyMMdd hh24:mi:ss'),msg_type from dnoticecontent "+sqlFilter+" order by send_time desc";     

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
<title>通知发送查询</title>
<script language=javascript>
	$(document).ready(
		function()
		{
	    $("tr").not("[input]").addClass("blue");
	    $("th").css("color","#3366FF").css("font-weight","bold");
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
    } else if(document.sitechform.endTime.value.substring(0,6)>document.sitechform.beginTime.value.substring(0,6)){
		     showTip(document.sitechform.endTime,"只能查询本月内的记录"); 
    	   sitechform.endTime.focus(); 	
    }
   else {
    hiddenTip(document.sitechform.beginTime);
    hiddenTip(document.sitechform.endTime);
    window.sitechform.sqlFilter.value="";//清空已保存的sqlFilter的值
    window.sitechform.sqlWhere.value="<%=sqlFilter%>";  
    doSubmit();
    }
}
function doSubmit(){
    window.sitechform.myaction.value="doLoad";
    window.sitechform.action="k182_msgSendQry.jsp";
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
   window.sitechform.action="k182_msgSendQry.jsp";
   window.sitechform.method='post';
   window.sitechform.submit();
    }
//清除表单记录
function clearValue(){
var e = document.forms[0].elements;
for(var i=0;i<e.length;i++){
  if(e[i].type=="select-one"||e[i].type=="text"||e[i].type=="hidden"){
  	if(e[i].id=="beginTime"){
	  	e[i].value='<%=getCurrDateStr("00:00:00")%>';
	  }else if(e[i].id=="endTime"){
	  	e[i].value='<%=getCurrDateStr("23:59:59")%>';
	  }else{
	  	e[i].value="";
	  }
  }else if(e[i].type=="checkbox"){
  	e[i].checked=false;
  }
 }
 window.location="k182_msgSendQry.jsp";
}

//导出
function expExcel(expFlag){
	  document.sitechform.action="<%=request.getContextPath()%>/npage/callbosspage/k180/k182_msgSendQry.jsp?exp="+expFlag;
	  keepValue();
    window.sitechform.page.value=<%=curPage%>;
    document.sitechform.method='post';
    document.sitechform.submit();
}

function keepValue(){
	window.sitechform.sqlFilter.value="<%=sqlFilter%>";
	window.sitechform.beginTime.value="<%=beginTime%>";
	window.sitechform.endTime.value="<%=endTime%>";
	window.sitechform.sendLogno.value="<%=sendLogno%>";
	window.sitechform.sendContent.value="<%=sendContent%>";
	window.sitechform.recvLogno.value="<%=recvLogno%>";
	window.sitechform.para.value="<%=myParams%>";
}

function deleteCheck(msg_id){
	if(rdShowConfirmDialog("你确定需要删除这条记录吗？")=="1"){
		deleteRec(msg_id);
	}
}
//删除记录
function deleteRec(msg_id){
	var mypacket = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/k180/k182_modifyMsgSend.jsp","正在删除相关记录，请稍候......");
	mypacket.data.add("msg_id",msg_id);
  core.ajax.sendPacket(mypacket,doProcess,true);
	mypacket=null;
}

function doProcess(packet){
	var retCode = packet.data.findValueByName("retCode");
	if(retCode=="00000"){
		rdShowMessageDialog("删除成功！",2);
		window.sitechform.myaction.value="doLoad";
    keepValue();
    window.sitechform.action="k182_msgSendQry.jsp";
    window.sitechform.method='post';
    document.sitechform.submit();
	}else{
		rdShowMessageDialog("删除失败！");
	}
}
	
	//居中打开窗口
	function openWinMid(url,name,iHeight,iWidth)
	{
	  var iTop = (window.screen.availHeight-30-iHeight)/2; //获得窗口的垂直位置;
	  var iLeft = (window.screen.availWidth-10-iWidth)/2; //获得窗口的水平位置;
	  window.open(url,name,'height='+iHeight+',innerHeight='+iHeight+',width='+iWidth+',innerWidth='+iWidth+',top='+iTop+',left='+iLeft+',toolbar=no,menubar=no,scrollbars=yes,resizeable=no,location=no,status=no');
	}
	//导出窗口
	function showExpWin(flag){
		window.sitechform.page.value="<%=curPage%>";
	  window.sitechform.sqlWhere.value="<%=sqlFilter%>"; 
	  window.sitechform.para.value="<%=myParams%>";
		openWinMid('k182_expSelect.jsp?flag='+flag,'选择导出列',340,320);
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

function showMsg(msg){
	openWinMid('k181_showMsg.jsp?msg='+msg+'&titlename=通知','选择导出列',160,320);
}
</script>
<script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js"></script>
</head>

<body >
<form id=sitechform name=sitechform>
<!--
<%@ include file="/npage/include/header.jsp"%>
-->
	<div id="Operation_Table" style="width: 100%;">
		<table cellspacing="0">
    <tr><td colspan='6' ><div class="title"><div id="title_zi">通知发送查询</div></div></td></tr>
      <tr >
	     <td > 开始时间 </td>
	     <td >
				<input id="beginTime" name="beginTime" type="text" value="<%=(beginTime==null)?getCurrDateStr("00:00:00"):beginTime%>" onclick="WdatePicker({dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});hiddenTip(document.sitechform.beginTime);">
				<img onclick="WdatePicker({el:$dp.$('beginTime'),dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});hiddenTip(document.sitechform.beginTime);" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
				<font color="orange">*</font>
	     </td>
	     <td > 发送工号 </td>
	     <td >
	     <!--zhengjiang 20091010 增加onkeyup="value=value.replace(/[^kf\d]/g,'');"和onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^kf\d]/g,''))"-->
			  <input name="sendLogno" id="sendLogno" type="text" onkeyup="value=value.replace(/[^kf\d]/g,'');" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^kf\d]/g,''))" value=<%=(sendLogno==null)?"":sendLogno%>>
	     </td>
	     <td > 通知内容 </td>
	     <td >
			  <input name="sendContent" id="sendContent" type="text" value=<%=(sendContent==null)?"":sendContent%>>
	     </td>
	   </tr>
	   <!-- THE SECOND LINE OF THE CONTENT -->
	   <tr >
	     <td > 结束时间 </td>
	     <td>
			  <input name ="endTime" type="text" id="endTime"  value="<%=(endTime==null)?getCurrDateStr("23:59:59"):endTime%>"  onclick="WdatePicker({dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});hiddenTip(document.sitechform.endTime);">
			  <img onclick="WdatePicker({el:$dp.$('endTime'),dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});hiddenTip(document.sitechform.endTime);" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
			  <font color="orange">*</font>
		  </td>     
		  <td> 接收工号</td>
	     <td>
	     <!--zhengjiang 20091010 增加onkeyup="value=value.replace(/[^kf\d]/g,'');"和onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^kf\d]/g,''))"-->
			  <input name ="recvLogno" type="text" id="recvLogno" onkeyup="value=value.replace(/[^kf\d]/g,'');" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^kf\d]/g,''))" value=<%=(recvLogno==null)?"":recvLogno%>>
		  </td>  
		  <td >&nbsp;&nbsp;</td>
	     <td>&nbsp;&nbsp;
		  </td>     
	    </tr>

        <!-- ICON IN THE MIDDLE OF THE PAGE-->
    <tr >
      <td colspan="8" align="left" id="footer" style="width:50em">
       <!--zhengjiang 20091004 查询与重置换位置--> 
       <input name="search" type="button"  id="search" value="查询" onClick="submitInput()">
       <input name="clear" type="button"  id="clear" value="重置" onClick="clearValue()">
        <input name="export" type="button"  id="search" value="导出" <%if(dataRows.length!=0) out.print("onClick=\"showExpWin('cur')\"");%>>
       
      </td>
    </tr>
		</table>    
	</div>
	
	
  <div id="Operation_Table">
	<table  cellspacing="0" width="90%">
    <tr >
      <td class="blue"  align="left" colspan="5">
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

        <input type="hidden" name="chkBoxNum"  value="<%=dataRows.length%>">
			  <input type="hidden" name="page" value="">
			  <input type="hidden" name="myaction" value="">
			  <input type="hidden" name="sqlFilter" value="">
			  <input type="hidden" name="sqlWhere" value="">
			  <input type="hidden" name="para" value="">
			  
        <tr >
        <script>
       	var tempBool ='flase';
      	if(checkRole(K182A_RolesArr)==true){	
      		document.write('<th align="center" class="blue" width="15%" > 操作 </th>');	
      		tempBool='true';
      	}
        </script>  
            <th align="center" class="blue" width="20%" > 发送工号 </th>
            <th align="center" class="blue" width="20%" > 接收工号 </th>
            <th align="center" class="blue" width="20%" > 通知内容 </th>
            <th align="center" class="blue" width="20%" > 发送时间 </th>
            <th align="center" class="blue" width="20%" > 消息类别 </th>
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
      	if(checkRole(K182A_RolesArr)==true){	
      		document.write('<img style="cursor:hand" onclick="deleteCheck(\'<%=dataRows[i][0]%>\');return false;" alt="删除记录" src="<%=request.getContextPath()%>/nresources/default/images/callimage/operImage/del.gif"  align="absmiddle">');	
      	}
        if(tempBool=='true'){
      		document.write('</td>');
      	}
      </script>
      <!--	
      <td align="center" class="<%=tdClass%>"  >
        <img style="cursor:hand" onclick="deleteCheck('<%=dataRows[i][0]%>');return false;" alt="删除记录" src="<%=request.getContextPath()%>/nresources/default/images/callimage/operImage/del.gif"  align="absmiddle">
      </td>
      -->
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][1].length()!=0)?dataRows[i][1]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][2].length()!=0)?dataRows[i][2]:"&nbsp;"%></td>
<td align="center" class="<%=tdClass%>" <%if(dataRows[i][3].length()>25){out.print("onClick=\"showMsg('"+dataRows[i][3]+"')\" style=\"cursor:hand\"");}%> ><%=(dataRows[i][3].length()!=0)?(dataRows[i][3].length()>25?dataRows[i][3].substring(0,15)+"...":dataRows[i][3]):"&nbsp;"%></td>      
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][4].length()!=0)?dataRows[i][4]:"&nbsp;"%></td>
      <td align="center" class="<%=tdClass%>"  ><%=(dataRows[i][5].length()!=0)?dataRows[i][5]:"&nbsp;"%></td>
      <% } %>

    <tr >
      <td class="blue"  align="right" colspan="5">
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

