<%
/********************
 
 -------------------------创建-----------何敬伟(hejwa) 2015-6-10 9:44:18-------------------
  关于二维码业务办理系统扩展使用群体的需求
 -------------------------后台人员：金刚--------------------------------------------
 
********************/
%>
              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 

<%
	String opCode      = WtcUtil.repNull(request.getParameter("opCode"));
  	String opName      = WtcUtil.repNull(request.getParameter("opName"));
                     
  String workNo      = (String)session.getAttribute("workNo");
  String password    = (String)session.getAttribute("password");
  String workName    = (String)session.getAttribute("workName");
  String orgCode     = (String)session.getAttribute("orgCode");
  String ipAddrss    = (String)session.getAttribute("ipAddr");
  String regionCode  = (String)session.getAttribute("regCode");
  String currentDate = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
  
  String numpage            = (String)request.getParameter("numpage") == null? "1":(String)request.getParameter("numpage");
  String endpanges          = (String)request.getParameter("numpage") == null? "0":(String)request.getParameter("numpage");
  String zongshus           = (String)request.getParameter("zongshus") == null? "0":(String)request.getParameter("zongshus");


	//业务要素传递过来的参数
	String phoneNo_t = (String)request.getParameter("phoneNo_t") == null? "":(String)request.getParameter("phoneNo_t");
	String loginNo_t = (String)request.getParameter("loginNo_t") == null? "":(String)request.getParameter("loginNo_t");
	
	String beginDate = (String)request.getParameter("beginDate") == null? currentDate:(String)request.getParameter("beginDate");
	String endDate   = (String)request.getParameter("endDate") == null? currentDate:(String)request.getParameter("endDate");
	String phoneNo_bl   = (String)request.getParameter("phoneNo_bl") == null? "":(String)request.getParameter("phoneNo_bl");
	

	    System.out.println("--------------numpage-------------> " + numpage);
%>

<wtc:service name="sm268Qry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="11">
  	<wtc:param value="0"/>
  	<wtc:param value="01"/>
  	<wtc:param value="<%=opCode%>"/>
  	<wtc:param value="<%=workNo%>"/>
  	<wtc:param value="<%=password%>"/>
    <wtc:param value="<%=phoneNo_t%>"/>
  	<wtc:param value=""/>
  	<wtc:param value="<%=loginNo_t%>"/>
  	<wtc:param value="<%=beginDate%>"/>	
  	<wtc:param value="<%=endDate%>"/>
  	<wtc:param value="<%=numpage%>"/>
  	<wtc:param value="<%=phoneNo_bl%>"/>
</wtc:service>

	<wtc:array id="result_t1" scope="end" start="0"  length="1"  />
	<wtc:array id="result_t2" scope="end" start="1"  length="10" />
<%

	System.out.println("-----------result_t1.length------------------>"+result_t1.length);
	System.out.println("-----------result_t2.length------------------>"+result_t2.length);
	if(retCode.equals("000000")){
	if(result_t1.length>0) {
    	
    
    	zongshus=result_t1[0][0];
    	
    	
		if(Integer.parseInt(result_t1[0][0].trim())==0) {
		 		endpanges="1";
		 }
		 if(Integer.parseInt(result_t1[0][0].trim())>0 && Integer.parseInt(result_t1[0][0].trim())<50) {
		 		endpanges="1";
		 }
		 if(Integer.parseInt(result_t1[0][0].trim())>50) {
		 		endpanges=(Integer.parseInt(result_t1[0][0].trim())/50+1)+"";
		 }
	  }
	}
%>



<%@ page contentType="text/html;charset=GBK"%>
<HTML><HEAD><TITLE><%=opName%></TITLE>
<script type="text/javascript" src="/njs/extend/My97DatePicker/WdatePicker.js"></script>
<SCRIPT language=JavaScript>
 
function pagecontione(nums) {  		
		
		if(!check_input())		return;
		
		window.location="fm268_1.jsp?opCode=<%=opCode%>&opName=<%=opName%>&crmActiveOpCode=<%=opCode%>"+
		"&phoneNo_t="+$("#phoneNo_t").val().trim()+
		"&loginNo_t="+$("#loginNo_t").val().trim()+
		"&beginDate="+$("#beginDate").val().trim()+
		"&endDate="+$("#endDate").val().trim()+
		
		"&numpage="+nums+"&endpanges=<%=endpanges%>&zongshus=<%=zongshus%>"+"&phoneNo_bl="+$("#phoneNo_bl").val().trim();			
}

function doQuery(){
	
	if(!check_input())		return;
	window.location="fm268_1.jsp?opCode=<%=opCode%>&opName=<%=opName%>&crmActiveOpCode=<%=opCode%>"+
		"&phoneNo_t="+$("#phoneNo_t").val().trim()+
		"&loginNo_t="+$("#loginNo_t").val().trim()+
		"&beginDate="+$("#beginDate").val().trim()+
		"&endDate="+$("#endDate").val().trim()+
		"&numpage=1&endpanges=<%=endpanges%>&zongshus=<%=zongshus%>"+"&phoneNo_bl="+$("#phoneNo_bl").val().trim();	
}  

/*
 * 校验表单
 * 开始时间和结束时间必须填写，推荐手机号码和推荐工号只允许输入其中一个，或者都不输入。 
 * 开始时间和结束时间不允许跨自然月
 */
function check_input(){
	if($("#phoneNo_t").val().trim()!=""&&$("#loginNo_t").val().trim()!=""){
		rdShowMessageDialog("推荐手机号码和推荐工号只允许输入其中一个，或者都不输入");
		return false;
	}
	
	var beginDate = $("#beginDate").val().trim();
	var endDate   = $("#endDate").val().trim();
	
	if(beginDate==""){
		rdShowMessageDialog("查询开始时间必须输入");
		return false;
	}
	
	if(endDate==""){
		rdShowMessageDialog("查询结束时间必须输入");
		return false;
	}
	
	if(beginDate.substring(0,6)!=endDate.substring(0,6)){
		rdShowMessageDialog("开始时间、结束时间不允许跨自然月");
		return false;
	}
	
	if(parseInt(beginDate)>parseInt(endDate)){
		rdShowMessageDialog("开始时间不能大于结束时间");
		return false;
	}
	
	return true;
}
function reSetThis(){
	window.location="fm268_1.jsp?opCode=<%=opCode%>&opName=<%=opName%>&crmActiveOpCode=<%=opCode%>"+
		"&phoneNo_t="+""+
		"&loginNo_t="+""+
		"&beginDate="+"<%=currentDate%>"+
		"&endDate="+"<%=currentDate%>"+
		"&numpage=1&endpanges=<%=endpanges%>&zongshus=<%=zongshus%>"+"&phoneNo_bl="+"";	
}

var excelObj;
function printTable()
{
	var obj=document.all.exportExcel;
	rows=obj.rows.length;
	if(rows>0){
		try{
			excelObj = new ActiveXObject("excel.Application");
			excelObj.Visible = true;
			excelObj.WorkBooks.Add;
			  for(i=0;i<rows;i++){
			    cells=obj.rows[i].cells.length;
			    for(j=0;j<cells;j++)
			      excelObj.Cells(i+1,j+1).Value="'" + obj.rows[i].cells[j].innerText;
			}
		}
		catch(e){}
	} else {
		
	}
}
</SCRIPT>
</HEAD>	
<BODY>
<FORM name="msgFORM" action="" method="post"> 
	<%@ include file="/npage/include/header.jsp" %>	
<div class="title"><div id="title_zi">查询条件</div></div>


<table cellSpacing="0">
	<tr>
		<td class="blue" width="=15%">业务办理手机号码</td>
		<td width="35%" colspan="3">
			<input type="text" name="phoneNo_bl" id="phoneNo_bl" value="<%=phoneNo_bl%>">
		</td>
	</tr>
	<tr>
	    <td class="blue" width="15%">推荐手机号码</td>
		  <td width="35%">
			    <input type="text" name="phoneNo_t" id="phoneNo_t" value="<%=phoneNo_t%>" /> 
		  </td>
		  
		      <td class="blue" width="15%">推荐工号</td>
		  <td width="35%">
			    <input type="text" name="loginNo_t" id="loginNo_t" value="<%=loginNo_t%>" /> 
		  </td>
	</tr>
	<tr>
		  <td class="blue" width="15%">开始时间</td>
		  <td width="35%">
			    <input type="text" name="beginDate" id="beginDate" value="<%=beginDate%>"  onclick="WdatePicker({dateFmt:'yyyyMMdd',autoPickDate:true,onpicked:function(){}})" />  
		  </td>
		  <td class="blue" width="15%">结束时间</td>
		  <td width="35%"> 
			    <input type="text" name="endDate" id="endDate" value="<%=endDate%>" onclick="WdatePicker({dateFmt:'yyyyMMdd',autoPickDate:true,onpicked:function(){}})" />   
		  </td>
	</tr>
</table>
<table cellSpacing="0">
	 <tr>
	 	<td id="footer">
	 		<input type="button" class="b_foot" value="查询" onclick="doQuery()"           />
	 		<input type="button" class="b_foot" value="重置" onclick="reSetThis()"         /> 
			<input type="button" class="b_foot" value="关闭" onclick="removeCurrentTab()"  /> 
	 	</td>
	</tr>
</table>
 <font class="orange">“是否冲正”字段仅当操作代码是1270、1272、g794时有效</font> 
<div class="title"><div id="title_zi">二维码营销业务量查询结果列表</div></div>
<TABLE cellSpacing="0"  id="exportExcel" name="exportExcel">
    <tr>
        <th width="15%">推荐工号/手机号码</th>
        <th width="13%">手机号码</th>	
        <th width="13%">办理时间</th>
        <th width="10%">操作代码</th>
        <th width="12%">操作流水</th>
        <th width="10%">资费代码/营销案编码</th>
        <th width="12%">资费名称/营销案名称</th>
        <th width="10%">渠道名称</th>
        <th width="10%">档位名称</th>
        <th width="10%">是否冲正</th>
    </tr>
<%
if(retCode.equals("000000")){
	

	for(int i=0;i<result_t2.length;i++){
  		out.print("<tr>");
  		out.print("<td>"+result_t2[i][0]+"</td>");
  		out.print("<td>"+result_t2[i][1]+"</td>");
  		out.print("<td>"+result_t2[i][3]+"</td>");
  		out.print("<td>"+result_t2[i][4]+"</td>");
  		out.print("<td>"+result_t2[i][5]+"</td>");
  		out.print("<td>"+result_t2[i][6]+"</td>");
  		out.print("<td>"+result_t2[i][7]+"</td>");
  		
  		out.print("<td>"+result_t2[i][8]+"</td>");
  		out.print("<td>"+result_t2[i][9]+"</td>");
  		
  		out.print("<td>"+result_t2[i][2]+"</td>");
  		out.print("</tr>");
	}
}
%>    
</table>

<table cellspacing="0">
	<tr>
    <td colspan="7" align="center" id="footer">
    共<%=zongshus%>条记录<input type="button" class="b_text" value="第一页" onClick="pagecontione('1')"/>&nbsp;&nbsp;&nbsp;<input type="button" class="b_text" value="上一页" onClick="pagecontione('<%=Integer.parseInt(numpage) - 1%>')"/>&nbsp;&nbsp;&nbsp;<input type="button" value="下一页" class="b_text" onClick="pagecontione('<%=Integer.parseInt(numpage) + 1%>')" />&nbsp;&nbsp;&nbsp;<input type="button" value="最后一页" class="b_text" onClick="pagecontione('<%=endpanges%>')" />
    &nbsp;&nbsp;&nbsp;<input class="b_foot" type=button name="excelExport" id="excelExport" value="导出EXCEL" onclick="printTable();">
    </td>
  </tr>
</table>

<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>