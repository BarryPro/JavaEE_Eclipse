<%
/*************************************
* ��  ��: ����V������ȷ�϶��Ž����ѯ 4869
* ��  ��: version v1.0
* ������: si-tech
* ������: shengzd @ 2010-03-22
**************************************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
		String opCode     = "e767";
    String opName     = "V���̺ſպ���Դ��ѯ";

    String workNo     = (String)session.getAttribute("workNo");//��������!!!
    String regionCode = (String)session.getAttribute("regCode");
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title><%=opName%></title>
    <script type="text/javascript" src="/npage/public/pubLightBox.js"></script>	
</head>

<script type=text/javascript>
   
  $(function() {
  	 $('#searchBtn').click(function() {
  	 			if(check()) {
	  	 				var groupNo = $('#groupNo').val();
							var beginNo = $('#beginNo').val();
				  		var endNo = $('#endNo').val();
  	 					document.groupIframe.location="fe767_3.jsp?opCode=<%=opCode%>&groupNo="+ groupNo + "&beginNo=" + beginNo + "&endNo=" + endNo;
  	 					showBox();
  	 			} 
  	 });
  	 
  	 $('#clearBtn').click(function() {
  	 			$('#groupNo').val('');
  	 			$('#beginNo').val('');
  	 			$('#endNo').val('');
  	 			
  	 			window.frames["groupIframe"].clearTable();	
  				window.frames["middle"].clearTable();	
  	 });
  	 
  	 $('#opCode').val('<%=opCode%>');
  	 $('#opName').val('<%=opName%>');
  	 
  	 //����
  	 /*
  	$('#groupNo').val(4510001206);
		$('#beginNo').val(6111);
  	$('#endNo').val(6222);
  	*/
  });
  
  function listQry() {
  		var groupNo = $('#groupNo').val();
			var beginNo = $('#beginNo').val();
  		var endNo = $('#endNo').val();
  		document.middle.location="fe767_2.jsp?opCode=<%=opCode%>&groupNo="+ groupNo + "&beginNo=" + beginNo + "&endNo=" + endNo;
  }
  
  function showIfTable() {
  	window.frames["groupIframe"].showTable();	
  	window.frames["middle"].showTable();	
  }
		function check() {
			var groupNo = $('#groupNo').val();
			var beginNo = $('#beginNo').val();
  		var endNo = $('#endNo').val();
  		if(groupNo == "" || groupNo == null) {
  			rdShowMessageDialog('���źŲ���Ϊ�գ�');
  			return false;
  		}
  		if(beginNo == "" || beginNo == null || endNo == "" || endNo == null) {
  			rdShowMessageDialog('��ʼ�Ŷ�������Ŷβ���Ϊ�գ�');
				return false;
  		}else if(beginNo.length<2 || endNo.length<2 
				||  beginNo.substring(0,1) != "6" || beginNo.substring(1,2) == "0"
				|| endNo.substring(0,1) != "6" || endNo.substring(1,2) == "0") {
  			rdShowMessageDialog('��ʼ�Ŷ�������Ŷε�һλ������6���ڶ�λ��Ϊ0');	
				return false;
  		}else if(beginNo.length < 4|| endNo.length < 4|| beginNo.length > 6 || endNo.length>6) {
  			rdShowMessageDialog('��ʼ�Ŷ�������Ŷ�ֻ����4��5��6λ��');	
  			return false;
  		}else if(beginNo.length != endNo.length) { 
  			rdShowMessageDialog('��ʼ�Ŷ�������Ŷ�λ��Ҫһ�£�');	
				return false;
  	  }else if(isNaN(beginNo) || isNaN(endNo)) {
			  rdShowMessageDialog('��ʼ�Ŷ�������Ŷ�ֻ��������');
				return false;
			}else if(parseInt(beginNo) > parseInt(endNo)) {
				rdShowMessageDialog('�����Ŷα�����ڵ��ڿ�ʼ�Ŷ�');
				return false;
			}else if(parseInt(endNo) - parseInt(beginNo) > 5000) {
				rdShowMessageDialog('�����Ŷ��뿪ʼ�Ŷο��Ҫ������5000��');
				return false;
			}
  	  return true;
		}
  	
  	function showBox() {
  		showLightBox();
  	}
  	
  	function hideBox() {
  		hideLightBox();	
  	}
</script>

<body>
<form name="frm" action="fe767_2.jsp" method="post" >
<%@ include file="/npage/include/header.jsp" %>
		<div class="title">
			<div id="title_zi">��ѯ����</div>
		</div>
		<input type="hidden" value=""  id="opCode" name="opCode" />
		<input type="hidden" value=""  id="opName" name="opName" />
		<div>
				<table cellspacing=0>
				    <tr>
				        <td class='blue'>¼�뼯�ź�</td>
				        <td >
				            <input type="text" name="groupNo" id="groupNo" value="" maxlength="10" v_must=1 v_type=0_9 v_minlength=10/>
				        </td>
				        <td class='blue' colspan="2"></td>
				    </tr>
				    <tr>
				    	  <td class='blue'>��ʼ�Ŷ�</td>
				    	  <td>
				    	     <input type="text" name="beginNo" id="beginNo" value="" maxlength='6' v_must ='1' onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')"/>	
				    	  </td>
				    	  <td class='blue'>�����Ŷ�</td>
				    	  <td>
				    	     <input type="text" name="endNo" id="endNo" value="" maxlength='6' v_must='1' onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')"/>	
				    	  </td>
				    </tr>
				    <tr id='footer'>
				        <td colspan='4'>
				            <input type="button"  id="searchBtn" class='b_foot' value="��ѯ" name="search" />
				            <input type="button"  id="clearBtn" class='b_foot' value="���" name="clear" />
				            <input type="button" class="b_foot" id="close" name="close" value="�ر�" onclick="removeCurrentTab()"/>
				        </td>
				    </tr>
				</table>
		</div>
		<IFRAME frameBorder=0 id="groupIframe" name="groupIframe" style="HEIGHT: 100px; WIDTH: 100%; Z-INDEX: 2">
		</IFRAME>
		<IFRAME frameBorder=0 id="middle" name="middle" style="HEIGHT: 400px; WIDTH: 100%; Z-INDEX: 1">
		</IFRAME>
					
<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>