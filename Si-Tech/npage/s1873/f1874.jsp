<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType= "text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp"%>
<%@ include file="/npage/bill/getMaxAccept.jsp"%>
<%
	String workNo = (String)session.getAttribute("workNo");
	String workName = (String)session.getAttribute("workName");
	String regionCode = ((String)session.getAttribute("orgCode")).substring(0,2);
	
    java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd");
    java.util.Date currentTime_1 = new java.util.Date();
    String today = formatter.format(currentTime_1);  
    
	String password = (String)session.getAttribute("password");
	String[][]  favInfo = (String[][])session.getAttribute("favInfo");
	String printAccept="";
	printAccept = getMaxAccept();
	System.out.println("printAccept="+printAccept);
	String opCode = request.getParameter("opCode");
	String opName = request.getParameter("opName");
	if(opCode == null || "".equals(opCode))
	{
		opCode = "1873";
	}
	
	if(opName == null || "".equals(opName))
	{
		opName = "随E行G3上网笔记本/手机状态变更";
	}
	
	
    String[][] result = null; 
%>
	<head>
		<title>随e行3G上网本/手机用户状态变更</title>
		<script language="JavaScript">
			onload=function(){
				getBeforePrompt("<%=opCode%>");
				self.status="";
				init();
			}
			
			function init(){
				var myPacket = new AJAXPacket("f1874Init.jsp","正在获得信息，请稍候......");
				myPacket.data.add("phone_no",document.all.phone_no.value);
				myPacket.data.add("opType","init");
				core.ajax.sendPacket(myPacket);	
				myPacket=null;

			}
			
			function doProcess(packet){
				var retCode = packet.data.findValueByName("retCode");
				var retMsg = packet.data.findValueByName("retMsg");
				var opType = packet.data.findValueByName("opType");
				if(retCode == "000000"){
					var result = packet.data.findValueByName("result");
					var result1 = packet.data.findValueByName("result1");
					if(opType == "init"){
							if("N" == result[10]) {
									rdShowMessageDialog(retMsg);
									document.form1.op_code.disabled = true;
									document.form1.confirm.disabled = true;
									document.form1.reset.disabled = true;
							}
							with(document.form1){
								cust_name.value = result[2];
								cust_id.value = result[3];
								id_no.value = result[4];
								sm_code.value = result[5];
								run_name.value = result[6];
								//usim_no.value = result[7];
								biz_type.value = result[9];
								state_code.value = result[11];
							}
							for(var i=0;i<result1[0].length;i++){
									//alert(result1[0][i]+result1[1][i]);
									document.all.mode_code.value=result1[0][i]+"-"+result1[1][i];
							}
							
					}else{
						rdShowMessageDialog(retMsg);
						window.location.reload();
	    				window.location.replace("f1874.jsp?activePhone=<%=activePhone%>");
					}
				}else{
					rdShowMessageDialog(retMsg);
					parent.removeTab(<%=opCode%>);
					//window.location.reload();
					//document.form1.op_code.disabled = true;
				}
			}
			function printCommit(){
				if(document.all.op_code.value=="0"){
					rdShowMessageDialog("请选择操作类型!");
					document.all.op_code.focus();
					return false;
				}		
				getAfterPrompt(document.all.op_code.value);		
				var ret = showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes"); 
				  if(typeof(ret)!="undefined")
				  {
				    if((ret=="confirm"))
				    {
				      if(rdShowConfirmDialog('确认电子免填单吗？')==1)
				      {
					    doCfm();
				      }
					}
					if(ret=="continueSub")
					{
				      if(rdShowConfirmDialog('确认要提交信息吗？')==1)
				      {
					    doCfm();
				      }
					}
				  }
				  else
				  {
				     if(rdShowConfirmDialog('确认要提交信息吗？')==1)
				     {
					   doCfm();
				     }
				  }			
			}		
			function doCfm(){
				with(document.form1){
					if(op_code.value=="0"){
						rdShowMessageDialog("请选择操作类型!");
						op_code.focus();
					}else{
						var myPacket = new AJAXPacket("f1874Cfm.jsp","正在获得信息，请稍候......");
						myPacket.data.add("opType","confirm");
						myPacket.data.add("phone_no",phone_no.value);
						myPacket.data.add("op_code",op_code.value);
						myPacket.data.add("op_name",op_code.options[document.all.op_code.selectedIndex].text);
						myPacket.data.add("login_no","<%=workNo%>");
						myPacket.data.add("printAccept","<%=printAccept%>");
						core.ajax.sendPacket(myPacket);	
						myPacket=null;
					}
				}
			}
			function showPrtDlg(printType,DlgMessage,submitCfm)
			{  //显示打印对话框 
				var h=210;
				var w=400;
				var t=screen.availHeight/2-h/2;
				var l=screen.availWidth/2-w/2;
				var pType="subprint";
				var billType="1";  
				var printStr = printInfo(printType);
			   
				var mode_code=null;
				var fav_code=null;
				var area_code=null;
				
				
				var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"; 
				var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage;
				var path = path  + "&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept=<%=printAccept%>&phoneNo=<%=activePhone%>&submitCfm=" + submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
				var ret=window.showModalDialog(path,printStr,prop);
				return ret;    
			}
			
			function printInfo(printType)
			{
			     var cust_info="";
				 var opr_info="";
				 var note_info1="";
				 var note_info2="";
				 var note_info3="";
				 var note_info4="";
			  
				 var retInfo = "";
				 
				cust_info+="手机号码：   "+document.all.phone_no.value+"|";
				cust_info+="客户姓名：   "+document.all.cust_name.value+"|";

			opr_info+="用户品牌："+document.all.sm_code.value+"    业务类型："+document.all.biz_type.value+"之"+document.all.op_code.options[document.all.op_code.selectedIndex].text+" |";
				opr_info+="操作流水：<%=printAccept%>" +"|";
				if(document.all.op_code.value=="1884"){
					opr_info+="本次办理资费: "+document.all.mode_code.value +"|";
					opr_info+="资费失效时间：当日"+"|";
				}
				note_info1+="备注："+"|";
			  
				retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
				retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
			    return retInfo;	
			}		
			function topage(opcode,valideVal,openflag,title,targetUrl)
			{
				 if((typeof parent.L)=="function")
				 {
				 		parent.L(openflag,opcode,title,targetUrl,valideVal);
				 }else{
						parent.parent.L(openflag,opcode,title,targetUrl,valideVal);
				 }
			}
			
			$(function(){
				$('#wait').show();
				getOpRela();
			}); 
			
			function getOpRela()
			{
				var packet = new AJAXPacket("/npage/include/getOpRela.jsp","请稍后...");
				packet.data.add("opCode" ,"<%=opCode%>");
			  core.ajax.sendPacketHtml(packet,doGetOpRela,true);//异步
				packet =null;
			}
			
			function doGetOpRela(data)
			{
				if(data.trim()!="")
				{
					$('#relationArea').html(data);
					$('#relationArea').show();
				}
			}
			
			function getBeforePrompt(opCode)
			{
				var packet = new AJAXPacket("/npage/include/getBeforePrompt.jsp","请稍后...");
				packet.data.add("opCode" ,opCode);
			  core.ajax.sendPacketHtml(packet,doGetBeforePrompt,true);//异步
				packet =null;
			}
			
			function doGetBeforePrompt(data)
			{
				$('#wait').hide();
				$('#beforePrompt').html(data);
			}
			
			function getAfterPrompt(opCode)
			{
				var packet = new AJAXPacket("/npage/include/getAfterPrompt.jsp","请稍后...");
				packet.data.add("opCode" ,opCode);
			  core.ajax.sendPacket(packet,doGetAfterPrompt,false);//同步
				packet =null;
			}
			
			function doGetAfterPrompt(packet)
			{
		    var retCode = packet.data.findValueByName("retCode"); 
		    var retMsg = packet.data.findValueByName("retMsg"); 
		    if(retCode=="000000"){
		    	promtFrame(retMsg);
		    }
			}
			
			
		 function getMidPrompt(classCode,classValue,id)
			{
				var packet = new AJAXPacket("/npage/include/getMidPrompt.jsp","请稍后...");
				packet.data.add("opCode" ,"<%=opCode%>");
				packet.data.add("classCode" ,classCode);
				packet.data.add("classValue" ,classValue);
				packet.data.add("id" ,id);
				core.ajax.sendPacket(packet,doGetMidPrompt,true);//异步
				packet =null;
			}
			
			
			function doGetMidPrompt(packet)
			{
			
		    var retCode = packet.data.findValueByName("retCode"); 
		    var retMsg = packet.data.findValueByName("retMsg"); 
		    var id = packet.data.findValueByName("id"); 
		    if(retCode=="000000"){
						document.getElementById(id).className = "promptBlue";
						$("#"+id).attr("title",retMsg);
						$("#"+id).tooltip();
				}else
					{
						document.getElementById(id).className = "";
						$("#"+id).attr("title","");
						$("#"+id).tooltip();
					}
			}			
			function getBefore()
			{
				getBeforePrompt(document.all.op_code.value);
			}			
		</script>
	</head>
	<body>
		<form action="" method="post" name="form1">
			<%@ include file="/npage/include/header.jsp" %>
			<div class="title">
				<div id="title_zi">付费号码信息</div>
			</div>
			<table cellspacing="0">
				<tr> 
					<td > 服务号码 </td>
					<td  colspan="3">
						<input Class="InputGrey" readOnly id=Text2 type=text maxlength=11 name="phone_no"  value ="<%=activePhone%>" onKeyPress="return isKeyNumberdot(0)" v_minlength=1 v_maxlength=11 v_type="mobphone"  v_name="手机号" v_must="1" maxlength="11" index="0">
					</td>
				</tr> 
				<tr>
					<td> 客户名称 </td>
					<td>
						<input type="text" name="cust_name" class="InputGrey" readOnly/>
					</td>
					<td> 客户编号 </td>
					<td>
						<input type="text" name="cust_id" class="InputGrey" readOnly/>
					</td>
				</tr>
				<tr>
					<td> 用户编号 </td>
					<td>
						<input type="text" name="id_no" class="InputGrey" readOnly/>
					</td>
					<td> 用户品牌 </td>
					<td>
						<input type="text" name="sm_code" class="InputGrey" readOnly/>
					</td>
				</tr>
				<tr>
					<td> 用户状态 </td>
					<td colspan="3">
						<input type="text" name="run_name" class="InputGrey" readOnly/>
					</td>
				</tr>
			</table>
			<div class="title">
				<div id="title_zi">随e行G3上网笔记本/手机业务信息</div>
			</div>			
			<table  cellspacing="0">
				<tr>
					<!--td> 内置卡号 </td>
					<td>
						<input type="text" name="usim_no" class="InputGrey" readOnly/>
					</td-->
					<td> 业务类型 </td>
					<td>
						<input type="text" name="biz_type" class="InputGrey" readOnly/>
					</td>
					<td> 内置卡状态 </td>
					<td>
						<input type="text" name="state_code" class="InputGrey" readOnly/>
					</td>					
				</tr>
				<!--tr>
					<td> 内置卡状态 </td>
					<td colspan="3">
						<input type="text" name="state_code" class="InputGrey" readOnly/>
					</td>
				</tr-->
			</table>
			<div class="title">
				<div id="title_zi">操作</div>
			</div>				
			<table cellspacing="0">
				<tr>
					<td> 操作类型 </td>
					<td>
						<select name="op_code" onchange="getBefore();">
							<option value="0">---请选择---</option>
							<option value="1874"> 业务暂停 </option>
							<option value="2054"> 业务恢复 </option>
							<option value="1876"> 内置卡挂失 </option>
							<option value="2055"> 内置卡解挂 </option>
							<option value="1884"> 内置卡去绑定 </option>
						</select>
					</td>
				</tr>
			</table>	

			<table cellspacing="0">
				<tr> 
					<td id="footer" noWrap colspan="6"> 
						<div align="center"> 
							<input class="b_foot" name="confirm"  type="button" value="提交" onclick="printCommit();">&nbsp; 
							<input class="b_foot" name="button"  type="button" value="关闭" onclick="parent.removeTab(<%=opCode%>)">&nbsp; 
						</div>
					</td>
				</tr> 
			</table>
			<div id="relationArea" style="display:none"></div>
						<div id="wait" style="display:none">
						<img  src="/nresources/default/images/blue-loading.gif" />
					</div>
					<div id="beforePrompt"></div>			
			<%@ include file="/npage/include/footer_simple.jsp" %>
			<input type="hidden" name="mode_code" value=""/>
		</form>
	</body>
</html>
<%@ include file="/npage/common/pwd_comm.jsp" %>
