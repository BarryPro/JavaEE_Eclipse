<%
  /*
   * ���ڶ�BOSSϵͳ���Ӷ��Ű������û�����Ȩ�޵�����
   * ����: 2014-02-19
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
  <meta http-equiv="Cache-Control" content="no-store"/>
  <meta http-equiv="Pragma" content="no-cache"/>
<%
	request.setCharacterEncoding("GBK");
	response.setHeader("Pragma","No-Cache"); 
  response.setHeader("Cache-Control","No-Cache");
  response.setDateHeader("Expires", 0);
  
  String currentMonth = new java.text.SimpleDateFormat("MM", Locale.getDefault())
  												.format(new java.util.Date());
	String currentYear = new java.text.SimpleDateFormat("yyyy", Locale.getDefault())
  												.format(new java.util.Date());
  
  String phoneNo = request.getParameter("srv_no");
  
  String opCode = "7378";
  String opName = "����ҵ��������������";
  
  String workNo = (String)session.getAttribute("workNo");
  String regionCode = (String)session.getAttribute("regCode");
%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>" id="accept"/>
	
<%
	//������ʽ
	String sqlAgentCode = " select op_code,total_date from sroleopcode where op_type='2' and region_code=:region ";

	//��֯�������
	String [] paraIn = new String[4];

	paraIn[0] = "region";
	paraIn[1] = regionCode.substring(0,2);
	paraIn[2] = sqlAgentCode;
	paraIn[3] = "region="+regionCode.substring(0,2);
%>
	<wtc:service name="sPubSelectNew" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="2" >
		<wtc:param value="<%=paraIn[0]%>"/>
		<wtc:param value="<%=paraIn[1]%>"/>
		<wtc:param value="<%=paraIn[2]%>"/>
		<wtc:param value="<%=paraIn[3]%>"/>
	</wtc:service>	
	<wtc:array id="opcodeArray" start="0" length="1" scope="end"/>
	<wtc:array id="totaldataArray" start="1" length="1" scope="end"/>
	  
<title><%=opName%></title>

<script language="javascript">
  var Constants = {
  		CURRENT_MONTH: '<%=currentMonth%>',
  		CURRENT_YEAR: '<%=currentYear%>',
  		OP_CODE			: '<%=opCode%>',
  		CUST_NAME   : '',
  		ACCEPT   : '<%=accept%>'
  };
  
  function optypeChange(){
	    var getNote_Packet = new AJAXPacket("f7378_rpc.jsp","���ڻ��ҵ����Ϣ�����Ժ�......");
    	getNote_Packet.data.add("retType","getopcode");
  		getNote_Packet.data.add("regionCode","<%=regionCode%>");
  		getNote_Packet.data.add("optype", document.all.op_type.value);
  		getNote_Packet.data.add("phone_no", "<%=phoneNo%>");  
  		getNote_Packet.data.add("listtype", $('#listtype').val());
  		core.ajax.sendPacket(getNote_Packet);
  		getNote_Packet=null;
	}
	
	function doProcess(packet){
      var errorCode = packet.data.findValueByName("errorCode");
      var errorMsg = packet.data.findValueByName("errorMsg");
      if(errorCode != "0000"){
      	rdShowMessageDialog("["+errorCode+"]:"+errorMsg,0);
      	return;
      }
      
      var typecode = packet.data.findValueByName("typecode");
  		var values = packet.data.findValueByName("values");
  		var names = packet.data.findValueByName("names");
  		fillDropDown(document.all.category, values, names);
  }
  
  function fillDropDown(obj,_value,_text){
	    obj.options.length = 0;
	    for(var i=0; i<_value.length;i++){
	      var option = new Option(_text[i],_value[i]);
	      obj.add(option);
	   }
	}
	
  function Page(){
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
          
          self.frmCfm();
      });
      
      $('#addBtn').click(function(e){
          e.stopPropagation();
          e.preventDefault();
          
          self.buttonDisable();
          self.addRow();
      });
      
      optypeChange();
  }
  
  Page.prototype.buttonDisable = function () {
      $('.duplicate').attr('disabled', 'disabled');
  };
  
  Page.prototype.validateRow = function () {
      var f = true;
      var targetValue = $('#op_type').val() + $('#category').val();
      $('#records tr').each(function(i, e){
          if ($(this).attr('data') == targetValue){
              f = false;
              return false;
          }
      });
      return f;
  };
  
  Page.prototype.addRow = function () {
      //1 У��
      if (!this.validateRow()){
          rdShowMessageDialog('�����ظ������ͬ�ļ�¼��');
          return;
      }
      
      if ($('tr[data]').length > 0){
          rdShowMessageDialog('ֻ������һ�����������ҵ������¼��');
          return;
      }
      
      //2 ������
      var publicityType = $('#op_type').val();
      var category = $('#category').val();
      
      var t = '';
          t+= '<tr data="' + publicityType + category + '">';
          t+= '  <td><input type="hidden" value="' + publicityType + '" class="publicityType">' + $('#op_type option:selected').text() + '  </td>';
          t+= '  <td><input type="hidden" value="' + category + '" class="category">' + $('#category option:selected').text() + '  </td>';
          t+= '  <td><input type="button" value="ɾ��" class="b_text" delete="true"></input></td>';
          t+= '</tr>';
          
      $('#records').append(t);
      
      $('#records input[delete="true"]').click(function(e){
           e.stopPropagation();
           e.preventDefault();
           $(this).parents('tr:first').remove();
      });
  };
  
  Page.prototype.closeWindow = function () {
      if(window.opener == undefined) {
          removeCurrentTab();
      } else {
          window.close();
      }
  }
  
  Page.prototype.validateSubmit = function(){
      if ($('#fileName').val() == ''){
          rdShowMessageDialog("��ѡ���ļ���");
          return false;
      }
      
      if ($('tr[data]').length <= 0){
          rdShowMessageDialog("������������ʽ�����ҵ����࣡");
          return false;
      }
      
      return true;
  };
  
	//���������ṩ�˷�ֹ�ظ������ť�Ŀ���
	Page.prototype.frmCfm = function(){
			if (!this.validateSubmit()){
			    return;
			}
			
			var publicityTypes = '', opCategorys = '';
			
			var recordLength = $('#records tr[data]').each(function(){
			    publicityTypes += $(this).find('.publicityType').val() + ',';
			    opCategorys += $(this).find('.category').val() + ',';
      }).length;
			
			var data = {publicityTypes: publicityTypes, 
			            opCategorys:opCategorys,
			            listtype: $('#listtype').val(),
			            switchFlag: $('input[name="switchFlag"]:checked').val(),
			            opType: $('#opType').val(),
			            recordLength: recordLength};
			
			var url = 'f7378_batchCfm.jsp?' + $.param(data);
			$('form').attr('action', url);
			if (!$('form').data('alreadySubmit')){
					$('form').data('alreadySubmit', true).submit();
			}
	}
	
  $(function(){
      var page = new Page();
  });
</script>
</head>
<body>
<form name="frm" method="POST" onKeyUp="chgFocus(frm)" ENCTYPE="multipart/form-data">		
  <%@ include file="/npage/include/header.jsp" %>     	
		<div class="title">
			<div id="title_zi">����ҵ�������������� </div>
		</div>
    
    <table  cellspacing="0" >          
   		<tr> 
    		<td width="16%" class="blue">������ʽ</td>
      	<td width="34%" >		
  			  <select id="opType" class="duplicate">
  			    <option value="A">���</option>
  			    <option value="D">ɾ��</option>
  			  </select>
        </td>
        
        <td class="blue">��������</td>
      	<td>
  			  <select name="listtype" id="listtype" class="duplicate">
  			    <option value="W">������</option>
  			    <option value="B">������</option>
  			  </select>
        </td>
      </tr>
     	
     	<tr>
  			<td width="16%" class="blue">ҵ���ܿ���</td>
  			<td width="34%" colspan="3">   
          <!-- 0���������Ĭ��ѡ�� -->
          <input type="radio" name="switchFlag" value="0" class="duplicate">��&nbsp
					<input type="radio" name="switchFlag" value="1" checked class="duplicate">��
  			</td>  
  			 
     	</tr>       
    
     	<tr>
     	  <td width="16%" class="blue">������ʽ����</td>
  			<td width="34%" >             
      	  <select v_must="1" name="op_type" id="op_type" onchange="optypeChange()">
      			<%for(int i = 0 ; opcodeArray != null && i<opcodeArray.length;  i ++){%>
      				<option value="<%=opcodeArray[i][0]%>"><%=totaldataArray[i][0]%></option>
     	 			<%}%>
  			  </select>
  			</td>
     	  
    		<td width="16%" class="blue">ҵ�����</td>
    	  <td width="34%">
					<select name="category" id="category">
					</select>
        </td>
     	</tr>
     	
     	<tr> 
        <td id="footer" colspan='4'>
      		<input type=button name="addBtn" id="addBtn" class="b_foot" value="����">
        </td>
    	</tr>  
		</table>
		
		<table id="records">
  		<tr>
   			<th>������ʽ</th>
   			<th>ҵ�����</th>
   			<th>����</th>  			
   		</tr>
		</table>
		
		<table>
		  <tr>
        <td class="blue" width="20%">�ļ�</td>
				<td colspan="3">
					<input type="file" name="fileName" id="fileName" class="button" style='border-style:solid;border-color:#7F9DB9;border-width:1px;font-size:12px;' />
				</td>
      </tr>
      
			<tr>
				<td class="blue">�ļ�˵��</td>
				<td colspan="3">&nbsp;
					һ.�������ļ�����Ϊ�ı��ļ�����׺.txt��<br>&nbsp;
					��.һ��������300������<br>&nbsp;
					��.�ļ�����ʾ�����£�<br>&nbsp;
					13766559873<br>&nbsp;
					13766559874<br>&nbsp;
					13766559875
				</td>
			</tr>
		</table>
		
    <table cellspacing="0" >          
     	<tr> 
        <td id="footer">              
      		<input type=button name="submitBtn" id="submitBtn" class="b_foot" value="ȷ��">
          <input type=button name="closeBtn" id="closeBtn" class="b_foot" value="�ر�" onClick="removeCurrentTab();">
        </td>
    	</tr>
    </table>
    
  <%@ include file="/npage/include/footer.jsp" %>   
</form>
<%@ include file="/npage/include/pubLightBox.jsp" %>
</body>
</html>