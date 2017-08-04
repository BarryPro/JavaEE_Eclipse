
<%
	 /*
	 * 功能: 12580个性化机主留言
	 * 版本: 1.0.0
	 * 日期: 2009/01/12
	 * 作者: xingzhan
	 * 版权: sitech
	 * update:
	 */
%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp"%>
<%@ page import="javax.servlet.http.HttpServletRequest,com.sitech.crmpd.core.wtc.util.*,java.util.*,java.io.OutputStream,com.sitech.boss.util.excel.*,java.text.SimpleDateFormat"%>
<%
		response.setHeader("Pragma","No-cache"); 
		response.setHeader("Cache-Control","no-cache"); 
		response.setDateHeader("Expires", 0);
%>
<%! 
  public  String getCurrDateStr(String str) {
	java.text.SimpleDateFormat objSimpleDateFormat = new java.text.SimpleDateFormat(
			"yyyy-MM-dd");
	return objSimpleDateFormat.format(new java.util.Date())+" "+str;
  }
  
%>

<%
  
  String opCode = "K506";
  String opName = "个性化机主留言";
  
  String loginNo = (String) session.getAttribute("workNo");
  String orgCode = (String) session.getAttribute("orgCode");
  String kf_longin_no = (String) session.getAttribute("kfWorkNo");
  String ACCEPT_NO = request.getParameter("ACCEPT_NO");
  String outStr = "select max(to_char(end_time,'yyyy-MM-dd HH24:mi:ss')), min(to_char(begin_time,'yyyy-MM-dd HH24:mi:ss')) from DTAKEMSG where msg_type = '1' and ACCEPT_NO = '"+ACCEPT_NO+"'";//判断是否有留言，在添加留言的时候时间不能重叠，如果重叠提示信息
  String outEndTime = "";//最大结束时间
  String outBeginTime = "";//最小开始时间
  
  String SERIAL_NO = request.getParameter("SERIAL_NO");
  
  String strINType = "button";
  String strUPType = "hidden";
  
  String BEGIN_TIME = "";
  String END_TIME = "";
  String MSG_CONTENT = "";
  
  if(SERIAL_NO==null||"".equals(SERIAL_NO)){
  	
  
  }else{
	
  strINType = "hidden";
  strUPType = "button";
 
  String sSql ="select to_char(BEGIN_TIME,'yyyy-MM-dd HH24:mi:ss'),to_char(END_TIME,'yyyy-MM-dd HH24:mi:ss'),MSG_CONTENT from DTAKEMSG where MSG_TYPE = '1' and SERIAL_NO = '"+SERIAL_NO+"'";
%>  
<wtc:service name="s151Select" outnum="8">
	<wtc:param value="<%=sSql %>" />
</wtc:service>
<wtc:array id="queryList" scope="end" />

<% 
  if(queryList.length > 0){   
  	
  	BEGIN_TIME =(queryList[0][0].length() != 0) ? queryList[0][0]: "";
  	END_TIME =(queryList[0][1].length() != 0) ? queryList[0][1]: "";
  	MSG_CONTENT =(queryList[0][2].length() != 0) ? queryList[0][2]: "";
  }
  
  }
%>
<!--查询是否已有留言，留言是结束时间，用于判断新添加留言时，是否有时间重叠 -->
<wtc:service name="s151Select" outnum="8">
	<wtc:param value="<%=outStr %>" />
</wtc:service>
<wtc:array id="querydata" scope="end" />
<%
if(querydata.length > 0){
	
	outEndTime = (querydata[0][0].length() != 0) ? querydata[0][0]: "";
	outBeginTime = (querydata[0][1].length() != 0) ? querydata[0][1]: "";
} 
%>

<html>
	<head>
		<title>个性化机主留言</title>
		<script language="JavaScript" type="text/JavaScript" src="../../inputops.js"></script>
		<script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js"></script>
		<script language=javascript>
		function modCfm(){
			
			var BEGIN_TIME = document.getElementById("BEGIN_TIME").value;
			var BEGIN_TIME1 = document.getElementById("BEGIN_TIME1").value;
			var END_TIME = document.getElementById("END_TIME").value;
			var END_TIME1 = document.getElementById("END_TIME1").value;
			var MSG_CONTENT = document.getElementById("MSG_CONTENT").value;
			
			var outendtime = document.getElementById("outendtime").value;//以后留言结束时间
			
			if(BEGIN_TIME == ""){
				
				showTip(document.sitechform.BEGIN_TIME,"开始日期不能为空！请从新选择后输入");
		        sitechform.BEGIN_TIME.focus();
		        return;
			}
			
			if(BEGIN_TIME1 == ""){
				
				showTip(document.sitechform.BEGIN_TIME1,"开始时间不能为空！请从新选择后输入");
		        sitechform.BEGIN_TIME1.focus();
		        return;
			}
			if(!judagetime(BEGIN_TIME1)){
				showTip(document.sitechform.BEGIN_TIME1,"请输入00:00:00~23:59:59之间的时间");
		        sitechform.BEGIN_TIME1.focus();
		        return;
			}
			if(END_TIME == ""){
				
				showTip(document.sitechform.END_TIME,"结束日期不能为空！请从新选择后输入");
		        sitechform.END_TIME.focus();
		        return;
			}
			if(END_TIME1 == ""){
				
				showTip(document.sitechform.END_TIME1,"结束时间不能为空！请从新选择后输入");
		        sitechform.END_TIME1.focus();
		        return;
			}
			if(!judagetime(END_TIME1)){
				showTip(document.sitechform.END_TIME1,"请输入00:00:00~23:59:59之间的时间");
		        sitechform.END_TIME1.focus();
		        return;
			}
			if((BEGIN_TIME+BEGIN_TIME1)>=(END_TIME+END_TIME)){
				
				showTip(document.sitechform.END_TIME,"结束日期不能小于或等于开始日期！请从新选择后输入");
		    
		        sitechform.END_TIME.focus();
		        return;
			}
			
			//if((BEGIN_TIME+BEGIN_TIME1)<=outendtime){
			//	if(rdShowConfirmDialog("新建留言和原有留言时间重叠！，是否继续添加",2) != 1){
			//		document.getElementById("innerH").style.display="";
			//		return;
			//	}
				//else{
					
				//}
				//showTip(document.sitechform.BEGIN_TIME,"新建留言和原有留言时间重叠，原有留言结束时间为"+outendtime+"！请从新选择后输入");
		    
		      //  sitechform.END_TIME.focus();
		        //return;
			//}
			
			if(MSG_CONTENT == ""){
				
				showTip(document.sitechform.MSG_CONTENT,"留言内容不能为空！请从新选择后输入");
		        sitechform.MSG_CONTENT.focus();
		        return;
			}
			
			var myPacket = new AJAXPacket("k506_newsave_obj.jsp","正在提交，请稍候......");	
			myPacket.data.add("BEGIN_TIME",BEGIN_TIME+" "+BEGIN_TIME1);	
			myPacket.data.add("END_TIME",END_TIME+" "+END_TIME1);
			myPacket.data.add("MSG_CONTENT",MSG_CONTENT);
			myPacket.data.add("ACCEPT_NO",<%=ACCEPT_NO%>);
			
			core.ajax.sendPacket(myPacket,doProcess,true);
			myPacket=null;
		}
		function modCfmUP(){
			
			var BEGIN_TIME = document.getElementById("BEGIN_TIME").value;
			var BEGIN_TIME1 = document.getElementById("BEGIN_TIME1").value;
			var END_TIME = document.getElementById("END_TIME").value;
			var END_TIME1 = document.getElementById("END_TIME1").value;
			var MSG_CONTENT = document.getElementById("MSG_CONTENT").value;
			
			var outendtime = document.getElementById("outendtime").value;//以后留言结束时间
			
			if(BEGIN_TIME == ""){
				
				showTip(document.sitechform.BEGIN_TIME,"开始日期不能为空！请从新选择后输入");
		        sitechform.BEGIN_TIME.focus();
		        return;
			}
			if(BEGIN_TIME1 == ""){
				
				showTip(document.sitechform.BEGIN_TIME1,"开始时间不能为空！请从新选择后输入");
		        sitechform.BEGIN_TIME1.focus();
		        return;
			}
			if(END_TIME == ""){
				
				showTip(document.sitechform.END_TIME,"结束日期不能为空！请从新选择后输入");
		        sitechform.END_TIME.focus();
		        return;
			}
			if(END_TIME1 == ""){
				
				showTip(document.sitechform.END_TIME1,"结束时间不能为空！请从新选择后输入");
		        sitechform.END_TIME1.focus();
		        return;
			}

			if((BEGIN_TIME+BEGIN_TIME1)>=(END_TIME+END_TIME)){
				
				showTip(document.sitechform.END_TIME,"结束日期不能小于或等于开始日期！请从新选择后输入");
		    
		        sitechform.END_TIME.focus();
		        return;
			}
			
			//if((BEGIN_TIME+BEGIN_TIME1)<=outendtime){
			//	if(rdShowConfirmDialog("修改的留言时间和原有留言时间重叠！，是否继续添加",2) != 1){
			//		document.getElementById("innerH").style.display="";
			//		return;
			//	}
				//else{
					
				//}
				//showTip(document.sitechform.BEGIN_TIME,"新建留言和原有留言时间重叠，原有留言结束时间为"+outendtime+"！请从新选择后输入");
		    
		      //  sitechform.END_TIME.focus();
		        //return;
			//}
			
			if(MSG_CONTENT == ""){
				
				showTip(document.sitechform.MSG_CONTENT,"留言内容不能为空！请从新选择后输入");
		        sitechform.MSG_CONTENT.focus();
		        return;
			}
			
			var myPacket = new AJAXPacket("k506_editsave_obj.jsp","正在提交，请稍候......");	
			myPacket.data.add("BEGIN_TIME",BEGIN_TIME+" "+BEGIN_TIME1);	
			myPacket.data.add("MSG_CONTENT",MSG_CONTENT);
			myPacket.data.add("END_TIME",END_TIME+" "+END_TIME1);
			myPacket.data.add("SERIAL_NO",<%=SERIAL_NO%>);
			
			core.ajax.sendPacket(myPacket,doProcess,true);
			myPacket=null;
		}
		function doProcess(myPacket)
		{
		
		  var retType = myPacket.data.findValueByName("retType");
			var retCode = myPacket.data.findValueByName("retCode");
			var retMsg = myPacket.data.findValueByName("retMsg");
			if(retCode=="000000"){
				
				rdShowMessageDialog("成功",2);
				window.dialogArguments.submitMe('1');
			    window.close();
			}else{
				
				rdShowMessageDialog("失败",0);
				return false;
			}
		}	
		</script>
	</head>
	<body>
		<%@ include file="/npage/include/header.jsp"%>
	    <form name="sitechform" id="sitechform">
	    	<!-- 已有留言隐藏域 -->
	    	<input type="hidden" name="outendtime" value="<%=outEndTime %>" />
		    <div id="Operation_Table">
		    	<table  cellspacing="0">
		    		<tr align="center">
		    			<td>
		    				日期范围
		    			</td>
		    			<td>
		    				时间范围
		    			</td>
		    		</tr>
		    		<tr>
		    			<td>
		    				开始日期
		    				<input id="BEGIN_TIME" name ="BEGIN_TIME" type="text"  value="<%=("".equals(BEGIN_TIME))?"":BEGIN_TIME.split(" ")[0]%>" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',position:{top:'under'}});hiddenTip(document.sitechform.BEGIN_TIME);return false;">
		    				<img onclick="WdatePicker({el:$dp.$('BEGIN_TIME'),dateFmt:'yyyy-MM-dd',position:{top:'under'}});return false;" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
		    				<font color="orange">*</font>
		    				
		    			</td>
		    			<td>
		    				开始时间
		    				<input id="BEGIN_TIME1" name ="BEGIN_TIME1" type="text"  value="<%=("".equals(BEGIN_TIME))?"00:00:00":BEGIN_TIME.split(" ")[1]%>" <!--onclick="WdatePicker({dateFmt:'HH:mm:ss',position:{top:'under'}});hiddenTip(document.sitechform.BEGIN_TIME);return false;"--  >
		    				<!--<img onclick="WdatePicker({el:$dp.$('BEGIN_TIME1'),dateFmt:'HH:mm:ss',position:{top:'under'}});return false;" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">-->
		    				<font color="orange">*</font>
		    			</td>
		    		</tr>
		    		<tr>
		    			<td>
		    				结束日期
		    				<input id="END_TIME" name ="END_TIME" type="text"  value="<%=("".equals(END_TIME))?"":END_TIME.split(" ")[0]%>" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',position:{top:'under'}});hiddenTip(document.sitechform.END_TIME);return false;">
		    				<img onclick="WdatePicker({el:$dp.$('END_TIME'),dateFmt:'yyyy-MM-dd',position:{top:'under'}});return false;" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
		    				<font color="orange">*</font>
		    			</td>
		    			<td>
		    				结束时间		    				
		    				<input id="END_TIME1" name ="END_TIME1" type="text"  value="<%=("".equals(END_TIME))?"23:59:59":END_TIME.split(" ")[1]%>" <!--onclick="WdatePicker({dateFmt:'HH:mm:ss',position:{top:'under'}});hiddenTip(document.sitechform.BEGIN_TIME);return false;"--  >
		    				<!--<img onclick="WdatePicker({el:$dp.$('END_TIME1'),dateFmt:'HH:mm:ss',position:{top:'under'}});return false;" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">-->
		    				<font color="orange">*</font>
		    			</td>
		    		</tr>
		    		<tr>
		    			<td colspan="2">
		    				用户留言信息<br>
		    				<textarea rows="10" cols="80" name="MSG_CONTENT" id="MSG_CONTENT"><%=MSG_CONTENT %></textarea>
		    			</td>
		    		</tr>
		    		<tr id="innerH" style="display:none ">
		    			<td colspan="2">
		    				<font color="orange">已设置留言的时间范围：开始时间<%=outBeginTime %>-----结束时间<%=outEndTime %></font>
		    			</td>
		    		</tr>
		    	</table>
		    	<br/>
				 <div id="" align="right">
				     <input type="<%=strINType %>" name="cfm" class="b_foot" value="确认" onclick="modCfm();"/>
				     <input type="<%=strUPType %>" name="cfm" class="b_foot" value="确认" onclick="modCfmUP();"/>
					 <input type="button" name="clo" class="b_foot" value="关闭" onclick="javascript:window.close();"/>
				 </div>
		    </div>
		</form>
	    <%@ include file="/npage/include/footer.jsp"%>
	</body>	
</html>