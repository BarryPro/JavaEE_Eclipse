<%
  /*
   * 139������꣬������
   * ����: 2013-03-11
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
      
      $('#submitBtn').click(function(e){
          e.stopPropagation();
          e.preventDefault();
          
          self.submitForm();
      });
      
      $('#bizName').click(function(e){
          e.stopPropagation();
          e.preventDefault();
          
          var option = $(this).find("option:selected");
          $('input[name="bizCode"]').val(option.attr('bizCode'));
          $('input[name="timeLong"]').val(option.attr('time'));
      });
      
      self.getCustInfo();
      self.detectBiz();
      $('#bizName').click();
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
      
      var packet = new AJAXPacket("detectBiz.jsp", "���ڻ�ȡ���ݣ����Ժ�...");
      packet.data.add("opCode", "<%=opCode%>");
      packet.data.add("phoneNo", "<%=phoneNo%>");
      core.ajax.sendPacket(packet, function(packet){
          self.setupPage(packet);
      });
      packet = null;
  }
  
  Page.prototype.setupPage = function(packet){
  		var self = this;
  		
  		var result = packet.data.findValueByName('result');
  		var retCode = packet.data.findValueByName('retCode');
			if (retCode != '000000'){
					$('#submitBtn').attr('disabled', 'true');
					rdShowMessageDialog("��ȡ������Ϣʧ�ܣ�����ϵ������Ա��", 1);
					return;
			}
			
			if (result[0][0] != ''){
					var temp = result[0][0].split('|');
					var finalResult = [];
					
					for (var i = 0 ;i < (temp.length - 1); i ++){
							var record = [];
							
							for (var j = 0; j < result[0].length; j++){ //��
									var array = result[0][j].split('|');
									record.push(array[i]);
							}
							finalResult.push(record);
					}
					
					for(var i = 0; i < finalResult.length; i++){
							if (finalResult[i][2] == '908545'){//�Ѿ�������
									$('input[name="bizCode"]').val(finalResult[i][4]);
									self.startDate = finalResult[i][6];
									$('#startDate').text(finalResult[i][6]);
									self.endDate = finalResult[i][7];
									$('#endDate').text(finalResult[i][7]);
									$('#originalAccept').text(finalResult[i][8]);
									
									var target = $('#bizName').attr('disabled', true);
									if (finalResult[i][4] == '+MAILBZ'){
											if (self.isOrderedHalfYear()){
													target.val(0);
											}else {
													target.val(1);
											}
									} else if (finalResult[i][4] == '+MAILVIP'){
											if (self.isOrderedHalfYear()){
													target.val(2);
											}else {
													target.val(3);
											}
									}
									
									self.isSubscribing = false;
									$('#oprType').text('�˶�');
									$('input[name="oprCode"]').val('07');
							}
					} 
			}
			
			if (self.isSubscribing) {//δ������
					$('.detailsLine').hide();
					$('#oprType').text('����');
					$('input[name="oprCode"]').val('06');
					self.isSubscribing = true;
			}
  }
  
  Page.prototype.printInfoForSubscribing = function (opcode){
			var cust_info="";
			var opr_info="";
			var note_info1="";
			var note_info2="";
			var note_info3="";
			var note_info4="";
			
			var retInfo = "";
			/************�ͻ���Ϣ************/
			cust_info += "�ֻ����룺" + Constants.PHONE_NO + "|";
			cust_info += "�ͻ�������" + Constants.CUST_NAME + "|";
			
			/************��������************/
			opr_info += "ҵ�����ͣ�139����ҵ��" + $('select option:selected').text() + "�������룬�ʷ�" + this.charge() + "|";
			opr_info += "�������ͣ�����|";
			opr_info += "����ʱ�䣺" + Constants.CURRENT_DATE + '|';

			/************ע������************/
			note_info1 += "��ע��������ֵҵ��" + this.detectTimeLong() + 
			"���ʷѵ��ڵ���25��ϵͳ�Զ�Ϊ���˶�ҵ����Ҳ������Ӫҵ�����Ͷ���0000��10086���ݶ�����ʾ�����˶����й��ƶ���|";

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
			/************�ͻ���Ϣ************/
			cust_info += "�ֻ����룺" + Constants.PHONE_NO + "|";
			cust_info += "�ͻ�������" + Constants.CUST_NAME + "|";
			
			/************��������************/
			opr_info += "ҵ�����ͣ�139����ҵ��" + this.timeLongForUnsubscribing() + "�����˶����롣|";
			opr_info += "�������ͣ��˶�|";
			opr_info += "����ʱ�䣺" + Constants.CURRENT_DATE + '|';

			retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
			retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
			
			return retInfo;
	}
  
  //��ʾ��ӡ�Ի���
  Page.prototype.showPrtDlg = function(opcode, DlgMessage, submitCfm){
			var h=180;
			var w=350;
			var t=screen.availHeight/2-h/2;
			var l=screen.availWidth/2-w/2;
			
			var pType = "subprint";             				 		//��ӡ���ͣ�print ��ӡ subprint �ϲ���ӡ
			var billType = "1";              				 			  //Ʊ�����ͣ�1���������2��Ʊ��3�վ�
			var sysAccept = "<%=accept%>";       						//��ˮ��
			var printStr 
			if(this.isSubscribing){
				printStr = this.printInfoForSubscribing(opcode);   				//����printinfo()���صĴ�ӡ����
			} else {
				printStr = this.printInfoForUnsubscribing(opcode);   				//����printinfo()���صĴ�ӡ����
			}
			var mode_code=null;           							  	//�ʷѴ���
			var fav_code=null;                				 			//�ط�����
			var area_code=null;             				 		  	//С������
			var phoneNo = <%=phoneNo%>;     					    	//�ͻ��绰
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
			var ret = this.showPrtDlg(opCode, "ȷʵҪ���е��������ӡ��", "Yes");
			if ((typeof(ret) == "undefined") || (ret=="continueSub")){
					if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��') == 1){
							self.frmCfm();
					}
			} else if(ret == "confirm"){
					if(rdShowConfirmDialog('ȷ�ϵ��������') == 1){
							self.frmCfm();
					}
			}
	}
	
	//���������ṩ�˷�ֹ�ظ������ť�Ŀ���
	Page.prototype.frmCfm = function(){
			showLightBox();
			$('form').attr('action', 'fg511Cfm.jsp');
			if (!$('form').data('alreadySubmit')){
					$('form').data('alreadySubmit', true).submit();
			}
	}
	
	Page.prototype.detectTimeLong = function(){
			if($('#bizName').find('option:selected').attr('time') == '180'){
					return '������';
			} else {
					return '����';
			}
	}
	
	Page.prototype.charge = function(){
			return $('#bizName').find('option:selected').attr('rmb');
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
	
	Page.prototype.timeLongForUnsubscribing = function(){
			if(this.isOrderedHalfYear()){
					return '������';
			} else {
					return '����';
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
  
  <%@ include file="/npage/include/header.jsp" %>
  <div class="title">
    <div id="title_zi">������</div>
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
  	
  	<tr>
  		<td class="blue">��������</td>
      <td id="oprType">
      </td>
  		<td class="blue">ҵ������</td>
      <td>
      	<select id="bizName" style="width: 160px;">
          <option spCode="908545" bizCode="+MAILBZ" time="180" rmb="30Ԫ/����" value="0">5Ԫ������30Ԫ/����</option>
          <option spCode="908545" bizCode="+MAILBZ" time="360" rmb="60Ԫ/��" value="1">5Ԫ��ȫ���60Ԫ/��</option>
          <option spCode="908545" bizCode="+MAILVIP" time="180" rmb="120Ԫ/����" value="2">20Ԫ������120Ԫ/����</option>
          <option spCode="908545" bizCode="+MAILVIP" time="360" rmb="240Ԫ/��" value="3">20Ԫ��ȫ���240Ԫ/��</option>
        </select>
        <input type="hidden" name="spCode" value="908545"><!-- spCode -->
        <input type="hidden" name="bizCode" value=""><!-- bizCode -->
        <input type="hidden" name="timeLong" value=""><!-- 180��,360�� -->
      </td>
  	</tr>
  	
    <tr class="detailsLine">
      <td class="blue">��ʼʱ��</td>
      <td id="startDate">
      </td>
      <td class="blue">����ʱ��</td>
      <td id="endDate">
      </td>
    </tr>
    
    <tr class="detailsLine">
      <td class="blue">ԭ������ˮ</td>
      <td colspan="3" id="originalAccept">
      </td>
    </tr>
    
    <tr>
      <td colspan="4" align="center" id="footer">
        <input class="b_foot" type=button name="submitBtn" id="submitBtn" value="ȷ��">    
        <input class="b_foot" type=button name="closeBtn" id="closeBtn" value="�ر�">
      </td>
    </tr>
  </table>
  <%@ include file="/npage/include/footer_simple.jsp" %>
</form>
<%@ include file="/npage/include/pubLightBox.jsp" %>
</body>
</html>