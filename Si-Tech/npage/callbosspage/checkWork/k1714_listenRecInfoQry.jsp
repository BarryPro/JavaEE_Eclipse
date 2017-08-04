<%
  /*
   * 功能: 听取录音情况查询
　 * 版本: 1.0
　 * 日期: 2008/10/17
　 * 作者: hanjc
　 * 版权: sitech
   *  
 　*/
 %>
<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,com.sitech.boss.util.excel.*"%>

<%!
//导出Excel
    void toExcel(String[][] queryList,String[] strHead,HttpServletResponse response){
   			System.out.println( " 开始导出Excel文件 " );
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
           System.out.println( " 导出Excel文件[成功] ");
        }catch  (Exception e1) {
        e1.printStackTrace();
           System.out.println( " 导出Excel文件[失败] ");
        } 
    }
    
%>

<%
    String opCode="k1714";
    String opName="综合查询-听取录音情况查询";
	  String loginNo = (String)session.getAttribute("workNo");  
	  String orgCode = (String)session.getAttribute("orgCode"); 
    String beginTime    =  request.getParameter("beginTime");        //开始时间
    String endTime      =  request.getParameter("endTime");          //结束时间
    String logNo        =  request.getParameter("logNo");            //工号
    String sysNo        =  request.getParameter("sysNo");            //流水号
    String[][] dataRows = new String[][]{};
    int rowCount=0;
    int pageSize = 2;            // Rows each page
    int pageCount=0;               // Number of all pages
    int curPage=0;                 // Current page
    String strPage="";               // Transfered pages
    String sqlStr="";
    String action = request.getParameter("myaction");
    String expFlag = request.getParameter("exp"); 
    String[] strHead= {"流水号","工号","时间","文件路径"};
System.out.println("=========action======="+action);
		String sqlFilter = request.getParameter("sqlFilter");
System.out.println("=========sqlFilter=========="+sqlFilter);
    if(sqlFilter==null || sqlFilter.trim().length()==0){
   	 if(beginTime!=null &&!beginTime.trim().equals("")&& endTime!=null&& !endTime.trim().equals("")){
       sqlFilter = " where to_char(listentime,'yyyyMMdd') > '"+beginTime.trim()+"' and to_char(listentime,'yyyyMMdd') < '"+endTime.trim()+"' ";
       if(logNo!=null && !logNo.trim().equals("")){
          sqlFilter = sqlFilter+" and login_no = '"+logNo.trim()+"'";
       }
       if(sysNo!=null && !sysNo.trim().equals("")){
          sqlFilter = sqlFilter+" and serial_no ='"+sysNo.trim()+"'";
       }
     }
    }
    
    if ("doLoad".equals(action)) {
       String sqlTemp = "select to_char(count(*)) count  from dlistenrecord "+sqlFilter;
%>	
					<wtc:service name="s151Select" outnum="1">
						<wtc:param value="<%=sqlTemp%>"/>
					</wtc:service>
					<wtc:array id="rowsC4" scope="end"/>	
<% 
				if(rowsC4.length!=0){
	      	rowCount = Integer.parseInt(rowsC4[0][0]);
	      }
System.out.println("\n\n=====sqlTemp==========="+sqlTemp);
System.out.println("\n\n=====rowCount==========="+rowCount);
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
        sqlStr = "select serial_no,login_no,to_char(listentime,'yyyy-MM-dd hh24:mi:ss'),filepath from dlistenrecord "+sqlFilter+" order by listentime desc";     
        String querySql = PageFilterSQL.getOraQuerySQL(sqlStr,String.valueOf(curPage),String.valueOf(pageSize),String.valueOf(rowCount));
System.out.println("\n\n=======beginTime+endTime============="+beginTime+"+"+endTime);
System.out.println("\n\n=======sqlStr:"+sqlStr);
%>	
					<wtc:service name="s151Select" outnum="5">
						<wtc:param value="<%=querySql%>"/>
					</wtc:service>
					<wtc:array id="queryList"  start="1" length="4" scope="end"/>	
<% 
					dataRows=queryList;
//System.out.println("queryList.length="+queryList.length);
   } 
   
   //导出当前显示数据
   if("cur".equalsIgnoreCase(expFlag)){    
 				String sqlTemp = "select to_char(count(*)) count from dlistenrecord "+sqlFilter;
%>	
					<wtc:service name="s151Select" outnum="1">
						<wtc:param value="<%=sqlTemp%>"/>
					</wtc:service>
					<wtc:array id="rowsC4" scope="end"/>	
<% 
				if(rowsC4.length!=0){
	      	rowCount = Integer.parseInt(rowsC4[0][0]);
	      }
System.out.println("\n\n=====sqlTemp==========="+sqlTemp);
System.out.println("\n\n=====rowCount==========="+rowCount);
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
        sqlStr = "select serial_no,login_no,to_char(listentime,'yyyy-MM-dd hh24:mi:ss'),filepath from dlistenrecord "+sqlFilter+" order by listentime desc";     
        String querySql = PageFilterSQL.getOraQuerySQL(sqlStr,String.valueOf(curPage),String.valueOf(pageSize),String.valueOf(rowCount));
System.out.println("\n\n====qqq===querySql:"+querySql);
%>	
					<wtc:service name="s151Select" outnum="5">
						<wtc:param value="<%=querySql%>"/>
					</wtc:service>
					<wtc:array id="queryList"  start="1" length="4" scope="end"/>	
<% 
				System.out.println("\n\n====qqq===queryList.length:"+queryList.length);
				this.toExcel(queryList,strHead,response);
   }
   if("all".equalsIgnoreCase(expFlag)){    
				
				sqlStr = "select serial_no,login_no,to_char(listentime,'yyyy-MM-dd hh24:mi:ss'),filepath from dlistenrecord "+sqlFilter+" order by listentime desc";     
%>	
					<wtc:service name="s151Select" outnum="5">
						<wtc:param value="<%=sqlStr%>"/>
					</wtc:service>
					<wtc:array id="queryList" start="0" length="5" scope="end"/>	
<% 
				this.toExcel(queryList,strHead,response);
   }   
%>

<html>
<head>
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
  else if(document.sitechform.logNo.value == ""){
		showTip(document.sitechform.logNo,"工号不能为空！请从新选择后输入");
		sitechform.logNo.focus();
    }    
    else {
    	
    hiddenTip(document.sitechform.beginTime);
    hiddenTip(document.sitechform.endTime);
    hiddenTip(document.sitechform.logNo);
    window.sitechform.sqlFilter.value="";//清空已保存的sqlFilter的值
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
  if(e[i].type=="select-one"||e[i].type=="text")
   e[i].value="";
 }
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
   window.sitechform.action="k1714_listenRecInfoQry.jsp";
   window.sitechform.method='post';
   window.sitechform.submit();
    }
function getCallListen(id){
//var a=window.showModalDialog("k170_getCallListen.jsp?flag_id="+id,window,"dialogHeight: 650px; dialogWidth: 850px;");
window.open("k170_getCallListen.jsp?flag_id="+id);
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
}
</script>
<script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js"></script>
</head>


<body >
<form id=sitechform name=sitechform>
<%@ include file="/npage/include/header.jsp"%>
	<div id="Operation_Table">
		<div class="title">查询条件</div>
		<table cellspacing="0">
    <!-- THE FIRST LINE OF THE CONTENT -->
     <tr >
	    <td > 开始时间 </td>
	    <td >
				<input id="beginTime" name="beginTime" type="text" readonly value="<%=(beginTime==null)?"":beginTime%>" onclick="WdatePicker({dateFmt:'yyyyMMdd'});hiddenTip(document.sitechform.beginTime);">
				<img onclick="WdatePicker({el:$dp.$('beginTime'),dateFmt:'yyyyMMdd'});hiddenTip(document.sitechform.beginTime);" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
				<font color="orange">*</font>
	    </td>
	   	<td > 结束时间 </td>
	    <td>
			  <input name ="endTime" type="text" id="endTime" readonly value="<%=(endTime==null)?"":endTime%>" onclick="WdatePicker({dateFmt:'yyyyMMdd'});hiddenTip(document.sitechform.endTime);">
			  <img onclick="WdatePicker({el:$dp.$('endTime'),dateFmt:'yyyyMMdd'});hiddenTip(document.sitechform.endTime);" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
			  <font color="orange">*</font>
		  </td>  
		  <td > 工号 </td>
	    <td >
			  <input name="logNo" type="text" value=<%=(logNo==null)?"":logNo%>>
			  <font color="orange">*</font>
	    </td>
		  <td> 流水号</td>
	    <td>
			  <input name ="sysNo" type="text" id="sysNo" value=<%=(sysNo==null)?"":sysNo%>>
		  </td>  
	   </tr>
        <!-- ICON IN THE MIDDLE OF THE PAGE-->
    <tr >
      <td colspan="8" align="left" id="footer">
        <input name="clear" type="button"  id="clear" value="重设" onClick="clearValue()">
        
       <input name="search" type="button"  id="search" value="查询" onClick="submitInput()"> &nbsp;&nbsp;
       
        <input name="toOut" type="button"  id="toOut" value="导出" <%if(dataRows.length!=0) out.print("onClick=\"expExcel('cur')\"");%>>
	
       <input name="toOutAll" type="button"  id="toOutAll" value="导出全部" <%if(dataRows.length!=0) out.print("onClick=\"expExcel('all')\"");%>>
       
      </td>
    </tr>
		</table>    
	</div>
  <div id="Operation_Table">
			  <table  cellspacing="0">
    <tr >
      <td class="blue"  align="left" >
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
        <input type="hidden" name="sqlFilter"  value="">
			  <input type="hidden" name="page" value="">
			  <input type="hidden" name="myaction" value="">
			  
          <tr >
            <th align="center" class="blue" width="60"  > 操作 </th>
            <th align="center" class="blue" width="80" > 流水号 </th>
            <th align="center" class="blue" width="120" > 工号 </th>
            <th align="center" class="blue" width="120" > 时间 </th>
            <th align="center" class="blue" width="180" > 文件路径 </th>
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
      <td align="center" class="<%=tdClass%>"  >
         <img onclick="getCallListen('<%=dataRows[i][0]%>');return false;" alt="听取语音" src="<%=request.getContextPath()%>/images/callimage/1.GIF" width="16" height="22" align="absmiddle">
      </td>
      <td align="center" class="<%=tdClass%>"  >
      	<%=dataRows[i][0]%>
      </td>
      <td align="center" class="<%=tdClass%>"  ><%=dataRows[i][1]%></td>
      <td align="center" class="<%=tdClass%>"  ><%=dataRows[i][2]%></td>
      <td align="center" class="<%=tdClass%>"  ><%=dataRows[i][3]%></td>
    </tr>
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
</div>
</form>
<%@ include file="/npage/include/footer.jsp"%>
</body>
</html>

