<%
  /*
   * 关于对BOSS系统增加短信白名单用户管理权限的申请
   * 日期: 2014-02-19
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
  String opName = "自有业务宣传名单管理";
  
  String workNo = (String)session.getAttribute("workNo");
  String regionCode = (String)session.getAttribute("regCode");
%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>" id="accept"/>
	
<%
	//宣传方式
	String sqlAgentCode = " select op_code,total_date from sroleopcode where op_type='2' and region_code=:region ";

	//组织输入参数
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
	    var getNote_Packet = new AJAXPacket("f7378_rpc.jsp","正在获得业务信息，请稍候......");
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
      //1 校验
      if (!this.validateRow()){
          rdShowMessageDialog('不能重复添加相同的记录！');
          return;
      }
      
      if ($('tr[data]').length > 0){
          rdShowMessageDialog('只能增加一种宣传分类和业务分类记录！');
          return;
      }
      
      //2 增加行
      var publicityType = $('#op_type').val();
      var category = $('#category').val();
      
      var t = '';
          t+= '<tr data="' + publicityType + category + '">';
          t+= '  <td><input type="hidden" value="' + publicityType + '" class="publicityType">' + $('#op_type option:selected').text() + '  </td>';
          t+= '  <td><input type="hidden" value="' + category + '" class="category">' + $('#category option:selected').text() + '  </td>';
          t+= '  <td><input type="button" value="删除" class="b_text" delete="true"></input></td>';
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
          rdShowMessageDialog("请选择文件！");
          return false;
      }
      
      if ($('tr[data]').length <= 0){
          rdShowMessageDialog("请增加宣传方式分类和业务分类！");
          return false;
      }
      
      return true;
  };
  
	//本方法中提供了防止重复点击按钮的控制
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
			<div id="title_zi">自有业务宣传名单管理 </div>
		</div>
    
    <table  cellspacing="0" >          
   		<tr> 
    		<td width="16%" class="blue">操作方式</td>
      	<td width="34%" >		
  			  <select id="opType" class="duplicate">
  			    <option value="A">添加</option>
  			    <option value="D">删除</option>
  			  </select>
        </td>
        
        <td class="blue">名单类型</td>
      	<td>
  			  <select name="listtype" id="listtype" class="duplicate">
  			    <option value="W">白名单</option>
  			    <option value="B">黑名单</option>
  			  </select>
        </td>
      </tr>
     	
     	<tr>
  			<td width="16%" class="blue">业务总开关</td>
  			<td width="34%" colspan="3">   
          <!-- 0的情况，关默认选择 -->
          <input type="radio" name="switchFlag" value="0" class="duplicate">开&nbsp
					<input type="radio" name="switchFlag" value="1" checked class="duplicate">关
  			</td>  
  			 
     	</tr>       
    
     	<tr>
     	  <td width="16%" class="blue">宣传方式分类</td>
  			<td width="34%" >             
      	  <select v_must="1" name="op_type" id="op_type" onchange="optypeChange()">
      			<%for(int i = 0 ; opcodeArray != null && i<opcodeArray.length;  i ++){%>
      				<option value="<%=opcodeArray[i][0]%>"><%=totaldataArray[i][0]%></option>
     	 			<%}%>
  			  </select>
  			</td>
     	  
    		<td width="16%" class="blue">业务分类</td>
    	  <td width="34%">
					<select name="category" id="category">
					</select>
        </td>
     	</tr>
     	
     	<tr> 
        <td id="footer" colspan='4'>
      		<input type=button name="addBtn" id="addBtn" class="b_foot" value="增加">
        </td>
    	</tr>  
		</table>
		
		<table id="records">
  		<tr>
   			<th>宣传方式</th>
   			<th>业务分类</th>
   			<th>操作</th>  			
   		</tr>
		</table>
		
		<table>
		  <tr>
        <td class="blue" width="20%">文件</td>
				<td colspan="3">
					<input type="file" name="fileName" id="fileName" class="button" style='border-style:solid;border-color:#7F9DB9;border-width:1px;font-size:12px;' />
				</td>
      </tr>
      
			<tr>
				<td class="blue">文件说明</td>
				<td colspan="3">&nbsp;
					一.所导入文件必须为文本文件（后缀.txt）<br>&nbsp;
					二.一次最多操作300个号码<br>&nbsp;
					三.文件内容示例如下：<br>&nbsp;
					13766559873<br>&nbsp;
					13766559874<br>&nbsp;
					13766559875
				</td>
			</tr>
		</table>
		
    <table cellspacing="0" >          
     	<tr> 
        <td id="footer">              
      		<input type=button name="submitBtn" id="submitBtn" class="b_foot" value="确认">
          <input type=button name="closeBtn" id="closeBtn" class="b_foot" value="关闭" onClick="removeCurrentTab();">
        </td>
    	</tr>
    </table>
    
  <%@ include file="/npage/include/footer.jsp" %>   
</form>
<%@ include file="/npage/include/pubLightBox.jsp" %>
</body>
</html>