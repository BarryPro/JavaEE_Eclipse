<%
  /*
   * ����: BOSS��������ƽ̨������������� m149
   * �汾: 1.0
   * ����: 2014/8/12 
   * ����: diling
   * ��Ȩ: si-tech
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
	
	//У��ʱ���ʽ
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
      rdShowMessageDialog("��ѡ���ļ���");
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
          <td class="blue">����ʱ��</td>
          <td>
              <input type="text" id="expiredTime" name="expiredTime" v_format="yyyyMMdd"  v_must="1"  class="button" maxlength="19" onblur="checkTimeFormat()" />&nbsp;
              <font color="orange">* (�����ʽ��yyyyMMdd)</font>
          </td>
      </tr>      
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
					��.һ��������200������<br>&nbsp;
					��.�ϴ��ļ��ı���ʽΪ�����ֻ����롱���ļ�����ʾ�����£�<br>&nbsp;
					<font class='orange'>
						&nbsp;&nbsp;13904511111
						<br>&nbsp;&nbsp;&nbsp;
						13904512222
					</font>
					<b>
            <br>&nbsp; ע����ʽ�е�ÿһ�����������ڿո��Ҷ���Ҫ�س����С�
            	�ı��ļ���ʽΪtxt�ļ���
          </b> 
				</td>
			</tr>
		</table>
		
    <table cellspacing="0" >          
     	<tr> 
        <td id="footer">              
      		<input type=button name="submitBtn" id="submitBtn" class="b_foot" value="ȷ��" onClick="frmCfm()">
          <input type=button name="closeBtn" id="closeBtn" class="b_foot" value="�ر�" onClick="removeCurrentTab();">
        </td>
    	</tr>
    </table>
    
  <%@ include file="/npage/include/footer.jsp" %>   
</form>
<%@ include file="/npage/include/pubLightBox.jsp" %>
</body>
</html>