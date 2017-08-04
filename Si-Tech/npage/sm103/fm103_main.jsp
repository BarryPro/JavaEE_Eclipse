<%
  /*
   * 功能: LTE自助换卡销售 m103
   * 版本: 1.0
   * 日期: 2014/5/13
   * 作者: diling
   * 版权: si-tech
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
  
  String opCode = (String)request.getParameter("opCode");
  String opName = (String)request.getParameter("opName");
  
  String workNo = (String)session.getAttribute("workNo");
  String regionCode = (String)session.getAttribute("regCode");
%>
<title><%=opName%></title>
<script language="javascript">
	
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
  
	function frmCfm(){
		var slecOperType =$("input[@name=opType][@checked]").val(); 
		var cardNo = $("#cardNo").val();
		var v_url = "fm103_simpCfm.jsp";
		if(slecOperType == "1"){ //单个
			$("#fileName").val("");
			if($('#cardNo').val() == ""){
	      rdShowMessageDialog("请输入临时手机号码！");
	      return false;
	    }
		}else{
			$("#cardNo").val("");
			if($('#fileName').val() == ""){
	      rdShowMessageDialog("请选择文件！");
	      return false;
	    }
	    v_url = 'fm103_batchCfm.jsp';
		}
		$('form').attr('action', v_url);
		if (!$('form').data('alreadySubmit')){
			$('form').data('alreadySubmit', true).submit();
		}
	}
	
	function changeType(val){
		if(val == "1"){//临时
			$("#tmpPhoneTr").css("display","");
			$("#batchTr1").css("display","none");
			$("#batchTr2").css("display","none");
			$("#cardNo").val("");
			$('#fileName').val(""); 
		}else{
			$("#tmpPhoneTr").css("display","none");
			$("#batchTr1").css("display","");
			$("#batchTr2").css("display","");
			$("#cardNo").val("");
			$("#fileName").val("");
			$("form").attr("encoding", "multipart/form-data");
			$("form").attr("ENCTYPE", "multipart/form-data");
		}
	}
	
</script>
</head>
<body>
	<form name="frm" method="POST" >		
  <input type="hidden" name="opCode" id="opCode" value="<%=opCode%>" />
  <input type="hidden" name="opName" id="opName" value="<%=opName%>" />
  <%@ include file="/npage/include/header.jsp" %>     	
		<div class="title">
			<div id="title_zi"><%=opName%> </div>
		</div>
    <table  cellspacing="0" >   
    	<tr>
        <td class="blue" width="20%">使用渠道</td>
				<td>
					<select name="useChannel" id="useChannel"  index="2">
						<option value="0">网上营业厅</option>
					  <option value="1">营业前台</option>
					</select>
				</td>
				<td class="blue" width="20%">SIM卡卡费</td>
				<td>
					<input type="text" name="simCardFee" id="simCardFee" value="0元" class="InputGrey" readonly  />
				</td>
      </tr> 
      <tr>
				<td class="blue" width="20%">操作类型</td>
				<td colspan="3">
					<input type="radio" name="opType" checked value="1" onclick="changeType('1')" />
			    单个换卡
			    &nbsp;&nbsp;&nbsp;
					<input type="radio" name="opType" value="2" onclick="changeType('2')"  />
			    批量换卡
				</td>
      </tr> 
    	<tr id="tmpPhoneTr">
        <td class="blue" width="20%">空卡卡号</td>
				<td colspan="3">
					<input type="text" name="cardNo" id="cardNo" value="" />
				</td>
				
      </tr>
		  <tr id="batchTr1" style="display:none" >
        <td class="blue" width="20%">文件</td>
				<td colspan="3">
					<input type="file" name="fileName" id="fileName" class="button" style='border-style:solid;border-color:#7F9DB9;border-width:1px;font-size:12px;' />
				</td>
      </tr>
      
			<tr id="batchTr2" style="display:none">
				<td class="blue">文件说明</td>
				<td colspan="3">&nbsp;
					一.所导入文件必须为文本文件（后缀.txt）<br>&nbsp;
					二.一次最多操作300个卡号<br>&nbsp;
					三.上传文件文本格式为：“空卡卡号”，文件内容示例如下：<br>&nbsp;
					<font class='orange'>
						&nbsp;&nbsp;08138170000050000001
						<br>&nbsp;&nbsp;&nbsp;
						08138170000050000002
					</font>
					<b>
            <br>&nbsp; 注：格式中的每一项均不允许存在空格，且都需要回车换行。
            	文本文件格式为txt文件。
          </b> 
				</td>
			</tr>
		</table>
		
    <table cellspacing="0" >          
     	<tr> 
        <td id="footer">              
      		<input type=button name="submitBtn" id="submitBtn" class="b_foot" value="确认" onClick="frmCfm()">
          <input type=button name="closeBtn" id="closeBtn" class="b_foot" value="关闭" onClick="removeCurrentTab();">
        </td>
    	</tr>
    </table>
    
  <%@ include file="/npage/include/footer.jsp" %>   
</form>
<%@ include file="/npage/include/pubLightBox.jsp" %>
</body>
</html>