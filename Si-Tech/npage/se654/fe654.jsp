<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%
    response.setHeader("Pragma","No-cache");
    response.setHeader("Cache-Control","no-cache");
    response.setDateHeader("Expires", 0);
%>
<%
		String opCode = WtcUtil.repNull(request.getParameter("opCode"));	
		String opName = WtcUtil.repNull(request.getParameter("opName"));	
		
		String ipAddress = (String)session.getAttribute("ipAddr");
		String loginNo = (String)session.getAttribute("workNo");
		String workname = (String)session.getAttribute("workName");
		String orgCode = (String)session.getAttribute("orgCode");
		String loginPwd  = (String)session.getAttribute("password");
		String Department = (String)session.getAttribute("orgCode");
		String regionCode = Department.substring(0,2);
		String districtCode = Department.substring(2,4);
		String strDate=new SimpleDateFormat("yyyyMMdd").format(Calendar.getInstance().getTime());
		//System.out.println(")))))))))))))))))))))))))))))0="+strDate);
%>
<%  
  //获取从上页得到的信息
	String loginAccept = request.getParameter("login_accept");
	if(loginAccept == null)
	{			
	//获取系统流水
%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="regionCode" routerValue="<%=regionCode%>"  id="req" />
<%		
		loginAccept=req;	
	}
%>
	<head>
		<title>
			<%=opName%>
		</title>
		<script type=text/javascript>
		function doProcess(packet)
		{
			//RPC处理函数findValueByName
			var retType = packet.data.findValueByName("retType");
			var retCode = packet.data.findValueByName("retCode"); 
			var retMessage = packet.data.findValueByName("retMessage"); 
			if(retType == "QryPhoneInfo"){
				var cust_id = packet.data.findValueByName("cust_id");
				var cust_name = packet.data.findValueByName("cust_name");
				var run_code = packet.data.findValueByName("run_code");
				var run_name = packet.data.findValueByName("run_name");
				var id_no = packet.data.findValueByName("id_no");
				if(retCode=="000000")
				{
					document.all.cust_id.value = cust_id;
					document.all.cust_name.value = cust_name;
					document.all.run_name.value = run_name;
					document.all.id_no.value = id_no;
					
				}else
				{
					retMessage = "错误" + retCode + "："+retMessage;
					rdShowMessageDialog(retMessage);
					return false;
				}  		
			}
			if(retType == "QryEcSiInfo"){
					var ECSIID = packet.data.findValueByName("ECSIID");
					var cust_name = packet.data.findValueByName("cust_name");

				
				if(retCode=="000000"){
					 if(ECSIID!=""){
					 document.all.ECSIID.value = ECSIID;
					 document.all.cust_name.value = cust_name;
					 document.all.confirm.disabled=false;
					 document.all.cust_id.readOnly=true;
					 //document.all.cust_status.value = cust_status;					
					//retMessage = "此EC/SI编号正确" + retCode  ;
					//rdShowMessageDialog(retMessage);
				  }else{
				  		retMessage = "查询失败，没有此条记录！";
					    rdShowMessageDialog(retMessage);
					    return false;
				  }
				}else
				{
					retMessage = "错误" + retCode + "："+retMessage;
					rdShowMessageDialog(retMessage);
					return false;
				}
			}
				//取流水
			if(retType == "getSysAccept")
			{
				if(retCode == "000000")
				{
					var sysAccept = packet.data.findValueByName("sysAccept");
					document.frm.loginAccept.value=sysAccept;
		
				}else{
					rdShowMessageDialog("查询流水出错,请重新获取！");
					return false;
				}
			}
		}		

			//得到号码信息
	/*function QryPhoneInfo()
		{
			if (document.frm.phoneNo.value == "")
			{
				rdShowMessageDialog("手机号码不能为空！");
				document.frm.phoneNo.focus();
				return false;		
			}

			var checkPwd_Packet = new AJAXPacket("../se654/getPhoneInfo.jsp","正在进行密码校验，请稍候......");
			checkPwd_Packet.data.add("retType","QryPhoneInfo");
			checkPwd_Packet.data.add("loginNo",<%=loginNo%>);
			checkPwd_Packet.data.add("phoneNo",document.frm.phoneNo.value);
			core.ajax.sendPacket(checkPwd_Packet);
			checkPwd_Packet = null;
		}*/



		function QryEcSiInfo()
		{
			if (document.frm.cust_id.value == "")
			{
				rdShowMessageDialog("EC/SI编码不能为空！");
				document.frm.ECSIID.focus();
				return false;		
			}	
			var checkPwd_Packet = new AJAXPacket("QryEcSiInfo.jsp","正在进行查询，请稍候......");
			checkPwd_Packet.data.add("retType","QryEcSiInfo");
			checkPwd_Packet.data.add("loginNo","<%=loginNo%>");
			checkPwd_Packet.data.add("black_type",document.frm.black_type.value);
			checkPwd_Packet.data.add("cust_id",document.frm.cust_id.value);
			checkPwd_Packet.data.add("ECSIType",document.frm.ECSIType.value);
			core.ajax.sendPacket(checkPwd_Packet);
			checkPwd_Packet = null;		
		}	


//取流水
function getSysAccept()
{
	var getSysAccept_Packet = new AJAXPacket("../s2897/pubSysAccept.jsp","正在生成操作流水，请稍候......");
	getSysAccept_Packet.data.add("retType","getSysAccept");
	core.ajax.sendPacket(getSysAccept_Packet);
	getSysAccept_Packet=null;
}			

			
		function conCfm()
		{		
			var EfftT=document.frm.EfftT.value;
			
			if(document.frm.EfftT.value=="")
			{
				rdShowMessageDialog("期望日期不能为空！");
				return;
			}
			
			var nowDate=  "<%=strDate%>";
			if(parseInt(EfftT)<parseInt(nowDate))
			{
				rdShowMessageDialog("期望日期不能小于当前日期！");
				return;
			}
			
			  var phoneNo=document.frm.phoneNo.value;
				var chPos_field ;
				var MobPhone;	
				var count=0;		
				while(phoneNo!=""){
				    chPos_field = phoneNo.indexOf("|");
				    MobPhone   =phoneNo.substring(0,chPos_field);
				    phoneNo = phoneNo.substring(chPos_field + 1);
					  //phoneNo=phoneNo.replace("\r\n","");
				    MobPhone = MobPhone.replace("\r\n","");       
				    count ++;
						if(count>50){
				      rdShowMessageDialog("添加的号码信息格式错误或成员数量超过30个！",0);
			        document.frm.phoneNo.focus();
			        return false;
					 }
			 }
			 
			 if(document.frm.black_type.value=="03"||document.frm.black_type.value=="04")
			 {
			 	if(document.frm.cust_id.value=="")
			 	{
			 		rdShowMessageDialog("EC/SI编码不能为空！");
					return;
			 	}
			 	
			 }
			 
			 document.frm.EcSiType1.value=document.frm.ECSIType.value;
			
			document.frm.opType.value="no";   //现在只提供号码录入方式			
			//getSysAccept();
			if (rdShowConfirmDialog("是否提交确认操作？")==1)
			{
				page = "fe654Cfm.jsp?opType="+document.frm.opType.value;
				frm.action=page;
				frm.method="post";
				frm.submit();
			}
			else{ 
				return false;
			}
		}
			
		function inputECSI()
		{
			if(document.frm.black_type.value == "03"||document.frm.black_type.value == "04"){

				document.all.tableNo.style.display="";
				document.all.tableNo1.style.display="";
				//document.all.tableNo2.style.display="";
				document.all.ECSIType.disabled =false;
				document.all.confirm.disabled=true;
			}else
			{
				document.all.tableNo.style.display="none";
				document.all.tableNo1.style.display="none";
				//document.all.tableNo2.style.display="none";
				document.all.ECSIType.disabled =true;
				document.all.confirm.disabled=false;
			}
			
		}
		
		function doclear()
		{
	 		window.location.href="fe654.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
	 	}
		
		</script>
	</head>

	<body>
		<form name="frm">
			<%@ include file="/npage/include/header.jsp" %>
			<input type="hidden" name="pageOpCode" value="<%=opCode%>">
			<input type="hidden" name="pageOpName" value="<%=opName%>">
			<input type="hidden" name="id_no">
			<input type="hidden" name="loginAccept"  value="<%=loginAccept%>"> <!-- 操作流水号 -->
			<input type="hidden" name="loginNo"  value="<%=loginNo%>">
			<input type="hidden" name="loginPwd"  value="<%=loginPwd%>">
			<input type="hidden" name="smName"  value="">
			<input type="hidden" name="grpName"  value="">
			<input type="hidden" name="opType"  value="124">
			<input type="hidden" name="orgCode"  value="<%=orgCode%>">
			<input type="hidden" name="ipAddress"  value="<%=ipAddress%>">
			<input type="hidden" name="EcSiType1"  value="">
			<div class="title">
					<div id="title_zi">请选择操作类型</div>
			</div>
					<TABLE cellSpacing="0">
						<TR>
							<TD class="blue">
								操作编码：
							</TD>
							<TD  >
								<SELECT name="black_type" onchange="inputECSI()">
									<OPTION value="01">
										01－加入全局黑名单
									</option>
									<OPTION value="02">
										02－退出全局黑名单
									</option>
									<OPTION value="03">
										03－加入EC/SI级黑名单
									</option>
									<OPTION value="04">
										04－退出EC/SI级黑名单
									</option>
								</SELECT>

							</TD>
							
							<TD class="blue">
								EC/SI类型：
							</TD>
							<TD>
								<SELECT name="ECSIType" disabled =true>
									<OPTION value="01">
										01－EC
									</option>
									<OPTION value="02">
										02－SI
									</option>
								</SELECT>
							</TD>
						</TR>
						<TR id="tableNo"  style=display:none>
							<TD class="blue">
								EC/SI编码：
							</TD>
							<TD width='32%'>
								<INPUT type="text" name="cust_id" value="">
								&nbsp;
								<FONT color="orange">
									<INPUT type="Button" name="button1" value="校验"  class="b_text" onclick="QryEcSiInfo()"/>
									*
								</FONT>
							</TD>

							<TD>
								&nbsp;
							</TD>
							<TD>
								&nbsp;
							</TD>
							

						</TR>
						<TR  id="tableNo1"  style=display:none>
							<TD class="blue">
								EC/SI编码：
							</TD>
							<TD>
								<INPUT type="text" name="ECSIID"  Class="InputGrey"  readonly>
							</TD>
							<TD class="blue">
								EC/SI名称：
							</TD>
							<TD>
								<INPUT type="text" name="cust_name" Class="InputGrey" size=40  readonly>
							</TD>
						</TR>
						
						<TR>
							<TD class="blue">
								号码
							</TD>
							<TD colspan="1">
								<textarea cols=30 rows=8 name="phoneNo" style="overflow:auto" v_must=1 v_minlength="11" v_maxlength="15" v_type="string" v_name="手机号码" index="8"></textarea>
							</TD>
							<TD colspan="2">
								注：批量增加号码时,请用"|"作为分隔符,并且最后一个号码也请用"|"作为结束.
								<br>例如：
								<br>&nbsp;&nbsp;&nbsp;&nbsp;20200000000|
								<br>&nbsp;&nbsp;&nbsp;&nbsp;20200654321|
							</TD>
						</TR>

			
						<TR>
							<TD class="blue">
								生效时间:
							</TD>
							<TD>
								<INPUT type="text" name="EfftT"  v_format="yyyyMMdd" maxlength="8" v_type="date" value="<%=strDate%>" v_must="1" size="9"/>
								<FONT color="orange">
									*
								</FONT>&nbsp;
								(格式:YYYYMMDD)&nbsp;
							</TD>
							<TD>
								&nbsp;
							</TD>
							<TD>
								&nbsp;
							</TD>
						</TR>
					</TABLE>

					<TABLE cellSpacing="0">
						<TR>
							<TD align="center">
								<INPUT  class="b_foot" type="Button" name="confirm" value="确认" onclick="conCfm()"   >
								<!--<INPUT  class="b_foot" type="reset" name="reset" value="清除"  >-->
								<INPUT  class="b_foot" type="reset" name="reset" value="清除" onclick="doclear()" >
								<INPUT  class="b_foot" type="Button" name="closeBtn" value="关闭" onClick="removeCurrentTab()">
							</TD>
						</TR>
					</TABLE>
<%@ include file="/npage/include/footer.jsp" %>
		</form>
	</body>
</html>


