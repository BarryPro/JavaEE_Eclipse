<%
  /*
   * 手机动漫
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
  var Constants = {
  		CURRENT_DATE: '<%=currentDate%>',
  		OP_CODE			: '<%=opCode%>',
  		CUST_NAME   : '',
  		PHONE_NO   : '<%=phoneNo%>'
  };
  /**
  function controlBtn(flag) {
      $("#submitBtn").attr("disabled", flag);
      $("#closeBtn").attr("disabled", flag);
  }
  */
  function Page(){
  		this.isSubscribing = true;
      this.initOthers();
  }
  
  Page.prototype.initOthers = function () {
      var self = this;
      $("#closeBtn").click(function(e){
          e.stopPropagation();
          e.preventDefault();
          
          self.closeWindow();
      });
      
     	$("#subOrderButton").click(function(e){
          e.stopPropagation();
          e.preventDefault();
          
          self.isSubscribing = true;
          self.setupData();
      }); 
      
      self.getCustInfo();
      self.detectBiz();
  }
  
  Page.prototype.closeWindow = function () {
      if(window.opener == undefined) {
          removeCurrentTab();
      } else {
          window.close();
      }
  }
  
  
  Page.prototype.submitForm = function () {
      this.printCommit(Constants.OP_CODE);
  }
  
  Page.prototype.detectBiz = function () {
      var self = this;
      
      var packet = new AJAXPacket("detectBiz.jsp", "正在获取数据，请稍候...");
      packet.data.add("opCode", "<%=opCode%>");
      packet.data.add("phoneNo", "<%=phoneNo%>");
      core.ajax.sendPacket(packet, function(packet){
          self.setupPage(packet);
      });
      packet = null;
  }
  
  Page.prototype.setupPage = function(packet){
  		var self = this;
  		self.contents = [];
  		
  		var result = packet.data.findValueByName('result');
  		var retCode = packet.data.findValueByName('retCode');
			if (retCode != '000000'){
					$('#submitBtn').attr('disabled', 'true');
					rdShowMessageDialog("获取订购信息失败，请联系管理人员！", 1);
					return;
			}
			var subOptions = $('#subBizName').find('option');
			
			//以后这部分内容如果继续拓展，最好将其抽出，放入单独的方法
			if (result[0][0] != ''){
					var temp = result[0][0].split('|');
					var finalResult = [];
					
					for (var i = 0 ;i < (temp.length - 1); i ++){
							var record = [];
							
							for (var j = 0; j < result[0].length; j++){ //列
									var array = result[0][j].split('|');
									record.push(array[i]);
							}
							finalResult.push(record);
					}
					
					var h = '';
					for(var i = 0, j = 0; i < finalResult.length; i++){
							if (finalResult[i][2] == '698029'){//已经订购过
								
							var a = {};	
							var	t = '<tbody class="quiteRecord">';
							    t += 	'<tr>';
									t += 		'<td class="blue">操作类型</td>';
									t +=      '<td>退订';
									t +=      '</td>';
									t +=  		'<td class="blue">业务种类</td>';
									t +=      '<td>';
									t +=      	'<select style="width: 160px;" disabled="true">';
							
									self.startDate = finalResult[i][6];
									self.endDate = finalResult[i][7];
									
									a['startDate'] = finalResult[i][6];
									a['endDate'] = finalResult[i][7];
									a['bizCode'] = finalResult[i][4];
									
									subOptions.each(function(){
											var biz = $(this).attr('bizCode');
											if (biz == a['bizCode']){
													$(this).remove();
											}
									});
									
									if (finalResult[i][4] == '1100000001'){
											if (self.isOrderedHalfYear()){
													t +=          '<option spCode="698029" bizCode="1100000001" time="180" rmb="18元/半年" value="0" checked="true">漫话天下半年包18元/半年</option>';
											}else {
													t +=          '<option spCode="698029" bizCode="1100000001" time="360" rmb="36元/年" value="1">漫话天下全年包36元/年</option>';
											}
									} else if (finalResult[i][4] == '1100000002'){
											if (self.isOrderedHalfYear()){
													t +=          '<option spCode="698029" bizCode="1100000002" time="180" rmb="18元/半年" value="2">时事天下半年包18元/半年</option>';
											}else {
													t +=          '<option spCode="698029" bizCode="1100000002" time="360" rmb="36元/年" value="3">时事天下全年包36元/年</option>';
											}
									} else if (finalResult[i][4] == '1100000003'){
											if (self.isOrderedHalfYear()){
													t +=          '<option spCode="698029" bizCode="1100000003" time="180" rmb="18元/年" value="4">日韩动漫半年包18元/半年</option>';
											}else {
													t +=          '<option spCode="698029" bizCode="1100000003" time="360" rmb="36元/年" value="5">日韩动漫全年包36元/年</option>';
											}
									} else if (finalResult[i][4] == '1100000004'){
											if (self.isOrderedHalfYear()){
													t +=          '<option spCode="698029" bizCode="1100000004" time="180" rmb="18元/年" value="6">每日一笑半年包18元/半年</option>';
											} else {
													t +=          '<option spCode="698029" bizCode="1100000004" time="360" rmb="36元/年" value="7">每日一笑全年包36元/年</option>';
											}
									}		
									t +=        '</select>';
									t +=        '<input type="hidden" name="bizCode' + j + '" value="' + finalResult[i][4] + '">';
									
									if (self.isOrderedHalfYear()){
											t +=        '<input type="hidden" name="timeLong' + j + '" value="180">';
									} else {
											t +=        '<input type="hidden" name="timeLong' + j + '" value="360">';
									}
									t +=      '</td>';
									t +=  	'</tr>';
									  	
									t +=    '<tr>';
									t +=      '<td class="blue">开始时间</td>';
									t +=      '<td id="startDate' + j + '">' + finalResult[i][6];
									t +=      '</td>';
									t +=      '<td class="blue">结束时间</td>';
									t +=      '<td id="endDate' + j + '">' + finalResult[i][7];
									t +=      '</td>';
									t +=    '</tr>';

									t +=    '<tr>';
									t +=      '<td class="blue">原办理流水</td>';
									t +=      '<td id="originalAccept' + j + '">' + finalResult[i][8];
									t +=      '</td>';
									t +=			'<td class="blue">操作</td>';
									t +=      '<td><input class="b_text" type="button" value="退订" index="' + j +'" id="quit' + j + '"/>';
									t +=      '</td>';
									t +=    '</tr>';
									t +=    '<tr>';
									t +=    '<td colspan="4">';
									t += '</br>';
									t +=    '</td>';
									t +=    '</tr>';
									t +=  '</tbody>';
									
									h += t;
									
									self.contents.push(a);
									j++;
							}
					}
					
					$('#quit_area').html(h);
			}
			
			$('.quiteRecord').find('input[id^="quit"]').click(function(e){
					e.stopPropagation();
					e.preventDefault();
					
					self.isSubscribing = false;
					self.setupData($(this).attr('index'));
			});
  }
  
  Page.prototype.setupData = function(index){
  		var self = this;
  		//构造数据传入下一个页面
  		var t = $('input[name="oprCode"]');
  		if (this.isSubscribing){
  				t.val('06');
  				
  				var p = $('#subBizName').find('option:selected');
  				$('input[name="bizCode"]').val(p.attr('bizCode'));
  				$('input[name="timeLong"]').val(p.attr('time'));
  		} else { //退订
  				t.val('07');
  				
  				var a = self.contents[index];
		  		$('input[name="bizCode"]').val(a.bizCode);
		  		self.startDate = a['startDate'];
					self.endDate = a['endDate'];
					
					if (self.isOrderedHalfYear){
							$('input[name="timeLong"]').val('180');
					}else {
							$('input[name="timeLong"]').val('360');
					}
  		}
			
			this.submitForm();
  }
  
  Page.prototype.printInfoForSubscribing = function (opcode){
			var cust_info="";
			var opr_info="";
			var note_info1="";
			var note_info2="";
			var note_info3="";
			var note_info4="";
			
			var retInfo = "";
			/************客户信息************/
			cust_info += "手机号码：" + Constants.PHONE_NO + "|";
			cust_info += "客户姓名：" + Constants.CUST_NAME + "|";
			
			/************受理内容************/
			opr_info += "业务类型：手机动漫业务" + $('#subBizName option:selected').text() + "功能申请，资费" + this.charge() + "|";
			opr_info += "操作类型：申请|";
			opr_info += "操作时间：" + Constants.CURRENT_DATE + '|';

			/************注意事项************/
			/*2014/02/19 9:08:02 gaopeng R_CMI_HLJ_xueyz_2014_1334133@关于优化数据业务包年、包半年资费的函 */
			note_info1 += "备注：订购增值业务" + this.detectTimeLong() + 
			",资费到期当月25日系统自动为您退订业务。您也可以在营业厅或发送短信0000到10086根据短信提示进行退订。中国移动。|";
			/*2014/02/19 9:08:02 gaopeng R_CMI_HLJ_xueyz_2014_1334133@关于优化数据业务包年、包半年资费的函 */
			retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
			retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
			return retInfo;
	}
	
	Page.prototype.printInfoForUnsubscribing = function (opcode){
			var cust_info="";
			var opr_info="";
			var note_info1="";
			var note_info2="";
			var note_info3="";
			var note_info4="";
			
			var retInfo = "";
			/************客户信息************/
			cust_info += "手机号码：" + Constants.PHONE_NO + "|";
			cust_info += "客户姓名：" + Constants.CUST_NAME + "|";
			
			/************受理内容************/
			opr_info += "业务类型：手机动漫业务" + this.timeLongForUnsubscribing() + "功能退订申请。|";
			opr_info += "操作类型：退订|";
			opr_info += "操作时间：" + Constants.CURRENT_DATE + '|';

			retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
			retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
			
			return retInfo;
	}
  
  //显示打印对话框
  Page.prototype.showPrtDlg = function(opcode, DlgMessage, submitCfm){
			var h=180;
			var w=350;
			var t=screen.availHeight/2-h/2;
			var l=screen.availWidth/2-w/2;
			
			var pType = "subprint";             				 		//打印类型：print 打印 subprint 合并打印
			var billType = "1";              				 			  //票价类型：1电子免填单、2发票、3收据
			var sysAccept = "<%=accept%>";       						//流水号
			var printStr 
			if(this.isSubscribing){
				printStr = this.printInfoForSubscribing(opcode);   				//调用printinfo()返回的打印内容
			} else {
				printStr = this.printInfoForUnsubscribing(opcode);   				//调用printinfo()返回的打印内容
			}
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
  
  Page.prototype.printCommit = function (opCode){
			var self = this;
			var ret = this.showPrtDlg(opCode, "确实要进行电子免填单打印吗？", "Yes");
			if ((typeof(ret) == "undefined") || (ret=="continueSub")){
					if(rdShowConfirmDialog('确认要提交信息吗？') == 1){
							self.frmCfm();
					}
			} else if(ret == "confirm"){
					if(rdShowConfirmDialog('确认电子免填单吗？') == 1){
							self.frmCfm();
					}
			}
	}
	
	//本方法中提供了防止重复点击按钮的控制
	Page.prototype.frmCfm = function(){
			showLightBox();
			$('form').attr('action', 'fg511Cfm.jsp');
			if (!$('form').data('alreadySubmit')){
					$('form').data('alreadySubmit', true).submit();
			}
	}
	
	Page.prototype.detectTimeLong = function(){
			if($('#subBizName').find('option:selected').attr('time') == '180'){
					return '包半年';
			} else {
					return '包年';
			}
	}
	
	Page.prototype.charge = function(){
			return $('#subBizName').find('option:selected').attr('rmb');
	}
	
	Page.prototype.isOrderedHalfYear = function(){
			var t = this.getDateFromString(this.endDate) - 
								this.getDateFromString(this.startDate);
			if (t > 184 * 24 * 3600 * 1000){
					return false;
			} else {
					return true;
			}
	}
	
	Page.prototype.getDateFromString = function(str){
			return new Date(str.substring(0,4) + '/' + str.substring(4,6) + '/' + str.substring(6,8)).getTime();
	}
	
	Page.prototype.getCustInfo = function(){
			
		var packet = new AJAXPacket("../public/pubGetUserBaseInfo.jsp","正在获取数据，请稍候......");
		packet.data.add("opCode", "<%=opCode%>");
		packet.data.add("phoneNo", "<%=phoneNo%>");
		core.ajax.sendPacket(packet, function(packet){
		Constants.CUST_NAME = packet.data.findValueByName('stPMcust_name');
		$('#custName').text(Constants.CUST_NAME);
      });
      packet = null;
	}
	
	Page.prototype.timeLongForUnsubscribing = function(){
			if(this.isOrderedHalfYear()){
					return '包半年';
			} else {
					return '包年';
			}
	}
	
  $(function(){
      var page = new Page();
  });
</script>
</head>
<body>
<form name="frm" method="post" action="">
  <input type="hidden" name="opCode" id="opCode" value="<%=opCode%>">
  <input type="hidden" name="opName" id="opName" value="<%=opName%>">
  <input type="hidden" name="sysAccept" value="<%=accept%>">
  <input type="hidden" name="phoneNo" value="<%=phoneNo%>">
  <input type="hidden" name="oprCode" value="">
  <input type="hidden" name="spCode" value="698029">
  
  <input type="hidden" name="bizCode" value="">
  <input type="hidden" name="timeLong" value="">
  
  <%@ include file="/npage/include/header.jsp" %>
  <div class="title">
    <div id="title_zi">操作区</div>
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
    
    <tbody id="quit_area">
  	</tbody>
    
    <tr>
      <td colspan="4" align="center" id="footer">
        <input class="b_foot" type=button name="closeBtn" id="closeBtn" value="关闭">
      </td>
    </tr>
  </table>
  
  <table cellspacing="0">
	  <tr>
  		<td class="blue">操作类型</td>
      <td>
      订购
      </td>
  		<td class="blue">业务种类</td>
      <td>
      	<select id="subBizName" style="width: 160px;">
          <option spCode="698029" bizCode="1100000001" time="180" rmb="18元/半年" value="0">漫话天下半年包18元/半年</option>
          <option spCode="698029" bizCode="1100000001" time="360" rmb="36元/年" value="1">漫话天下全年包36元/年</option>
          <option spCode="698029" bizCode="1100000002" time="180" rmb="18元/半年" value="2">时事天下半年包18元/半年</option>
          <option spCode="698029" bizCode="1100000002" time="360" rmb="36元/年" value="3">时事天下全年包36元/年</option>
          <option spCode="698029" bizCode="1100000003" time="180" rmb="18元/年" value="4">日韩动漫半年包18元/半年</option>
          <option spCode="698029" bizCode="1100000003" time="360" rmb="36元/年" value="5">日韩动漫全年包36元/年</option>
          <option spCode="698029" bizCode="1100000004" time="180" rmb="18元/年" value="6">每日一笑半年包18元/半年</option>
          <option spCode="698029" bizCode="1100000004" time="360" rmb="36元/年" value="7">每日一笑全年包36元/年</option>
        </select>
      </td>
      <td class="blue">操作</td>
      <td>
      	<input type="button" id="subOrderButton" class="b_text" value="订购"/>
      </td>
  	</tr>
  </table>
  <%@ include file="/npage/include/footer_simple.jsp" %>
</form>
<%@ include file="/npage/include/pubLightBox.jsp" %>
</body>
</html>