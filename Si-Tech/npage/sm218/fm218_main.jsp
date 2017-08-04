<%
  /*
   * 功能: m218·集团客户购充值卡
   * 版本: 1.0
   * 日期: 2015/1/8 
   * 作者: diling
   * 版权: si-tech
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	String opCode = request.getParameter("opCode");
	String opName = request.getParameter("opName");  
	String ip_Addr = (String)session.getAttribute("ipAddr");
	String workno = (String)session.getAttribute("workNo");
	String org_code = ((String)session.getAttribute("orgCode")).substring(0,7);
	String nopass  =(String)session.getAttribute("password"); 
	String Department = (String)session.getAttribute("orgCode");
	String regionCode = (String)session.getAttribute("regCode");
	String districtCode = Department.substring(2,4);
	String powerRight = (String)session.getAttribute("powerRight"); 
%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region"
	routerValue="<%=regionCode%>" id="sysAcceptl" />
<html xmlns="http://www.w3.org/1999/xhtml">
	<HEAD>
		<TITLE><%=opName%></TITLE>	
			<SCRIPT type=text/javascript>	
				function getInfo_Cust(){
					document.all.qryFlag.value="qryCust";
			    var pageTitle = "集团客户选择";
			    var fieldName = "证件号码|客户ID|客户名称|用户ID|用户编号 |用户名称|产品代码|产品名称|集团编号|付费帐户|品牌名称|品牌代码|";
					var sqlStr = "";
			    var selType = "S";    //'S'单选；'M'多选
			    var retQuence = "12|0|1|2|3|4|5|6|7|8|9|10|11|";
			    var retToField = "iccid|cust_id|cust_name|grpIdNo|user_no|grp_name|product_code2|product_name2|unit_id|account_id|sm_name|sm_code|";
			    var cust_id = document.frm.cust_id.value;
			    if(document.frm.unit_id.value == "" ){
			        rdShowMessageDialog("请输入集团编号进行查询！");
			        document.frm.unit_id.focus();
			        return false;
				   }
				   PubSimpSelCust(pageTitle,fieldName,sqlStr,selType,retQuence,retToField); 
				}
			
				function PubSimpSelCust(pageTitle,fieldName,sqlStr,selType,retQuence,retToField){
			    var path = "<%=request.getContextPath()%>/npage/sm218/fm218_sel.jsp";
			    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
			    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
			    path = path + "&selType=" + selType+"&iccid=" + document.all.iccid.value;
			    path = path + "&cust_id=" + document.all.cust_id.value;
			    path = path + "&unit_id=" + document.all.unit_id.value;
			    path = path + "&user_no=" + document.all.user_no.value;
			    path = path + "&qryFlag=" + document.all.qryFlag.value;
				
				  retInfo = window.open(path,"newwindow","height=450, width=1000,top=50,left=100,scrollbars=yes, resizable=no,location=no, status=yes");
					return true;
				}
				
				function getvaluecust(retInfo,object){
				  var retToField = "iccid|cust_id|cust_name|grpIdNo|user_no|grp_name|product_code2|product_name2|unit_id|account_id|sm_name|sm_code|";
				  if(retInfo ==undefined)      
				  {   return false;   }
					var chPos_field = retToField.indexOf("|");
			    var chPos_retStr;
			    var valueStr;
			    var obj;
			    while(chPos_field > -1){
		        obj = retToField.substring(0,chPos_field);
		        chPos_retInfo = retInfo.indexOf("|");
		        valueStr = retInfo.substring(0,chPos_retInfo);
		        document.all(obj).value = valueStr;
		        retToField = retToField.substring(chPos_field + 1);
		        retInfo = retInfo.substring(chPos_retInfo + 1);
		        chPos_field = retToField.indexOf("|");
			    }
				}
				
				function qryInfo(){
					var cardBeginNo = $("#cardBeginNo").val();
					var cardEndNo = $("#cardEndNo").val();
					var unit_id = $("#unit_id").val();
					if(unit_id == ""){
						rdShowMessageDialog("请先根据集团编号查询集团信息！",1);
					  return false;
					}
					if(!check(frm)){
						return false;
					}
					var markDiv=$("#intablediv"); 
          markDiv.empty();
					
					var packet = new AJAXPacket("fm218_ajax_qryCardInfo.jsp","正在获得数据，请稍候......");
	        packet.data.add("opCode","<%=opCode%>");
	        packet.data.add("cardBeginNo",cardBeginNo);
	        packet.data.add("cardEndNo",cardEndNo);
	        core.ajax.sendPacketHtml(packet,doQryCardInfo);
				}
				
				function doQryCardInfo(data){
					$("#next").attr("disabled","true");
					$("#custQuery").attr("disabled","true");
					$("#unit_id").attr("readonly",true);
					$("#unit_id").attr("class","InputGrey");
					$("#cust_name").attr("readonly",true);
					$("#cust_name").attr("class","InputGrey");
					$("#grpIdNo").attr("readonly",true);
					$("#grpIdNo").attr("class","InputGrey");
					$("#product_name2").attr("readonly",true);
					$("#product_name2").attr("class","InputGrey");
					$("#account_id").attr("readonly",true);
					$("#account_id").attr("class","InputGrey");
					$("#cardBeginNo").attr("readonly",true);
					$("#cardBeginNo").attr("class","InputGrey");
					$("#cardEndNo").attr("readonly",true);
					$("#cardEndNo").attr("class","InputGrey");
					
					//找到添加表格的div
					var markDiv=$("#intablediv"); 
					markDiv.empty();
					markDiv.append(data);
					var retCode = $("#retCode").val();
					var retMsg = $("#retMsg").val();
					if(retCode!="000000"){
					 rdShowMessageDialog("错误代码："+retCode+"<br>错误信息："+retMsg,0);
					 window.location.href="fm218_main.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
					}
				}
				
				function subInfo(submitBtn){
					
		
		
          if(rdShowConfirmDialog("确认要提交吗？")!=1){
          	return false;
          }else{
          	 /* 按钮延迟 */
          	 showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes");
          	 
    				controlButt(submitBtn);
            var unit_id = $("#unit_id").val();
            var grpIdNo = $("#grpIdNo").val();
            var account_id = $("#account_id").val();
            var cardBeginNo = $("#cardBeginNo").val();
            var cardEndNo = $("#cardEndNo").val();
            var card_num = $("#card_num").val();
            var card_parValue = $("#card_parValue").val();
            var sale_price = $("#sale_price").val();
            var real_salePrice = $("#real_salePrice").val();
            var res_code = $("#res_code").val();
            
            var packet = new AJAXPacket("fm218_ajax_subInfo.jsp","正在获得数据，请稍候......");
          	packet.data.add("opCode","<%=opCode%>");
          	packet.data.add("cardBeginNo",cardBeginNo);
          	packet.data.add("cardEndNo",cardEndNo);
          	packet.data.add("grpIdNo",grpIdNo);
          	packet.data.add("unit_id",unit_id);
          	packet.data.add("card_num",card_num);
          	packet.data.add("sale_price",sale_price);
          	packet.data.add("real_salePrice",real_salePrice);
          	packet.data.add("res_code",res_code);
          	packet.data.add("account_id",account_id);
          	packet.data.add("sysAcceptl","<%=sysAcceptl%>");
          	core.ajax.sendPacket(packet,doSubInfo);
          	packet = null;
          }
				}
				
				function doSubInfo(packet){
					var retCode = packet.data.findValueByName("retCode");
					var retMsg = packet.data.findValueByName("retMsg");
					if(retCode!="000000"){
						rdShowMessageDialog("错误代码："+retCode+"<br>错误信息："+retMsg,0);
						window.location.href="fm218_main.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
					}else{
						rdShowMessageDialog("提交成功！",2);
						window.location.href="fm218_main.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
				}
			}
//liangyl 关于在有价卡销售界面增加大额购买查验证件限制的需求	
	
function showPrtDlg(printType,DlgMessage,submitCfm){  //显示打印对话框 
      var h=180;
      var w=350;
      var t=screen.availHeight/2-h/2;
      var l=screen.availWidth/2-w/2;		   	   
      var pType="subprint";             				 	//打印类型：print 打印 subprint 合并打印
      var billType="1";              				 			  //票价类型：1电子免填单、2发票、3收据
      var sysAccept ="<%=sysAcceptl%>";             	//流水号
      var printStr = printInfo(printType);
	 	//调用printinfo()返回的打印内容 
      var mode_code=null;           							  //资费代码
      var fav_code=null;                				 		//特服代码
      var area_code=null;             				 		  //小区代码
      var opCode="m218";                   			 	//操作代码
      var phoneNo="";                  //客户电话
      
      var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
      var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage;
  		path+="&mode_code="+mode_code+
	  	"&fav_code="+fav_code+"&area_code="+area_code+
	  	"&opCode="+opCode+"&sysAccept="+sysAccept+
	  	"&phoneNo="+phoneNo+
	  	"&submitCfm="+submitCfm+"&pType="+
	  	pType+"&billType="+billType+ "&printInfo=" + printStr;
	  var ret=window.showModalDialog(path,printStr,prop);
	  return ret;
}

//打印模板id为：93
function printInfo(printType){
  var cust_info="";
  var opr_info="";
  var note_info1="";
  var note_info2="";
  var note_info3="";
  var note_info4="";
  var retInfo = "";
  
  cust_info+="客户姓名：客户姓|";
  cust_info+="证件号码：证件号码|";
  cust_info+="证件类型：证件类型|";
  cust_info+="经办人姓名：经办人姓名|";
	cust_info+="经办人证件号码：经办人证件号码|";
  
	opr_info+="业务类型：有价卡销售     ";
	opr_info+="业务流水：<%=sysAcceptl%>|";
	opr_info+="开始卡号："+$("#cardBeginNo").val()+"     ";
	opr_info+="结束卡号："+$("#cardEndNo").val()+"|";
	opr_info+="有价卡张数："+$("#card_num").val().trim()+"|";
	opr_info+="总金额："+$("#real_salePrice").val().trim()+"|";
  
  retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
  retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
  return retInfo;
}

</script>
</HEAD>
<BODY>
	<FORM action="" method="post" name="frm">
		<%@ include file="/npage/include/header.jsp"%>
		<div class="title">
			<div id="title_zi"><%=opName%></div>
		</div>
		<TABLE cellSpacing=0>
			<TR>
				<TD width="18%" class="blue">集团编号</TD>
				<TD width="32%"><input type="text" name="unit_id" id="unit_id"
					size="20" v_type="string" v_must=1 value="" /> <input
					type="button" name="custQuery" class="b_text" id="custQuery"
					onKeyUp="if(event.keyCode==13)getInfo_Cust();"
					onClick="getInfo_Cust();" style="" value=查询 /></TD>
				<TD width="18%" class="blue">集团名称</TD>
				<TD width="32%"><input type="text" name="cust_name"
					id="cust_name" v_must="1" size="20" value="" /></TD>
			</TR>
			<TR>
				<TD width="18%" class="blue">产品ID</TD>
				<TD width="32%"><input type="text" name="grpIdNo" id="grpIdNo"
					size="20" v_must="1" value="" /></TD>
				<TD width="18%" class="blue">产品名称</TD>
				<TD width="32%"><input type="text" name="product_name2"
					id="product_name2" size="20" v_must="1" value="" /></TD>
			</TR>
			<TR>
				<TD width="18%" class="blue">付费账户</TD>
				<TD colspan="3"><input type="text" name="account_id"
					id="account_id" size="20" v_must="1" value="" /></TD>
			</TR>
			<TR>
				<TD width="18%" class="blue">充值卡开始序列号</TD>
				<TD width="32%"><input type="text" name="cardBeginNo"
					id="cardBeginNo" size="20" v_type="0_9" maxlength="40" v_must="1"
					value="" /></TD>
				<TD width="18%" class="blue">充值卡结束序列号</TD>
				<TD width="32%"><input type="text" name="cardEndNo"
					id="cardEndNo" size="20" v_type="0_9" maxlength="40" v_must="1"
					value="" /></TD>
			</TR>
			<tr>
				<td colspan="4"><jsp:include
						page="/npage/public/hwReadCustCard.jsp">
						<jsp:param name="hwAccept" value="<%=sysAcceptl%>" />
						<jsp:param name="showBody" value="01" />
						<jsp:param name="sopcode" value="<%=opCode%>" />
					</jsp:include></td>
			</tr>
			<tr>
				<td id="footer" colspan="4">&nbsp;
					<input name="next" id="next" type="button" class="b_foot" value="查询" onclick="qryInfo()" />&nbsp;
					<input name="back" class="b_foot" type=button value="清除" onclick="window.location='fm218_main.jsp?opCode=<%=opCode%>&opName=<%=opName%>'">&nbsp;
					<input name="closeBtn" class="b_foot" onClick="removeCurrentTab()" type="button" value="关闭" />
				</td>
			</tr>
		</TABLE>

		<!-------------隐藏域--------------->
		<input type="hidden" name="qryFlag" value="" />
		<input type="hidden" name="iccid" value="" />
		<input type="hidden" name="cust_id" value="" />
		<input type="hidden" name="user_no" value="" />
		<input type="hidden" name="product_code2" value="" />
		<input type="hidden" name="grp_name" value="" />
		<input type="hidden" name="sm_name" value="" />
		<input type="hidden" name="sm_code" value="" />
		<!-------------隐藏域--------------->
		<div id="intablediv"></div>
		<%@ include file="/npage/include/footer.jsp"%>
	</FORM>
</BODY>
</HTML>
