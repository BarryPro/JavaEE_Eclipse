<%
  /*
   * 139邮箱包年，包半年
   * 日期: 2013-03-11
   * 作者: zhouby
   */
%>
<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=GBK">
	<meta http-equiv="Expires" content="0">
<%
	request.setCharacterEncoding("GBK");
	response.setHeader("Pragma","No-Cache"); 
  response.setHeader("Cache-Control","No-Cache");
  response.setDateHeader("Expires", 0);
  
  String currentDate = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date());
  
  String opCode = (String)request.getParameter("opCode");
  String opName = (String)request.getParameter("opName");
  String workNo = (String)session.getAttribute("workNo");
  String regionCode = (String)session.getAttribute("regCode");
  String phoneNo = (String)request.getParameter("activePhone");
%>

<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>" id="accept"/>

<title><%=opName%></title>

<script language="javascript">
	
	
		   onload=function()
	   {
			getCustInfo();	
	   }
	
		function getCustInfo(){
			
			var packet = new AJAXPacket("../public/pubGetUserBaseInfo.jsp","正在获取数据，请稍候......");
      packet.data.add("opCode", "<%=opCode%>");
      packet.data.add("phoneNo", "<%=phoneNo%>");
      core.ajax.sendPacket(packet, function(packet){
      		var CUST_NAME = packet.data.findValueByName('stPMcust_name');
      		$('#custName').text(CUST_NAME);
      });
      packet = null;
	}
	
	 function queryBigClass(){
	 if(document.all.bigzame.value=="qxz") {
	 	 // rdShowMessageDialog("请选择要申请的资费大类!");
	 	  var tmpObj="";
	 	  tmpObj = "littleame";
	  	document.all(tmpObj).options.length=0;
	  return false;
	 }
		var getNote_Packet = new AJAXPacket("qryClassInfo.jsp","正在获得小类信息，请稍候......");
		getNote_Packet.data.add("bigclasscode",document.all.bigzame.value);
		core.ajax.sendPacket(getNote_Packet,returnBigClass);
		getNote_Packet=null;
	 }
	 
 function returnBigClass(packet){
		var tmpObj="";
 		var errorCode = packet.data.findValueByName("retCode");
		var errorMsg =  packet.data.findValueByName("retMsg");
	  var	backArrMsg= packet.data.findValueByName("backArrMsg1");
	  if( errorCode == "000000"){
	  	 tmpObj = "littleame";
	  	 		document.all(tmpObj).options.length=0;
				  document.all(tmpObj).options.length=backArrMsg.length;
		        for(i=0;i<backArrMsg.length;i++)
			      {
				      document.all(tmpObj).options[i].text=backArrMsg[i][0];
				      document.all(tmpObj).options[i].value=backArrMsg[i][1]+"--"+backArrMsg[i][2]+"--"+backArrMsg[i][3]+"--"+backArrMsg[i][4]+"--"+backArrMsg[i][5];		        		        		        
			      }
	  }
		
		}
 
	
 function printInfo(){
			var cust_info="";
			var opr_info="";
			var note_info1="";
			var note_info2="";
			var note_info3="";
			var note_info4="";
			var baotime="";
			var baotimezhanshi="";
			var qianshu="";			
			var sm= new Array();
					sm =$('#littleame').val().split("--");
					//alert($('#littleame').val());
					baotime=sm[1];
					if(baotime=="B"){
					baotime="包半年";
					baotimezhanshi="半年";
					}
					if(baotime=="Y"){
					baotime="包年";
					baotimezhanshi="年";
					}
					else if (baotime=="150")
					{
						baotime="包学期";
						baotimezhanshi="学期";
					}
					else if (baotime=="360")
					{
						baotime="包年";
						baotimezhanshi="年";						
					}
					qianshu=sm[2];

			var retInfo = "";
			/************客户信息************/
			cust_info += "手机号码：<%=phoneNo%>|";
			cust_info += "客户姓名："+$('#custName').text()+"|";
			
			/************受理内容************/

			if ( document.all.bigzame.value=="GXTC" || document.all.bigzame.value=="DZTC" )
			{
				opr_info += "业务类型："+$('#littleame option:selected').text()+"|";
			}
			else
			{
				opr_info += "业务类型：增值业务"+ $('#littleame option:selected').text()+"功能申请，"
					+"资费"+qianshu+"元/"+baotimezhanshi+"。|";
			}			
			opr_info += "操作类型：订购|";
			opr_info += "操作时间：<%=currentDate%>|";
						/************注意事项************/
			if ( document.all.bigzame.value=="GXTC" || document.all.bigzame.value=="DZTC" )
			{
				note_info1 += "备注："+"|"+"1. 包学期/包年资费当月申请立即生效，包学期/包年款一次性划为专款"+"|"
					+"2. WLAN校园包学期、包年资费和包月资费不能重复办理"+"|"
					+"3. WLAN大众包年资费与包月资费不能重复办理"+"|"
					+"4. 包学期/包年资费中途不能变更，可以退订次月生效，包年款系统一次性回收，不退还"+"|"
					+"5. 包学期/包年资费到期后，不退订自动转为相应包月资费."+"|"
					+"|";

			}
			else if(document.all.bigzame.value=="CYZL"){
				note_info1 += "备注：订购增值业务"+baotime+"，资费到期当月15日系统将下发短信提醒您"+baotime+"资费即将到期，您是否需要转为车友助理（10元/月）或退订业务，请您根据短信提示进行操作。中国移动。|";
			}
			else if(document.all.bigzame.value=="HLY"){
				note_info1 += "备注：订购增值业务"+baotime+"，资费到期当月15日系统将下发短信提醒您"+baotime+"资费即将到期，您是否需要转为和留言包月（3元/月）或退订业务，请您根据短信提示进行操作。中国移动。|";
			}
			else
			{
				/*2014/02/19 9:08:02 gaopeng R_CMI_HLJ_xueyz_2014_1334133@关于优化数据业务包年、包半年资费的函 */
				note_info1 += "备注：订购增值业务" +baotime+ 
				"，资费到期当月25日系统自动为您退订业务。您也可以在营业厅或发送短信0000到10086根据短信提示进行退订。中国移动。|";
				/*2014/02/19 9:08:02 gaopeng R_CMI_HLJ_xueyz_2014_1334133@关于优化数据业务包年、包半年资费的函 */
			}
			retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
			retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
			return retInfo;
	}
  
  //显示打印对话框
function showPrtDlg(DlgMessage, submitCfm){
			var h=180;
			var w=350;
			var t=screen.availHeight/2-h/2;
			var l=screen.availWidth/2-w/2;
			
			var pType = "subprint";             				 		//打印类型：print 打印 subprint 合并打印
			var billType = "1";              				 			  //票价类型：1电子免填单、2发票、3收据
			var sysAccept = "<%=accept%>";       						//流水号
			var printStr = printInfo();   				//调用printinfo()返回的打印内容
			var opcode="g713";
			var mode_code=null;           							  	//资费代码
			var fav_code=null;                				 			//特服代码
			var area_code=null;             				 		  	//小区代码
			var phoneNo = <%=phoneNo%>;     					    	//客户电话
			var prop = "dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+
				"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
															 
			var path = "/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage;
			path += "&mode_code="+mode_code+
				"&fav_code="+fav_code+"&area_code="+area_code+
				"&opCode="+opcode+"&sysAccept="+sysAccept+
				"&phoneNo=" + phoneNo+
				"&submitCfm="+submitCfm+"&pType="+
				pType+"&billType="+billType+ "&printInfo=" + printStr;
				
			var ret = window.showModalDialog(path,printStr,prop);
			return ret;
	}
  
  function printCommit(){
  	 if(document.all.bigzame.value=="qxz") {
	 	  rdShowMessageDialog("请选择要申请的资费大类!");
	 		 return false;
	 		}
	 				var sm= new Array();
					sm =$('#littleame').val().split("--");
					$('#qiyedaima').val(sm[3]);
					$('#yewudaima').val(sm[4]);
					var	chuanbaotime="";
					var baotime=sm[1];
					if(baotime=="B"){
						chuanbaotime="180";
					} else if(baotime=="Y"){
						chuanbaotime="360";
					} else {
						chuanbaotime = baotime;
					}
					$('#shijianxianzhi').val(chuanbaotime);
					
			var ret = showPrtDlg("确实要进行电子免填单打印吗？", "Yes");
			if ((typeof(ret) == "undefined") || (ret=="continueSub")){
					if(rdShowConfirmDialog('确认要提交信息吗？') == 1){
							frmCfm();
					}
			} else if(ret == "confirm"){
					if(rdShowConfirmDialog('确认电子免填单吗？') == 1){
							frmCfm();
					}
			}
	}
	
	//本方法中提供了防止重复点击按钮的控制
function frmCfm(){
			showLightBox();
			$('form').attr('action', 'fg713Cfm.jsp');
			if (!$('form').data('alreadySubmit')){
					$('form').data('alreadySubmit', true).submit();
			}
	}

</script>
</head>
<body>
<form name="frm" method="post" action="">
  <input type="hidden" name="opCode" id="opCode" value="<%=opCode%>">
  <input type="hidden" name="opName" id="opName" value="<%=opName%>">
  <input type="hidden" name="sysAccept" value="<%=accept%>">
  <input type="hidden" name="phoneNo" value="<%=phoneNo%>">
	<input type="hidden" name="shijianxianzhi" id="shijianxianzhi" value="">
	<input type="hidden" name="qiyedaima" id="qiyedaima" value="">
	<input type="hidden" name="yewudaima" id="yewudaima" value="">
  <input type="hidden" name="selectvalues" id="selectvalues" value="06">
  <input type="hidden" name="locatiurl" id="locatiurl" value="fg713.jsp">
  
  <%@ include file="/npage/include/header.jsp" %>
  <div class="title">
    <div id="title_zi"><%=opName%></div>
  </div>
  
  <table cellspacing="0">
  	<tr>
      <td class="blue" width="14%">客户姓名</td>
      <td width="36%" id="custName">
      	
      </td>
      <td class="blue" width="14%">手机号</td>
      <td width="36%" id="phoneNo"><%=phoneNo%>
      </td>
    </tr>
  	

  	
    <tr class="detailsLine">
  		<td class="blue">业务大类</td>
      <td>
      	<select id="bigzame" name="bigzame" style="width: 140px;" onChange="queryBigClass()">
      	<option value='qxz'>--请选择--</option>
				<option value='YXWJ'>游戏玩家</option>
				<option value='SJSP'>手机视频</option>
				<option value='SJDM'>手机动漫漫赏</option>
				<option value='WXYY'>无线音乐俱乐部</option>
				<option value='GXTC'>高校WLAN套餐</option>
				<option value='SJB'>手机报</option>
				<!-- <option value='CYZL'>车友助理</option> -->
				<option value='HLY'>和留言</option>
        </select>

      </td>
      
        		<td class="blue">业务小类</td>
      <td>
      	<select id="littleame" name="littleame" style="width: 200px;">

        </select>

      </td>
    </tr>
    
    
    <tr>
      <td colspan="4" align="center" id="footer">
        <input class="b_foot" type=button name="submitBtn" id="submitBtn" value="确定" onClick="printCommit()">    
        <input class="b_foot" type=button name="closeBtn" id="closeBtn" value="关闭">
      </td>
    </tr>
  </table>
  <%@ include file="/npage/include/footer_simple.jsp" %>
</form>
<%@ include file="/npage/include/pubLightBox.jsp" %>
</body>
</html>