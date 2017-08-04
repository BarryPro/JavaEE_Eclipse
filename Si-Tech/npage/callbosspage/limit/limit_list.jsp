<%
  /*
   * 功能: 设置呼叫限制
　 * 版本: 1.8.2
　 * 日期: 2008/12/21
　 * 作者: tancf
　 * 版权: sitech
　*/
%>
<%
		String opCode = "";
		String opName = "设置呼叫限制";
%>
<%@ page contentType="text/html;charset=gb2312"%>

<%   
		String    errCode ="";
		String    errMsg = " ";
		

	 
%>	

<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,com.sitech.boss.util.excel.*"%>
<%!
//导出Excel
    public void toExcel(String[][] queryList,String[] strHead,HttpServletResponse response){
        XLSExport e  =   new  XLSExport(null);
        String headname = "";//Excel文件名
        try {
        OutputStream os = response.getOutputStream();//取得输出流
        response.reset();//清空输出流
        response.setContentType("application/ms-excel");//定义输出类型
        response.setHeader("Content-disposition", "attachment; filename="+XLSExport.gbToUtf8(headname)+".xls");//设定输出文件头
				int intMaxRow=5000+1;
				ArrayList datalist = new ArrayList();
				for(int i=0;i<queryList.length;i++){
				    String[] dateSour={queryList[i][0],queryList[i][0],queryList[i][0],queryList[i][0],queryList[i][0]};
				    datalist.add(dateSour);
		    }
				XLSExport.excelExport(e, os, strHead, datalist, intMaxRow);
           e.exportXLS(os);
           System.out.println( " 导出Excel文件[成功] ");
        }catch  (Exception e1) {
           System.out.println( " 导出Excel文件[失败] ");
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
    String action = "doLoad";
		String expFlag = request.getParameter("exp");        //导出标示
		
		String firstValue = request.getParameter("firstValue")==null?"":request.getParameter("firstValue"); 
		String secondValue = request.getParameter("secondValue")==null?"":request.getParameter("secondValue");
		String thirdValue = request.getParameter("thirdValue")==null?"":request.getParameter("thirdValue"); 
		String checkRadio=request.getParameter("checkRadio")==null?"0":request.getParameter("checkRadio");
		String sqlFilter = request.getParameter("sqlFilter")==null?"":request.getParameter("sqlFilter");
    //查询条件
    
	   if(sqlFilter==null || sqlFilter.trim().length()==0){
	   if(checkRadio.equals("0")){
	  	if(firstValue!=null&&!firstValue.trim().equals("")){
      sqlFilter=sqlFilter+"  and  t1.kf_login_no='"+firstValue+"' ";
    	}
    	}
    	if(checkRadio.equals("1")){
	  	if(secondValue!=null&&!secondValue.trim().equals("")){
      sqlFilter=sqlFilter+"  and  to_number(t1.kf_login_no) >='"+secondValue+"' ";
    	}
	  	if(thirdValue!=null&&!thirdValue.trim().equals("")){
      sqlFilter=sqlFilter+"  and  to_number(t1.kf_login_no) <='"+thirdValue+"' ";
    	}    	
    	}
    } 
    
	
    
    //符合条件的记录条数
    if ("doLoad".equals(action)) {
 
        
        String sqlTemp = "select count(*) from dloginmsgrelation t1,dloginmsg t2 where t1.BOSS_LOGIN_NO=t2.LOGIN_NO "+sqlFilter;                                
 System.out.println("=========sqlTemp=========="+sqlTemp);
%>


	<wtc:service name="s151Select" outnum="1">
	<wtc:param value="<%=sqlTemp%>"/>
</wtc:service>
		<wtc:array id="rowsC4" scope="end"/>
<%
	if(rowsC4.length!=0){
	  	rowCount = Integer.parseInt(rowsC4[0][0]);
	}
	
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
	sqlStr = "select  distinct(t1.kf_login_no),t2.login_no,t2.login_name, decode(t3.kf_login_no, null, 0, 1) from dloginmsgrelation t1, dloginmsg t2, (select kf_login_no from DCALLLOGINMENU where auth_id = 'K014') t3 where t1.BOSS_LOGIN_NO = t2.LOGIN_NO and t3.kf_login_no(+) = t1.kf_login_no "+sqlFilter+ "order by t1.KF_LOGIN_NO asc";
   System.out.println(sqlStr);       
	String querySql = PageFilterSQL.getOraQuerySQL(sqlStr,String.valueOf(curPage),String.valueOf(pageSize),String.valueOf(rowCount));

%>



	<wtc:service name="s151Select" outnum="12">
	<wtc:param value="<%=querySql%>"/>
</wtc:service>
<wtc:array id="queryList"   scope="end"/>

<%
System.out.println("=================================================================");
System.out.println(queryList.length);
System.out.println("=================================================================");
dataRows=queryList;
}


//获得当前展示行数
if("cur".equalsIgnoreCase(expFlag)){
String sqlTemp = "select count(*) from dloginmsgrelation t1,dloginmsg t2 where t1.BOSS_LOGIN_NO=t2.LOGIN_NO "+sqlFilter;                                
System.out.println("sqlTemp"+sqlTemp);
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
        sqlStr = "select  distinct(t1.kf_login_no),t2.login_no,t2.login_name, decode(t3.kf_login_no, null, 0, 1) from dloginmsgrelation t1, dloginmsg t2, (select kf_login_no from DCALLLOGINMENU where auth_id = 'K014') t3 where t1.BOSS_LOGIN_NO = t2.LOGIN_NO and t3.kf_login_no(+) = t1.kf_login_no "+sqlFilter+ " order by t1.KF_LOGIN_NO asc";
        String querySql = PageFilterSQL.getOraQuerySQL(sqlStr,String.valueOf(curPage),String.valueOf(pageSize),String.valueOf(rowCount));
System.out.println("sqlStr"+sqlStr);
%>


<wtc:service name="s151Select" outnum="12">
	<wtc:param value="<%=querySql%>"/>
</wtc:service>
		<wtc:array id="queryList"   scope="end"/>
<%
		this.toExcel(queryList,strHead,response);
}
   
   if("all".equalsIgnoreCase(expFlag)){
	sqlStr = "select  distinct(t1.kf_login_no),t2.login_no,t2.login_name, decode(t3.kf_login_no, null, 0, 1)  from dloginmsgrelation t1, dloginmsg t2, (select kf_login_no from DCALLLOGINMENU where auth_id = 'K014') t3 where t1.BOSS_LOGIN_NO = t2.LOGIN_NO and t3.kf_login_no(+) = t1.kf_login_no "+sqlFilter+ " order by t1.KF_LOGIN_NO asc";
	
	System.out.println("\n\n===全部====sqlStr:"+sqlStr);
%>


	<wtc:service name="s151Select" outnum="12">
	<wtc:param value="<%=sqlStr%>"/>
</wtc:service>
	<wtc:array id="queryList" start="0" length="12" scope="end"/>
<%
	this.toExcel(queryList,strHead,response);
   }
%>

<html>
<head>
<title>设置呼叫限制</title>
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
function submitInputCheck(){
		var checkRadio1=document.all.checkRadio;
	if(checkRadio1[1].checked)
	{
   if(document.sitechform.thirdValue.value*1<=document.sitechform.secondValue.value*1){
		 showTip(document.sitechform.thirdValue,"结尾工号必须大于起始工号");
		 sitechform.thirdValue.focus(); 
    }
    else{
    window.sitechform.sqlFilter.value="";//清空已保存的sqlFilter的值
    doSubmit();
  }
  }
  else
  	{
    window.sitechform.sqlFilter.value="";//清空已保存的sqlFilter的值
    doSubmit();
  }
}
function doSubmit(){
    window.sitechform.myaction.value="doLoad";
    window.sitechform.action="limit_list.jsp";
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
   window.sitechform.action="limit_list.jsp";
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
}




/**
  *进行处理
  */
function doSelect(keyValue){
	if(keyValue.checked)
	{
	      var totalValue=keyValue.value;
				var kf_no=totalValue.substring(0,totalValue.indexOf("&"));
				var boss_no=totalValue.substring(totalValue.indexOf("&")+2,totalValue.length);
				var mypacket = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/limit/limit_do.jsp","...");
				mypacket.data.add("addMode","add");
				mypacket.data.add("kf_login_no",kf_no);
				mypacket.data.add("boss_no",boss_no);
				core.ajax.sendPacket(mypacket,doProcess,true);
				mypacket=null;
	}
	else
	{
				var totalValue=keyValue.value;
				var kf_no=totalValue.substring(0,totalValue.indexOf("&"));
				var boss_no=totalValue.substring(totalValue.indexOf("&")+2,totalValue.length);
				var mypacket = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/limit/limit_do_delete.jsp","...");
				mypacket.data.add("addMode","delete");
				mypacket.data.add("kf_login_no",kf_no);
				mypacket.data.add("boss_no",boss_no);
				core.ajax.sendPacket(mypacket,doProcess,true);
				mypacket=null;		
	}
	

}
function doSelectAll()
{
	var objectChk=document.sitechform.chkSelect;
	if(objectChk.length>1)
	{
		if(objectChk[0].checked)
		{
			for(var i=0;i<objectChk.length;i++)
			{
						if(!objectChk[i].checked)
						{
							objectChk[i].checked=true;
							if(i>0)
							{
							
							var totalValue=objectChk[i].value;
							var kf_no=totalValue.substring(0,totalValue.indexOf("&"));
							var boss_no=totalValue.substring(totalValue.indexOf("&")+2,totalValue.length);
							var mypacket = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/limit/limit_do.jsp","...");
							mypacket.data.add("addMode","add");
							mypacket.data.add("kf_login_no",kf_no);
							mypacket.data.add("boss_no",boss_no);
							core.ajax.sendPacket(mypacket,doProcess,true);
							mypacket=null;
							}
						}
			}
		}
		else
			{
					for(var i=0;i<objectChk.length;i++)
					{
								if(objectChk[i].checked)
								{
									objectChk[i].checked=false;
									if(i>0)
									{
									var totalValue=objectChk[i].value;
									var kf_no=totalValue.substring(0,totalValue.indexOf("&"));
									var boss_no=totalValue.substring(totalValue.indexOf("&")+2,totalValue.length);
									var mypacket = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/limit/limit_do_delete.jsp","...");
									mypacket.data.add("addMode","delete");
									mypacket.data.add("kf_login_no",kf_no);
									mypacket.data.add("boss_no",boss_no);
									core.ajax.sendPacket(mypacket,doProcess,true);
									mypacket=null;
									}
								}
					}				
			}
	}
	else
		{
			if(objectChk.checked)
			{
			objectChk.checked=true;
			}
			else
			{
			objectChk.checked=false;
			}
		}
}

/**
  *返回处理函数
  */
function doProcess(packet){
	var retCode = packet.data.findValueByName("retCode");
	if(retCode=="000000"){
		//rdShowMessageDialog("处理成功！");

	}else{
		//rdShowMessageDialog("处理失败！");
	}
}
</script>

<script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js"></script>
</head>

<body scroll="auto">
<form id="sitechform" name="sitechform">
<%@ include file="/npage/include/header.jsp"%>
  <div id="Operation_Table">
  	<table cellspacing="0" >
  	<tr >
      <td >指定工号<input type="radio" name="checkRadio" value="0" <%if(checkRadio.equals("0")){%>checked<%}%> onclick="modifyMode();">选择范围<input type="radio" name="checkRadio" value="1" <%if(checkRadio.equals("1")){%>checked<%}%> onclick="modifyMode();">
     	   <input name="search" type="button"  id="search" value="查询" onClick="submitInputCheck();return false;">
     </td>
      </tr>
    </table>
 <div id="type11">
   <table>
     <tr>
      <td >
			  指定工号<input type="text" name="firstValue" value="<%=firstValue%>">
		
		  </td> 
		</tr>
		</table>
		</div>
    <div id="type2">
    	<table>
      <tr>
      <td >
			  起始工号<input type="text" name="secondValue" value="<%=secondValue%>">
			  结尾工号<input type="text" name="thirdValue" value="<%=thirdValue%>">
			  
		  </td> 
		  </tr>
		</table>
		</div>    
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
		<input type="hidden" name="sqlFilter" value="<%=sqlFilter%>">


     <tr>
      	<td width="33%" class="blue" >
      		<input type="checkbox" name="chkSelect" value="all" onclick="doSelectAll();">全部
      	</td>
      	<td width="33%" class="blue">
      		工号
      	</td>
      	 <td width="33%" class="blue">
      		BOSS工号
      	</td>
      	<td width="33%" class="blue">
      		姓名
      	</td>
      </tr>

          <% for ( int i = 0; i < dataRows.length; i++ ) {
                String tdClass="";
           %>
           <tr>
      	<td width="33%" class="blue" >
      		<input type="checkbox" name="chkSelect" value="<%=dataRows[i][1]%>&&<%=dataRows[i][2]%>" <%if(dataRows[i][4].equals("1")){%>checked<%}%> onclick="doSelect(this);">
      	</td>
      	<td width="33%" class="blue">
      		<%=dataRows[i][1]%>
      	</td>
      	 <td width="33%" class="blue">
      		<%=dataRows[i][2]%>
      	</td>
      	<td width="33%" class="blue">
      		<%=dataRows[i][3]%>
      	</td>
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
	rdShowMessageDialog('没有选择要查看的记录',0);
	return false;
	}
	var height = 300;
	var width = 420;
	var top = screen.availHeight/2 - height/2;
	var left=screen.availWidth/2 - width/2;
	var winParam = "height=" + height + ",width=" + width + ",top=" + top + ",left= " + left + ",toolbar=yes,menubar=no,scrollbars=yes, resizable=yes,location=no, status=no";
	window.open("../../../../npage/callbosspage/checkWork/K310/K310_query_detail_checkPerson.jsp?plan_id="+planNo, "outHelp", winParam);
}
function modifyMode()
{
	var checkRadio1=document.all.checkRadio;
	if(checkRadio1[0].checked)
	{
		document.getElementById("type11").style.display='';
		document.getElementById("type2").style.display='none';
	}
	if(checkRadio1[1].checked)
	{
		document.getElementById("type11").style.display='none';
		document.getElementById("type2").style.display='';			
	}
}
modifyMode();
</script>


