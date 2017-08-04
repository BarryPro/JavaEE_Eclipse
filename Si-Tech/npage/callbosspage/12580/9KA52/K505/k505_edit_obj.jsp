
<%
	 /*
	 * 功能: 12580群组-edit
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
<%
  
  String opCode = "K505";
  String opName = "群组";

  String org_code = (String)session.getAttribute("orgCode");
  String workNo = (String)session.getAttribute("workNo");
  
  String SERIAL_NO = request.getParameter("SERIAL_NO");
  
  String GRP_NAME= "";
  String ACCEPT_NO = "";
  String GRP_DESCR = "";
  
  String strSql = "select GRP_NAME,ACCEPT_NO,GRP_DESCR from DMSGGRP where SERIAL_NO = '"+SERIAL_NO+"'";
%>

<wtc:service name="s151Select" outnum="3">
	<wtc:param value="<%=strSql%>" />
</wtc:service>
<wtc:array id="queryList" scope="end" />
<% 
  
  GRP_NAME = (queryList[0][0].length() != 0) ? queryList[0][0]: "";
  ACCEPT_NO = (queryList[0][1].length() != 0) ? queryList[0][1]: "";
  GRP_DESCR = (queryList[0][2].length() != 0) ? queryList[0][2]: "";
%>

<html>
	<head>
		<title>群组</title>
		<script language=javascript>
			
			function modCfmUP(){
				var GRP_NAME = document.getElementById("GRP_NAME").value;
			    var ACCEPT_NO = document.getElementById("ACCEPT_NO").value;
			    var GRP_DESCR = document.getElementById("GRP_DESCR").value;
			    
			    if(GRP_NAME==null){
			    	
			    	showTip(document.sitechform.GRP_NAME,"群组名称不能为空！请从新选择后输入");
			        sitechform.GRP_NAME.focus();
			        return;
			    }
			    if(ACCEPT_NO==null){
			    	
			    	showTip(document.sitechform.ACCEPT_NO,"属主号码不能为空！请从新选择后输入");
			        sitechform.ACCEPT_NO.focus();
			        return;
			    }
			    
			  var myPacket = new AJAXPacket("k505_editsave_obj.jsp","正在提交，请稍候......");
			  myPacket.data.add("GRP_NAME",GRP_NAME);
				myPacket.data.add("ACCEPT_NO",ACCEPT_NO);
				myPacket.data.add("GRP_DESCR",GRP_DESCR);
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
						//alert("插入成功");
						rdShowMessageDialog("成功",2);
						window.dialogArguments.submitMe('1');
					  window.close();
					}else if(retCode=="44444"){
						rdShowMessageDialog("失败，该群组名称以存在！",0);
						return false;
					}else{
						//alert("插入失败!");
						rdShowMessageDialog("失败",0);
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
					更改群组信息
				</div>
				<table  cellspacing="0">
					
					<tr>
						<td>
						群组名称：
						</td>
						<td>
						<input type="text" name="GRP_NAME" id="GRP_NAME" value="<%=GRP_NAME %>"><font color="orange">*</font>
						</td>
					</tr>
					<tr>
						<td>
						属主号码：
						</td>
						<td>
						<input type="text" name="ACCEPT_NO" id="ACCEPT_NO" value="<%=ACCEPT_NO %>" disabled >
						</td>
					</tr>
					<tr>
						<td>
						备注：
						</td>
						<td>
						<input type="text" name="GRP_DESCR" id="GRP_DESCR" value="<%=GRP_DESCR %>">
						</td>
					</tr>
					<tr>
						<td colspan="2" align="right">
				        <input type="button" name="cfm" class="b_foot" value="确认" onclick="modCfmUP();"/>
					    <input type="button" name="clo" class="b_foot" value="关闭" onclick="javascript:window.close();"/>
						</td>
					</tr>
				</table>
			</div>
		</form>
	    <%@ include file="/npage/include/footer.jsp"%>		
	</body>	  

</html>