<%
  /*
   * 关于实现BOSS前台业务模糊验证业务的需求
   * 标准神州行模糊校验
   * 日期: 2013-03-26
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
	<style>
		.centre-op{
				margin: 0 auto;
				display: block;
				width: 80px;
		}
	</style>
<%
	request.setCharacterEncoding("GBK");
	response.setHeader("Pragma","No-Cache"); 
  response.setHeader("Cache-Control","No-Cache");
  response.setDateHeader("Expires", 0);
  
  String currentMonth = new java.text.SimpleDateFormat("MM", Locale.getDefault())
  												.format(new java.util.Date());
	String currentYear = new java.text.SimpleDateFormat("yyyy", Locale.getDefault())
  												.format(new java.util.Date());
  
  String opCode = (String)request.getParameter("opCode");
  String opName = (String)request.getParameter("opName");
  String workNo = (String)session.getAttribute("workNo");
  String regionCode = (String)session.getAttribute("regCode");
  String phoneNo = (String)request.getParameter("activePhone");
%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" 
	routerKey="region" routerValue="<%=regionCode%>" id="accept"/>
	
<title><%=opName%></title>

<script language="javascript">
  var Constants = {
  		CURRENT_MONTH: '<%=currentMonth%>',
  		CURRENT_YEAR: '<%=currentYear%>',
  		OP_CODE			: '<%=opCode%>',
  		CUST_NAME   : '',
  		PHONE_NO   : '<%=phoneNo%>',
  		ACCEPT   : '<%=accept%>'
  };
  
  function Page(){
      this.initOthers();
      this.years = []; //年月要对应
      this.months = [];//年月要对应
      this.limit = 0;	 //总限制条件，超过4才能发起最终检测请求
      this.phoneLimit = 0;//通话记录计数器。ps：5个有过通话记录的电话，算一个制约条件
  }
  
  Page.prototype.initOthers = function () {
      var self = this;
      
      $("#closeBtn").click(function(e){
          e.stopPropagation();
          e.preventDefault();
          
          self.closeWindow();
      });
      
      $('#submitBtn').click(function(e){
          e.stopPropagation();
          e.preventDefault();
          
          self.checkBusiness();
      });
      
      $('.checkPhone').click(function(e){
      		e.stopPropagation();
          e.preventDefault();
         var checkPhoneList = $(this).prevAll('.com-phone');
  			var checkFlag = 0;
	  		checkPhoneList.each(function(){
	  				if($(this).val().length>0){
	  					checkFlag++;
	  				}
	  				
	  		});
			//只有5个验证号码都填的时候 才进行验证
	  		if(checkFlag>0){
	  			
	  			for(var i=0;i<checkPhoneList.length;i++){
	  				if (!checkElement(checkPhoneList[i])){							
  							return;
					}
	  			}
	  			self.checkPhone($(this));
	  		}
      });
      
      $('.turnToOther').click(function(e){
      		e.stopPropagation();
          e.preventDefault();
          
      		window.location.href = '/npage/s5061/s1441.jsp?opCode=1441&opName=重新签署协议登记&crmActiveOpCode=1441&activePhone=<%=phoneNo%>&broadPhone=&accept=<%=accept%>&pwrfNeed=N';
      });
      
      self.getCustInfo();
      self.getBillInfo();
  }
  
  /**
  	* 限制条件制约器
  	*/
  Page.prototype.increase = function () {
  		this.limit++;
  		if (this.limit >= 2){
  				$('#submitBtn').attr('disabled', false);
  		} else {
  				$('#submitBtn').attr('disabled', true);
  		}
  }
  Page.prototype.reduce = function(){
  		this.limit--;
  		if (this.limit < 0 ){
  				this.limit = 0;
  		}
  }
  
  Page.prototype.closeWindow = function () {
      if(window.opener == undefined) {
          removeCurrentTab();
      } else {
          window.close();
      }
  }
  
  Page.prototype.getBillInfo = function () {
      var self = this;
      
      var packet = new AJAXPacket("fg551GetBillList.jsp", "正在获取数据，请稍候...");
      packet.data.add("phoneNo", "<%=phoneNo%>");
      core.ajax.sendPacket(packet, function(packet){
          self.setupPageForBill(packet);
      });
      packet = null;
  }
  
  Page.prototype.setupPageForBill = function(packet){
  		var self = this;
  		
  		var retCode = packet.data.findValueByName('retCode');
  		var retMsg = packet.data.findValueByName('retMsg');
			if (retCode != '000000'){
					$('#submitBtn').attr('disabled', 'true');
					rdShowMessageDialog("" + retCode + " " + retMsg , 1);
					return;
			}
			var result = packet.data.findValueByName('result');
			var t = '<tr>\
					  		<td>1</td>\
					      <td>交费时间&nbsp;%s</td>\
					  		<td>交费信息&nbsp;%s元</td>\
					  		<td>上月消费额度&nbsp;%s元</td>\
					      <td>\
					      	<label class="centre-op">\
					      		<input type="checkbox" class="checkMiniBox" value="">确认正确\
					      	</label>\
					      </td>\
					  	</tr>';
			t = t.replace(/%s/, result[0][0]);  	
			t = t.replace(/%s/, result[0][1]);  	
			t = t.replace(/%s/, result[0][2]);  	
			$(t).appendTo($('#summary-info'));
			
			//注册事件
			$('.checkMiniBox').click(function(e){
      		e.stopPropagation();
          
      		if ($(this).is(':checked')){
      				self.increase();
      		} else {
      				self.reduce();
      		}
      });
  }
  
  Page.prototype.checkBusiness = function(){
  		var packet = new AJAXPacket("fg551Cfm.jsp", "正在发送，请稍候...");
      packet.data.add("opCode", "<%=opCode%>");
      packet.data.add("phoneNo", '<%=phoneNo%>');
      packet.data.add("accept", '<%=accept%>');
      core.ajax.sendPacket(packet, function(packet){
      		var retCode = packet.data.findValueByName("retCode");
      		var retMsg = packet.data.findValueByName("retMsg");
      		
      		if (retCode != '000000'){
							$('#submitBtn').attr('disabled', 'true');
							rdShowMessageDialog("" + retCode + " " + retMsg , 1);
							return;
					}
      	
          var result = packet.data.findValueByName("result");
          if (result[0][0] == '000000'){
          		$('.turnToOther').attr('disabled', false);
          }
      });
      packet = null;
  }
  
  Page.prototype.checkPhone = function(button){
  		var self = this;
  		var targetPhoneNos = $(button).prevAll('.com-phone');
  		
  		var targetPhoneNo = '';
  		targetPhoneNos.each(function(){
  				targetPhoneNo += $(this).attr('value')+",";
  		});
  		targetPhoneNo = targetPhoneNo.substring(0,(targetPhoneNo.length-1));
  		var packet = new AJAXPacket("fg551CheckPhone.jsp", "正在检测，请稍候...");
      packet.data.add("originalPhoneNo", "<%=phoneNo%>");
      packet.data.add("targetPhoneNo", targetPhoneNo);
      packet.data.add("opCode", '<%=opCode%>');
      core.ajax.sendPacket(packet, function(packet){
      		var retCode = packet.data.findValueByName("retCode");
      		var retMsg = packet.data.findValueByName("retMsg");
      		
      		if (retCode != '000000'){
							$('#submitBtn').attr('disabled', 'true');
							rdShowMessageDialog("" + retCode + " " + retMsg , 1);
							return;
					}
      	
          var result = packet.data.findValueByName("result");
          
          if (result[0][2] == '0'){
          		rdShowMessageDialog('验证通过！');
          		$(button).attr('disabled', 'disabled');
          		self.increase();
          } else {
          		rdShowMessageDialog(targetPhoneNo + '验证失败！' + retMsg, 1 );
          }
      });
      packet = null;
  }
  
  Page.prototype.checkBill = function(button){
  		var date = $(button).attr('date'); //格式YYYYMM
  		var value = $.trim($(button).prev().attr('value'));//消费额度
  		
  		var packet = new AJAXPacket("fg551CheckBill.jsp", "正在检测，请稍候...");
      packet.data.add("phoneNo", "<%=phoneNo%>");
      packet.data.add("date", date);
      packet.data.add("value", value);
      core.ajax.sendPacket(packet, function(packet){
          var result = packet.data.findValueByName("result");
          if (result[0][39] == '0'){
          		rdShowMessageDialog(date + '消费额度通过验证！');
          		$(button).attr('disabled', 'disabled');
          		self.increase();
          } else {
          		rdShowMessageDialog(date + '消费额度未通过验证！', 1);
          }
      });
      packet = null;
  }
	
	//本方法中提供了防止重复点击按钮的控制
	Page.prototype.frmCfm = function(){
			showLightBox();
			$('form').attr('action', 'fg511Cfm.jsp');
			if (!$('form').data('alreadySubmit')){
					$('form').data('alreadySubmit', true).submit();
			}
	}
	
	Page.prototype.getDateFromString = function(str){
			var t = str.substring(0,4) + '/' + str.substring(4,6) + '/' + str.substring(6,8);
			var m = new Date(t);
			return m.getTime();
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
  
  <%@ include file="/npage/include/header.jsp" %>
  <div class="title">
    <div id="title_zi">基本信息</div>
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
  </table>
  <%@ include file="/npage/include/footer_simple.jsp" %>
  
  <div id="Main">
		<div id="Operation_Table"> 
		  <div class="title">
		    <div id="title_zi">信息区</div>
		  </div>
		  
		  <table cellspacing="0" id="summary-info"></table>
  	</div>
  </div>
  
  <div id="Main">
		<div id="Operation_Table"> 
		  <div class="title">
		    <div id="title_zi">输入区</div>
		  </div>
		  
		  <table cellspacing="0">
		  	<tr>
		  		<td class="blue" width="14%">通话记录</td>
		      <td width="86%">
		      	<input type="text" class="com-phone" value="" v_type="phone" maxLength="11" v_must="1" onkeyup="this.value=this.value.replace(/\D/g,'')">
		      	<input type="text" class="com-phone" value="" v_type="phone" maxLength="11" v_must="1" onkeyup="this.value=this.value.replace(/\D/g,'')">
		      	<input type="text" class="com-phone" value="" v_type="phone" maxLength="11" v_must="1" onkeyup="this.value=this.value.replace(/\D/g,'')">
		      	<input type="text" class="com-phone" value="" v_type="phone" maxLength="11" v_must="1" onkeyup="this.value=this.value.replace(/\D/g,'')">
		      	<input type="text" class="com-phone" value="" v_type="phone" maxLength="11" v_must="1" onkeyup="this.value=this.value.replace(/\D/g,'')">
		      	<input class="b_text checkPhone" type="button" value="检验">
		      </td>
		  	</tr>

		    <tr>
		      <td colspan="4" align="center" id="footer">
		        <input class="b_foot" type=button name="submitBtn" id="submitBtn" value="确定" disabled="true">    
		        <input class="b_foot" type=button name="closeBtn" id="closeBtn" value="关闭">
		        <input class="b_foot turnToOther" type=button name="" value="重新签署协议登记(1441)" disabled="true">
		      </td>
		    </tr>
		  </table>
  	</div>
  </div>
</form>
<%@ include file="/npage/include/pubLightBox.jsp" %>
</body>
</html>