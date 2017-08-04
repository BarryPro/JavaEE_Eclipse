<%
/*
 * 功能: 儿童套餐
 * 版本: 1.0
 * 日期: 2012/6/28 11:19:29
 * 作者: zhangyan
 * 版权: si-tech
 * update:
*/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
String opCode=request.getParameter("opCode");
String opName=request.getParameter("opName");
String workNo = (String)session.getAttribute("workNo");
String passwd=(String)session.getAttribute("password");
String regCode=(String)session.getAttribute("regCode");
String cldPhone=request.getParameter("activePhone");

java.util.Date sysdate = new java.util.Date();
java.text.SimpleDateFormat sf2
	= new java.text.SimpleDateFormat("yyyy年MM月dd日");
String createTime2 = sf2.format(sysdate);

/*用于校验手机号密码*/
boolean pwrf=false;
String pubOpCode = opCode;
String pubWorkNo = (String)session.getAttribute("workNo");
%>


<%@ include file="/npage/public/pubCheckPwdPower.jsp" %>
<html xmlns="http://www.w3.org/1999/xhtml"> 
	<head>
		<title><%=opCode%></title>
	</head>
	<body onload="cldInit()">
		<form  name="frm" action="" method="POST" >
					
		<!--操作流水-->
		<wtc:sequence name="sPubSelect" key="sMaxSysAccept"
			routerKey="workNo" routerValue="<%=workNo%>" id="loginAccept"/>

			
			<input type="hidden" id="opCode" name	="opCode"	value= "<%=opCode%>">
			<input type="hidden" id="opName" name	="opName"	value= "<%=opName%>">
			<!--家长姓名-->
			<input type="hidden" id="pName" name	="pName"	value= "">
			<!--儿童姓名-->
			<input type="hidden" id="cldName" name	="cldName"	value= "">
			<!--儿童用户品牌-->
			<input type="hidden" id="cldSmName" name	="cldSmName"	value= "">
			<!--操作流水-->
			<input type="hidden" id="loginAccept" name	="loginAccept"	value= "<%=loginAccept%>">
			<%@ include file="/npage/include/header.jsp" %>

			<DIV id="Operation_Table">

				<div class="title">
					<div id="title_zi"><%=opName%></div>
				</div>
				
				<wtc:service name="sChildOfferInit" outnum="4"
					routerKey="region" routerValue="<%=regCode%>" 
					retcode="retCode" retmsg="retMsg">
					<wtc:param value="<%=loginAccept%>"/>
					<wtc:param value="01"/>
					<wtc:param value="<%=opCode%>"/>
					<wtc:param value="<%=workNo%>"/>
					<wtc:param value="<%=passwd%>"/>
					<wtc:param value="<%=cldPhone%>"/>
					<wtc:param value=""/>
					<wtc:param value="2"/>
				</wtc:service>
				<wtc:array id="rstProd" scope="end" />
				
				<%
				if ( retCode.equals("000000") )
				{
					System.out.println(opCode+"~~~~rstProd.length="+rstProd.length);
					if ( rstProd.length==0 )
					{
					%>
						<script>
							rdShowMessageDialog("查不到用户办理的儿童套餐资费!",0);
							removeCurrentTab();
						</script>
					<%
					}
					else
					{
					%>	
						<table>
							<tr>
								<th align="center">儿童用户号码:</th>
								<td>
									<input type="text" id="cldPhone" name="cldPhone" 
										value='<%=cldPhone%>' readOnly class='InputGrey'/>	
								</td>			
								<th align="center">家长用户号码:</th>
								<td>
									<input type="text" id="pPhoneNo" name="pPhoneNo" 
										value='<%=rstProd[0][0]%>'  readOnly class='InputGrey'/>	
								</td>
							</tr>	
							<tr>
								<th align="center">取消后资费ID:</th>
								<td>
									<input type="text" id="offerId" name="offerId" 
										value='<%=rstProd[0][1]%>' readOnly class='InputGrey'/>	
								</td>			
								<th align="center">取消后资费名称:</th>
								<td >
									<input type="text" id="offerNm" name="offerNm" 
										value='<%=rstProd[0][2]%>' readOnly class='InputGrey'/>	
								</td>
							</tr>
							<tr>
								<th align="center" >取消后资费描述:</th>
								<td colspan='3'>
									<textarea id="offerCmt" name="offerCmt" cols='120' rows='7'
									value='<%=rstProd[0][3]%>' readOnly  ><%=rstProd[0][2]%></textarea>	
								</td>
							</tr>		
						</table>
					<%
					}
				}
				else
				{
					System.out.println(opCode+"~~~~retCode"+retCode);
				%>
					<script>
						rdShowMessageDialog("<%=retCode%>:<%=retMsg%>",0);
						removeCurrentTab();
					</script>
				<%
				}
				%>				

				<table>
					<tr>
						<td  id="footer">
							<input class="b_foot" type="button" name=cfmBtn value="确认"
								onClick="doCfm();">
							<input class="b_foot" type="button" name=clsBtn value="关闭"
								onClick="removeCurrentTab();">								
						</td>
					</tr>
				</table>	
				<%@ include file="/npage/include/footer.jsp" %>
			</div>
		</form>
	</body>
	<script type="text/javascript">
		
		/*组装打印信息*/	
		function printInfo(printType)
		{    

			/*客户信息*/
			var cust_info="";
			/*业务信息*/
			var opr_info="";
			
			/*备注信息*/
			var note_info1="";
			var note_info2="";
			var note_info3="";
			var note_info4="";
			
			var retInfo = "";

			cust_info+= "手机号码：     "+"<%=cldPhone%>"+"|";
			cust_info+= "客户姓名：     "+document.all.cldName.value+"|";
			
			
			opr_info+="办理业务：儿童套餐取消"+"|";
			opr_info+="用户品牌："+document.all.cldSmName.value+"|";                       
			opr_info+="操作流水："+<%=loginAccept%>+"     业务操作时间："+"<%=createTime2%>"+"|";
			opr_info+="家长号码："+document.all.pPhoneNo.value
				+"   家长姓名："+document.all.pName.value+"|";

			retInfo = cust_info+"#"+opr_info+"#"+note_info1+"#"+note_info2+"#"+note_info3+"#"+note_info4+"#";
			retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
		    return retInfo;
		}		
		
		function conf()
		{
			document.frm.action="fE891Cfm.jsp";
			document.frm.submit();
		}
		
		function getPInfo(packet)
		{
			var pName=packet.data.findValueByName("stPMcust_name");
			document.all.pName.value=pName;
		}		
		
		function getCInfo(packet)
		{
			var cldName=packet.data.findValueByName("stPMcust_name");
			var cldSmName=packet.data.findValueByName("stPMsm_name");
			document.all.cldName.value=cldName;
			document.all.cldSmName.value=cldSmName;
		}		
		
		function doCfm()
		{
			document.all.cfmBtn.disabled=true;
			/*查用户信息免填单用*/
			var pPacket = new AJAXPacket("../public/pubGetUserBaseInfo.jsp"
				,"请稍后...");
			/*给ajax页面传递参数*/
			pPacket.data.add("phoneNo",document.all.pPhoneNo.value );
			pPacket.data.add("opCode","<%=opCode%>" );
			
			/*调用页面,并指定回调方法*/
			core.ajax.sendPacket(pPacket,getPInfo,false);
			pPacket=null;		
			
			/*查用户信息免填单用*/
			var cPacket = new AJAXPacket("../public/pubGetUserBaseInfo.jsp"
				,"请稍后...");
			/*给ajax页面传递参数*/
			cPacket.data.add("phoneNo",document.all.cldPhone.value );
			cPacket.data.add("opCode","<%=opCode%>" );
			
			/*调用页面,并指定回调方法*/
			core.ajax.sendPacket(cPacket,getCInfo,false);
			pPacket=null;				
			
			
			var ret = showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes");
			if(typeof(ret)!="undefined")
			{ 
				if((ret=="confirm"))
				{
					if(rdShowConfirmDialog('确认电子免填单吗？')==1)
					{
						conf();
					}
					else
					{
						document.all.cfmBtn.disabled=false;	
					}
				}
				if(ret=="continueSub")
				{
					if(rdShowConfirmDialog('确认要提交信息吗？')==1)
					{
						conf();
					}
					else
					{
						document.all.cfmBtn.disabled=false;	
					}
				}
			}
			else
			{
				if(rdShowConfirmDialog('确认要提交信息吗？')==1)
				{
					conf();
				}
				else
				{
					document.all.cfmBtn.disabled=false;	
				}
			}			
			
		}
		
		
		/*显示打印对话框*/
		function showPrtDlg(printType,DlgMessage,submitCfm)
		{ 
			var h=210;
			var w=400;
			var t=screen.availHeight/2-h/2;
			var l=screen.availWidth/2-w/2;
			var pType="subprint";
			var billType="1";
			var sysAccept = "<%=loginAccept%>";
			var printStr = printInfo(printType);
		
			var mode_code=null;
			var fav_code=null;
			var area_code=null
		
			var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
			var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp"
				+"?DlgMsg="+DlgMessage;
			var path = path  + "&mode_code="+mode_code
				+"&fav_code="+fav_code
				+"&area_code="+area_code
				+"&opCode=<%=opCode%>&sysAccept="+sysAccept
				+"&phoneNo=<%=cldPhone%>&submitCfm=" + submitCfm
				+"&pType="+pType+"&billType="+billType
				+ "&printInfo=" + printStr;

			var ret=window.showModalDialog(path,printStr,prop);
			return ret;
		}		
	</script>
</html>
