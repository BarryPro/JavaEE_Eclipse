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
  String currentDay = new java.text.SimpleDateFormat("dd", Locale.getDefault())
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
<script language="javascript" type="text/javascript" 
  src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js"></script>
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
      
      optypeChange();
  };
  
  Page.prototype.closeWindow = function () {
      if(window.opener == undefined) {
          removeCurrentTab();
      } else {
          window.close();
      }
  }

	Page.prototype.frmCfm = function(){
			
			var data = {listtype: $('#listtype').val(),
			            switchFlag: $('input[name="switchFlag"]:checked').val(),
			            op_type: $('#op_type').val(),
			            category: $('#category').val(),
			            beginTime: $('#beginTime').val(),
			            endTime: $('#endTime').val()};
			
			var url = 'f7378_exportRecords.jsp?' + $.param(data);
	    $('#targetFrame').attr('src', url);
	}
	
  $(function(){
      var page = new Page();
  });
</script>
</head>
<body>
<form name="frm" method="POST" onKeyUp="chgFocus(frm)">		
  <%@ include file="/npage/include/header.jsp" %>     	
		<div class="title">
			<div id="title_zi">自有业务宣传名单管理 </div>
		</div>
    
    <table  cellspacing="0" >          
   		<tr> 
        <td width="16%" class="blue">名单类型</td>
      	<td width="34%" >
  			  <select name="listtype" id="listtype">
  			    <option value="W">白名单</option>
  			    <option value="B">黑名单</option>
  			  </select>
        </td>
        
        <td width="16%" class="blue">业务总开关</td>
  			<td width="34%" >             
      	  <input type="radio" name="switchFlag" value="0">开&nbsp
					<input type="radio" name="switchFlag" value="1" checked>关
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
     	  <td width="16%" class="blue">开始时间</td>
  			<td width="34%" >
    	   <input id="beginTime" readonly="true" name="beginTime" type="text"
    	    value="<%=currentYear%><%=currentMonth%>01"
    	    onclick="WdatePicker({dateFmt:'yyyyMMdd',position:{top:'under'}});"/>
    	    yyyyMMdd<font class="orange">*</font>
     	  </td>
     	  
     	  <td width="16%" class="blue">结束时间</td>
  			<td width="34%" >
    	   <input id="endTime" readonly="true" name="endTime" type="text" 
    	     value="<%=currentYear%><%=currentMonth%><%=currentDay%>"
    	     onclick="WdatePicker({dateFmt:'yyyyMMdd',position:{top:'under'}});"/>
    	   yyyyMMdd<font class="orange">*</font>
     	  </td>
     	</tr>
		</table>
		
    <table cellspacing="0">
     	<tr>
        <td id="footer">
      	  <input type=button name="submitBtn" id="submitBtn" class="b_foot" value="查询">
        </td>
    	</tr>
    </table>
    <!-- f7378_exportRecords.jsp -->
    <iframe src="" id="targetFrame" style="width: 100%;height: 400px;"></iframe>
  <%@ include file="/npage/include/footer.jsp" %>   
</form>
<%@ include file="/npage/include/pubLightBox.jsp" %>
</body>
</html>