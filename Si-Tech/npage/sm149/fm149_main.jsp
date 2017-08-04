<%
  /*
   * 功能: BOSS垃圾短信平台白名单批量添加 m149
   * 版本: 1.0
   * 日期: 2014/8/12 
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
	$(function(){
		if("<%=opCode%>" == "m149"){
			$("#expiredTimeTr").css("display","");
		}else if("<%=opCode%>" == "m150"){
			$("#expiredTimeTr").css("display","none");
		}
	});
	
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
	
	//校验时间格式
	function checkTimeFormat(){
		if(!checkElement(document.frm.expiredTime)) return false;
		if(!forDate(document.frm.expiredTime)){
		  return false;
		}
		return true;
	}
  
	function frmCfm(){
		var expiredTime = "";
		if("<%=opCode%>" == "m149"){
			if(!checkTimeFormat()) return false;
			expiredTime = $("#expiredTime").val();
		}
		
		if ($('#fileName').val() == ""){
      rdShowMessageDialog("请选择文件！");
      return false;
    }
		var url = 'fm149_batchCfm.jsp?opCode=<%=opCode%>&opName=<%=opName%>&expiredTime='+expiredTime;
		$('form').attr('action', url);
		if (!$('form').data('alreadySubmit')){
			$('form').data('alreadySubmit', true).submit();
		}
	}
	
</script>
</head>
<body>
<form name="frm" method="POST" ENCTYPE="multipart/form-data">		
  <%@ include file="/npage/include/header.jsp" %>     	
		<div class="title">
			<div id="title_zi"><%=opName%> </div>
		</div>
    <table  cellspacing="0" >    
    	 <tr id="expiredTimeTr">
          <td class="blue">到期时间</td>
          <td>
              <input type="text" id="expiredTime" name="expiredTime" v_format="yyyyMMdd"  v_must="1"  class="button" maxlength="19" onblur="checkTimeFormat()" />&nbsp;
              <font color="orange">* (输入格式：yyyyMMdd)</font>
          </td>
      </tr>      
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
					二.一次最多操作200个号码<br>&nbsp;
					三.上传文件文本格式为：“手机号码”，文件内容示例如下：<br>&nbsp;
					<font class='orange'>
						&nbsp;&nbsp;13904511111
						<br>&nbsp;&nbsp;&nbsp;
						13904512222
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