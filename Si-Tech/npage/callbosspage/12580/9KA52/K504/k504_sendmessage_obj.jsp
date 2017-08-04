
<%
	 /*
	 * 功能: 12580个人电话本-send短信
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
  
  String opCode = "K504";
  String opName = "个人电话本";

  String SERIAL_NO = request.getParameter("SERIAL_NO")==null?"":request.getParameter("SERIAL_NO"); 
  String ACCEPT_NO = request.getParameter("ACCEPT_NO")==null?"":request.getParameter("ACCEPT_NO");
  //String savelist = request.getParameter("savelist")==null?"":request.getParameter("savelist");
  
  String myList[] = new String[]{};
  
  String sSql = "select person_phone from DPHONLIST where 1=2 ";
  String[] sn = (String[])SERIAL_NO.split(";");
  
  for(int i = 0; i < sn.length; i++){
  	sSql += " or serial_no = '"+sn[i]+"'";
  }
%>  
<wtc:service name="s151Select" outnum="2">
	<wtc:param value="<%=sSql %>" />
</wtc:service>
<wtc:array id="queryList" scope="end" />
<% 
  int num = 0;
  
  for(int i=0;i<queryList.length;i++){
  	
  	if(queryList[i][0]!=null&&!"".equals(queryList[i][0])){
  	
  		num++;
  	
  	}
  }
%>
<html>
	<head>
		<title>群组</title>
		<script language=javascript>
		function checkThisB(a){
		    
		    document.getElementById("ACCEPT_NOc").disabled = "";
			
		}
		function checkThisA(a){
		
			document.getElementById("ACCEPT_NOc").disabled = "disabled";
			
		}
		function addNum(){
			
			deleteNull();
			
			if(document.getElementById("Phone_num").value ==""){
				
				return;
			}
			var text = document.getElementById("Phone_num").value;
			var value = document.getElementById("Phone_num").value;
			
			var n = "1";
			
			for(var i =0;i<document.getElementById("GRP_NUM").options.length;i++){
		
				if(document.getElementById("GRP_NUM").options[i].value==text){
					n="0";
					rdShowMessageDialog("此号码已存在该列表中！",1)
					return;
				}
			}
			
			if(n=="1"){
				document.getElementById("GRP_NUM").options.add(new Option(text,value));
				document.getElementById("Phone_num").value = "";
			}
		}
		function deleteAll(){
			var len = document.getElementById("GRP_NUM").options.length;
			var sel = document.getElementById("GRP_NUM").options;
		
			for(var i=len-1;i>=0;i--){
           		sel.remove(i);
        	}
			
		}
		function deleteOne(){
				
			var sel = document.getElementById("GRP_NUM").options;
			
			if(sel.selectedIndex<0){
				
				rdShowMessageDialog("请至少选择一个电话号码",1);
			}
				
			while(sel.selectedIndex>=0) {
			  sel.options.remove(sel.selectedIndex);
			} 
			
		}
		function deleteNull(){
			var len = document.getElementById("GRP_NUM").options.length;
			var sel = document.getElementById("GRP_NUM").options;
		
			for(var i=len-1;i>=0;i--){
				if(""==(sel[i].value.trim())){
					sel.remove(i);				
				}
        	}
		}
		//去左右空格;
		function trim(s){
				return rtrim(ltrim(s));
		}
		//去左空格;
		function ltrim(s){
		  	return s.replace( /^\s*/, "");
		}
		
		//去右空格;
		function rtrim(s){
				return s.replace( /\s*$/, "");
		}
		function sendMessage(){
			
			var phone_number = "";
			var sel = document.getElementById("GRP_NUM").options;
			for(var i =0;i<sel.length;i++){
				
				phone_number = phone_number + "_" + sel[i].value;
			}
			
			if("" == phone_number.replace("_","")){
				
				rdShowMessageDialog("通知号码列表为空！请添加至少一个电话号码。",1);
				return;
			}
		
			var ACCEPT_NOb = document.getElementById("ACCEPT_NOb");
			var ACCEPT_NOc = document.getElementById("ACCEPT_NOc");
			var ACCEPT_NO = "10658088" ;
			if(ACCEPT_NOb.checked){
				
				ACCEPT_NO = ACCEPT_NOc.value;
			}
			if("" == ACCEPT_NO){
				
				rdShowMessageDialog("主叫号不能为空!",1);
				return;
			}
			var shortmessage = document.getElementById("shortmessage").value;
			if("" == shortmessage){
				
				rdShowMessageDialog("短信内容不能为空!",1);
				return;
			}
			if(shortmessage.length > 300){
				
				rdShowMessageDialog("短信内容不能超过300个汉字!",1);
				return;
			}
			if(rdShowConfirmDialog("是否确定发送短信？")!=1){
				window.close();
				return;
		  }
			var callerphone = "";
			var contactid = "";
			if(window.opener.top.cCcommonTool != undefined && window.opener.top.cCcommonTool.getCaller() != ""){
				callerphone = window.opener.top.cCcommonTool.getCaller();
				contactid = trim(window.opener.parent.document.getElementById("contactIdnew").innerHTML);
			}else{
				callerphone = trim(window.opener.parent.document.getElementById("caller_phone_no").innerHTML);
			}
			var myPacket = new AJAXPacket("k504_send_obj.jsp","正在提交，请稍候......");
			myPacket.data.add("callerphone",callerphone);
			myPacket.data.add("contactid",contactid);
			myPacket.data.add("phone_number",phone_number);
			myPacket.data.add("ACCEPT_NO",ACCEPT_NO);
			myPacket.data.add("shortmessage",shortmessage);
	       	core.ajax.sendPacket(myPacket,doProcess,true);
		  	myPacket=null;
		}
		function doProcess(myPacket)
		{
		
		  var retType = myPacket.data.findValueByName("retType");
			var retCode = myPacket.data.findValueByName("retCode");
			var retMsg = myPacket.data.findValueByName("retMsg");
			if(retCode=="000000"){
				//alert("插入成功");
				//rdShowMessageDialog("成功",2);
				window.opener.submitMe('msgY');
			    window.close();
			    //window.close();
			}else{
				//alert("插入失败!");
				//rdShowMessageDialog("失败",0);
				window.opener.submitMe('msgN');
				return false;
			}
		}
		</script>
	</head>
	<body>
		<%@ include file="/npage/include/header.jsp"%>
	    <form name="sitechform" id="sitechform">
		    <div id="Operation_Table">
				<div class="title">
				短信通知
				</div>
				<table  cellspacing="0">
					<tr>
						<td width="40%" valign="top"  nowrap="nowrap">
							指定送出号码方式：
							<div>
								<input type="radio" name="ACCEPT_NO" id="ACCEPT_NOa" value="<%=ACCEPT_NO %>" checked="checked" onclick="checkThisA(this);">系统默认<br>
								<input type="radio" name="ACCEPT_NO" id="ACCEPT_NOb" value="" onclick="checkThisB(this);">指认主叫&nbsp;<input type="text" name="ACCEPT_NOc" id="ACCEPT_NOc" value="<%=ACCEPT_NO %>" disabled="disabled">
							</div>
						</td>
						<td rowspan="3">
							<input type="checkbox" name="" id="" value="">内容带话务员
							<div>
								<textarea rows="20" cols="60" name="shortmessage" id="shortmessage"></textarea>
							</div>
							<center><input type="button" name="" class="b_foot" id="" value="发送" onclick="sendMessage();">&nbsp;<input type="button" name="" class="b_foot" id="" onClick="window.close();" value="退出"></center>
						</td>
					</tr>
					<tr>
						<td valign="top" nowrap="nowrap">
							添加通知号码
							<div>
								<input type="text" name="Phone_num"  id="Phone_num" value="">&nbsp;<input type="button" class="b_foot" name="" id="" value="添加" onclick="addNum();">
							</div>
						</td>
					</tr>
					<tr>
						<td valign="top" nowrap="nowrap" >
							通知号码列表（共<%=num %>个）
							<div>
								<select name="GRP_NUM"  id="GRP_NUM" multiple="multiple" size="5" style="width:35mm">
									<%  
									  if(queryList.length>0){
									  	
									  	for(int i=0;i<queryList.length;i++){
									  		%>
									  		<option value="<%=queryList[i][0] %>" ><%=queryList[i][0] %></option>
									  		<%
									  	}
									  }
									%>
								</select>
								<br>
								<input type="button" name="" class="b_foot" id="" value="清空" onclick="deleteAll();">&nbsp;
								<input type="button" name="" class="b_foot" id="" value="删除" onclick="deleteOne();">
								
							</div>
						</td>
					</tr>
				</table>
			</div>		
	    </form>
	    <%@ include file="/npage/include/footer.jsp"%>
	</body>	
</html>	
