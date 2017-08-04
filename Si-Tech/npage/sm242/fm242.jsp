 <%
	/********************
	 version v2.0
	开发商: si-tech
	update:2015/2/13 星期五 下午 1:55:12 ningtn
	********************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
		String opCode=request.getParameter("opCode");	
		String opName=request.getParameter("opName");

	String workno = (String)session.getAttribute("workNo");
	String regioncode=(String)session.getAttribute("regCode");
	String noPass = (String)session.getAttribute("password");
	String orgcode = (String)session.getAttribute("orgCode");
  String dateStr=new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
  String regionCode= (String)session.getAttribute("regCode");


%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regioncode%>"  id="sysAccept" />
	
<HEAD>
		<TITLE><%=opName%></TITLE>
		<script language="JavaScript">
			$(document).ready(function(){
				
				
				
				//提交服务
				$("#quchoose").click(function(){
					if(!checkForm()){
						return false;
					}
					
					//校验
					var phoneNo = $.trim($("#phone").val());
					var cardNo = $.trim($("#oldCardId").val());
	        var packet = new AJAXPacket("../sm241/fm241Check.jsp","正在获得数据，请稍候......");
	      	packet.data.add("cardNo",cardNo);
	      	packet.data.add("phoneNo",phoneNo);
	      	packet.data.add("opCode","m241");
	      	packet.data.add("opName","有价卡登记");
	      	
	      	core.ajax.sendPacket(packet,dogetOfferInfo);
	      	packet = null;   
					
					
					if($("#oldCardStatys").val() == "0"){
						return false;
					}
					
					//查询数据
					var selectSql = "select  card_money  from dchncardres  where card_no = :iOld_Card_no";
					var params = "iOld_Card_no=" + $("#oldCardId").val();
					var getUnitId_Packet = new AJAXPacket("/npage/public/pubSelectBySql.jsp","正在校验请稍候......");
					getUnitId_Packet.data.add("selectSql",selectSql);
					getUnitId_Packet.data.add("params",params);
					getUnitId_Packet.data.add("wtcOutNum","1");
					core.ajax.sendPacket(getUnitId_Packet,doOldBack);
					getEncryptPwd_Packet = null;
					if($("#unitIdFlag").val() == "0"){
						return false;
					}
					//查询数据
					var selectSql = "select  card_money  from dchncardres  where card_no = :iOld_Card_no";
					var params = "iOld_Card_no=" + $("#newCardId").val();
					var getUnitId_Packet = new AJAXPacket("/npage/public/pubSelectBySql.jsp","正在校验请稍候......");
					getUnitId_Packet.data.add("selectSql",selectSql);
					getUnitId_Packet.data.add("params",params);
					getUnitId_Packet.data.add("wtcOutNum","1");
					core.ajax.sendPacket(getUnitId_Packet,doNewBack);
					getEncryptPwd_Packet = null;
					
					if($("#unitIdFlag").val() == "0"){
						return false;
					}
					//提交
					
					if($("#oldCardPrice").val() != $("#newCardPrice").val()){
						rdShowMessageDialog("新旧卡面值不一致" + retmsg,0);
						return false;
					}
					
					var ret = showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes");
			if(typeof(ret)!="undefined")
			  {
			    if((ret=="confirm"))
			    {
			      if(rdShowConfirmDialog('确认电子免填单吗？')==1)
			      {
				   		formConfirm();
			      }
					}
				if(ret=="continueSub")
				{
			      if(rdShowConfirmDialog('确认提交信息么？')==1)
			      {
				    	formConfirm();
			      }
				}
			  }
			else
			  {
			     if(rdShowConfirmDialog('确认提交信息么？')==1)
			     {
				     formConfirm();
			     }
			  }
					
					
				});
			});
			
			function formConfirm(){
				
				/*调用提交服务*/
				var getdataPacket = new AJAXPacket("/npage/sm242/fm242Cfm.jsp","正在获得数据，请稍候......");
				getdataPacket.data.add("serviceName","sm242Cfm");
				getdataPacket.data.add("outnum","0");
				getdataPacket.data.add("inputParamsLength","13");
				getdataPacket.data.add("inParams0",$("#sysAccept").val());
				getdataPacket.data.add("inParams1","01");
				getdataPacket.data.add("inParams2","<%=opCode%>");
				getdataPacket.data.add("inParams3","<%=workno%>");
				getdataPacket.data.add("inParams4","<%=noPass%>");
				getdataPacket.data.add("inParams5",$("#phone").val());
				getdataPacket.data.add("inParams6","");
				/*旧卡*/
				getdataPacket.data.add("inParams7",$("#oldCardId").val());
				/*新卡*/
				getdataPacket.data.add("inParams8",$("#newCardId").val());
				/*持卡人姓名*/
				getdataPacket.data.add("inParams9",$("#username").val());
				/*证件类型*/
				getdataPacket.data.add("inParams10",$("#idType").val());
				/*证件号码*/
				getdataPacket.data.add("inParams11",$("#idIccid").val());
				/*证件备注*/
				getdataPacket.data.add("inParams12",$("#remark").val());
				core.ajax.sendPacket(getdataPacket,doCfmBack);
				getdataPacket = null;
			}
			
			function doCfmBack(packet){
	      var retcode = packet.data.findValueByName("retcode");
	      var retmsg = packet.data.findValueByName("retmsg");
	      if(retcode == "000000"){
	        rdShowMessageDialog("操作成功",2);
	      }else if(retcode == "000001"){
	        rdShowMessageDialog("操作成功，此号码为外地号码！",2);
	      }else{
	      	rdShowMessageDialog("提交失败！错误代码：" + retcode + "，错误信息：" + retmsg,0);
	      }
	      doclear();
	    }
	    
	    function doclear(){
		  	window.location.href = "fm242.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
			}
		
			
			function checkForm(){
				if(!check(document.frm)){
					return false;
				}
				
				//旧卡校验内容： a、序列号第5位为“7”，第6、7位为“08”（系统判断）
				var oldCardId = $("#oldCardId").val();
				var oldCard5Num = oldCardId.substring(4,5);
				if(oldCard5Num != "7"){
					rdShowMessageDialog("校验旧卡号失败！,第5位应为“7”",0);
					return false;
				}
				var oldCard67Num = oldCardId.substring(5,7);
				if(oldCard67Num != "08"){
					rdShowMessageDialog("校验旧卡号失败！,第6、7位应为“08”",0);
					return false;
				}
				//新卡第5位不为7
				var newCardId = $("#newCardId").val();
				var newCard5Num = newCardId.substring(4,5);
				if(newCard5Num == "7"){
					rdShowMessageDialog("校验新卡号失败！,第5位不应为“7”",0);
					return false;
				}

				return true;
			}
						
			function doOldBack(packet){
				var retcode = packet.data.findValueByName("retcode");
				var retmsg = packet.data.findValueByName("retmsg");
				var result = packet.data.findValueByName("result");
				if(retcode != "000000"){
					$("#unitIdFlag").val("0");
					rdShowMessageDialog(retmsg,0);
				}else{
					var countNum = result[0][0];
					$("#oldCardPrice").val(countNum);
					$("#unitIdFlag").val("1");
				}
			}
			
			function doNewBack(packet){
				var retcode = packet.data.findValueByName("retcode");
				var retmsg = packet.data.findValueByName("retmsg");
				var result = packet.data.findValueByName("result");
				if(retcode != "000000"){
					$("#unitIdFlag").val("0");
					rdShowMessageDialog(retmsg,0);
				}else{
					var countNum = result[0][0];
					$("#newCardPrice").val(countNum);
					$("#unitIdFlag").val("1");
				}
			}
			
			function dogetOfferInfo(packet){
	      var retcode = packet.data.findValueByName("retcode");
	      var retmsg = packet.data.findValueByName("retmsg");
	      var cardStatus = packet.data.findValueByName("cardStatus");
	      if(retcode != "000000"){
	        rdShowMessageDialog("校验卡号失败！错误代码：" + retcode + "，错误信息：" + retmsg,0);
	      }else{
	      	if(cardStatus != "无效"){
	      		$("#oldCardStatys").val("0");
	      		rdShowMessageDialog("只有无效的卡可以办理！",0);
	      	}else{
	      		$("#oldCardStatys").val("1");
	      	}
	      }
	    }
	    
	    function showPrtDlg(printType,DlgMessage,submitCfm)
		  {  //显示打印对话框
			var pType="print";                     // 打印类型print 打印 subprint 合并打印
		  var billType="1";                      //  票价类型1电子免填单、2发票、3收据
			var sysAccept ="<%=sysAccept%>";                       // 流水号
			var printStr = printInfo(printType);   //调用printinfo()返回的打印内容
			var mode_code=null;                        //资费代码
			var fav_code=null;                         //特服代码
			var area_code=null;                    //小区代码
			var opCode =   "<%=opCode%>";                         //操作代码
			var phoneNo = "";                           //客户电话

		   	var h=200;
		   	var w=400;
		   	var t=screen.availHeight/2-h/2;
		   	var l=screen.availWidth/2-w/2;

		   	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"
			var path= "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
			var path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+phoneNo+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
			var ret=window.showModalDialog(path,printStr,prop);
		  }

		  function printInfo(printType)
		  {
		  	
        var cust_info=""; //客户信息
      	var opr_info=""; //操作信息
      	var retInfo = "";  //打印内容
      	var note_info1=""; //备注1
      	var note_info2=""; //备注2
      	var note_info3=""; //备注3
      	var note_info4=""; //备注4

				cust_info += " |";
				opr_info+="客户姓名:"+$("#username").val()+"            手机号码:"+$("#phone").val()+"|";
				opr_info+="证件号码:" + $("#idIccid").val() +"|";
				opr_info+="办理业务：充值卡换卡变更|";
				opr_info+="业务流水：<%=sysAccept%>      充值卡换卡费：0"+"|";
				opr_info+="原充值卡号："+$("#oldCardId").val()+"  原充值卡面值："+$("#oldCardPrice").val()+"元|";
				opr_info+="新充值卡号："+$("#newCardId").val()+"  新充值卡面值："+$("#newCardPrice").val()+"元|";
				
				note_info1+="备注：为方便您的充值卡正常使用，请您在营业厅现场进行充值，并将充值卡返还给营业人员处理。|";
				note_info1+="尊敬的客户您好，根据您反馈的充值卡情况，发现您的充值卡涂层尚未刮开但已充值，存在被他人盗用的可能，我公司将视情况向公安机关报案。请您留存以下相关信息以便配合调查，谢谢。|";
					
				retInfo= strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	  	      	retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); //把“#"替换为url格式

	    	    return retInfo;
		  }
			
		</script>
</HEAD>
<BODY >
	<FORM action="" method=post name="frm" ENCTYPE="multipart/form-data">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi"><%=opName%></div>
	</div>
	<input type="hidden" name="opCode" value="<%=opCode%>">
	<input type="hidden" name="opName" value="<%=opName%>">
	<input type="hidden" name="sysAccept" id="sysAccept" value="<%=sysAccept%>"> 
	<input type="hidden" id="oldCardStatys" value="0"/>
	<input type="hidden" id="unitIdFlag" value="0"/>
	<input type="hidden" id="newCardPrice"  />
	<input type="hidden" id="oldCardPrice"  />
	
	<table cellspacing="0">
		<tr>
			<td class="blue">旧卡序列号</td>
			<td>
				<input type="text" id="oldCardId" maxlength="30" v_must="1" 
						v_type="string" onblur="checkElement(this)"/>
				<font class=orange>*</font>
			</td>
			<td class="blue">新卡序列号</td>
			<td>
				<input type="text" id="newCardId" maxlength="30" v_must="1" 
						v_type="string" onblur="checkElement(this)"/>
				<font class=orange>*</font>
			</td>
		</tr>
		
		<tr>
			<td class="blue">持卡人姓名</td>
			<td>
				<input type="text" id="username" maxlength="10" v_must="1" 
						v_type="string" onblur="checkElement(this)"/>
				<font class=orange>*</font>
			</td>
			<td class="blue">持卡人联系电话</td>
			<td>
				<input type="text" id="phone" maxlength="11" v_must="1" 
						v_type="string" onblur="checkElement(this)"/>
				<font class=orange>*</font>
			</td>
		</tr>
		
		<tr>
			<td class="blue">证件类型</td>
			<td>
				<SELECT  id="idType" name="idType"> 
					<OPTION selected value="0">身份证</OPTION> 
					<OPTION value="1">军官证</OPTION> 
					<OPTION value=2>户口簿</OPTION> 
					<OPTION value=3>港澳通行证</OPTION> 
					<OPTION value=4>警官证</OPTION> 
					<OPTION value=5>台湾通行证</OPTION> 
					<OPTION value=6>外国公民护照</OPTION>
				</SELECT>
			</td>
			<td class="blue">证件号码</td>
			<td>
				<input type="text"  id="idIccid" maxlength="20" v_must="1" v_type="string" onblur="checkElement(this)" />
				<font class=orange>*</font>
			</td>
		</tr>
		
		<tr>
			<td class="blue">备注</td>
			<td colspan="3">
				<input type="text"  id="remark" maxlength="100" size="80"/>
			</td>
		</tr>
		
		<tr>
			<td id="footer" colspan="4">
			<input  name="quchoose" id="quchoose" class="b_foot" type="button" value="确认&打印">
			&nbsp;
			<input  name="clear" class="b_foot" type=reset value="重置" />
			&nbsp;                  			
			</td>
		</tr>
	</table>
	
	
	<%@ include file="/npage/include/footer.jsp" %>
	</FORM>
</BODY>
</HTML>