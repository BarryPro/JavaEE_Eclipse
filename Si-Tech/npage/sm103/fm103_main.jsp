<%
  /*
   * ����: LTE������������ m103
   * �汾: 1.0
   * ����: 2014/5/13
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
		if(slecOperType == "1"){ //����
			$("#fileName").val("");
			if($('#cardNo').val() == ""){
	      rdShowMessageDialog("��������ʱ�ֻ����룡");
	      return false;
	    }
		}else{
			$("#cardNo").val("");
			if($('#fileName').val() == ""){
	      rdShowMessageDialog("��ѡ���ļ���");
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
		if(val == "1"){//��ʱ
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
        <td class="blue" width="20%">ʹ������</td>
				<td>
					<select name="useChannel" id="useChannel"  index="2">
						<option value="0">����Ӫҵ��</option>
					  <option value="1">Ӫҵǰ̨</option>
					</select>
				</td>
				<td class="blue" width="20%">SIM������</td>
				<td>
					<input type="text" name="simCardFee" id="simCardFee" value="0Ԫ" class="InputGrey" readonly  />
				</td>
      </tr> 
      <tr>
				<td class="blue" width="20%">��������</td>
				<td colspan="3">
					<input type="radio" name="opType" checked value="1" onclick="changeType('1')" />
			    ��������
			    &nbsp;&nbsp;&nbsp;
					<input type="radio" name="opType" value="2" onclick="changeType('2')"  />
			    ��������
				</td>
      </tr> 
    	<tr id="tmpPhoneTr">
        <td class="blue" width="20%">�տ�����</td>
				<td colspan="3">
					<input type="text" name="cardNo" id="cardNo" value="" />
				</td>
				
      </tr>
		  <tr id="batchTr1" style="display:none" >
        <td class="blue" width="20%">�ļ�</td>
				<td colspan="3">
					<input type="file" name="fileName" id="fileName" class="button" style='border-style:solid;border-color:#7F9DB9;border-width:1px;font-size:12px;' />
				</td>
      </tr>
      
			<tr id="batchTr2" style="display:none">
				<td class="blue">�ļ�˵��</td>
				<td colspan="3">&nbsp;
					һ.�������ļ�����Ϊ�ı��ļ�����׺.txt��<br>&nbsp;
					��.һ��������300������<br>&nbsp;
					��.�ϴ��ļ��ı���ʽΪ�����տ����š����ļ�����ʾ�����£�<br>&nbsp;
					<font class='orange'>
						&nbsp;&nbsp;08138170000050000001
						<br>&nbsp;&nbsp;&nbsp;
						08138170000050000002
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