<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>

<%
String regCode	=(String)session.getAttribute("regCode");
String opCode="e787";
String opName="社保通业务开通";

String phoneNo=request.getParameter("activePhone");

/*获取系统时间*/
java.util.Date sysdate = new java.util.Date();
SimpleDateFormat sf = new SimpleDateFormat("yyyyMMdd HH:mm:ss");
SimpleDateFormat sf1 = new SimpleDateFormat("yyyyMMdd");
SimpleDateFormat sf2 = new SimpleDateFormat("yyyyMMddHHmmss");
String opTimeD = sf1.format(sysdate);
String opTimeS = sf.format(sysdate);
String opTimeS1= sf2.format(sysdate);

/*操作流水*/
String printAccept=getMaxAccept();
%>

<html xmlns="http://www.w3.org/1999/xhtml"> 
	<head>
		<title>e787.社保通业务开通</title>
		<script src="/npage/public/json2.js" type="text/javascript"></script>
		<script src="socialInsurance.js" type="text/javascript"></script>
		<script>
			/*购买人手机号码不能为空*/
			function doCfm()
			{
			
				/*校验身份证不能为空*/
				if ($("#orderIdIccId").val()=="")
				{
					rdShowMessageDialog("必须填写购买人身份证号码!",0);	
					return false;
				}
				
				/*校验身份证是否合法*/
				if(!forIdCard(document.getElementById("orderIdIccId")))
				{
   					return false;
				}		
				
				/*校验IMEI		*/	
				if ($("#orderImei").val()=="")
				{
					rdShowMessageDialog("必须填写IMEI码!",0);	
					return false;
				}	
					
				if( document.getElementById("orderImei").value.len()!=15)
				{
					rdShowMessageDialog("IMEI码必须15位!",0);	
					return false;					
				}				

				if (!forInt(document.getElementById("orderImei")))
				{
					return false;					
				}	

				if ($("#cfmCode").val()=="2")
				{
					rdShowMessageDialog("IMEI码必须校验通过!",0);	
					return false;					
				}
				else if ($("#cfmCode").val()=="3")
				{
					rdShowMessageDialog("绑定人信息必须校验通过!",0);	
					return false;	
				}
				
				var tabBd=document.getElementById("tabBindInfo");
				if (tabBd.rows.length==1)
				{
					rdShowMessageDialog("绑定人信息必须填写" , 0);
					return false;
				}
				/*提交拼JSON串*/	
				
				 //var =document.getElementById("tabBindInfo").rows[1].cells[1].children[0].value;
				var siList1= new siList();
				
				/*基本信息*/

				
				/*循环添加绑定人信息*/			
				var strIdIcd="";
				var strNId="";
				var strName="";
				for ( var i=1; i<tabBd.rows.length; i++ )
				{
					if (tabBd.rows[i].cells[0].children[0].value.trim()=="")
					{
						rdShowMessageDialog("绑定人身份证号不能为空!");
						return false;
					}
					
					if (tabBd.rows[i].cells[1].children[0].value.trim()=="")
					{
						rdShowMessageDialog("绑定人绑定人社保编号不能为空!");
						return false;
					}
									
					var bdInfo=new bind();
					
					bdInfo.setGid(tabBd.rows[i].cells[0].children[0].value);
					bdInfo.setNid(tabBd.rows[i].cells[1].children[0].value);
					bdInfo.setName(tabBd.rows[i].cells[2].children[0].value);
					
					strIdIcd+=tabBd.rows[i].cells[0].children[0].value+"|";
					strNId+=tabBd.rows[i].cells[1].children[0].value+"|";
					strName+=tabBd.rows[i].cells[2].children[0].value+"|";
					
					siList1.setBind(bdInfo);	
				}
				
				var bsInfo=new base();
				bsInfo.setMobile($("#orderPhoneNo").val());
				bsInfo.setBgid($("#orderIdIccId").val());
				bsInfo.setBname($("#orderCustName").val());
				bsInfo.setDeviceId($("#orderImei").val());
				bsInfo.setMobile($("#orderPhoneNo").val());
				bsInfo.setAddr($("#orderAddr").val());	
				
				/*把基本信息添加到社保信息里*/
				siList1.setBase(bsInfo);				
				document.all.hdGId.value=strIdIcd;
				document.all.hdNId.value=strNId;
				document.all.hdGName.value=strName;

				/*社保对象转换为JSON串*/
				var jsonSclIsc = JSON.stringify(siList1,function(key,value){
					return value;
				});		
				$("#jsonSI").val(jsonSclIsc);
				/*转到提交页面*/

			 	//打印工单并提交表单
				var ret = showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes");
				if(typeof(ret)!="undefined")
				{ 
					if((ret=="confirm"))
					{
						if(rdShowConfirmDialog('确认电子免填单吗？')==1)
						{
							document.frmE787.action="fE787Cfm.jsp";
							document.frmE787.submit();
						}
					}
					if(ret=="continueSub")
					{
						if(rdShowConfirmDialog('确认要提交信息吗？')==1)
						{
							document.frmE787.action="fE787Cfm.jsp";
							document.frmE787.submit();
						}
					}
				}
				else
				{
					if(rdShowConfirmDialog('确认要提交信息吗？')==1)
					{
						document.frmE787.action="fE787Cfm.jsp";
						document.frmE787.submit();
					}
				}
			  	return true;				
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
					+"&phoneNo=<%=phoneNo%>&submitCfm=" + submitCfm
					+"&pType="+pType+"&billType="+billType
					+ "&printInfo=" + printStr;
				var ret=window.showModalDialog(path,printStr,prop);
				return ret;
			}
			
			/*拼免填单内容*/
			function printInfo(printType)
			{    
				/*客户信息*/
				var cust_info="";
				cust_info+= "手机号码：     "
					+document.all.orderPhoneNo.value+"|";
				cust_info+= "客户姓名：     "
					+document.all.orderCustName.value
					+"    证件号码：     "
					+document.all.orderIdIccId.value+"|";
				cust_info+= "|";
				
				/*业务信息*/
				var opr_info="";
				opr_info+="办理业务：社保通业务开户"+"|";
				opr_info+="业务资费："
					+document.getElementById("orderOfferName").value+"|";
				opr_info+="工单编号："+"<%=printAccept%>"+"|";
				opr_info+="业务生效时间："+"<%=opTimeD%>"+"|";
				
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
			
			/*绑定人信息*/
			function addBindInfo()
			{
				/*首先校验已绑定人数量*/
				var tab_len=$("#tabBindInfo").find("tr").length;

				$("#cfmCode").val("3");
				if (tab_len>2)
				{
					rdShowMessageDialog("绑定人数量不能大于两个!",0);
					return false;
				}
				
				var bindCode=parseInt( $("#bindCode").val() , 10)+1;
				$("#bindCode").val(bindCode);
				$("#tabBindInfo").append("<tr>"
				+"<td align='center'>"
					+"<input type='text' id='bandIdIccId"+bindCode+"' "
						+"name='bandIdIccId' value='' "
						+"size='18' maxlength='20' "
						+"  onblur='getBindInfo("+bindCode+" , this)'  >"
				+"</td>"
				+"<td align='center'>"
					+"<input type='text' id='bandNId"+bindCode+"' "
						+"name='bandNId' value='' "
						+"size='20'  maxlength='15'"
						+" onblur='getBindInfo("+bindCode+" , this)' >"
				+"</td align='center'>"
				+"<td align='center'>"
					+"<input type='text' id='bandName"+bindCode+"' "
						+"name='bandName' value='' "
						+" maxlength='18' size='20'>"
				+"</td>"	
				+"<td align='center'>"
					+"<input type='button' onclick='delBindInfo( this )'   "
						+"name='bandName' value='删除' class='b_text'>"
				+"</td>"														
				+"</tr>"
				);
			}
	
			function delBindInfo(k)
			{
				$(k).parent().parent().remove(); 
			}
			
			/*获取绑定人信息*/
			function getBindInfo(i , obj)
			{
				document.all.hdChkId.value=obj.id;
				if ($("#bandIdIccId"+i).val()==""
					 && $("#bandNId"+i).val()=="" )
				{
					rdShowMessageDialog("身份证号和社保编号至少填写一个!",0);
					return false;
				}	
				/*校验身份证是否合法*/
				if ( document.getElementById("bandIdIccId"+i).value.trim().len()!=0 )
				{
					if(!forIdCard(document.getElementById("bandIdIccId"+i)))
					{
	   					return false;
					}					
				}
				
				/*校验身份证是否合法*/
				if ( document.getElementById("bandNId"+i).value.trim().len()!=0 )
				{
					if ( document.getElementById("bandNId"+i).value.trim().len()!=10 )
					{
						rdShowMessageDialog("社保号码必须10位!",0);
						return false;
					}
					else
					{
						if(!forInt(document.getElementById("bandNId"+i)))
						{
		   					return false;
						}
					}					
				}
						
					
				var addBind = new bind();
				
				addBind.setGid($("#bandIdIccId"+i).val());
				addBind.setNid($("#bandNId"+i).val());
				addBind.setName($("#bandName"+i).val());
				
				/*拼json串*/
				var jsonBind = JSON.stringify(addBind,function(key,value){
					return value;
				});
				
				$("#bandIdIccId"+i).attr("disabled" , "disabled");
				$("#bandNId"+i).attr("disabled" , "disabled");
				$("#bandName"+i).attr("disabled" , "disabled");							
				
				var strBind="{bid:'"+obj.value+"'}";
				var packet = new AJAXPacket("fE787MainAjax.jsp"
					,"请稍后...");
				packet.data.add("jsonBind" ,strBind);
				packet.data.add("bindCode" ,i);
				packet.data.add("getType" ,"getBid");
				core.ajax.sendPacket(packet,setBindInfo,true);//异步
				packet =null;
			}
			
			function setBindInfo(packet)
			{

				var	retCode=packet.data.findValueByName("retCode"); 
				var	retMsg=packet.data.findValueByName("retMsg"); 
				var	bindCode=packet.data.findValueByName("bindCode"); 

				if (retCode!="000000")
				{
					$("#bandIdIccId"+bindCode).attr("disabled" , "");
					$("#bandNId"+bindCode).attr("disabled" , "");
					$("#bandName"+bindCode).attr("disabled" , "");					
					
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
					$("#bandIdIccId"+bindCode).val(bindInfo.gid);
					$("#bandNId"+bindCode).val(bindInfo.nid);
					$("#bandName"+bindCode).val(bindInfo.name);
					
					/*表单元素置灰*/
					$("#bandIdIccId"+bindCode).attr("disabled" , "disabled");
					$("#bandNId"+bindCode).attr("disabled" , "disabled");
					$("#bandName"+bindCode).attr("disabled" , "disabled");
					$("#cfmCode").val("0");
				}
			}
		</script>
	</head>
	<body>
	<form name='frmE787' action='' method='POST'>
		
		<!--确认标识:
			0:全部校验通过,
			1:默认所有校验都不通过.
			2:校验IMEI不通过
			3:绑定人校验不通过-->
		<input type='hidden' id='cfmCode' value='1'>	
		
		<!--确认标识:0:全部校验通过,1:校验不通过-->
		<input type='hidden' id='cfmMsg' value=''>	
		
		<!--操作代码-->
		<input type='hidden' name = 'opCode' id='opCode' value='<%=opCode%>'>				
		
		<!--操作名称-->
		<input type='hidden' id='opName' value='<%=opName%>'>		
		
		<!--绑定人数量-->
		<input type='hidden' name = 'bindCode' id='bindCode' value='0'>
		
		<!--社保信息JSON串-->
		<input type="hidden" id = "jsonSI" name="jsonSI" value= "">
		
		<!--绑定人信息json串-->
		<input type="hidden" id = "jsonBind" name="jsonBind" value= "">		
		
		<!--绑定人身份证-->
		<input type="hidden" id = "hdGId" name="hdGId" value= "">			
		<!--绑定人社保号-->
		<input type="hidden" id = "hdNId" name="hdNId" value= "">		
		<!--绑定人姓名-->
		<input type="hidden" id = "hdGName" name="hdGName" value= "">		
		<input type="hidden" id = "hdChkId" name="hdChkId" value= "">		
					
		<!--操作流水-->
		<input type="hidden" id = "printAccept" 
			name="printAccept" value= "<%=printAccept%>">	
						
		<!--操作时间-->
		<input type="hidden" id = "opTimeD" name="opTimeD" value= "<%=opTimeD%>">		
		<input type="hidden" id = "opTimeS" name="opTimeS" value= "<%=opTimeS%>">		
		<input type="hidden" id = "opTimeS1" name="opTimeS1" value= "<%=opTimeS1%>">		
		
		<!---->

		<div id="Operation_Title">
			<div class="icon"></div>
				<B><%=opCode%>.<%=opName%></B>
		</div>
		<!--查询条件-->
		<DIV id="Operation_Table">
			<div class="title">
				<div id="title_zi">购买人信息</div>
			</div>
			<table id="orderInfo">
				<tr>
					<th>购买人手机号码</th>
					<td>
						<input	TYPE="TEXT" id='orderPhoneNo' name='orderPhoneNo'
							maxlength='15' size='20' value='<%=phoneNo%>' 
							class='InputGrey' readOnly >
						<font color='red'>*</font>
					</td>
					<%
					String sqlOrdCstNm="  SELECT T1.CUST_NAME	"
						+"    FROM DCUSTMSG T,	"
						+"         DCUSTDOC T1	"
						+"   WHERE T.CUST_ID = T1.CUST_ID	"
						+"     AND T.PHONE_NO = :phoneNo";
					
					String[] inParamsCN = new String[2];
					inParamsCN[0] = sqlOrdCstNm;
					inParamsCN[1] = "phoneNo=" + phoneNo;
					
					String work_no = WtcUtil.repNull((String)session.getAttribute("workNo"));
					String password = WtcUtil.repNull((String)session.getAttribute("password"));
					String userNote = "通过手机号码[" + phoneNo + "]查询";
					%>
					
					<wtc:sequence name="sPubSelect" key="sMaxSysAccept" id="loginAccept"/>
  
          <wtc:service name="sUserCustInfo" outnum="40" >
              <wtc:param value="<%=loginAccept%>"/>
              <wtc:param value="01"/>
              <wtc:param value="<%=opCode%>"/>
              <wtc:param value="<%=work_no%>"/>
              <wtc:param value="<%=password%>"/>
              <wtc:param value="<%=phoneNo%>"/>
              <wtc:param value=""/>
              <wtc:param value=""/>
              <wtc:param value="<%=userNote%>"/>
              <wtc:param value=""/>
              <wtc:param value=""/>
              <wtc:param value=""/>
              <wtc:param value=""/>
          </wtc:service>
					
					<wtc:array id="rstCN" scope="end" />
					  <%
					  //System.out.println(" zhouby fE787Main.jsp " + rstCN[0][5]);
					  %>
					<th>购买人姓名</th>
					<td>
						<input	TYPE="TEXT" id='orderCustName' name='orderCustName'
							maxlength='15' size='20' value='<%=rstCN[0][5]%>' 
							class='InputGrey' readOnly >
						<font color='red'>*</font>
					</td>	
				</tr>							
				<tr>
					<th>IMEI码</th>
					<td>
						<input	TYPE="TEXT" id='orderImei' name='orderImei'
							size='20' maxlength='15' >
						<font color='red'>*</font>
					</td>
					<th>资费</th>
					<td>
						<input type='hidden' id='orderOfferName' name='orderOfferName' 
							value='社保通10元包月2M'>
						<select id='orderOfferId' name='orderOfferId'>
							<option value='37682'>37682-->社保通10元包月2M</option>
						</select>
					</td>
				</tr>	
				<tr>
					<th>购买人身份证号</th>
					<td colspan='3'>
						<input	TYPE="TEXT" id='orderIdIccId' name='orderIdIccId' 
							maxlength='18' size='20'>
						<font color='red'>*</font>
					</td>
				</tr>					
				<tr>
					<th>购买人地址</th>
					<td colspan='3'>
						<input	TYPE="TEXT" id='orderAddr' name='orderAddr'
							size='130' maxlength='120'>
					</td>
				</tr>							
			</table>
			<div class="title">
				<div id="title_zi">绑定人信息</div>
				<input	TYPE="button" id='bindImeiChk'
					class="b_text" value='新增' onclick='addBindInfo()'>
			</div>			
			<table id="tabBindInfo">	
				<th align='center'>绑定人身份证号</th>					
				<th align='center'>绑定人社保编号</th>					
				<th align='center'>绑定人姓名</th>								
				<th align='center'>操作</th>								
			</table>			
			
			<!--操作按钮-->
			<table>
				<tr>
					<td  id="footer">
						<input type="button" id=cfmPage value="确认"
							onClick="doCfm()" class="b_foot" >
						<input type="button" id=clsPage value="关闭"
							onClick="window.close();" class="b_foot">						
					</td>
				</tr>
			</table>		
		</div>
	</form>
	</body>
</html>