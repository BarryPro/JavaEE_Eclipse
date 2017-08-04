<%
  /*
   * �ֻ�����
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
  		self.contents = [];
  		
  		var result = packet.data.findValueByName('result');
  		var retCode = packet.data.findValueByName('retCode');
			if (retCode != '000000'){
					$('#submitBtn').attr('disabled', 'true');
					rdShowMessageDialog("��ȡ������Ϣʧ�ܣ�����ϵ������Ա��", 1);
					return;
			}
			var subOptions = $('#subBizName').find('option');
			
			//�Ժ��ⲿ���������������չ����ý����������뵥���ķ���
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
					
					var h = '';
					for(var i = 0, j = 0; i < finalResult.length; i++){
							if (finalResult[i][2] == '698029'){//�Ѿ�������
								
							var a = {};	
							var	t = '<tbody class="quiteRecord">';
							    t += 	'<tr>';
									t += 		'<td class="blue">��������</td>';
									t +=      '<td>�˶�';
									t +=      '</td>';
									t +=  		'<td class="blue">ҵ������</td>';
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
													t +=          '<option spCode="698029" bizCode="1100000001" time="180" rmb="18Ԫ/����" value="0" checked="true">�������°����18Ԫ/����</option>';
											}else {
													t +=          '<option spCode="698029" bizCode="1100000001" time="360" rmb="36Ԫ/��" value="1">��������ȫ���36Ԫ/��</option>';
											}
									} else if (finalResult[i][4] == '1100000002'){
											if (self.isOrderedHalfYear()){
													t +=          '<option spCode="698029" bizCode="1100000002" time="180" rmb="18Ԫ/����" value="2">ʱ�����°����18Ԫ/����</option>';
											}else {
													t +=          '<option spCode="698029" bizCode="1100000002" time="360" rmb="36Ԫ/��" value="3">ʱ������ȫ���36Ԫ/��</option>';
											}
									} else if (finalResult[i][4] == '1100000003'){
											if (self.isOrderedHalfYear()){
													t +=          '<option spCode="698029" bizCode="1100000003" time="180" rmb="18Ԫ/��" value="4">�պ����������18Ԫ/����</option>';
											}else {
													t +=          '<option spCode="698029" bizCode="1100000003" time="360" rmb="36Ԫ/��" value="5">�պ�����ȫ���36Ԫ/��</option>';
											}
									} else if (finalResult[i][4] == '1100000004'){
											if (self.isOrderedHalfYear()){
													t +=          '<option spCode="698029" bizCode="1100000004" time="180" rmb="18Ԫ/��" value="6">ÿ��һЦ�����18Ԫ/����</option>';
											} else {
													t +=          '<option spCode="698029" bizCode="1100000004" time="360" rmb="36Ԫ/��" value="7">ÿ��һЦȫ���36Ԫ/��</option>';
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
									t +=      '<td class="blue">��ʼʱ��</td>';
									t +=      '<td id="startDate' + j + '">' + finalResult[i][6];
									t +=      '</td>';
									t +=      '<td class="blue">����ʱ��</td>';
									t +=      '<td id="endDate' + j + '">' + finalResult[i][7];
									t +=      '</td>';
									t +=    '</tr>';

									t +=    '<tr>';
									t +=      '<td class="blue">ԭ������ˮ</td>';
									t +=      '<td id="originalAccept' + j + '">' + finalResult[i][8];
									t +=      '</td>';
									t +=			'<td class="blue">����</td>';
									t +=      '<td><input class="b_text" type="button" value="�˶�" index="' + j +'" id="quit' + j + '"/>';
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
  		//�������ݴ�����һ��ҳ��
  		var t = $('input[name="oprCode"]');
  		if (this.isSubscribing){
  				t.val('06');
  				
  				var p = $('#subBizName').find('option:selected');
  				$('input[name="bizCode"]').val(p.attr('bizCode'));
  				$('input[name="timeLong"]').val(p.attr('time'));
  		} else { //�˶�
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
			/************�ͻ���Ϣ************/
			cust_info += "�ֻ����룺" + Constants.PHONE_NO + "|";
			cust_info += "�ͻ�������" + Constants.CUST_NAME + "|";
			
			/************��������************/
			opr_info += "ҵ�����ͣ��ֻ�����ҵ��" + $('#subBizName option:selected').text() + "�������룬�ʷ�" + this.charge() + "|";
			opr_info += "�������ͣ�����|";
			opr_info += "����ʱ�䣺" + Constants.CURRENT_DATE + '|';

			/************ע������************/
			/*2014/02/19 9:08:02 gaopeng R_CMI_HLJ_xueyz_2014_1334133@�����Ż�����ҵ����ꡢ�������ʷѵĺ� */
			note_info1 += "��ע��������ֵҵ��" + this.detectTimeLong() + 
			",�ʷѵ��ڵ���25��ϵͳ�Զ�Ϊ���˶�ҵ����Ҳ������Ӫҵ�����Ͷ���0000��10086���ݶ�����ʾ�����˶����й��ƶ���|";
			/*2014/02/19 9:08:02 gaopeng R_CMI_HLJ_xueyz_2014_1334133@�����Ż�����ҵ����ꡢ�������ʷѵĺ� */
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
			opr_info += "ҵ�����ͣ��ֻ�����ҵ��" + this.timeLongForUnsubscribing() + "�����˶����롣|";
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
			if($('#subBizName').find('option:selected').attr('time') == '180'){
					return '������';
			} else {
					return '����';
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
  <input type="hidden" name="spCode" value="698029">
  
  <input type="hidden" name="bizCode" value="">
  <input type="hidden" name="timeLong" value="">
  
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
    
    <tbody id="quit_area">
  	</tbody>
    
    <tr>
      <td colspan="4" align="center" id="footer">
        <input class="b_foot" type=button name="closeBtn" id="closeBtn" value="�ر�">
      </td>
    </tr>
  </table>
  
  <table cellspacing="0">
	  <tr>
  		<td class="blue">��������</td>
      <td>
      ����
      </td>
  		<td class="blue">ҵ������</td>
      <td>
      	<select id="subBizName" style="width: 160px;">
          <option spCode="698029" bizCode="1100000001" time="180" rmb="18Ԫ/����" value="0">�������°����18Ԫ/����</option>
          <option spCode="698029" bizCode="1100000001" time="360" rmb="36Ԫ/��" value="1">��������ȫ���36Ԫ/��</option>
          <option spCode="698029" bizCode="1100000002" time="180" rmb="18Ԫ/����" value="2">ʱ�����°����18Ԫ/����</option>
          <option spCode="698029" bizCode="1100000002" time="360" rmb="36Ԫ/��" value="3">ʱ������ȫ���36Ԫ/��</option>
          <option spCode="698029" bizCode="1100000003" time="180" rmb="18Ԫ/��" value="4">�պ����������18Ԫ/����</option>
          <option spCode="698029" bizCode="1100000003" time="360" rmb="36Ԫ/��" value="5">�պ�����ȫ���36Ԫ/��</option>
          <option spCode="698029" bizCode="1100000004" time="180" rmb="18Ԫ/��" value="6">ÿ��һЦ�����18Ԫ/����</option>
          <option spCode="698029" bizCode="1100000004" time="360" rmb="36Ԫ/��" value="7">ÿ��һЦȫ���36Ԫ/��</option>
        </select>
      </td>
      <td class="blue">����</td>
      <td>
      	<input type="button" id="subOrderButton" class="b_text" value="����"/>
      </td>
  	</tr>
  </table>
  <%@ include file="/npage/include/footer_simple.jsp" %>
</form>
<%@ include file="/npage/include/pubLightBox.jsp" %>
</body>
</html>