
<%
	 /*
	 * 功能: 12580群组-新建编辑
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
  
  String opCode = "K505";
  String opName = "群组维护";
  
  String ACCEPT_NO = "";
  String phone_date = "";
  String phone_month = "";
  String phone_yeas = "";
  
   ACCEPT_NO = request.getParameter("ACCEPT_NO");
  
%>

<html>
	<head>
		<title>群组</title>
		<script language="JavaScript" type="text/JavaScript" src="../../inputops.js"></script>
		<script language=javascript>
		
		function submitInContent(){
			var GRP_NAME = document.getElementById("GRP_NAME").value;
			var GRP_DESCR = document.getElementById("GRP_DESCR").value;
			
			 if(GRP_NAME == ""){
			    	showTip(document.sitechform.GRP_NAME,"群组名称不能为空！请从新选择后输入");
			        sitechform.GRP_NAME.focus();
			        return;
			    }
			var myPacket = new AJAXPacket("k505_newsave_obj.jsp","正在提交，请稍候......");
			
			myPacket.data.add("GRP_NAME",GRP_NAME); 
			myPacket.data.add("GRP_DESCR",GRP_DESCR);
			myPacket.data.add("ACCEPT_NO",<%=ACCEPT_NO%>);
			
			core.ajax.sendPacket(myPacket,doProcess,true);			
			document.sitechform.GRP_NAME.value="";
			document.sitechform.GRP_DESCR.value="";
			myPacket=null;
			
		}
		function doProcess(myPacket)
		{
		
		    var retType = myPacket.data.findValueByName("retType");
			var retCode = myPacket.data.findValueByName("retCode");
			var retMsg = myPacket.data.findValueByName("retMsg");
			var SERIAL_NO = myPacket.data.findValueByName("SERIAL_NO");
		    var PERSON_ID = document.getElementById("PERSON_ID").value;
			
				if(retCode=="000000"){
					//alert("插入成功");
					rdShowMessageDialog("成功",2);
				    document.all.frameSelectGRP.contentWindow.location="../../../../callbosspage/12580/9KA52/K505/k505_frameSelectGRP_GRP.jsp?ACCEPT_NO=<%=ACCEPT_NO %>&SERIAL_NO="+SERIAL_NO+"&PERSON_ID="+PERSON_ID;             
				   // document.all.frameSelectPERSON.contentWindow.location="../../../../callbosspage/12580/9KA52/K505/k505_frameSelectPERSON_GRP.jsp?SERIAL_NO="+SERIAL_NO;             
				}else if(retCode=="11111"){
					
					rdShowMessageDialog("失败,该群组中已有相同名称，请更换",0);
					return false;
				}else if(retCode=="22222"){
					
					rdShowMessageDialog("失败,该群组中已存在此号码，请更换",0);
					return false;
				}else if(retCode=="33333"){
					
					rdShowMessageDialog("失败,此号码已存在，请更换",0);
					return false;
				}else if(retCode=="44444"){
					
					rdShowMessageDialog("群组数已超过10个",0);
					return false;
				}else if(retCode=="55555"){
					
					rdShowMessageDialog("该群组中电话号码已超过20个",0);
					return false;
				}else{
					//alert("插入失败!");
					rdShowMessageDialog("失败",0);
					return false;
				}
		}
		function submitAddContent(){
			
			var GRP_ID = document.getElementById("GRP_ID").value;
			
			var PERSON_NAME = document.getElementById("PERSON_NAME").value;
			var PERSON_PHONE = document.getElementById("PERSON_PHONE").value;
			var PERSON_FAX = document.getElementById("PERSON_FAX").value;
			var PERSON_EMAIL = document.getElementById("PERSON_EMAIL").value;
			var PERSON_QQ = document.getElementById("PERSON_QQ").value;
			
			var phone_yeas = document.getElementById("phone_yeas").value;
			var phone_month = document.getElementById("phone_month").value;
			var phone_date = document.getElementById("phone_date").value;
			var PERSON_UNIT = document.getElementById("PERSON_UNIT").value;
			var PERSON_DESCR = document.getElementById("PERSON_DESCR").value;
			
			var PERSON_BIRTH = phone_yeas+"-"+phone_month+"-"+phone_date;
			
			var SEX = document.getElementById("PERSON_SEXM").checked;
			var PERSON_SEX;
			if(SEX){
				PERSON_SEX = "M";
			}else{
				PERSON_SEX = "F";
			}
		
			if(GRP_ID == ""){
		    	rdShowMessageDialog("请先选中一个群组!",0);
		        return;
			}						
			
			if(PERSON_PHONE == ""){
		    	showTip(document.sitechform.PERSON_PHONE,"主号码不能为空！请从新选择后输入");
		        sitechform.PERSON_PHONE.focus();
		        return;
			}
			if(!f_check_mobile(PERSON_PHONE)){;
				showTip(document.sitechform.PERSON_PHONE,"主号码格式不正确！请从新选择后输入");
		    sitechform.PERSON_PHONE.focus();
				return;
			}
			
			var myPacket = new AJAXPacket("k505_addsave_obj.jsp","正在提交，请稍候......");
			
			myPacket.data.add("GRP_ID",GRP_ID); 
			myPacket.data.add("PERSON_NAME",PERSON_NAME);
			myPacket.data.add("PERSON_PHONE",PERSON_PHONE);
			myPacket.data.add("PERSON_FAX",PERSON_FAX);
			myPacket.data.add("PERSON_EMAIL",PERSON_EMAIL);
			myPacket.data.add("PERSON_QQ",PERSON_QQ);
			myPacket.data.add("PERSON_UNIT",PERSON_UNIT);
			myPacket.data.add("PERSON_BIRTH",PERSON_BIRTH);
			myPacket.data.add("PERSON_SEX",PERSON_SEX);
			myPacket.data.add("PERSON_DESCR",PERSON_DESCR);
			myPacket.data.add("ACCEPT_NO",<%=ACCEPT_NO%>);
			
			core.ajax.sendPacket(myPacket,doProcess,true);
			document.getElementById("PERSON_NAME").value = "";
			document.getElementById("PERSON_PHONE").value = "";
			document.getElementById("PERSON_FAX").value = "";
			document.getElementById("PERSON_EMAIL").value = "";
			document.getElementById("PERSON_QQ").value = "";
			document.getElementById("phone_yeas").value = "";
			document.getElementById("phone_month").value = "";
			document.getElementById("phone_date").value = "";
			document.getElementById("PERSON_UNIT").value = "";
			document.getElementById("PERSON_DESCR").value = "";
			
			myPacket=null;
		}
		function submitUpContent(){
			var GRP_ID = document.getElementById("GRP_ID").value;
			var PERSON_ID = document.getElementById("PERSON_ID").value;
			
			var PERSON_NAME = document.getElementById("PERSON_NAME").value;
			var PERSON_PHONE = document.getElementById("PERSON_PHONE").value;
			var PERSON_FAX = document.getElementById("PERSON_FAX").value;
			var PERSON_EMAIL = document.getElementById("PERSON_EMAIL").value;
			var PERSON_QQ = document.getElementById("PERSON_QQ").value;
			
			var phone_yeas = document.getElementById("phone_yeas").value;
			var phone_month = document.getElementById("phone_month").value;
			var phone_date = document.getElementById("phone_date").value;
			var PERSON_UNIT = document.getElementById("PERSON_UNIT").value;
			var PERSON_DESCR = document.getElementById("PERSON_DESCR").value;
			
			var PERSON_BIRTH = phone_yeas+"-"+phone_month+"-"+phone_date;
			
			var SEX = document.getElementById("PERSON_SEXM").checked;
			var PERSON_SEX;
			if(SEX){
				PERSON_SEX = "M";
			}else{
				PERSON_SEX = "F";
			}
			
			if(PERSON_PHONE == ""){
		    	showTip(document.sitechform.PERSON_PHONE,"主号码不能为空！请从新选择后输入");
		        sitechform.PERSON_PHONE.focus();
		        return;
			}
			
			if(!f_check_mobile(PERSON_PHONE)){;
				showTip(document.sitechform.PERSON_PHONE,"主号码格式不正确！请从新选择后输入");
		    sitechform.PERSON_PHONE.focus();
				return;
			}
			
			if(PERSON_ID == ""){
		    	rdShowMessageDialog("请选中一条联系人记录！",0);
		        return;
			}
			
			var myPacket = new AJAXPacket("k505_updatesave_obj.jsp","正在提交，请稍候......");
			
			myPacket.data.add("GRP_ID",GRP_ID); 
			myPacket.data.add("PERSON_ID",PERSON_ID);
			myPacket.data.add("PERSON_NAME",PERSON_NAME);
			myPacket.data.add("PERSON_PHONE",PERSON_PHONE);
			myPacket.data.add("PERSON_FAX",PERSON_FAX);
			myPacket.data.add("PERSON_EMAIL",PERSON_EMAIL);
			myPacket.data.add("PERSON_QQ",PERSON_QQ);
			myPacket.data.add("PERSON_UNIT",PERSON_UNIT);
			myPacket.data.add("PERSON_BIRTH",PERSON_BIRTH);
			myPacket.data.add("PERSON_SEX",PERSON_SEX);
			myPacket.data.add("PERSON_DESCR",PERSON_DESCR);
			
			document.getElementById("PERSON_NAME").value = "";
			document.getElementById("PERSON_PHONE").value = "";
			document.getElementById("PERSON_FAX").value = "";
			document.getElementById("PERSON_EMAIL").value = "";
			document.getElementById("PERSON_QQ").value = "";
			document.getElementById("phone_yeas").value = "";
			document.getElementById("phone_month").value = "";
			document.getElementById("phone_date").value = "";
			document.getElementById("PERSON_UNIT").value = "";
			document.getElementById("PERSON_DESCR").value = "";
			
			core.ajax.sendPacket(myPacket,doProcess,true);
			myPacket=null;
		}
		function submitDelContent(){
			var GRP_ID = document.getElementById("GRP_ID").value;
			var PERSON_ID = document.getElementById("PERSON_ID").value;
			
			if(GRP_ID == ""){
		    	rdShowMessageDialog("请选中一个群组对象！",0);
		        return;
			}
			if(PERSON_ID == ""){
		    	rdShowMessageDialog("请选中一条联系人记录！",0);
		        return;
			}
			var flag=window.confirm("确实要删除吗?");
    		if(flag==true){
    		    document.getElementById("PERSON_ID").value = "";
				var myPacket = new AJAXPacket("k505_delete_obj.jsp","正在提交，请稍候......");
				
				myPacket.data.add("GRP_ID",GRP_ID); 
				myPacket.data.add("PERSON_ID",PERSON_ID);
				
				core.ajax.sendPacket(myPacket,doProcess);
				
				document.getElementById("PERSON_NAME").value = "";
				document.getElementById("PERSON_PHONE").value = "";
				document.getElementById("PERSON_FAX").value = "";
				document.getElementById("PERSON_EMAIL").value = "";
				document.getElementById("PERSON_QQ").value = "";
				document.getElementById("phone_yeas").value = "";
				document.getElementById("phone_month").value = "";
				document.getElementById("phone_date").value = "";
				document.getElementById("PERSON_UNIT").value = "";
				document.getElementById("PERSON_DESCR").value = "";
				myPacket=null;
			}
		}
		function submitSelContent(){
			var GRP_ID = document.getElementById("GRP_ID").value;
			
			var PERSON_NAME = document.getElementById("PERSON_NAME").value;
			var PERSON_PHONE = document.getElementById("PERSON_PHONE").value;
			var PERSON_FAX = document.getElementById("PERSON_FAX").value;
			var PERSON_EMAIL = document.getElementById("PERSON_EMAIL").value;
			var PERSON_QQ = document.getElementById("PERSON_QQ").value;
			
			var phone_yeas = document.getElementById("phone_yeas").value;
			var phone_month = document.getElementById("phone_month").value;
			var phone_date = document.getElementById("phone_date").value;
			var PERSON_UNIT = document.getElementById("PERSON_UNIT").value;
			var PERSON_DESCR = document.getElementById("PERSON_DESCR").value;
			
			var PERSON_BIRTH = phone_yeas+"-"+phone_month+"-"+phone_date;
			
			var SEX = document.getElementById("PERSON_SEXM").checked;
			var PERSON_SEX;
			if(SEX){
				PERSON_SEX = "M";
			}else{
				PERSON_SEX = "F";
			}
			
			if(GRP_ID == ""){
		    	rdShowMessageDialog("请选中一个群组对象！",0);
		        return;
			}
			
			var src = "../../../../callbosspage/12580/9KA52/K505/k505_frameSelectPERSON_GRP.jsp?SERIAL_NO="+GRP_ID+"&ACCEPT_NO=<%=ACCEPT_NO%>";
			
			if(PERSON_NAME != ""){
				
				src = src+"&PERSON_NAME="+PERSON_NAME;
			}
			if(PERSON_PHONE != ""){
				
				src = src+"&PERSON_PHONE="+PERSON_PHONE;
			}
			if(PERSON_FAX != ""){
				
				src = src+"&PERSON_FAX="+PERSON_FAX;
			}
			if(PERSON_EMAIL != ""){
				
				src = src+"&PERSON_EMAIL="+PERSON_EMAIL;
			}
			if(PERSON_QQ != ""){
				
				src = src+"&PERSON_QQ="+PERSON_QQ;
			}
			if(PERSON_UNIT != ""){
				
				src = src+"&PERSON_UNIT="+PERSON_UNIT;
			}
			if(PERSON_DESCR != ""){
				
				src = src+"&PERSON_DESCR="+PERSON_DESCR;
			}
			if(PERSON_SEX != ""){
				
				src = src+"&PERSON_SEX="+PERSON_SEX;
			}
			if(PERSON_BIRTH != ""){
				
				src = src+"&PERSON_BIRTH="+PERSON_BIRTH;
			}
			
			
			document.all.frameSelectPERSON.contentWindow.location=src;
		}
		</script>
	</head>
	<body>
		  <%@ include file="/npage/include/header.jsp"%>
		  <form name="sitechform" id="sitechform">
		    
	  	    <div id="Operation_Table">
				<table  cellspacing="0" cellpadding="0" border="0" height="440px">
					<tr>
						<td valign="top" width="20%" rowspan="3">
							<div id="GRP_TREE">
                            	<iframe style="height:100%" name="frameSelectGRP" id="frameSelectGRP" src="../../../../callbosspage/12580/9KA52/K505/k505_frameSelectGRP_GRP.jsp?ACCEPT_NO=<%=ACCEPT_NO %>" FRAMEBORDER="0" SCROLLING="auto" width="100%"></iframe>
							</div>
						</td>
						<td valign="top" nowrap="nowrap" height="10%">
							
							    <b>群组信息设置</b><br>
							    群组名称：<input type="text" name="GRP_NAME" id="GRP_NAME" value="" width="8" onClick="hiddenTip(this);"><font color="orange">*</font> &nbsp;
							    群组描述：<input type="text" name="GRP_DESCR" id="GRP_DESCR" value="" width="8"> &nbsp;
							    <input name="delete_value" class="b_foot" type="button" id="add" value="增加" onClick="submitInContent();"> 
							
						</td>
					</tr>
					<tr>
						<td  height="45%">
						
							<iframe style="height:100%" name="frameSelectPERSON" src="../../../../callbosspage/12580/9KA52/K505/k505_frameSelectPERSON_GRP.jsp" FRAMEBORDER="0" SCROLLING="YES" width="100%"></iframe>
						</td>
					</tr>
					<tr>
					    <td height="45%"  valign="top" nowrap="nowrap" >
							 <b>联系人详细信息</b>
							 <table  cellspacing="0" cellpadding="0" border="0" >
							 	<tr>
							 		<td>
							 			  姓名：
							 		</td>
							 		<td>
							 			<input type="hidden" name="GRP_ID" id="GRP_ID" value="" />
							 			<input type="hidden" name="PERSON_ID" id="PERSON_ID" value="" />
							 			<input type="text" name="PERSON_NAME" id="PERSON_NAME" value="" width="8">
							 		</td>
							 		<td>
							 			  主号码：
							 		<td>
							 			<input type="text" name="PERSON_PHONE" id="PERSON_PHONE" value="" width="8" onClick="hiddenTip(this);"><font color="orange">*</font>
							 		</td>
							 		<td rowspan="6">
								 		<input name="add_value" class="b_foot" type="button" id="add" value="增加" onClick="submitAddContent();"> <br>
							 			<input name="update_value" class="b_foot" type="button" id="update" value="修改" onClick="submitUpContent();"> <br>
			 			     	        <input name="delete_value" class="b_foot" type="button" id="delete" value="删除" onClick="submitDelContent();"> <br>
		 			     	     	    <input name="select_value" class="b_foot" type="button" id="select" value="查找" onClick="submitSelContent();"> <br>
		 			     	     	    <input name="close_value" class="b_foot" type="button" id="close" value="关闭" onClick="window.close();">
							 		</td>
							 	</tr>
							 	<tr>
							 		<td>
							 			  传真：
							 		</td>
							 		<td>
							 			<input type="text" name="PERSON_FAX" id="PERSON_FAX" value="" width="8">
							 		</td>
							 		<td>
							 			  邮箱：
							 		</td>
							 		<td>
							 			<input type="text" name="PERSON_EMAIL" id="PERSON_EMAIL" value="" width="8">
							 		</td>
							 	
							 	</tr>
							 	<tr>
							 		<td>
							 			  QQ/BP：
							 		</td>
							 		<td>
							 			<input type="text" name="PERSON_QQ" id="PERSON_QQ" value="" width="8">
							 		</td>
							 		<td>
							 	           性别：
							 		</td>
							 		<td>
							 			男<input type="radio" name="PERSON_SEX" id="PERSON_SEXM" checked="checked" value="M">
							 			女<input type="radio" name="PERSON_SEX" id="PERSON_SEXF" value="F">
							 		</td>
							 	</tr>
							 	<tr>
							 	    <td>
							 	    	生日
							 	    	
							 	    </td>
							 		<td nowrap="nowrap" colspan="3"> 
				             
							           <select name="phone_yeas" id="phone_yeas" size="1">
							           <%for(int i = 0;i<40;i++){ %>
							               <option value="<%=i+1970 %>"  <%if((""+(i+1970)).equals(phone_yeas)){ %>selected <%} %>><%=i+1970 %></option>
							           <%} %>   
							           </select>年
							           <select name="phone_month" id="phone_month" size="1">
							           <%for(int i = 0;i<12;i++){ %>
							               <option value="<%=i+1 %>"  <%if((""+(i+1)).equals(phone_month)){ %>selected <%} %>><%=i+1 %></option>
							           <%} %>   
							           </select>月
							           <select name="phone_date" id="phone_date" size="1">
							           <%for(int i = 0;i<31;i++){ %>
							               <option value="<%=i+1 %>"  <%if((""+(i+1)).equals(phone_date)){ %>selected <%} %>><%=i+1 %></option>
							           <%} %> 
							           </select>日
							        </td>
							 	</tr>
							 	<tr>
							 		<td nowrap="nowrap">	
							 			单位信息
							 	    </td>
							 		<td colspan="3">
							 			<input type="text" name="PERSON_UNIT" id="PERSON_UNIT" value="" size="50%">
							 		</td >
							 	</tr>
							 	<tr>
							 		<td>
							 			备注
							 	    </td>
							 		<td colspan="3">
							 			<input type="text" name="PERSON_DESCR" id="PERSON_DESCR" value="" size="50%">
							 		</td >
							 	</tr>
							</table>
						</td>
					</tr>
				</table>
			</div>	
	    </form>
	    <%@ include file="/npage/include/footer.jsp"%>	
	</body>	
</html>
