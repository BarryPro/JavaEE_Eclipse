<%
  /*
   * 功能: 显示该通话详细信息
　 * 版本: 1.0
　 * 日期: 2008/10/20
　 * 作者: hanjc
　 * 版权: sitech
   *  
 　*/
 %>
<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.* "%>

<%
    String opCode="k170";
    String opName="综合查询-来电信息-显示该通话详细信息";
	  String loginNo = (String)session.getAttribute("workNo");  
	  String orgCode = (String)session.getAttribute("orgCode"); 

    String contact_id   = request.getParameter("contact_id");            //发送工号
    String start_date   = request.getParameter("start_date"); 
    String[][] dataRows = new String[][]{};
    String[][] callResList = new String[][]{};
    String isPwdVer = "N";
    String sqlStr="";
    String tableName = request.getParameter("tableName");
    String action = request.getParameter("myaction");
   	System.out.println("=========start_date======"+start_date);
		if(start_date!=null){
			tableName="dcallcall"+start_date.substring(0,6);
		}
		
    if ("doLoad".equals(action) || contact_id!=null) {
    sqlStr = "select contact_id,to_char(BEGIN_DATE,'yyyy-MM-dd hh24:mi:ss'),caller_phone,acceptid,cust_name,accept_phone,contact_phone,fax_no,grade_code,accept_login_no,servicecity,region_code,to_char(accept_long),contact_phone,cust_name,callee_phone,mail_address,contact_address,bak,transfer_bak from "+tableName+" where contact_id="+contact_id;
    System.out.println("==========sqlStr=========="+sqlStr);
%>	
					<wtc:service name="s151Select" outnum="20">
						<wtc:param value="<%=sqlStr%>"/>
					</wtc:service>
					<wtc:array id="queryList" scope="end"/>	
<% 
    		dataRows = queryList;
    	System.out.println("==========dataRows.length========"+dataRows.length);
    	sqlStr = "select CALLCAUSEDESCS,CALL_ACCEPT_ID from "+tableName+" where CONTACT_ID="+contact_id;
%>	
					<wtc:service name="s151Select" outnum="2">
						<wtc:param value="<%=sqlStr%>"/>
					</wtc:service>
					<wtc:array id="queryList" scope="end"/>	
<% 
				callResList = queryList;
    	System.out.println("queryList============length=="+queryList.length);
    	System.out.println("sqlStr============value=="+sqlStr);

    	sqlStr = "select VERTIFY_PASSWD_FLAG from "+tableName+" where CONTACT_ID="+contact_id;
%>	
					<wtc:service name="s151Select" outnum="1">
						<wtc:param value="<%=sqlStr%>"/>
					</wtc:service>
					<wtc:array id="queryList" scope="end"/>	
<% 
					if(queryList.length!=0){
						isPwdVer = queryList[0][0];
					}
    	System.out.println("isPwdVer=="+isPwdVer);
    	System.out.println("sqlStr=====value=="+sqlStr);
}
%>

<html>
<head>
<title>显示该通话详细信息</title>
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
function submitInput(url){
   if( document.sitechform.contact_id.value == ""){
    	  showTip(document.sitechform.contact_id,"流水号不能为空！请重新选择后输入");
        sitechform.contact_id.focus();
    }   
    else {
    	
    hiddenTip(document.sitechform.contact_id);
    doSubmit(url);
    }
}
function doSubmit(url){
    window.sitechform.action=url;
    window.sitechform.method='post';
    window.sitechform.submit();
}

//关闭窗口
function closeWin(){
  window.close();	
}


</script>
<script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js"></script>
</head>

<body >
<form id=sitechform name=sitechform>
<%@ include file="/npage/include/header.jsp"%>
		<div class="title" id="footer">	 
 		流水号&nbsp;<input name="contact_id" type="text"  id="contact_id" value="<%=contact_id%>" >
   <input name="search" type="button"  id="search" value="查询" onClick="submitInput('k170_getCallDetail.jsp?myaction=doLoad')"> &nbsp;&nbsp;
   <input name="clear" type="button"  id="clear" value="关闭" onClick="closeWin()">
   <input name="tableName" type="hidden" value="<%=tableName%>">
</div>

<br>
	<div id="Operation_Table">
		<div class="title">基本信息</div>
		<table cellspacing="0">
    <!-- THE FIRST LINE OF THE CONTENT -->
      <tr >
	     <td > 流水号 </td>
	     <td ><%=(dataRows.length!=0 && dataRows[0][0].length()!=0)? dataRows[0][0]:"&nbsp;"%></td>
	     <td > 受理时间 </td>
	     <td ><%=(dataRows.length!=0 && dataRows[0][1].length()!=0)? dataRows[0][1]:"&nbsp; "%></td>
	     <td > 主叫号码 </td>
	     <td ><%=(dataRows.length!=0 && dataRows[0][2].length()!=0)? dataRows[0][2]:" &nbsp;"%></td>
	     <td > 受理方式 </td>
	     <td ><%=(dataRows.length!=0 && dataRows[0][3].length()!=0)? dataRows[0][3]:" &nbsp;"%></td>
	   </tr>
	   <!-- THE SECOND LINE OF THE CONTENT -->
	   <tr >
	     <td > 客户姓名 </td>
	     <td ><%=(dataRows.length!=0 && dataRows[0][4].length()!=0)? dataRows[0][4]:" &nbsp;"%></td>
	     <td > 受理号码 </td>
	     <td ><%=(dataRows.length!=0 && dataRows[0][5].length()!=0)? dataRows[0][5]:" &nbsp;"%></td>
	     <td > 联系电话 </td>
	     <td ><%=(dataRows.length!=0 && dataRows[0][6].length()!=0)? dataRows[0][6]:" &nbsp;"%></td>
	     <td > 传真号码 </td>
	     <td ><%=(dataRows.length!=0 && dataRows[0][7].length()!=0)? dataRows[0][7]:" &nbsp;"%></td>   
	    </tr>
	    
	  <!-- THE THIRD LINE OF THE CONTENT -->
	   <tr >
	     <td > 客户级别 </td>
	     <td ><%=(dataRows.length!=0 && dataRows[0][8].length()!=0)? dataRows[0][8]:" &nbsp;"%></td>
	     <td > 受理工号 </td>
	     <td ><%=(dataRows.length!=0 && dataRows[0][9].length()!=0)? dataRows[0][9]:" &nbsp;"%></td> 
	     <td>业务地市 </td>
	     <td ><%=(dataRows.length!=0 && dataRows[0][10].length()!=0)? dataRows[0][10]:" &nbsp;"%></td>
	     <td > 用户地市 </td>
	     <td ><%=(dataRows.length!=0 && dataRows[0][11].length()!=0)? dataRows[0][11]:" &nbsp;"%></td>   
	    </tr>
	    
	   <!-- THE FOURTH LINE OF THE CONTENT -->
	   <tr >
	     <td > 通话时长 </td>
	     <td ><%=(dataRows.length!=0 && dataRows[0][12].length()!=0)? dataRows[0][12]:" &nbsp;"%></td>
	     <td > 联系方式 </td>
	     <td ><%=(dataRows.length!=0 && dataRows[0][13].length()!=0)? dataRows[0][13]:" &nbsp;"%>
	     </td> 
	     <td >联系人 </td>
	     <td ><%=(dataRows.length!=0 && dataRows[0][14].length()!=0)? dataRows[0][14]:" &nbsp;"%>
	     </td>
	     <td > 被叫号码 </td>
	     <td ><%=(dataRows.length!=0 && dataRows[0][15].length()!=0)? dataRows[0][15]:" &nbsp;"%>
	     </td>   
	    </tr>
	    
	    <!-- THE FIFTH LINE OF THE CONTENT -->
	   <tr >
	     <td > EMail </td>
	     <td ><%=(dataRows.length!=0 && dataRows[0][16].length()!=0)?dataRows[0][16]:" &nbsp;"%></td>
	     <td > 通信地址 </td>
   			<td colspan="5"><%=(dataRows.length!=0 && dataRows[0][17].length()!=0)? dataRows[0][17]:" &nbsp;"%></td>
	    </tr>
	    
	   <!-- THE SIXTH LINE OF THE CONTENT -->
	   <tr >
	     <td > 备注 </td>
	     <td colspan="7"><%=(dataRows.length!=0 && dataRows[0][18].length()!=0)? dataRows[0][18]:" &nbsp;"%></td> 
	    </tr>
	    
	  <!-- THE SEVENTH LINE OF THE CONTENT -->
	   <tr >
	     <td > 转接备注 </td>
	     <td colspan="7"><%=(dataRows.length!=0 && dataRows[0][19].length()!=0)? dataRows[0][19]:" &nbsp;"%></td>
		</table> 

</div><br>
		<div id="Operation_Table">
		<div class="title">来电原因</div>	   
		<table cellspacing="0">
			 <tr >
	     <td ><%=(callResList.length!=0 && callResList[0][0].length()!=0)? callResList[0][0]:" &nbsp;"%></td>
	     <td > 外呼流水号 </td>
	     <td ><%=(callResList.length!=0 && callResList[0][1].length()!=0)? callResList[0][1]:" &nbsp;"%></td> 
	    </tr>
	  </table>
	</div><br>
  <div id="Operation_Table">
  	<div class="title">文字交谈内容</div>	  
			  <table  cellspacing="0">
    <tr >
			<td>
				该流水号没有对应的交谈信息
			</td>
    </tr>
  </table>
</div><br>

<div id="Operation_Table">
  	<div class="title">内容求助信息</div>	  
			  <table  cellspacing="0">
    <tr >
			<td bgcolor="white">
				该流水号没有对应的内部求助信息
			</td>
    </tr>
  </table>
</div><br>

<div id="Operation_Table">
  	<div class="title">放音信息</div>	  
			  <table  cellspacing="0">
    <tr >
			<td>
				该流水号没有对应的知识库放音信息
			</td>
    </tr>
  </table>
</div><br>

<div id="Operation_Table">
  	<div class="title">密码验证信息</div>	  
			  <table  cellspacing="0">
    <tr >
			<td>
				<%=isPwdVer.equals("Y")? "验证" : "无需验证"%>
			</td>
    </tr>
  </table>
</div>
</form>
<%@ include file="/npage/include/footer.jsp"%>
</body>
</html>

