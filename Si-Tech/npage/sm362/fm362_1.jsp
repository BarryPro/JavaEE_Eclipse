<%
/********************
 
 -->>描述创建人、时间、模块的功能
 -------------------------创建-----------何敬伟2016-3-29 10:17:41------------------
 

 -------------------------后台人员：wangzc、zuolf--------------------------------------------
 
********************/
%>
              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 

<%
	String opCode        = WtcUtil.repNull(request.getParameter("opCode"));
  String opName        = WtcUtil.repNull(request.getParameter("opName"));
  
  String workNo    = (String)session.getAttribute("workNo");
  String password  = (String)session.getAttribute("password");
  String workName  = (String)session.getAttribute("workName");
  String orgCode   = (String)session.getAttribute("orgCode");
  String ipAddrss  = (String)session.getAttribute("ipAddr");
  String regionCode = (String)session.getAttribute("regCode");
  
  String currentDate = "";
	String param = "select to_char(sysdate,'yyyyMMdd HH24:mi:ss') as currentDate from dual";
%>
  <wtc:service name="TlsPubSelCrm" outnum="1" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=param%>" />
	</wtc:service>
	<wtc:array id="result_currentDate" scope="end"   />
<%	
	if(result_currentDate.length>0){
		currentDate = result_currentDate[0][0];
	}
	
	System.out.println("--hejwa------fm362_1.jsp----AAAAAAAAAAA-----Currentdate--AAAAAAAAAAA----------->"+currentDate);
		
	java.util.Calendar cal = java.util.Calendar.getInstance(); 
	cal.add(Calendar.MONTH, 1); 
	cal.set(Calendar.DATE, 1); 
	String n_month_Date = new java.text.SimpleDateFormat("yyyyMMdd 00:00:00").format(new java.util.Date(cal.getTimeInMillis()));

	
	
	String paraAray1[] = new String[8];
	
	paraAray1[0] = "";                                       //流水
	paraAray1[1] = "01";                                     //渠道代码
	paraAray1[2] = opCode;                                   //操作代码
	paraAray1[3] = (String)session.getAttribute("workNo");   //工号
	paraAray1[4] = (String)session.getAttribute("password"); //工号密码
	paraAray1[5] = activePhone;                            //用户号码
	paraAray1[6] = "";       
	paraAray1[7] = "3";    
	
%> 
	<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="sysAcceptl" /> 
		
  <wtc:service name="sm357Qry" outnum="11" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=paraAray1[0]%>" />
		<wtc:param value="<%=paraAray1[1]%>" />	
		<wtc:param value="<%=paraAray1[2]%>" />
		<wtc:param value="<%=paraAray1[3]%>" />
		<wtc:param value="<%=paraAray1[4]%>" />
		<wtc:param value="<%=paraAray1[5]%>" />
		<wtc:param value="<%=paraAray1[6]%>" />
		<wtc:param value="<%=paraAray1[7]%>" />	
	</wtc:service>
	<wtc:array id="result_t2" scope="end"  />
		
<%
	
	String j_ProdCode = "";
	String j_ProdName = "";
	String j_GearCode = "";
	String j_GearName = "";
	String j_group_id = "";
	
	String j_offer_flag  = "";
	String prod_eff_date = "";
	String main_phone="";
	
	if("000000".equals(code)){
		if(result_t2.length>0){
			j_ProdCode = result_t2[0][1];
			j_ProdName = result_t2[0][0];
			j_GearCode = result_t2[0][3];
			j_GearName = result_t2[0][2];
			j_group_id = result_t2[0][4];
			j_offer_flag  = result_t2[0][5];
			prod_eff_date = result_t2[0][7];
			main_phone = result_t2[0][10];
		}
 
	}else{
%>
<SCRIPT language=JavaScript>
	rdShowMessageDialog("sm357Qry错误：<%=code%>，<%=msg%>");
	removeCurrentTab();
</SCRIPT>
<%}

	//查询已添加角色
	String paraAray2[] = new String[11];
	paraAray2[0] = "";                                       //流水
	paraAray2[1] = "01";                                     //渠道代码
	paraAray2[2] = opCode;                                   //操作代码
	paraAray2[3] = (String)session.getAttribute("workNo");   //工号
	paraAray2[4] = (String)session.getAttribute("password"); //工号密码
	paraAray2[5] = main_phone;                            //用户号码
	paraAray2[6] = "";       
	paraAray2[7] = "4";    	
	paraAray2[8] = j_ProdCode;    	
	paraAray2[9] = j_GearCode;    	
	paraAray2[10] = j_group_id;    	

%>


  <wtc:service name="sm357Qry" outnum="9" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=paraAray2[0]%>" />
		<wtc:param value="<%=paraAray2[1]%>" />	
		<wtc:param value="<%=paraAray2[2]%>" />
		<wtc:param value="<%=paraAray2[3]%>" />
		<wtc:param value="<%=paraAray2[4]%>" />
		<wtc:param value="<%=paraAray2[5]%>" />
		<wtc:param value="<%=paraAray2[6]%>" />
		<wtc:param value="<%=paraAray2[7]%>" />	
		<wtc:param value="<%=paraAray2[8]%>" />	
		<wtc:param value="<%=paraAray2[9]%>" />	
		<wtc:param value="<%=paraAray2[10]%>" />				
	</wtc:service>
	<wtc:array id="result_t3" scope="end"  />
		
<%

	//根据档位代码查询资费
		 String paraAray4[] = new String[8];
						paraAray4[0] = "";                                       //流水
						paraAray4[1] = "01";                                     //渠道代码
						paraAray4[2] = opCode;                                   //操作代码
						paraAray4[3] = (String)session.getAttribute("workNo");   //工号
						paraAray4[4] = (String)session.getAttribute("password"); //工号密码
						paraAray4[5] = main_phone;                            //用户号码
						paraAray4[6] = "";       
						paraAray4[7] = j_GearCode;    	
%>


  <wtc:service name="sm358Qry" outnum="19" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=paraAray4[0]%>" />
		<wtc:param value="<%=paraAray4[1]%>" />	
		<wtc:param value="<%=paraAray4[2]%>" />
		<wtc:param value="<%=paraAray4[3]%>" />
		<wtc:param value="<%=paraAray4[4]%>" />
		<wtc:param value="<%=paraAray4[5]%>" />
		<wtc:param value="<%=paraAray4[6]%>" />
		<wtc:param value="<%=paraAray4[7]%>" />	
	</wtc:service>
	<wtc:array id="result_t4" scope="end"  />
		

<%@ page contentType="text/html;charset=GBK"%>
<HTML><HEAD><TITLE><%=opName%></TITLE>
<script language="javascript" type="text/javascript" src="/npage/public/json2.js"></script>	
<SCRIPT language=JavaScript>

var j_EFF_DATE = "";

//重置刷新页面
function reSetThis(){
	  location = location;	
}

function show_offer_det(outClssName,offer_name,offer_desc,offer_sum){
	  var h     = 400;
    var w     = 880;
    var t     = screen.availHeight/2-h/2;
    var l     = screen.availWidth/2-w/2;
    var prop  = "dialogHeight:"+h+"px;dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
    var tpath = "/npage/sm358/fm358_2.jsp"+
    												"?outClssName="+outClssName+//
    												"&offer_name="+offer_name+//
    												"&offer_desc="+offer_desc+
    												"&offer_sum="+offer_sum+
    												"&opCode=<%=opCode%>"+
    												"&opName=<%=opName%>";
    var ret   = window.showModalDialog(tpath,"",prop);
}


 
$(document).ready(function(){
	
	var c_p = 0;//当月总价
	var n_p = 0;//下月总价
 //计算总价
 $("#old_offer_table tr:gt(0)").each(function(){
 	
 });

});    
</SCRIPT>
</HEAD>	
<BODY>
<FORM name="msgFORM" action="" method="post"> 
<input type="hidden" id="prt_cust_name" name="prt_cust_name" value="" />
<input type="hidden" id="prt_cust_bran" name="prt_cust_bran" value="" />
<input type="hidden" id="prt_note_into" name="prt_note_into" value="" />		
	<%@ include file="/npage/include/header.jsp" %>	
<div class="title"><div id="title_zi">选择产品</div></div>


<table cellSpacing="0">
	<tr>
	    <td class="blue" width="25%">家庭产品：</td>
		  <td width="25%">
		  	<%=j_ProdName%>
		  </td>
 
	    <td class="blue" width="25%">产品档位：</td>
		  <td width="25%">
			   <%=j_GearName%>
		  </td>
	</tr>
	<tr>
		<td class="blue">群组：</td>
		<td colspan="3">
			<%=j_group_id%>
		</td>
	</tr>
</table>

<div class="title"><div id="title_zi">已添加角色</div></div>
<table cellSpacing="0"  id="old_mem_table">
	<tr>
		<th width="25%" name="phonenumber">手机号码</th>
		<th style="display:none">角色代码</th>
		<th width="25%" name="rolename">角色名称</th>
		<th width="25%">生效时间</th>
		<th width="25%">失效时间</th>
		<th style="display:none">标志位，标识是否需要付费，返回Y的代表需要付费，需要拼一条PAY_INFO</th>
	</tr>
<%
for(int i=0;i<result_t3.length;i++){
%>
<tr>
	<td name="phonenumber"><%=result_t3[i][0]%></td>
	<td  style="display:none"><%=result_t3[i][6]%></td>
	<td name="rolename"><%=result_t3[i][1]%></td>
	<td><%=result_t3[i][2]%></td>
	<td><%=result_t3[i][3]%></td>
	<td  style="display:none" ><%=result_t3[i][8]%></td>
	<td  style="display:none" ><%=result_t3[i][7]%></td>
</tr>
<%
}
%>
</table>



<div class="title"><div id="title_zi">已订购资费列表</div></div>
<table cellSpacing="0"  id="old_offer_table">
	 <tr>
		<th width="25%">资费名称</th>
		<th width="25%">生效时间</th>
		<th width="25%">失效时间</th>
		<th width="25%">价格</th>
	</tr>
<%
for(int i=0;i<result_t4.length;i++){
if("Y".equals(result_t4[i][9])){
%>

 	<tr>
		<td><%=result_t4[i][6]%></td>
		<td><%=result_t4[i][14]%></td>
		<td><%=result_t4[i][15]%></td>
		<td><%=result_t4[i][8]%></td>
		
		
		
	</tr>

<%
}
}
%>
 <!--
 <tr>
		<td width="25%"  class="blue">本月总价：</td>
		<td width="25%"><span id="span_c_p"></span></td>
		<td width="25%"  class="blue">下月总价：</td>
		<td width="25%"><span id="span_n_p"></span></td>
	</tr>
	-->

<%
if("".equals(j_ProdCode)){
%>
	<tr>
		<td  colspan="4"><font class="orange">未订购产品</font></td>
	</tr>
<%
}
%>
	
</table>


<table cellSpacing="0">
	 <tr>
	 	<td id="footer">
	 		<input type="button" class="b_foot" value="重置" onclick="reSetThis()"         /> 
			<input type="button" class="b_foot" value="关闭" onclick="removeCurrentTab()"  /> 
	 	</td>
	</tr>
</table>
<div id="messagediv"></div>
<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>
