<%
/*
 * 功能: 省内携号
 * 版本: 1.0
 * 日期: 2012/3/9 14:19:13
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
String opCode="e688";
String opName="省内携号取消";
String regCode=(String)session.getAttribute("regCode");
String phoneNo=request.getParameter("activePhone");
String workNo=(String)session.getAttribute("workNo");
String password=(String)session.getAttribute("password");

/*业务办理时间*/
java.util.Date sysdate = new java.util.Date();
java.text.SimpleDateFormat sf2
	= new java.text.SimpleDateFormat("yyyy年MM月dd日");
String createTime2 = sf2.format(sysdate);

%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" id="sLoginAccept"/>
<%
String create_accept = sLoginAccept; 
System.out.println("zhangyan 1111111 create_accept" +create_accept);
%>
<!--查客户信息-->
<wtc:service name="sCustDocSmQry" routerKey="region" routerValue="<%=regCode%>" retcode="retCode1" retmsg="retMsg1" outnum="2" >
  <wtc:param value="0"/>
  <wtc:param value="01"/>
  <wtc:param value="<%=opCode%>"/>
  <wtc:param value="<%=workNo%>"/>	
  <wtc:param value="<%=password%>"/>		
  <wtc:param value="<%=phoneNo%>"/>	
  <wtc:param value=""/>
</wtc:service>
<wtc:array id="rstCmsg" scope="end"/>
<%
String custName="";
String smName="";
if("000000".equals(retCode1)){
  if ( rstCmsg.length==0 )
  {
  	%>
  	<script>
  		rdShowMessageDialog	("查客户信息出错" , 0);
  		removeCurrentTab();
  	</script>
  	<%
  }else
  {
  	custName=rstCmsg[0][0];
  	smName=rstCmsg[1][0];
  }
}else{
%>
  <script>
    rdShowMessageDialog	("错误代码：<%=retCode1%><br>错误信息：<%=retMsg1%>" , 0);
    removeCurrentTab();
  </script>
<%
}


out.println("custName="+custName+"--smName="+smName);
%>
<html>
	<head>
		<script src="../public/json2.js" type="text/javascript"></script>
		<script src="fE688OfferObj.js" type="text/javascript"></script>
		<script language="javascript">
			function doCfm()
			{
				
				if (	$("#checkFlag").val()=="0")
				{
					rdShowMessageDialog("必须先校验操作流水!",0);
					return false;
				}
				
				$("#confirm").attr("disabled",false);
				var param1		= new	param();
				var business1	= new	business();
				var publicinfo1	= new	pubicinfo();
				var offerList1	= new	OfferList();
				
				publicinfo1.setCreate_accept( "<%=create_accept%>" );
				publicinfo1.setPhone_no( $("#phoneNo").val() );
				publicinfo1.setOpCode("e688");
				publicinfo1.setLoginNo("<%=workNo%>");
				publicinfo1.setOp_note("e688省内携号冲正");
				param1.setBack_accept(document.getElementById("old_accept").value);
				
				business1.setParam(param1);
				business1.setFuncname("pubChgCityRevs");
				
				offerList1.setBusiness(business1);
				offerList1.setPubicinfo(publicinfo1);
				
				var paramBelong		= new	param();
				var businessBelong	= new	business();	
				businessBelong.setFuncname("pubPhoneBelongChg");
				paramBelong.setOper("07");	
				paramBelong.setGroup_id("");
				paramBelong.setIn_group_id("");
				paramBelong.setSend_status("");
				paramBelong.setSms_release("");
				paramBelong.setBack_accept( document.getElementById("old_accept").value );
				businessBelong.setParam(paramBelong);
				offerList1.setBusiness(businessBelong);
				
				/*增值业务*/
				var paramAdd		= new	param();
				var businessAdd	= new	business();		
				businessAdd.setFuncname("platBusiOper");					
				paramAdd.setOper("07");
				//paramAdd.setBusitype(valueAddedServices[j][0]);
				businessAdd.setParam(paramAdd);	
					
				offerList1.setBusiness(businessAdd);	
				
				var businessAdd1	= new	business();	
				var paramAdd1		= new	param();
				businessAdd1.setFuncname("spBusiOper");					
				paramAdd1.setOper("07");

				businessAdd1.setParam(paramAdd1);	
				offerList1.setBusiness(businessAdd1);	
				
				var myJSONText = JSON.stringify(offerList1,function(key,value){
					return value;
				});
				document.getElementById("myJSONText").value=myJSONText;	
				//conf();
				//alert(myJSONText);
				
				var ret = showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes");
				if(typeof(ret)!="undefined")
				{ 
					if((ret=="confirm"))
					{
						if(rdShowConfirmDialog('确认电子免填单吗？')==1)
						{
							conf();
						}
					}
					if(ret=="continueSub")
					{
						if(rdShowConfirmDialog('确认要提交信息吗？')==1)
						{
							conf();
						}
					}
				}
				else
				{
					if(rdShowConfirmDialog('确认要提交信息吗？')==1)
					{
						conf();
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
				//var sysAccept = document.all.login_accept.value;
				var printStr = printInfo(printType);
			
				var mode_code=null;
				var fav_code=null;
				var area_code=null
			
				var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
				var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg="+DlgMessage;
				var path = path  
					+"&mode_code="+mode_code
					+"&fav_code="+fav_code
					+"&area_code="+area_code
					+"&opCode=<%=opCode%>"
					+"&sysAccept=<%=create_accept%>"
					+"&phoneNo="+$("#phoneNo").val()
					+"&submitCfm=" + submitCfm
					+"&pType="+pType
					+"&billType="+billType
					+"&printInfo=" + printStr;
				var ret=window.showModalDialog(path,printStr,prop);
				return ret;
			}		
			
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
				
				/*客户信息*/
				cust_info+= "手机号码：     "+document.all.phoneNo.value+"|";
				cust_info+= "客户姓名：     "+"<%=custName%>"+"|";
          
				/*业务信息*/
				opr_info+="客户品牌："+"<%=smName%>"+"     办理业务： 取消省内携号预约"
					+"            生效方式：立即生效"+"|";
				opr_info+="操作流水："+"<%=create_accept%>"+"|"; 	
				opr_info+="业务办理时间："+"<%=createTime2%>"+"|";              
				opr_info+="	预约携出地："+document.all.outRegNm.value
					+"      预约携入地："+document.all.inRegNm.value+"|";              
				opr_info+="当前主资费：("+document.all.curOi.value+"、"
					+document.all.curOn.value+")  "+"|";  
				opr_info+="业务说明："+"|";	
				opr_info+="您当前的资费、增值业务将保留，相关收费原则不变。"+"|";	
				opr_info+="取消携号预约业务后，您可以根据需要，自行参与营销活动，"
					+"办理其他资费、集团业务或增值业务。"+"|";	
				
				/*备注信息*/
				note_info1+="1. 您可根据需要，再次办理在预约省内携号业务时所取消的业务。"+"|";		
				retInfo+=" "+"|";
				retInfo+=" "+"|";
				retInfo+=" "+"|";
				retInfo+=" "+"|";    
				retInfo+=" "+"|";	
				retInfo+=" "+"|";
				
				//note_info1 =retInfo;
			
				retInfo = cust_info+"#"+opr_info+"#"+note_info1+"#"+note_info2+"#"+note_info3+"#"+note_info4+"#";
				retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
				return retInfo;
			}
			
				
			function conf()
			{
				document.e688MainForm.action="fE688Cfm.jsp";
				document.e688MainForm.submit();
			}
			
			function checkAccept1()
			{
				
				if ($("#old_accept").val()=="")
				{
					rdShowMessageDialog("必须输入操作流水!",0);
					return false;
				}
				var packet = new AJAXPacket("fE688CheckAccept.jsp","请稍后...");
				packet.data.add("old_accept",$("#old_accept").val());
				packet.data.add("phoneNo",$("#phoneNo").val());
				core.ajax.sendPacket(packet,checkRst);
				packet =null;					
			}
			
			function checkRst(packet)
			{
				var errorCode 	= packet.data.findValueByName("errorCode");
				var errorMsg 	= packet.data.findValueByName("errorMsg");	
				var arrE688 	= packet.data.findValueByName("arrE688");	
				if (errorCode=="000000")
				{
					//rdShowMessageDialog(errorCode+":"+errorMsg);
					$("#confirm").attr("disabled",false);
					$("#old_accept").attr("disabled",true);
					$("#checkFlag").val("1");
					$("#phoneNo").val(arrE688[0]);
					$("#loginNo").val(arrE688[1]);
					$("#opTime").val(arrE688[2]);
					$("#outRegNm").val(arrE688[3]);
					$("#inRegNm").val(arrE688[4]);
					$("#curOi").val(arrE688[5]);
					$("#curOn").val(arrE688[6]);
					
				}			
				else
				{
					rdShowMessageDialog(errorCode+":"+errorMsg);
				}
			}
		</script>
	</head>
	<FORM name="e688MainForm" action="" method=post>
		<%@ include file="/npage/include/header.jsp" %>	

		<input type="hidden" id="opCode" name="opCode" value="<%=opCode%>">
		<input type="hidden" id="opName" name="opName" value="<%=opName%>">
		
		<input type="hidden" id="myJSONText" name="myJSONText" value="">
		<input type="hidden" id="checkFlag" name="checkFlag" value="0">
		<!--当前资费代码-->
		<input type="hidden" id="curOi" name="checkFlag" value="0">
		<!--当前资费名称-->
		<input type="hidden" id="curOn" name="checkFlag" value="0">
		
		<div class="title" >
			<div id="title_zi">省内携号取消</div>
		</div>	
		<table>
			<tr>
				<th align="center">操作流水</th>
				<td  colspan="3" >
					<input type="text" id = "old_accept" name="old_accept" >
					<input type="button" id="checkAccept" name = "checkAccept" 
						onclick = "checkAccept1()" value="校验" class = "b_text">
				</td>
			</tr>
			<tr>
				<th align="center">手机号</th>
				<td colspan="3" >
					<input type="text" class="InputGrey" 
						name="phoneNo" id="phoneNo" value="<%=phoneNo%>">
				</td>
			</tr>
			<tr>
				<th align="center">操作工号</th>
				<td>
					<input type="text" class="InputGrey" name="loginNo" id="loginNo">
				</td>
				<th align="center">操作时间</th>
				<td>
					<input type="text" class="InputGrey" name="opTime" id="opTime">
				</td>
			</tr>
			<tr>
				<th align="center">携出地</th>
				<td>
					<input type="text" class="InputGrey" name="outRegNm" id="outRegNm">
				</td>
				<th align="center">携入地</th>
				<td>
					<input type="text" class="InputGrey" name="inRegNm" id="inRegNm">
				</td>
			</tr>			
			
			<tr id="footer">
				<td colspan="4">
					<input class="b_foot" name=confirm id="confirm" type=button
						onClick="doCfm()" value="确定" disabled >
					<input class="b_foot" name=back onClick="removeCurrentTab()"
						type=button value="关闭">
				</td>				
			</tr>
		</table>
		
		<%@ include file="/npage/include/footer_new.jsp"%>
	</form>
</html>