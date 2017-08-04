<%
  /*
   * 营销案外呼查询
   * 日期: 2013-12-05
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
  
  String currentMonth = new java.text.SimpleDateFormat("MM", Locale.getDefault())
  												.format(new java.util.Date());
  String currentYear = new java.text.SimpleDateFormat("yyyy", Locale.getDefault())
  												.format(new java.util.Date());
  
  String opCode = (String)request.getParameter("opCode");
  String opName = (String)request.getParameter("opName");
  String selectedRegion = (String)request.getParameter("selectedRegion") == null? "00":(String)request.getParameter("selectedRegion");
  String selectedopcode = (String)request.getParameter("selectedopcode") == null? "00":(String)request.getParameter("selectedopcode");
  
  String workNo = (String)session.getAttribute("workNo");
  String password = (String)session.getAttribute("password");
  String regionCode = (String)session.getAttribute("regCode");
	
  String numpage = (String)request.getParameter("numpage") == null? "1":(String)request.getParameter("numpage");
  String endpanges = (String)request.getParameter("numpage") == null? "0":(String)request.getParameter("numpage");
  String  zongshus= (String)request.getParameter("zongshus") == null? "0":(String)request.getParameter("zongshus");


%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>" id="accept"/>

<%
	String [][]result = {};
	if(!"00".equals(selectedRegion) && !"00".equals(selectedopcode)){
	    System.out.println(" zhouby opCode " + opCode);
	    System.out.println(" zhouby workNo " + workNo);
	    System.out.println(" zhouby password " + password);
	    System.out.println(" zhouby selectedRegion " + selectedRegion);
	    System.out.println(" zhouby numpage " + numpage);
%>

<wtc:service name="sm001Qry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="11">
  	<wtc:param value="<%=accept%>"/>
  	<wtc:param value="01"/>
  	<wtc:param value="<%=opCode%>"/>
  	<wtc:param value="<%=workNo%>"/>
  	<wtc:param value="<%=password%>"/>
    <wtc:param value=""/>
  	<wtc:param value=""/>
  	<wtc:param value="备注"/>
  	<wtc:param value="<%=selectedRegion%>"/>
  	<wtc:param value="<%=numpage%>"/>
</wtc:service>

<wtc:array id="result_s" start="0" length="10" scope="end"/>
<wtc:array id="retArr13" start="10" length="1" scope="end"/>
<%
	 result = result_s;
	if(retArr13!=null&&retArr13.length>0) {
    	if(!"".equals(retArr13[0][0])&&zongshus.equals("0")) {
    		zongshus=retArr13[0][0];
    	}
		if(!"".equals(retArr13[0][0])&&Integer.parseInt(retArr13[0][0].trim())==0) {
		 		endpanges="1";
		 }
		 if(!"".equals(retArr13[0][0])&&Integer.parseInt(retArr13[0][0].trim())>0 && Integer.parseInt(retArr13[0][0].trim())<10) {
		 		endpanges="1";
		 }
		 if(!"".equals(retArr13[0][0])&&Integer.parseInt(retArr13[0][0].trim())>10) {
		 		endpanges=Integer.parseInt(retArr13[0][0].trim())/10+"";
		 }
	  }
	}
%>

<title><%=opName%></title>

<script language="javascript">
	var records = [];
<%	
	if (true && result.length > 0){
			for(int i = 0; i < result.length; i++){
%>
					var t = [];
<%
					for(int j = 0; j < result[i].length; j++){
					System.out.println("zhouby result [" + i +"][" + j + "] = " + result[i][j]);
%>					
							t[<%=j%>] = '<%=result[i][j].trim().replaceAll("\\n", "").replaceAll("\\n", "")%>';
<%
					}
%>
					records[<%=i%>] = t;
<%
			}
	}
%>
  var Constants = {
  		CURRENT_MONTH: '<%=currentMonth%>',
  		CURRENT_YEAR: '<%=currentYear%>',
  		OP_CODE			: '<%=opCode%>',
  		CUST_NAME   : '',
  		ACCEPT   : '',
  		NUMPAGE_LESS : '<%=Integer.parseInt(numpage) - 1%>',
  		NUMPAGE_MORE : '<%=Integer.parseInt(numpage)+1%>',
  		WORK_NO : '<%=workNo%>'
  };
  
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
      
      
      
      this.setupArea();
  }
  
  Page.prototype.closeWindow = function () {
      if(window.opener == undefined) {
          removeCurrentTab();
      } else {
          window.close();
      }
  }
  /*<th>联系电话</th>						
			<th>身份证号码</th>
			<th>购买号码</th>
			<th>原配送地址</th>
			<th>预占工号</th>
			<th>操作</th>*/
  
 	Page.prototype.setupArea = function () {
      var t = '',self = this;
      
      for (var i = 0; i < records.length; i++){
	        t += 		 '<tr>';
    		t +=				'<td>' + records[i][0] + '</td>'; 						
    		t +=				'<td>' + records[i][2] + '</td>';
    		t +=				'<td>' + records[i][3] + '</td>';
    		
    		if (records[i][08] != '08'){
    		    t +=			'<td>' + records[i][4] + ''+records[i][5] + '<input type="text" id="address'+i+'" class="address" value="' + records[i][6] + '" disabled readonly="readonly"/></td>';
    		}else {
    		    t +=			'<td>'+records[i][4]+''+records[i][5]+'<input type="text" id="address'+i+'" class="address" value="' + records[i][6] + '" readonly="readonly"/></td>';
    		}
    		
    		t +=                '<td>' + records[i][9] + '</td>';
    		
    		t +=				'<td>';
    		
    		if (records[i][9] == ''){//预占工号是空        Constants.WORK_NO
    				t +=			'<input type="button" value="预占" class="b_text hold" line="' + i + '"/>';							
    				t +=			'<input type="radio" disabled="true" name="callRadio" line="' + i + '" vl="1" class="updateCall"/>外呼成功 &nbsp;';
    				t +=			'<input type="radio" disabled="true" name="callRadio" line="' + i + '" vl="0" class="updateCall"/>外呼失败 &nbsp;';
    		} else {//非空，需要判断和当前工号比较，如果是当前工号，预占按钮灰色，后边可以用
    		        //如果不是当前工号，全不可用，展示当前工号
    		        if(records[i][9] == Constants.WORK_NO){
        				t +=			'<input type="button" value="预占" class="b_text" disabled="true"/>';	
        				t +=			'<input type="radio" name="call_' + i + '" line="' + i + '" vl="1" class="updateCall"/>外呼成功 &nbsp;';
        				t +=			'<input type="radio" name="call_' + i + '" line="' + i + '" vl="0" class="updateCall"/>外呼失败 &nbsp;';
    				}else {
    				    t +=			'<input type="button" value="预占" class="b_text" disabled="true"/>';	
    				    t +=			'<input type="radio" disabled="true" name="callRadio" line="' + i + '" vl="1" class="updateCall"/>外呼成功 &nbsp;';
    				    t +=			'<input type="radio" disabled="true" name="callRadio" line="' + i + '" vl="0" class="updateCall"/>外呼失败 &nbsp;';
    				}	
    		} 
    		t +=				'</td>';
    	    t +=		 '</tr>';
    	}
    	//t+='<tr><td colspan="7" align="center"><input type="button" class="b_text" value="上一页" numberLess="' + Constants.NUMPAGE_LESS+'" />&nbsp;&nbsp;&nbsp;<input type="button" value="下一页" class="b_text" numberMore="'+Constants.NUMPAGE_MORE+'" /></td></tr>';
    	
    	$('#targetArea').html(t);
	 		
	 	$('input[numberLess]').click(function(e){
	 		 e.stopPropagation();
             e.preventDefault();
          		
             pagecontione($(this).attr('numberLess'));
	 	});

	 		$('input[numberMore]').click(function(e){
	 		   e.stopPropagation();
                 e.preventDefault();
                  		
                 pagecontione($(this).attr('numberMore'));
	 		});
	 		
	 		$('.hold').click(function(e){
	 			 e.stopPropagation();
         		 e.preventDefault();
          		
          		self.requestHoleNo($(this));
	 		});
	 		
	 		$('.updateAddr').click(function(e){
	 			 e.stopPropagation();
                 e.preventDefault();
          
                 self.requestUpdateAddr($(this));
	 		});
	 		
	 		$('.updateCall').click(function(e){
	 			e.stopPropagation();
		          
		        var f = $(this).attr('vl');
		        var $tr = $(this).parents('tr:first');
    			var address = $tr.find('.address').val().trim();
    		    if(address == "" && f != '0') {//成功情况下的配送地址不能为空
    				rdShowMessageDialog("修改的配送地址不能为空！");
    				return false;
    			}
    			
		        $(this).parents('tr:first').find('.address').attr('disabled', 'disabled');
		        self.requestCall($(this), f);
	 		});
	 		
	 		$('.showMore').click(function(e){
	 				e.stopPropagation();
          			e.preventDefault();
          
          			self.showMore($(this));
	 		});
	 		
  }
  
  function pagecontione(nums) {  		
  		var selectedRegion = $("#regionSelect").val();
			var selectedopcode = $("#opSelect").val();	
			window.location="fm001Main.jsp?opCode=<%=opCode%>&opName=<%=opName%>&crmActiveOpCode=<%=opCode%>&selectedRegion="+selectedRegion+"&selectedopcode="+selectedopcode+"&numpage="+nums+"&endpanges=<%=endpanges%>&zongshus=<%=zongshus%>";			
  }
  
  Page.prototype.requestHoleNo = function (button) {
  		if($('#reasonDiv').length > 0){
		   $('#reasonDiv').remove();
		}
  		var t = '',self = this;
        
        var i = button.attr('line');
  		var myPacket = new AJAXPacket("holdNo.jsp","正在获得记录总数，请稍候...");
			myPacket.data.add("accept",Constants.ACCEPT);
			myPacket.data.add("opCode","<%=opCode%>");
			myPacket.data.add("phoneNo", records[i][3]);
			myPacket.data.add("orderId", records[i][7]);
			myPacket.data.add("oprType", '08');

			core.ajax.sendPacket(myPacket, function(packet){
			var errorCode = packet.data.findValueByName('retCode');
			var errorMsg = packet.data.findValueByName('retMsg');
					
			if (errorCode == '000000'){
				rdShowMessageDialog("预占成功！");
				button.attr('disabled', true);
				button.parent().find('input[@name=callRadio]').attr('disabled',false);
				//可以修改配送地址
  				var $tr = button.parent().parent();
				$tr.find('.address').attr('disabled',false);				
			} else {
				rdShowMessageDialog("预占失败！" + errorCode + errorMsg);
			}
			});
			myPacket=null;
  }
  
  Page.prototype.requestUpdateAddr = function (button) {
  		var t = '',self = this;
  		var myPacket = new AJAXPacket("holdNo.jsp","正在执行服务，请稍候...");
			myPacket.data.add("accept",Constants.ACCEPT);
			myPacket.data.add("opCode","<%=opCode%>");
			myPacket.data.add("phoneNo",records[Number(button.attr('line'))][3]);
			myPacket.data.add("isDispatch","4");
			myPacket.data.add("iFlag","3");
			myPacket.data.add("iMailAddress",$(button).prev().val());
			myPacket.data.add("oprType", '08');
			
			core.ajax.sendPacket(myPacket, function(packet){
					var errorCode = packet.data.findValueByName('retCode');
					var errorMsg = packet.data.findValueByName('retMsg');
					
					if (errorCode == '000000'){
							rdShowMessageDialog("更新地址成功！");
							button.attr('disabled', 'true');
					} else {
							rdShowMessageDialog("更新地址失败！" + errorCode + errorMsg);
					}
			});
			myPacket=null;
	}
	
	Page.prototype.requestCall = function (button, flag) {
		var self = this;
		
		if($('#reasonDiv')){
			$('#reasonDiv').remove();
		}
		
		if(flag == '0') {
			var smg = '<div id="reasonDiv"><input type="textArea" value="外呼失败原因" id="failReasonArea" maxlength="100" style="overflow: scroll; height: 40px; width: 350px;" value=""><font class="orange">*</font> <input type="button" id="submitReasonBtn" value="确认" class="b_text" /><div>';
			button.parent().append(smg);
			
			$('#submitReasonBtn').click(function(e) {
				e.stopPropagation();
		        e.preventDefault();
		        
				if($('#failReasonArea').val().length == 0) {
					rdShowMessageDialog("请输入失败原因！");
					return false;
				}else if($('#failReasonArea').val().length > 100) {
					rdShowMessageDialog("最大允许输入100个字符！");
					return false;
				}else {
				    self.submitRequest(button,flag);
				}
			});
		}else if(flag == '1') {
			self.submitRequest(button, flag);
		}
	}

	Page.prototype.submitRequest = function (button, flag) {
		if(rdShowConfirmDialog('确认提交吗？')==1){
			var t = '',self = this;
			var falgss="";
			var resongss="";
			
			if(flag=="0") {
    			falgss="0";
    			resongss = $('#failReasonArea').val();
			}else {
    			falgss="1";
    			resongss = "";
			}
			
			var address = $(button).parents('tr:first').find('.address').val();
			if (flag == '0'){//外呼失败，地址变成空
			    address = '';
			}
			
			var i = button.attr('line');
  			var myPacket = new AJAXPacket("getResultCfm.jsp","正在获得记录总数，请稍候...");
			myPacket.data.add("accept", Constants.ACCEPT);
			myPacket.data.add("opCode","<%=opCode%>");
			myPacket.data.add("reason", resongss);
			myPacket.data.add("phoneNo",records[i][3]);
			myPacket.data.add("iOrderId",records[i][7]);
			myPacket.data.add("iItemStatus",falgss);
			myPacket.data.add("iMailAddress", address);

			core.ajax.sendPacket(myPacket, function(packet){
				var errorCode = packet.data.findValueByName('retCode');
				var errorMsg = packet.data.findValueByName('retMsg');
				
				if (errorCode == '000000'){
					rdShowMessageDialog("外呼结果设置完成！");
					button.parent().parent().remove();
				} else {
					rdShowMessageDialog("调用服务失败！" + errorCode + errorMsg);
				}
			});
			myPacket=null;
		} else {
		    var $tr = $(button).parents('tr:first');
    		var address = $tr.find('.address').removeAttr('disabled');
		}
	}
	
	Page.prototype.showMore = function (button) {
  		var t = '',self = this, i = button.attr('line');
			var path = "recordDetails.jsp";
			path = path + "?opCode=<%=opCode%>";
			path = path + "&opName=<%=opName%>";
			path = path + "&conPhone=" +  records[i][0];
			path = path + "&idIccid=" + records[i][2];
			path = path + "&json=" + records[i][9];
			path = path + "&phone_no=" + records[i][3];
			var retInfo = window.showModalDialog(path,"","dialogWidth:45;dialogHeight:40;");
	}

	$(function(){
		var page = new Page();
		
		$('#targetArea').find('tr').each(function() {	
			var $this = $(this);
			if($this.find('input[class="b_text hold"]').val() == '预占' ) {
				$this.find('.updateAddr').parent().find('input:eq(0)').attr('readonly',true);
				$this.find('.updateAddr').attr('disabled',true);
			}else {
				$this.find('.updateAddr').parent().find('input:eq(0)').attr('readonly',false);
				$this.find('.updateAddr').attr('disabled',false);	
			}	
		});
		
		$("#regionSelect").val("<%=selectedRegion%>");	
		$("#opSelect").val("<%=selectedopcode%>");	
			
		$("#opSelect").change(function(){
			var selectedRegion = $("#regionSelect").val();
			var selectedopcode = $("#opSelect").val();	
			window.location="fm001Main.jsp?opCode=<%=opCode%>&opName=<%=opName%>&crmActiveOpCode=<%=opCode%>&selectedRegion="+selectedRegion+"&selectedopcode="+selectedopcode+"&numpage=<%=numpage%>&endpanges=<%=endpanges%>&zongshus=<%=zongshus%>";
		});
		
		$("#regionSelect").change(function(){
			var selectedRegion = $("#regionSelect").val();
			var selectedopcode = $("#opSelect").val();	
			window.location="fm001Main.jsp?opCode=<%=opCode%>&opName=<%=opName%>&crmActiveOpCode=<%=opCode%>&selectedRegion="+selectedRegion+"&selectedopcode="+selectedopcode+"&numpage=<%=numpage%>&endpanges=<%=endpanges%>&zongshus=<%=zongshus%>";
		});
	});
</script>
</head>
<body>
<form name="frm" method="post" action="">
  <input type="hidden" name="opCode" id="opCode" value="<%=opCode%>">
  <input type="hidden" name="opName" id="opName" value="<%=opName%>">
  <input type="hidden" name="sysAccept" value="<%=accept%>">
  
  <%@ include file="/npage/include/header.jsp" %>
  <div class="title">
    <div id="title_zi">选择操作</div>
  </div>
  <table cellspacing="0">
  	<tr>
			<td>地市</td>
			<td colspan="5">
				<select id="regionSelect" >
					<option value="00">--请选择--</option>
					<wtc:qoption name="TlsPubSelCrm" outnum="2">
						<wtc:sql>
							select group_id,region_name 
							from sregioncode 
							where use_flag='Y' 
							order by group_id
						</wtc:sql>
					</wtc:qoption>
				</select>
			</td>
		</tr>
		  	<tr>
			<td>功能代码</td>
			<td colspan="5">
				<select id="opSelect" >
					<option value="00">--请选择--</option>
					<option value="i279">i279--移动商城开户</option>
				</select>
			</td>
		</tr>
	</table>
  
  <div class="title">
    <div id="title_zi">基本信息</div>
  </div>
  
  <table cellspacing="0">
    <tr>
      <td colspan="6">需向用户复核身份证号码、购买号码和原配送地址3项信息后才能为用户修改配送地址，如果外呼失败，那么外呼三次后才可以录入外呼结果</td>
    </tr>
		<tr>
			<th>联系电话</th>						
			<th>身份证号码</th>
			<th>购买号码</th>
			<th>原配送地址</th>
			<th>预占工号</th>
			<th>操作</th>
		</tr>
		
		<tbody id="targetArea">
		</tbody>
		
    <tr>
      <td colspan="6" align="center" id="footer">
      共<%=zongshus%>条记录<input type="button" class="b_text" value="第一页" onClick="pagecontione('1')"/>&nbsp;&nbsp;&nbsp;<input type="button" class="b_text" value="上一页" onClick="pagecontione('<%=Integer.parseInt(numpage) - 1%>')"/>&nbsp;&nbsp;&nbsp;<input type="button" value="下一页" class="b_text" onClick="pagecontione('<%=Integer.parseInt(numpage) + 1%>')" />&nbsp;&nbsp;&nbsp;<input type="button" value="最后一页" class="b_text" onClick="pagecontione('<%=endpanges%>')" />&nbsp;&nbsp;&nbsp;<input class="b_foot" type=button name="closeBtn" id="closeBtn" value="关闭">
      </td>
    </tr>
  </table>
  <%@ include file="/npage/include/footer_simple.jsp" %>
</form>
<%@ include file="/npage/include/pubLightBox.jsp" %>
</body>
</html>