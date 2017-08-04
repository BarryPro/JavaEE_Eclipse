<%
/*************************************
* 功  能: g378·虚拟V网用户办理 
* 版  本: version v1.0
* 开发商: si-tech
* 创建者: liujian @ 2012-12-31 13:52:45
**************************************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.sitech.boss.util.page.*"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	
	String opCode     =  request.getParameter("opCode");
    String opName     =  request.getParameter("opName");
    String workNo     = (String)session.getAttribute("workNo");
     String workName     = (String)session.getAttribute("workName");
    String password = (String) session.getAttribute("password");
    String regionCode = (String)session.getAttribute("regCode");
    String phoneNo = request.getParameter("phoneNo");
    String powerRight = WtcUtil.repNull((String)session.getAttribute("powerRight"));
	boolean qryFlag = false;
	StringBuffer offerSb = new StringBuffer("");
	String sql_select1 = "select trim(a.offer_id),trim(a.offer_id)||'-->'||trim(a.offer_name) from product_offer a,region d,DBCUSTADM.sregioncode e where a.offer_attr_type='VpG0' and a.offer_id=d.offer_id and d.group_id=e.group_id and e.region_code=:region_code and a.exp_date>=sysdate and a.eff_date<=sysdate and d.right_limit <= :right_limit order by a.offer_id";
	String srv_params1 = "region_code=" + regionCode + ",right_limit=" + powerRight ;
	String userPhoneNo = "", groupNo = "", groupName = "", userName = "", currOffer = "",nextOffer = "";

%>
	<wtc:sequence name="TlsPubSelCrm" key="sMaxSysAccept" routerKey="regioncode" 
			routerValue="<%=regionCode%>"  id="loginAccept" />
			
	<wtc:service name="sg381Qry"  routerKey="regioncode" 
			routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="6">
		<wtc:param value="<%=loginAccept%>"/>
		<wtc:param value="01"/>
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=workNo%>"/>	
		<wtc:param value="<%=password%>"/>
		<wtc:param value="<%=phoneNo%>"/>
		<wtc:param value=""/>
		<wtc:param value=""/>
	</wtc:service>
	<wtc:array id="qryArr"  scope="end"/>
<%
	if(retCode.equals("000000") && qryArr.length > 0) {
		qryFlag = true;
		groupNo = qryArr[0][0]; 
		groupName = qryArr[0][1];
		userPhoneNo = qryArr[0][2];
		userName = qryArr[0][3]; 
		currOffer = qryArr[0][4];
		nextOffer = qryArr[0][5];
		if(opCode.equals("g379")) {
%>
			<wtc:sequence name="TlsPubSelCrm" key="sMaxSysAccept" routerKey="regioncode" 
				routerValue="<%=regionCode%>"  id="loginAccept" />
			<wtc:service name="sPkgCodeQry" routerKey="region" routerValue="<%=regionCode%>" retcode="rstCode2" retmsg="rstMsg2" outnum="3">
				<wtc:param value="<%=loginAccept%>"/>
				<wtc:param value="01"/>
				<wtc:param value="<%=opCode%>"/>
				<wtc:param value="<%=workNo%>"/>	
				<wtc:param value="<%=password%>"/>
				<wtc:param value="<%=phoneNo%>"/>
				<wtc:param value=""/>
				<wtc:param value="<%=regionCode%>"/>
				<wtc:param value="<%=powerRight%>"/>
			</wtc:service>
			<wtc:array id="result_offer" scope="end"/>
	<%
			if(rstCode2.equals("000000") && result_offer.length > 0) {
				for(int i=0; i<result_offer.length; i++) {
					  offerSb.append("<option value ='").append(result_offer[i][0]).append("'>")
							 .append(result_offer[i][1])
							 .append("</option>");
				}
			}
		}
	}
%>		        	
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title><%=opName%></title>
</head>

<script type=text/javascript>
  $(function() {
  		$(window.parent.document).find("iframe[@id='groupIframe']").css('height','0px');
	
  		$('#offerSelect').css('width','300px');
  		if(<%=qryFlag%>) {
  			$('#currOffer').css('width','300px');
  			if('<%=opCode%>' == 'g379') {
  				$('#offerSelect').css('display','block');
  				$('#offerSelect').append("<%=offerSb.toString()%>");
  				var nextOffer = '<%=nextOffer%>';
  				$("#offerSelect option[value='" + nextOffer.substring(0,nextOffer.indexOf('-')) + "']").attr("disabled", true);
  				$("#offerSelect").val(nextOffer.substring(0,nextOffer.indexOf('-')));
  			}else if('<%=opCode%>' == 'g380') {
  				$('#nextOfferTd').append('<input type="text" name="currOffer" id="nextOffer" value="<%=nextOffer%>" class="InputGrey" readonly style="width:40%"/>');
  			}
			showTable();
		}else {
			clearTable();
			rdShowMessageDialog("错误代码：<%=retCode%>，错误信息：<%=retMsg%>",0);
		}
		
		$('#submitBtn').click(function() {
			
			//window.parent.showBox();
			if('<%=opCode%>' == 'g379') {
				
				 var  ret = showPrtDlg379("Detail","确实要进行电子免填单打印吗？","Yes");
		    
		     if(typeof(ret)!="undefined"){
		        if((ret=="confirm")){
		          if(rdShowConfirmDialog('确认要提交信息吗？')==1){
		            		nextStepCfmG379();
		          }
		        }
		        if(ret=="continueSub"){
		          if(rdShowConfirmDialog('确认要提交信息吗？')==1){
										nextStepCfmG379();
		          }
		        }
		      }else{
		        if(rdShowConfirmDialog('确认要提交信息吗？')==1){
										nextStepCfmG379();
		        }
		      }
			}else if('<%=opCode%>' == 'g380') {
				
				var  ret = showPrtDlg380("Detail","确实要进行电子免填单打印吗？","Yes");
		    
		     if(typeof(ret)!="undefined"){
		        if((ret=="confirm")){
		          if(rdShowConfirmDialog('确认要提交信息吗？')==1){
		            		nextStepCfmG380();
		          }
		        }
		        if(ret=="continueSub"){
		          if(rdShowConfirmDialog('确认要提交信息吗？')==1){
										nextStepCfmG380();
		          }
		        }
		      }else{
		        if(rdShowConfirmDialog('确认要提交信息吗？')==1){
										nextStepCfmG380();
		        }
		      }
			}	
		});
		//隐藏父页面的遮罩
		window.parent.hideBox();
  });
  
  function nextStepCfmG380(){
  	var packet = new AJAXPacket("fg378_3.jsp","正在获得相关信息，请稍候......");
		var _data = packet.data;
		_data.add("loginAccept","<%=loginAccept%>");
		_data.add("opCode","<%=opCode%>");
		_data.add("userPhoneNo","<%=userPhoneNo%>");
		_data.add("groupNo",'<%=groupNo%>');
		_data.add("method","g380cfm");
		core.ajax.sendPacket(packet,g380cfmProcess);
		packet = null;
  }
  
  function nextStepCfmG379(){
  	var nextOffer = '<%=nextOffer%>';
  				nextOffer = nextOffer.substring(0,nextOffer.indexOf('-'));
  				
  				if($('#offerSelect').val() == nextOffer) {
  					window.parent.hideBox();
  					rdShowMessageDialog("请选择下月资费！");
  					return false;
  				}
  					
				var packet = new AJAXPacket("fg378_3.jsp","正在获得相关信息，请稍候......");
				var _data = packet.data;
				
				_data.add("loginAccept","<%=loginAccept%>");
				_data.add("opCode","<%=opCode%>");
				_data.add("userPhoneNo","<%=userPhoneNo%>");
				_data.add("groupNo",'<%=groupNo%>');
				_data.add("offerId",$('#offerSelect').val());
				_data.add("method","g379cfm");
				core.ajax.sendPacket(packet,g379cfmProcess);
				packet = null;	
  	
  }
  
  function showTable() {
  	$('#userTable').css('display','block');
  	$(window.parent.document).find("iframe[@id='groupIframe']").css('height',$("body").height()+20 + 'px');		
  }
  function clearTable() {
  		$('#tabList2').empty();
  		$('#userTable').css('display','none');
  }
  
	function g380cfmProcess(package) {
		var g380cfmCode = package.data.findValueByName("g380cfmCode");
		var g380cfmMsg = package.data.findValueByName("g380cfmMsg");	
		var loginAccept = package.data.findValueByName("loginAccept");	
		$('#loginAccept').val(loginAccept);
  
		if(g380cfmCode == '000000' || g380cfmCode == '0') {
			rdShowMessageDialog("虚拟V网用户资费退出成功！");
			clearTable();
			$(window.parent.document).find("input[@id='phoneNo']").val('');
			$(window.parent.document).find("iframe[@id='groupIframe']").css('height','0px');
		}else {
			rdShowMessageDialog("错误代码：" + g380cfmCode +  "，错误信息：" + g380cfmMsg,0);	
		}
		window.parent.hideBox();
	}
	
	function g379cfmProcess(package) {
		var g379cfmCode = package.data.findValueByName("g379cfmCode");
		var g379cfmMsg = package.data.findValueByName("g379cfmMsg");	
		var loginAccept = package.data.findValueByName("loginAccept");	
		$('#loginAccept').val(loginAccept);
		
		if(g379cfmCode == '000000' || g379cfmCode == '0') {
			rdShowMessageDialog("虚拟V网用户资费变更成功！");
			clearTable();
			$(window.parent.document).find("input[@id='phoneNo']").val('');
			$(window.parent.document).find("iframe[@id='groupIframe']").css('height','0px');
			
		}else {
			rdShowMessageDialog("错误代码：" + g379cfmCode +  "，错误信息：" + g379cfmMsg,0);	
		}
		window.parent.hideBox();
	}
	
	 function showPrtDlg379(printType,DlgMessage,submitCfm)
{  //显示打印对话框
   var h=180;
   var w=350;
   var t=screen.availHeight/2-h/2;
   var l=screen.availWidth/2-w/2;

  var pType="subprint";             				 	//打印类型：print 打印 subprint 合并打印
	var billType="1";              				 			  //票价类型：1电子免填单、2发票、3收据
	var sysAccept ="<%=loginAccept%>";             	//流水号
	var printStr = printInfo379(printType);			 		//调用printinfo()返回的打印内容
	var mode_code=null;           							  //资费代码
	var fav_code=null;                				 		//特服代码
	var area_code=null;             				 		  //小区代码
	var opCode="g379" ;                   			 	//操作代码
	var phoneNo=document.all.userPhoneNo.value;                  //客户电话

    var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
    var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_dz.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
    path+="&mode_code="+mode_code+
			"&fav_code="+fav_code+"&area_code="+area_code+
			"&opCode=<%=opCode%>&sysAccept="+sysAccept+
			"&phoneNo="+phoneNo+
			"&submitCfm="+submitCfm+"&pType="+
			pType+"&billType="+billType+ "&printInfo=" + printStr;
     var ret=window.showModalDialog(path,printStr,prop);
     return ret;
}

function printInfo379(printType)
{

	var cust_info="";  				//客户信息
	var opr_info="";   				//操作信息
	var note_info1=""; 				//备注1
	var note_info2=""; 				//备注2
	var note_info3=""; 				//备注3
	var note_info4=""; 				//备注4
	var retInfo = "";  				//打印内容
	//var _consumeTerm = parseInt(document.getElementById("Consume_Term").value,10);/* diling add 消费期限保留整数部分 2011/8/30 11:17:17 */

	opr_info+='<%=workNo%>'+' '+'<%=workName%>'+"|";
	opr_info+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	cust_info+="手机号码："+document.all.userPhoneNo.value+"|";
	cust_info+="客户姓名："+document.all.userName.value+"|";	
	cust_info+="客户地址："+"|";
	cust_info+="集团编号：<%=groupNo%>"+"|";
	cust_info+="集团名称：<%=groupName%>"+"|";



	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	opr_info+="业务流水："+document.all.loginAccept.value+"|";
	opr_info+="业务类型：集团成员资费变更"+"|";
  opr_info+="集团产品名称：BOSS侧虚拟V网"+"|";
  opr_info+="当月BOSS侧虚拟V网资费套餐名称：<%=currOffer%>"+"|";
   opr_info+="下月BOSS侧虚拟V网资费套餐名称："+$("#offerSelect").find("option:selected").text()+"|";
 // opr_info+="BOSS侧虚拟V网资费套餐描述："+offersid+"--"+offerscoments+"|";
	opr_info+="集团成员资费变更，生效时间为次月。"+"|"; /*diling add  增加业务有效期 2011/8/30 11:17:17 */

	note_info1+="备注："+"|";


	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
    return retInfo;
}

 function showPrtDlg380(printType,DlgMessage,submitCfm)
{  //显示打印对话框
   var h=180;
   var w=350;
   var t=screen.availHeight/2-h/2;
   var l=screen.availWidth/2-w/2;

  var pType="subprint";             				 	//打印类型：print 打印 subprint 合并打印
	var billType="1";              				 			  //票价类型：1电子免填单、2发票、3收据
	var sysAccept ="<%=loginAccept%>";             	//流水号
	var printStr = printInfo380(printType);			 		//调用printinfo()返回的打印内容
	var mode_code=null;           							  //资费代码
	var fav_code=null;                				 		//特服代码
	var area_code=null;             				 		  //小区代码
	var opCode="g380" ;                   			 	//操作代码
	var phoneNo=document.all.userPhoneNo.value;                  //客户电话

    var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
    var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_dz.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
    path+="&mode_code="+mode_code+
			"&fav_code="+fav_code+"&area_code="+area_code+
			"&opCode=<%=opCode%>&sysAccept="+sysAccept+
			"&phoneNo="+phoneNo+
			"&submitCfm="+submitCfm+"&pType="+
			pType+"&billType="+billType+ "&printInfo=" + printStr;
     var ret=window.showModalDialog(path,printStr,prop);
     return ret;
}

function printInfo380(printType)
{

	var cust_info="";  				//客户信息
	var opr_info="";   				//操作信息
	var note_info1=""; 				//备注1
	var note_info2=""; 				//备注2
	var note_info3=""; 				//备注3
	var note_info4=""; 				//备注4
	var retInfo = "";  				//打印内容
	//var _consumeTerm = parseInt(document.getElementById("Consume_Term").value,10);/* diling add 消费期限保留整数部分 2011/8/30 11:17:17 */

	opr_info+='<%=workNo%>'+' '+'<%=workName%>'+"|";
	opr_info+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	cust_info+="手机号码："+document.all.userPhoneNo.value+"|";
	cust_info+="客户姓名："+document.all.userName.value+"|";	
	cust_info+="客户地址："+"|";
	cust_info+="集团编号：<%=groupNo%>"+"|";
	cust_info+="集团名称：<%=groupName%>"+"|";



	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	retInfo+=" "+"|";
	opr_info+="业务流水："+document.all.loginAccept.value+"|";
	opr_info+="业务类型：集团成员删除"+"|";
  opr_info+="集团产品名称：BOSS侧虚拟V网"+"|";
  opr_info+="当月BOSS侧虚拟V网资费套餐名称：<%=currOffer%>"+"|";
   opr_info+="下月BOSS侧虚拟V网资费套餐名称：<%=nextOffer%>"+"|";
 // opr_info+="BOSS侧虚拟V网资费套餐描述："+offersid+"--"+offerscoments+"|";
	opr_info+="集团成员删除，生效时间为24小时。"+"|"; 

	note_info1+="备注："+"|";


	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
    return retInfo;
}
</script>

<body>
<form name="frm2" action="" method="post" >
		<div id="userTable">
			<div class="title">
				<div id="title_zi">用户信息</div>
			</div>
			
			<div id="Operation_Table" style="padding:0px">
				<table cellspacing=0 >
					<tr>
						<td class='blue'>集团号</td>
						<td>
							<input type="text" name="groupNo" id="groupNo" value="<%=groupNo%>" class="InputGrey" readonly />
						</td>
						<td class='blue'>集团名称</td>
						<td>
							<input type="text" name="groupName" id="groupName" value="<%=groupName%>" class="InputGrey" style="width:50%" readonly />
						</td>
				    </tr>
				    <tr>
						<td class='blue'>用户手机号码</td>
						<td>
							<input type="text" name="userPhoneNo" id="userPhoneNo" value="<%=userPhoneNo%>" class="InputGrey" readonly />
						</td>
						<td class='blue'>用户名称</td>
						<td>
							<input type="text" name="userName" id="userName" value="<%=userName%>" class="InputGrey" readonly />
						</td>
				    </tr>
				    <tr>
						<td class='blue'>当月资费</td>
						<td colspan="3">
							<input type="text" name="currOffer" id="currOffer" value="<%=currOffer%>" class="InputGrey" readonly />
						</td>
						
				    </tr>
				    <tr>
				    	<td class='blue'>下月资费</td>
						<td id="nextOfferTd" colspan="3"><select id="offerSelect" style="display:none"></select></td>	
				    </tr>
				    <tr id='footer'>
				        <td colspan='4'>
				            <input type="button"  id="submitBtn" class='b_foot' value="确定" name="submitBtn" />
				        </td>
				    </tr>
				</table>
			</div>
		</div>
		<input type="hidden" name="loginAccept" id="loginAccept" value="" />
</form>
</body>
</html>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    