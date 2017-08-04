<%
  /*
   * 功能: R_CMI_HLJ_guanjg_2015_2303829@关于优化实名标识系列功能的需求示
   * 版本: 1.0
   * 日期: 2015/7/13 15:00:57
   * 作者: gaopeng
   * 版权: si-tech
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/bill/getMaxAccept.jsp" %>
<%
		response.setHeader("Pragma","No-Cache"); 
		response.setHeader("Cache-Control","No-Cache");
		response.setDateHeader("Expires", 0); 
    String regionCode = (String)session.getAttribute("regionCode");
    String loginNo = (String)session.getAttribute("workNo");
 		String noPass = (String)session.getAttribute("password");
 		String groupID = (String)session.getAttribute("groupId");
 		String opCode = (String)request.getParameter("opCode");
 		String opName = (String)request.getParameter("opName");
		String phoneNo = (String)request.getParameter("activePhone");
		String loginAccept = getMaxAccept();
		
		String ipAddrM = (String)session.getAttribute("ipAddr");
 		String inst = "通过phoneNo[" + phoneNo + "]查询";
		String custName = "";
		
%>

<wtc:service name="sUserCustInfo" outnum="41" >
      <wtc:param value="<%=loginAccept%>"/>
      <wtc:param value="01"/>
      <wtc:param value="<%=opCode%>"/>
      <wtc:param value="<%=loginNo%>"/>
      <wtc:param value="<%=noPass%>"/>
      <wtc:param value="<%=phoneNo%>"/>
      <wtc:param value=""/>
      <wtc:param value="<%=ipAddrM%>"/>
      <wtc:param value="<%=inst%>"/>
      <wtc:param value=""/>
      <wtc:param value=""/>
      <wtc:param value=""/>
      <wtc:param value=""/>
  </wtc:service>

	<wtc:array id="result11" scope="end" />

<%
		if(result11.length <= 0)
		{
%>
<script language="JavaScript">
			rdShowMessageDialog("该用户不是在网用户或状态不正常！");
			removeCurrentTab();
</script>
<%
			return ;
		}
		else
		{
			custName = result11[0][5];
		}
%>

<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="sysAccept" />

  	
<html>
<head>
	<title><%=opName%></title>
	<script language="javascript" type="text/javascript" src="/npage/public/knockout-2.0.0.js" ></script>
	<script src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js" type="text/javascript"></script>
	<script language="javascript">
		
		var globelOpCode = "";
		
		$(document).ready(function(){
			changeType("<%=opCode%>");
		});
		
		
		

		
		function doQry(){
			
			/*手机号码*/
			var phoneNo = $.trim($("#phoneNo").val());
			/*礼品代码*/
			var giftNo = $.trim($("#giftNo").val());
			/*礼品名称*/
			var giftName = $.trim($("#giftName").val());
			
				
				/*ajax start*/
			var getdataPacket = new AJAXPacket("/npage/sm285/fm285Qry.jsp","正在获得数据，请稍候......");
		 	getdataPacket.data.add("phoneNo",phoneNo);
			getdataPacket.data.add("opCode",globelOpCode);
			getdataPacket.data.add("giftNo",giftNo);
			getdataPacket.data.add("giftName",giftName);
			core.ajax.sendPacket(getdataPacket,doRetRegion);
			getdataPacket = null;
			
			
		}
		
	function doRetRegion(packet){
			var retCode = packet.data.findValueByName("retCode");
			var retMsg = packet.data.findValueByName("retMsg");
			var infoArray = packet.data.findValueByName("infoArray");
			var canUseJf = packet.data.findValueByName("canUseJf");
			
		
			if(retCode == "000000"){
				if(infoArray.length == 0){
					rdShowMessageDialog("没有可兑换商品!",1);
					return false;
				}	
				/*赋值可用积分*/
				$("#canUseJf").val(canUseJf);
				var optionStr = "<option value='' selected>--请选择--</option>";
				for(var i=0;i<infoArray.length;i++){
					var giftSum = infoArray[i][0];
					if(giftSum == "0"){
						rdShowMessageDialog("无可兑换商品！");
						return false;
					}
					var giftNo = infoArray[i][0];
					var giftName = infoArray[i][1];
					var giftContent = infoArray[i][2];
					/*0非终端 1终端*/
					var giftType = infoArray[i][3];
					var giftJf = infoArray[i][5];
					var giftPrice = infoArray[i][7];
					var initPrice = 0;
					if(giftPrice.length != 0){
						initPrice = Number(giftPrice)/100;
					}
					
					optionStr += "<option value='"+giftNo+"|"+giftName+"|"+giftContent+"|"+giftJf+"|"+initPrice+"|"+giftType+"'>"+giftName+"-->"+giftJf+"积分</option>"

				}
				$("select[name='giftSel']").empty();
				$("select[name='giftSel']").append(optionStr);
				$("#qryContent1").show();
				$("#qryContent2").show();
				$("#qryContent3").show();
				$("#qryContent4").show();
				
			}else{
				$("#qryContent1").hide();
				$("#qryContent2").hide();
				$("#qryContent3").hide();
				$("#qryContent4").hide();
				rdShowMessageDialog("错误代码："+retCode+",错误信息："+retMsg,1);
				
			}
		}
		
		function showPrtDlg(printType,DlgMessage,submitCfm)
		  {  //显示打印对话框
			var pType="subprint";                     // 打印类型print 打印 subprint 合并打印
		  var billType="1";                      //  票价类型1电子免填单、2发票、3收据
			var sysAccept ="<%=sysAccept%>";                       // 流水号
			var printStr = printInfo(printType);   //调用printinfo()返回的打印内容
			var mode_code=null;                        //资费代码
			var fav_code=null;                         //特服代码
			var area_code=null;                    //小区代码
			var opCode =   globelOpCode;                         //操作代码
			var phoneNo = "<%=phoneNo%>";                           //客户电话

		   	var h=300;
		   	var w=400;
		   	var t=screen.availHeight/2-h/2;
		   	var l=screen.availWidth/2-w/2;

		   	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"
			var path= "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
			var path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode="+opCode+"&sysAccept="+sysAccept+"&phoneNo="+phoneNo+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
			var ret=window.showModalDialog(path,printStr,prop);
		  }

		  function printInfo(printType)
		  {	
		  	if(globelOpCode == "m285"){
			  	var giftSel = $.trim($("select[name='giftSel']").find("option:selected").val());
			  	/*单个积分值*/
					var giftJf = $.trim($("#giftJf").val());
					var needUseJf = Number(giftJf) * Number($("#dhNum").val());
					var giftArray = new Array();
					giftArray = giftSel.split("|");
					
					//var jfp84 = Math.ceil(Number(needUseJf/84));
					
	        var cust_info=""; //客户信息
	      	var opr_info=""; //操作信息
	      	var retInfo = "";  //打印内容
	      	var note_info1=""; //备注1
	      	var note_info2=""; //备注2
	      	var note_info3=""; //备注3
	      	var note_info4=""; //备注4
	
					cust_info+=" "+"|";
					
					cust_info+="手机号码："+"<%=phoneNo%>"+"|";
	      	cust_info+="客户姓名：<%=custName%>|";
					opr_info+="商品信息："+giftArray[1]+"|";
					opr_info+="兑换个数："+$("#dhNum").val()+"|";
					opr_info+="积分值："+needUseJf+"|";
						
						
					
					opr_info+="业务类型:<%=opName%>"+"|";
					opr_info+="业务流水：<%=sysAccept%>"+"|";
					note_info1+= "备注：|";
					note_info1+="尊敬的客户，您本次使用"+needUseJf+"积分兑换"+giftArray[1]+"商品，如您未开通中国移动和包业务则本次兑换将为您免费开通该业务，开通和使用和包业务不会产生任何费用，本次兑换将使用"+needUseJf+"积分兑换成"+(Number(giftArray[4])*Number($("#dhNum").val()))+"元和包电子券，再使用"+(Number(giftArray[4])*Number($("#dhNum").val()))+"元电子券兑换"+giftArray[1]+"商品。|";
					
					retInfo= strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
		  	  retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); //把“#"替换为url格式
	
		    	return retInfo;
		  	}else if(globelOpCode == "m336"){
		  		
		  		var radioChl = $.trim($("input[name='radioChl'][checked]").val());
		  		//alert(radioChl);
		  		var infoArr = new Array();
					infoArr = radioChl.split("|");
					
		  		
		  		var cust_info=""; //客户信息
	      	var opr_info=""; //操作信息
	      	var retInfo = "";  //打印内容
	      	var note_info1=""; //备注1
	      	var note_info2=""; //备注2
	      	var note_info3=""; //备注3
	      	var note_info4=""; //备注4
	
					cust_info+=" "+"|";
					
					cust_info+="手机号码："+"<%=phoneNo%>"+"|";
	      	cust_info+="客户姓名：<%=custName%>|";
						
					
					opr_info+="业务类型:<%=opName%>"+"|";
					opr_info+="业务流水：<%=sysAccept%>"+"|";
					opr_info+="冲正物品："+infoArr[3]+"|";
					opr_info+="冲正串码："+infoArr[7]+"|";
					opr_info+="本次冲正积分："+infoArr[8]+"|";
					note_info1+= "备注：|";
						
					retInfo= strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
		  	  retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); //把“#"替换为url格式
	
		    	return retInfo;
		  		
		  	}
		  	
		  }
		
	
		function doCfm(){
			
			var opType = $("input[name='opType'][checked]").val();
			if(opType == "m285"){
				
				var giftSel = $.trim($("select[name='giftSel']").find("option:selected").val());
				if(giftSel.length == 0){
					rdShowMessageDialog("请选择商品！");
					return false;
				}
				var dhNumObj = $("#dhNum")[0];
				if(!checkElement(dhNumObj)){
					return false;
				}
				var dhNum = $.trim($("#dhNum").val());
				if(Number(dhNum) <= 0){
					rdShowMessageDialog("兑换个数至少要1个！");
					return false;
				}
				/*单个积分值*/
				var giftJf = $.trim($("#giftJf").val());
				var needUseJf = Number(giftJf) * Number($("#dhNum").val());
				var canUseJf = $.trim($("#canUseJf").val()); 
				if(needUseJf > Number(canUseJf)){
					rdShowMessageDialog("可用积分值不够！");
					return false;
				}
				
				var giftArray = new Array();
				giftArray = giftSel.split("|");
				var giftNo = giftArray[0];
			
			}else if(opType == "m336"){
				
				var radioChl = $.trim($("input[name='radioChl'][checked]").val());
				if(radioChl.length==0){
					rdShowMessageDialog("请选择冲正选项！");
					return false;
				}
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
			  return true;
			
			
			
			
		}
		function formConfirm(){
			
			var opType = $("input[name='opType'][checked]").val();
			
			if(opType == "m285"){
				
				var giftSel = $.trim($("select[name='giftSel']").find("option:selected").val());
			
				var dhNumObj = $("#dhNum")[0];
				
				var dhNum = $.trim($("#dhNum").val());
				if(!checkElement($("#dhNum")[0])){
					return false;
				}
				
				var giftType = $.trim($("#giftType").val());
				
				/*单个积分值*/
				var giftJf = $.trim($("#giftJf").val());
				var needUseJf = Number(giftJf) * Number($("#dhNum").val());
				var canUseJf = $.trim($("#canUseJf").val()); 
				
				
				var giftArray = new Array();
				giftArray = giftSel.split("|");
				var giftNo = giftArray[0];
				
				/*提交*/
					/*ajax start*/
				var getdataPacket = new AJAXPacket("/npage/sm285/fm285Cfm.jsp","正在获得数据，请稍候......");
				
				var printAccept = "<%=sysAccept%>";
				/*这里opcode赋值为opType 因为有可能在m285里进行冲正m336操作*/
				var iOpCode = opType;
				var iPhoneNo = "<%=phoneNo%>";
				
				getdataPacket.data.add("opCode",iOpCode);
				getdataPacket.data.add("phoneNo",iPhoneNo);
				getdataPacket.data.add("giftNo",giftNo);
				getdataPacket.data.add("dhNum",dhNum);
				getdataPacket.data.add("giftJf",giftJf);
				getdataPacket.data.add("giftType",giftType);
				
				getdataPacket.data.add("printAccept",printAccept);
				
				
				core.ajax.sendPacket(getdataPacket,doRetCfm);
				getdataPacket = null;
					
			}else if(opType == "m336"){
				
				var radioChl = $.trim($("input[name='radioChl'][checked]").val());
				var infoArr = new Array();
				infoArr = radioChl.split("|");
								
				var czLoginAccept = $.trim(infoArr[6]);
				var czStringCode = $.trim(infoArr[7]);
				
				/*提交*/
					/*ajax start*/
				var getdataPacket = new AJAXPacket("/npage/sm285/fm285CzCfm.jsp","正在获得数据，请稍候......");
				
				var printAccept = "<%=sysAccept%>";
				/*这里opcode赋值为opType 因为有可能在m285里进行冲正m336操作*/
				var iOpCode = opType;
				var iPhoneNo = "<%=phoneNo%>";
				
				getdataPacket.data.add("opCode",iOpCode);
				getdataPacket.data.add("phoneNo",iPhoneNo);
				getdataPacket.data.add("czLoginAccept",czLoginAccept);
				getdataPacket.data.add("czStringCode",czStringCode);
				
				getdataPacket.data.add("printAccept",printAccept);
				
				
				core.ajax.sendPacket(getdataPacket,doRetCfm);
				getdataPacket = null;
				
			}	
		
		}
		
		function doRetCfm(packet){
			var retCode = packet.data.findValueByName("retCode");
			var retMsg = packet.data.findValueByName("retMsg");
			if(retCode == "000000"){
				rdShowMessageDialog("操作成功！",2);
				window.location.reload();
			}else{
				rdShowMessageDialog("错误代码："+retCode+",错误信息："+retMsg,1);
				window.location.reload();
			}
			
		}
		
		/*礼品信息列表变更方法*/
		function changeGift(){
			var giftSel = $.trim($("select[name='giftSel']").find("option:selected").val());
			if(giftSel.length == 0){
				rdShowMessageDialog("请选择商品！");
				$("#giftContent").html("");
				return false;
			}
			var giftArray = new Array();
			giftArray = giftSel.split("|");
			var giftNo = giftArray[0];
			var giftName = giftArray[1];
			var giftContent = giftArray[2];
			var giftJf = giftArray[3];
			var giftType = giftArray[5];
			/*0非终端1终端 终端只允许兑换1个 非终端可以兑换多个*/
			if(giftType == "0"){
				$("#dhNum").attr("class","");	
				$("#dhNum").attr("readonly",false);				
			}
			if(giftType == "1"){
				$("#dhNum").attr("class","InputGrey");	
				$("#dhNum").attr("readonly","readonly");				
			}
			$("#giftContent").html(giftContent);
			$("#giftJf").val(giftJf);
			$("#giftType").val(giftType);
			
		}
		
		/*办理和冲正*/
		function changeType(opCode){
			globelOpCode = opCode;
			if(opCode == "m285"){
				$("input[name='opType']").eq(0).attr("checked","checked");
				
				$("#banliContent").show();
				$("#resultContent").hide();
			}else if(opCode == "m336"){
				
				$("input[name='opType']").eq(1).attr("checked","checked");
				$("#banliContent").hide();
				doCzQuery();
				
				/*调用查询服务 查询冲正数据*/
			}
		}
		
		
		function doCzQuery(){
			
			/*手机号码*/
			var phoneNo = $.trim($("#phoneNo").val());
				
				/*ajax start*/
			var getdataPacket = new AJAXPacket("/npage/sm285/fm285CzQry.jsp","正在获得数据，请稍候......");
		 	getdataPacket.data.add("phoneNo",phoneNo);
			getdataPacket.data.add("opCode",globelOpCode);
			
			core.ajax.sendPacket(getdataPacket,doRetRegionCz);
			getdataPacket = null;
			
		}
		
		function doRetRegionCz(packet){
			var retCode = packet.data.findValueByName("retCode");
			var retMsg = packet.data.findValueByName("retMsg");
			var infoArray = packet.data.findValueByName("infoArray");
			
			$("#resultContent").show();
			$("#appendBody").empty();
		
			if(retCode == "000000"){
				for(var i=0;i<infoArray.length;i++){
					
					var czPhoneNo = infoArray[i][0];
					var czCustName = infoArray[i][1];
					var czGiftNo = infoArray[i][2];
					var czGiftName = infoArray[i][3];
					var czOpTime = infoArray[i][4];
					var czOpLogin = infoArray[i][5];
					var czLoginAccept = infoArray[i][6];
					var czStringCode = infoArray[i][7];
					var czPoint = infoArray[i][8];
					
					var stringSub = czStringCode.substring(czStringCode.length-6,czStringCode.length);
					
					var appendxing = "";
					for(var j=0;j<(czStringCode.length-6);j++){
						appendxing += "*";
					}
					
					
					var appendStr = "<tr>";
					var appendCheckBoxStr = "<input type='radio' name='radioChl' value='"+czPhoneNo+"|"+czCustName+"|"+czGiftNo+"|"+czGiftName+"|"+czOpTime+"|"+czOpLogin+"|"+czLoginAccept+"|"+czStringCode+"|"+czPoint+"'/> ";
					appendStr += "<td width='10%'>"+appendCheckBoxStr+"</td>"
											+"<td width='12%'>"+czPhoneNo+"</td>"
											+"<td width='12%'>"+czCustName+"</td>"
											+"<td width='13%'>"+czGiftNo+"</td>"
											+"<td width='13%'>"+czGiftName+"</td>"
											+"<td width='13%'>"+appendxing+stringSub+"</td>"
											+"<td width='13%'>"+czOpTime+"</td>"
											+"<td width='13%'>"+czOpLogin+"</td>"
											
					appendStr +="</tr>";	
									
					$("#appendBody").append(appendStr);
				}
				
			}else{
				$("#appendBody").empty();
				//$("#export").attr("disabled","disabled");
				rdShowMessageDialog("错误代码："+retCode+",错误信息："+retMsg,1);
				
			}
		}
	</script>
	</head>
<body>
	<form action="" method="post" name="f1">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi"><%=opName%></div>
	</div>
	<div>
		
		 <table id=""  cellspacing="0">      	
       <tr>
        		<td width=20% class="blue">操作类型</td>
        		<td width=80% colspan="3">
        			<span id="radio1"><input type="radio" name="opType"	value="m285"   onclick="changeType(this.value);" checked/>办理 &nbsp;&nbsp;</span>
							<span id="radio2"><input type="radio" name="opType"	value="m336"  onclick="changeType(this.value);"/>冲正 &nbsp;&nbsp;</span>
						</td>
       </tr>
     </table>  				
		<table id="banliContent">
			
	    <tr>
	  		<td width="20%" class="blue">服务号码</td>
	  		<td width="80%" colspan="3">
	  			<input type="text" id="phoneNo" name="phoneNo" value="<%=phoneNo%>" class="InputGrey" readonly />
	  			&nbsp;
	  			<input type="button" class="b_text" name="qryBtn" value="查询" onclick="doQry();"/>
	  		</td>
	  	</tr>
	  	<tr style="display:none">
	  			<td width="20%" class="blue">礼品代码</td>
		  		<td width="80%" colspan="3">
		  			<input type="text" id="giftNo" name="giftNo"  value=""/>
		  		</td>
	  	</tr>
	  	<tr style="display:block">
		  		<td width="20%" class="blue">礼品名称</td>
		  		<td width="80%" colspan="3">
		  			<input type="text" id="giftName" name="giftName" value="" />
		  		</td>
		  	</tr>
	  	<div id="qryContent">
		  	<tr id="qryContent1" style="display:none">
		  		<td width="20%" class="blue">可用积分</td>
		  		<td width="80%" colspan="3">
		  			<input type="text" id="canUseJf" name="canUseJf" value="" class="InputGrey" readonly />
		  		</td>
		  		
		  	</tr>
		  	<tr id="qryContent4" style="display:none">
		  		<td width="20%" class="blue">商品信息</td>
		  		<td width="80%" colspan="3">
		  			<select name="giftSel" onchange= "changeGift();" style="width:320px">
		  				
		  			</select>
		  		</td>
		  	</tr>
		  	<tr id="qryContent2" style="display:none">
		  		<td width="20%" class="blue">商品描述</td>
		  		<td width="80%" colspan="3" id="giftContent">
		  			
		  		</td>
		  	</tr>
		  	<tr id="qryContent3" style="display:none">
		  		<td width="20%" class="blue">兑换个数</td>
		  		<td width="80%" colspan="3">
		  			<input type="text" id="dhNum" class="InputGrey" name="dhNum" value="1" v_type="0_9" v_must="1" readOnly/>
		  			
		  			<input type="hidden" id="giftJf" name="giftJf" value="" />
		  			<input type="hidden" id="giftType" name="giftType" value="" />
		  			
		  		</td>
		  	</tr>
	  	</div>
	  	
		</table>
		
		<!-- 查询结果列表 -->
	<div id="resultContent" style="display:none">
		<div class="title">
			<div id="title_zi">查询结果列表</div>
		</div>
		<table id="exportExcel" name="exportExcel">
			<th width="10%">选择</th>
			<th width="12%">手机号码</th>
			<th width="12%">客户姓名</th>
			<th width="13%">兑换商品编码</th>
			<th width="13%">兑换商品名称</th>
			<th width="13%">终端兑换码</th>
			<th width="13%">操作时间</th>
			<th width="13%">操作工号</th>
			
			<tbody id="appendBody">
				
			</tbody>
		</table>
	</div>
			
		<table>
			<tr>
				<td align=center colspan="4" id="footer">
					<input class="b_foot" name="sure"  type="button" value="确认&打印"  onclick="doCfm();">&nbsp;&nbsp;
					<input class="b_foot" name="sure"  type="button" value="重置"  onclick="javascript:window.location.reload();">&nbsp;&nbsp;
					<input class="b_foot" name="close"  onClick="removeCurrentTab()" type=button value=关闭>
				</td>
			</tr>	
		</table>
	</div>
	<div id="OfferAttribute"></div><!--销售品属性-->
	

	<%@ include file="/npage/include/footer.jsp" %>
</form>
<script>
var excelObj;
function printTable(object)
{
	var obj=document.all.exportExcel;
	rows=obj.rows.length;
	if(rows>0){
		try{
			excelObj = new ActiveXObject("excel.Application");
			excelObj.Visible = true;
			excelObj.WorkBooks.Add;
			  for(i=0;i<rows;i++){
			    cells=obj.rows[i].cells.length;
			    for(j=0;j<cells;j++)
			      excelObj.Cells(i+1,j+1).Value="'" + obj.rows[i].cells[j].innerText;
			}
		}
		catch(e){}
	} else {
		
	}
}
</script>
</body>


</html>
