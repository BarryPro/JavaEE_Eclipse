<%
  /*
   * ����ʵ��BOSSǰ̨ҵ��ģ����֤ҵ�������
   * ��׼������ģ��У��
   * ����: 2013-03-26
   * ����: zhouby
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
      this.years = []; //����Ҫ��Ӧ
      this.months = [];//����Ҫ��Ӧ
      this.limit = 0;	 //����������������4���ܷ������ռ������
      this.phoneLimit = 0;//ͨ����¼��������ps��5���й�ͨ����¼�ĵ绰����һ����Լ����
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
			//ֻ��5����֤���붼���ʱ�� �Ž�����֤
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
          
      		window.location.href = '/npage/s5061/s1441.jsp?opCode=1441&opName=����ǩ��Э��Ǽ�&crmActiveOpCode=1441&activePhone=<%=phoneNo%>&broadPhone=&accept=<%=accept%>&pwrfNeed=N';
      });
      
      self.getCustInfo();
      self.getBillInfo();
  }
  
  /**
  	* ����������Լ��
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
      
      var packet = new AJAXPacket("fg551GetBillList.jsp", "���ڻ�ȡ���ݣ����Ժ�...");
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
					      <td>����ʱ��&nbsp;%s</td>\
					  		<td>������Ϣ&nbsp;%sԪ</td>\
					  		<td>�������Ѷ��&nbsp;%sԪ</td>\
					      <td>\
					      	<label class="centre-op">\
					      		<input type="checkbox" class="checkMiniBox" value="">ȷ����ȷ\
					      	</label>\
					      </td>\
					  	</tr>';
			t = t.replace(/%s/, result[0][0]);  	
			t = t.replace(/%s/, result[0][1]);  	
			t = t.replace(/%s/, result[0][2]);  	
			$(t).appendTo($('#summary-info'));
			
			//ע���¼�
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
  		var packet = new AJAXPacket("fg551Cfm.jsp", "���ڷ��ͣ����Ժ�...");
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
  		var packet = new AJAXPacket("fg551CheckPhone.jsp", "���ڼ�⣬���Ժ�...");
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
          		rdShowMessageDialog('��֤ͨ����');
          		$(button).attr('disabled', 'disabled');
          		self.increase();
          } else {
          		rdShowMessageDialog(targetPhoneNo + '��֤ʧ�ܣ�' + retMsg, 1 );
          }
      });
      packet = null;
  }
  
  Page.prototype.checkBill = function(button){
  		var date = $(button).attr('date'); //��ʽYYYYMM
  		var value = $.trim($(button).prev().attr('value'));//���Ѷ��
  		
  		var packet = new AJAXPacket("fg551CheckBill.jsp", "���ڼ�⣬���Ժ�...");
      packet.data.add("phoneNo", "<%=phoneNo%>");
      packet.data.add("date", date);
      packet.data.add("value", value);
      core.ajax.sendPacket(packet, function(packet){
          var result = packet.data.findValueByName("result");
          if (result[0][39] == '0'){
          		rdShowMessageDialog(date + '���Ѷ��ͨ����֤��');
          		$(button).attr('disabled', 'disabled');
          		self.increase();
          } else {
          		rdShowMessageDialog(date + '���Ѷ��δͨ����֤��', 1);
          }
      });
      packet = null;
  }
	
	//���������ṩ�˷�ֹ�ظ������ť�Ŀ���
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
			var packet = new AJAXPacket("../public/pubGetUserBaseInfo.jsp","���ڻ�ȡ���ݣ����Ժ�......");
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
    <div id="title_zi">������Ϣ</div>
  </div>
  
  <table cellspacing="0">
  	<tr>
      <td class="blue" width="14%">�ͻ�����</td>
      <td width="36%" id="custName">
      </td>
      <td class="blue" width="14%">�ֻ���</td>
      <td width="36%" id="phoneNo"><%=phoneNo%>
      </td>
    </tr>
  </table>
  <%@ include file="/npage/include/footer_simple.jsp" %>
  
  <div id="Main">
		<div id="Operation_Table"> 
		  <div class="title">
		    <div id="title_zi">��Ϣ��</div>
		  </div>
		  
		  <table cellspacing="0" id="summary-info"></table>
  	</div>
  </div>
  
  <div id="Main">
		<div id="Operation_Table"> 
		  <div class="title">
		    <div id="title_zi">������</div>
		  </div>
		  
		  <table cellspacing="0">
		  	<tr>
		  		<td class="blue" width="14%">ͨ����¼</td>
		      <td width="86%">
		      	<input type="text" class="com-phone" value="" v_type="phone" maxLength="11" v_must="1" onkeyup="this.value=this.value.replace(/\D/g,'')">
		      	<input type="text" class="com-phone" value="" v_type="phone" maxLength="11" v_must="1" onkeyup="this.value=this.value.replace(/\D/g,'')">
		      	<input type="text" class="com-phone" value="" v_type="phone" maxLength="11" v_must="1" onkeyup="this.value=this.value.replace(/\D/g,'')">
		      	<input type="text" class="com-phone" value="" v_type="phone" maxLength="11" v_must="1" onkeyup="this.value=this.value.replace(/\D/g,'')">
		      	<input type="text" class="com-phone" value="" v_type="phone" maxLength="11" v_must="1" onkeyup="this.value=this.value.replace(/\D/g,'')">
		      	<input class="b_text checkPhone" type="button" value="����">
		      </td>
		  	</tr>

		    <tr>
		      <td colspan="4" align="center" id="footer">
		        <input class="b_foot" type=button name="submitBtn" id="submitBtn" value="ȷ��" disabled="true">    
		        <input class="b_foot" type=button name="closeBtn" id="closeBtn" value="�ر�">
		        <input class="b_foot turnToOther" type=button name="" value="����ǩ��Э��Ǽ�(1441)" disabled="true">
		      </td>
		    </tr>
		  </table>
  	</div>
  </div>
</form>
<%@ include file="/npage/include/pubLightBox.jsp" %>
</body>
</html>