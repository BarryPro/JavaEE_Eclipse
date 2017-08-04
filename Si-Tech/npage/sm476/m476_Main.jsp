<%
/********************
 * version v2.0
 * 开发商: si-tech
 * update by qidp @ 2009-02-05
 ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ page import="com.sitech.boss.util.page.*"%>
<%
	String op_code="m476";
	String op_name = "工号操作日志查询";
	String opCode = op_code;
	String opName =op_name;
	String workNo = (String)session.getAttribute("workNo");
	String workName = (String)session.getAttribute("workName");
	String regionCode = (String)session.getAttribute("regCode");
	//ArrayList arrSession = (ArrayList)session.getAttribute("allArr");
	//String[][] baseInfoSession = (String[][])arrSession.get(0);
	//String[][] fiveInfoSession = (String[][])arrSession.get(4);
	String workpw = (String)session.getAttribute("password");
	String org_code = (String)session.getAttribute("orgCode");
	
	
	
	boolean workNoFlag=false;
	if(workNo.substring(0,1).equals("z")||workNo.substring(0,1).equals("Z"))
		workNoFlag=true;
	

	
	int iPageNumber = request.getParameter("pageNumber")==null?1:Integer.parseInt(request.getParameter("pageNumber"));
	int iPageSize = 25;
	int iStartPos = (iPageNumber-1)*iPageSize;
	int iEndPos = iPageNumber*iPageSize;
	
	int rows=0;
	String errcode="000000";
	String errmsg="";
	String[][] result0=null;
	
	String ipAddr=request.getRemoteAddr();;
	String opNote = "";
	String beginPos=String.valueOf(iStartPos);
	String MaxNum=String.valueOf(iPageSize);
	
	String disPlay = request.getParameter("disPlay") ;
	String opType="";
	String beginDate="";
	String endDate="";
	String oaNumber = "" ;
	String oploginNo="";
	
	if("yes".equals(disPlay)){
		opType=WtcUtil.repStr(request.getParameter("opType"),""); 
		oaNumber=WtcUtil.repStr(request.getParameter("oaNumber"),""); 
		beginDate=WtcUtil.repStr(request.getParameter("beginDate"),"");
		endDate=WtcUtil.repStr(request.getParameter("endDate"),"");
		oploginNo=WtcUtil.repStr(request.getParameter("oploginNo"),"");
%>
		<wtc:service name="sm999Qry" outnum="17" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="0"/>
			<wtc:param value="01"/>
			<wtc:param value="m476"/>
			<wtc:param value="<%=oploginNo%>"/>
			<wtc:param value=""/>
			<wtc:param value=""/>
			<wtc:param value=""/>
			<wtc:param value="<%=opType%>"/>
			<wtc:param value="<%=oaNumber%>"/>
			<wtc:param value="<%=beginDate%>"/>
			<wtc:param value="<%=endDate%>"/>
		</wtc:service>
		<wtc:array id="r0" scope="end"/>
<%
		errcode=retCode;
		errmsg=retMsg;
		result0=r0;
	}
	else{
		//初始化查询日期
		GregorianCalendar   gc   =   (GregorianCalendar)   Calendar.getInstance();   
		gc.setTime(new java.util.Date());   
		gc.add(Calendar.MONTH,   -1);
		beginDate = new java.text.SimpleDateFormat("yyyyMM").format(gc.getTime());
		beginDate = beginDate+"01" ;
		endDate = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
	}
	System.out.println("liangyl------------------------------"+errcode);
	if(errcode.equals("000000")&&result0!=null){
		System.out.println("liangyl------------------------------"+result0.length);
	}
	
	if(!errcode.equals("000000"))
	{
%>
		<script language='jscript'>
			rdShowMessageDialog('<%=errmsg%>' + '[' + '<%=errcode%>' + ']',0);
			history.go(-1);
		</script>
<%
	}else{
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<TITLE><%=op_name%></TITLE>

<script language="javascript">
$(document).ready(function(){
	$("#opType").val("<%=opType%>");
	selectOpType();
})
	function doCheck(){
		if(!check(document.form1)){
			return false;			
		}
		if(parseInt(document.form1.beginDate.value)>parseInt(document.form1.endDate.value)){
			rdShowMessageDialog("开始时间不能大于结束时间！",0);
			document.form1.beginDate.focus();
	    	return false;
		}
		document.form1.action="m476_Main.jsp";
		document.form1.submit();
	}
function selectOpType(){
	//if(!$("tr[name='mobaihegroup']").is(":hidden")){
	var opType = $("#opType").val();
	$("#timeTbody").hide();
	$("#oaTbody").hide();
	$("#opLoginNoTr").hide();
	$("#beginDate").attr("v_must","1");
	$("#endDate").attr("v_must","1");
	$("#oaNumber").attr("v_must","1");
	if(opType=="1"){
		$("#oaNumber").attr("v_must","0");
		$("#opLoginNoTr").show();
		$("#timeTbody").show();
	}
	else if(opType=="0"){
		$("#beginDate").attr("v_must","0");
		$("#endDate").attr("v_must","0");
		$("#opLoginNoTr").show();
		$("#oaTbody").show();
	}
}
</script>
</HEAD>

<body>
<form  method=post name="form1" >
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">工号操作日志查询</div>
</div>
	<input type="hidden" name="disPlay"  value="yes">
	
	<table cellspacing="0">
		<tr> 
			<td class="blue" width="33%">操作类型</td>
			<td colspan="3">
				<select id="opType" name="opType" onchange="selectOpType()">
					<option value="">-请选择-</option>
					<option value="1">操作时间</option>
					<option value="0">OA编号</option>
				</select>
				<font class="orange">*</font>
			</td>
		</tr>
		<tbody id="timeTbody" style="display: none">
			<tr> 
				<td class="blue">开始时间</td>
	            <td>
	            	<input id="beginDate" name="beginDate" type="text" value="<%=beginDate%>" v_must="1" v_type="date"/>
	            	<font class="orange">*</font>
	            </td>
	            <td class="blue">结束时间</td>
	            <td>
	            	<input id="endDate" name="endDate" type="text" value="<%=endDate%>" v_must="1" v_type="date"/>
	            	<font class="orange">*</font>
	            </td>
			</tr>
		</tbody>
		<tbody id="oaTbody" style="display: none">
			<tr> 
				<td class="blue">OA编号</td>
	            <td colspan="3">
	            	<input id="oaNumber" name="oaNumber" type="text" value="<%=oaNumber%>" v_must="1"/>
	            	<font class="orange">*</font>
	            </td>
			</tr>
		</tbody>
		<tr id="opLoginNoTr" style="display: none"> 
			<td class="blue">操作工号</td>
			<td colspan="3">
				<input type="text" id="oploginNo" name="oploginNo" maxlength="10" value="<%=oploginNo%>" v_must="1"/>
				<font class="orange">*</font>
			</td>
		</tr>
		
		<tr id="footer"> 
			<td colspan="4" align="center">
				<input type="button" id="qryBtn" name="qryBtn" class="b_foot" value="查询" onclick="doCheck()">
				&nbsp;&nbsp;
				<input type="reset" id="resBtn" name="resBtn" class="b_foot" value="重置" >
			</td>
		</tr>
	</table>
	</div>
<div id="Operation_Table">
<div class="title">
	<div id="title_zi">查询结果</div>
</div>
<table cellspacing="0">
		<tr>
			<th>OA编号</th>
			<th>OA标题</th>
			<th>操作工号</th>
			<th>操作时间</th>
			<th>被操作工号</th>
			<th>操作代码</th>
			<th>操作名称</th>
			<th>原角色</th>
			<th>新角色</th>
			<th>增加权限</th>
			<th>删除权限</th>
		</tr>
	<%
		if(result0 != null){
			rows=result0.length;
		}
		if(rows<1){
	%>
		<tr><td colspan="11" align = "center"><b><font class="orange">无查询结果</font></td></tr>
	<%
		}
			
		for(int i=0;i<rows;i++){
		    String tdClass = "";            
            if (i%2==0){
                 tdClass = "Grey";
            }
	%>
		<tr align="center" onmouseout="this.style.backgroundColor=''" onmouseover="this.style.backgroundColor='#E8E8E8';this.style.cursor='hand'">
			<td class="<%=tdClass%>"><%=result0[i][0]%></td>
			<td class="<%=tdClass%>"><%=result0[i][1]%></td>
			<td class="<%=tdClass%>"><%=result0[i][2]%></td>
			<td class="<%=tdClass%>"><%=result0[i][3]%></td>
			<td class="<%=tdClass%>"><%=result0[i][4]%></td>
			<td class="<%=tdClass%>"><%=result0[i][5]%></td> 
			<td class="<%=tdClass%>"><%=result0[i][15]%></td> 
			<td class="<%=tdClass%>"><%=result0[i][6]%>-<%=result0[i][11]%></td> 
			<td class="<%=tdClass%>"><%=result0[i][7]%>-<%=result0[i][12]%></td> 
			<td class="<%=tdClass%>"><%=result0[i][8]%>-<%=result0[i][13]%></td> 
			<td class="<%=tdClass%>"><%=result0[i][9]%>-<%=result0[i][14]%></td> 
		</tr>
	<%
		}
	%>
	</table>
	<%@ include file="/npage/include/footer.jsp" %>
	</FORM>
	</BODY>
</HTML>

<%}%>
