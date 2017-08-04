<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.util.*"%>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>

<%
String regCode	=(String)session.getAttribute("regCode");
String opCode="e789";
String opName="社保通业务销户";

String iLoginAccept="0";
String iChnSource="01";
String iOpCode=opCode;
String iLoginNo=(String)session.getAttribute("workNo");
String iLoginPwd=(String)session.getAttribute("password");
String iPhoneNo=request.getParameter("activePhone");
String iUserPwd="";
String iIpAddr=(String)session.getAttribute("ipAddr");

/*获取系统时间*/
java.util.Date sysdate = new java.util.Date();
java.util.Calendar cal = java.util.Calendar.getInstance();
cal.setTime(sysdate);
cal.set(Calendar.DAY_OF_MONTH, 1);
cal.roll(Calendar.DAY_OF_MONTH, -1);
SimpleDateFormat sf2 = new SimpleDateFormat("yyyy-MM-dd");
String opTimeD = sf2.format(cal.getTime());
System.out.println("~~~"+opTimeD );
/*操作流水*/
String printAccept=getMaxAccept();
%>
<wtc:service name="se787Qry"  outnum="11"
	routerKey="region" routerValue="<%=regCode%>" 
	retmsg="rmE787Qry" retcode="rcE787Qry">
	<wtc:param value="<%=iLoginAccept%>"/>
	<wtc:param value="<%=iChnSource%>"/>
	<wtc:param value="<%=iOpCode%>"/>
	<wtc:param value="<%=iLoginNo%>"/>
	<wtc:param value="<%=iLoginPwd%>"/>
	<wtc:param value="<%=iPhoneNo%>"/>
	<wtc:param value="<%=iUserPwd%>"/>
	<wtc:param value="<%=iIpAddr%>"/>
</wtc:service>
<wtc:array id="rstE787Qry" scope="end" />	
<%
if(!rcE787Qry.equals("000000"))
{
%>
	<script>
		rdShowMessageDialog("<%=rcE787Qry%>:<%=rmE787Qry%>");
		removeCurrentTab();
	</script>
<%
}
else
{%>
	
<html xmlns="http://www.w3.org/1999/xhtml"> 
	<head>
		<title>社保通业务变更</title>
		<script src="/npage/public/json2.js" type="text/javascript"></script>
		<script src="socialInsurance.js" type="text/javascript"></script>
	</head>
	<body>
	<form name='frmE789' action='' method='POST'>
		
		<!--确认标识:
			0:全部校验通过,
			1:默认所有校验都不通过.
			2:校验IMEI不通过
			3:绑定人校验不通过-->
		<input type='hidden' id='cfmCode' value='1'>	
		<input type='hidden' id='opCode' name='opCode' value='<%=opCode%>'>	
		<input type='hidden' id='opName' name='opName' value='<%=opName%>'>	
		<input type='hidden' id='strIdIcd' name='strIdIcd' value=''>	
		<input type='hidden' id='strNId' name='strNId' value=''>	
		<input type='hidden' id='strName' name='strName' value=''>	
		
		<!--操作流水-->
		<input type="hidden" id = "printAccept" 
			name="printAccept" value= "<%=printAccept%>">			
		<!--确认标识:0:全部校验通过,1:校验不通过-->
		<input type='hidden' id='cfmMsg' value=''>	
		<div id="Operation_Title">
			<div class="icon"></div>
				<B><%=opName%></B>
		</div>
		
		<DIV id="Operation_Table">
			<div class="title">
				<div id="title_zi">购买人信息</div>
			</div>
			<table>
			<tr>
				<th>手机号码</th>
				<td><input type='text' id='phoneNo' name="phoneNo" value='<%=iPhoneNo%>' class='InputGrey'></td>
				<th>IMEI码:</th>
				<td><input type='text' id='oldImeiNo' name='oldImeiNo' value='<%=rstE787Qry[0][1]%>'class='InputGrey'></td>
			</tr>

			</table>
			<div class="title">
				<div id="title_zi">绑定人信息</div>
			</div>
			<table id='addband'>
				<tr>
					<th>绑定人身份证号</th>
					<th> 绑定人社保号码</th>
					<th>绑定人姓名</th>
				</tr>
				<%
				/*zhangyan:绑定人数量写死为二,
				改变绑定人数量直接修改变量即可,方便今后扩展*/
				int bindNum=2;
				String gIds[]=rstE787Qry[0][5].split("\\|");
				String nIds[]=rstE787Qry[0][6].split("\\|");
				String ngNames[]=rstE787Qry[0][7].split("\\|");

				for ( int i=0;i<gIds.length;i++ )
				{
				%>
					<tr>
						<td><input type="text" id='gId<%=i%>' name='gId<%=i%>' class='InputGrey'
							value="<%=gIds[i]%>"></td>
						<td><input type="text" id='nId<%=i%>' name='nId<%=i%>' class='InputGrey'
							value="<%=nIds[i]%>"></td>
						<td><input type="text" id='ngName<%=i%>' name='ngName<%=i%>' class='InputGrey'
							value="<%=ngNames[i]%>"></td>								
					</tr>			
				<%
				}
				%>
			</table>

			<!--操作按钮-->
			<table>
				<tr>
					<td  id="footer">
						<input type="button" id=cfmPage value="确认"
							onClick="doCfm()" class="b_foot" >
						<input type="button" id=clsPage value="关闭"
							onClick="removeCurrentTab();" class="b_foot">						
					</td>
				</tr>
			</table>	
			<!--最大绑定人数量-->
			<input type='hidden' id='maxBn' value="<%=bindNum%>">
			<input type='hidden' id='ofrId' name="ofrId" value="<%=rstE787Qry[0][2]%>">
			<!--社保信息JSON串-->
			<input type="hidden" id = "jsonSI" name="jsonSI" value= "">
			
			<!--绑定人信息json串-->
			<input type="hidden" id = "jsonBind" name="jsonBind" value= "">				
			<!--当前绑定人数量-->	
			<input type='hidden' id='curBn' value="<%=gIds.length%>">	
		</div>
	</form>
	<script>
		function setBindInfo(packet)
		{

			var	retCode=packet.data.findValueByName("retCode"); 
			var	retMsg=packet.data.findValueByName("retMsg"); 
			var	bindCode=packet.data.findValueByName("bindCode"); 

			if (retCode!="000000")
			{
				$("#gId"+bindCode).attr("disabled" , "");
				$("#nId"+bindCode).attr("disabled" , "");
				$("#ngName"+bindCode).attr("disabled" , "");					
				
				rdShowMessageDialog(retCode+":"+retMsg , 0);
				return false;
			}
			else
			{
				/*表单元素赋值*/
				var	bindJson=packet.data.findValueByName("oBindJson"); 

				/*json对象转换*/
				var bindInfo=eval('('+bindJson+')'); 
				/*设置表单值*/
				$("#gId"+bindCode).val(bindInfo.gid);
				$("#nId"+bindCode).val(bindInfo.nid);
				$("#ngName"+bindCode).val(bindInfo.name);
		
				/*表单元素置灰*/
				$("#gId"+bindCode).attr("disabled" , "disabled");
				$("#nId"+bindCode).attr("disabled" , "disabled");
				$("#ngName"+bindCode).attr("disabled" , "disabled");
				$("#cfmCode").val("0");
			}
		}		
		/*获取绑定人信息*/
		function getBindInfo(i , obj)
		{
			if ($("#gId"+i).val()==""
				 && $("#nId"+i).val()=="" )
			{
				rdShowMessageDialog("身份证号和社保编号至少填写一个!",0);
				return false;
			}			
				
			var addBind = new bind();
			
			addBind.setGid($("#gId"+i).val());
			addBind.setNid($("#nId"+i).val());
			addBind.setName($("#ngName"+i).val());
			
			/*拼json串*/
			var jsonBind = JSON.stringify(addBind,function(key,value){
				return value;
			});
			
			
			$("#gId"+i).attr("disabled" , "disabled");
			$("#nId"+i).attr("disabled" , "disabled");
			$("#ngName"+i).attr("disabled" , "disabled");							
			
			var strBind="{bid:'"+obj.value+"'}";
			var packet = new AJAXPacket("fE789MainAjax.jsp"
				,"请稍后...");
			packet.data.add("jsonBind" ,strBind);
			packet.data.add("bindCode" ,i);
			packet.data.add("getType" ,"getBid");
			core.ajax.sendPacket(packet,setBindInfo,true);//异步
			packet =null;
		}		
		function doCfm()
		{
		 	//打印工单并提交表单
		 	var jsonSI="{'deviceid':'"+document.all.oldImeiNo.value+"'}";
		 	document.all.jsonSI.value=jsonSI;
		 	
			var ret = showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes");
			if(typeof(ret)!="undefined")
			{ 
				if((ret=="confirm"))
				{
					if(rdShowConfirmDialog('确认电子免填单吗？')==1)
					{
						document.frmE789.action="fE789Cfm.jsp";
						document.frmE789.submit();
					}
				}
				if(ret=="continueSub")
				{
					if(rdShowConfirmDialog('确认要提交信息吗？')==1)
					{
						document.frmE789.action="fE789Cfm.jsp";
						document.frmE789.submit();
					}
				}
			}
			else
			{
				if(rdShowConfirmDialog('确认要提交信息吗？')==1)
				{
					document.frmE789.action="fE789Cfm.jsp";
					document.frmE789.submit();
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
			var sysAccept = document.all.printAccept.value;
			var printStr = printInfo(printType);
		
			var mode_code=null;
			var fav_code=null;
			var area_code=null
		
			var prop="dialogHeight:"+h+"px; "
				+"dialogWidth:"+w+"px; "
				+"dialogLeft:"+l+"px; "
				+"dialogTop:"+t+"px;"
				+"toolbar:no; menubar:no; scrollbars:yes; "
				+"resizable:no;location:no;status:no;help:no";
			var path = "<%=request.getContextPath()%>"
				+"/npage/innet/hljBillPrint_jc.jsp?DlgMsg="+DlgMessage;
			var path = path  + "&mode_code="+mode_code
				+"&fav_code="+fav_code+"&area_code="+area_code
				+"&opCode=<%=opCode%>&sysAccept="+sysAccept
				+"&phoneNo=<%=iPhoneNo%>&submitCfm=" + submitCfm
				+"&pType="+pType+"&billType="+billType
				+ "&printInfo=" + printStr;
			var ret=window.showModalDialog(path,printStr,prop);
			return ret;
		}		
	
		/*拼免填单内容*/
		function printInfo(printType)
		{   
			var cust_info="";
			cust_info+= "手机号码：<%=iPhoneNo%>"+"|";
			cust_info+= "客户姓名：     <%=rstE787Qry[0][10]%>"
				+"    证件号码：     <%=rstE787Qry[0][0]%>"+"|";
			cust_info+= "|";
			
			/*业务信息*/
			var opr_info="";
			opr_info+="办理业务：社保通业务销户"+"|";
			/*设备变更*/

			opr_info+="工单编号："+"<%=printAccept%>"+"|";
			opr_info+="销户生效时间："+"<%=opTimeD%>"+"|";		
			
			var note_info1="";
			var note_info2="	欢迎使用中国移动社保通业务，"
				+"如有任何问题请与您的客户经理联系。";
			var note_info3="";
			var note_info4="";
			
			/*拼装免填单信息*/
			var retInfo = "";
			retInfo+=" "+"|";
			retInfo+=" "+"|";
			retInfo+=" "+"|";
			retInfo+=" "+"|";    
			retInfo+=" "+"|";	
			retInfo+=" "+"|";
				
			note_info1 =retInfo;
			
			retInfo = cust_info+"#"
				+opr_info+"#"
				+note_info1+"#"+note_info2+"#"+note_info3+"#"+note_info4+"#";
			retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
		    return retInfo;
		}				
		
	</script>
</body>
</html>
<%}%>
