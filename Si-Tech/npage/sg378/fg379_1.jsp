<%
/*************************************
* ��  ��: ����V���û��ʷѱ��(g379) �� ����V���û��˳�(g380)
* ��  ��: version v1.0
* ������: si-tech
* ������: liujian @ 2012-12-31 13:51:37
**************************************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	String opCode = request.getParameter("opCode");
	String opName = request.getParameter("opName");
    String workNo     = (String)session.getAttribute("workNo");
    String regionCode = (String)session.getAttribute("regCode");
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title><%=opName%></title>
    <script type="text/javascript" src="/npage/public/pubLightBox.js"></script>	
</head>

<script type=text/javascript>
   
    
    function checkQuestion() {
		var phoneNo = $('#phoneNo').val();
		if(!phoneNo) {
			rdShowMessageDialog('�������ֻ��ţ�');	
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
  	
  $(function() {
  	 $('#searchBtn').click(function() {
  	 	
  	 			if (document.getElementsByName("opFlag")[0].checked) {	 				
							if(checkQuestion()) {
								var phoneNo = $('#phoneNo').val();
								var opCode = '<%=opCode%>';
								document.groupIframe.location="fg379_2.jsp?opCode=<%=opCode%>&phoneNo=" + phoneNo;	
								/*
								if(opCode == 'g379') {//���
									document.groupIframe.location="fg379_2.jsp?opCode=<%=opCode%>&phoneNo=" + phoneNo;	
								}else if(opCode == 'g380') {//ɾ��
									document.groupIframe.location="fg380_2.jsp?opCode=<%=opCode%>&phoneNo=" + phoneNo;	
								}
								*/
								showBox();
							}

					} else if (document.getElementsByName("opFlag")[1].checked) {
					
								var jituanhao = $('#jituanhao22').val();
								
								if(jituanhao.trim()=="") {
									rdShowMessageDialog('�����뼯�źţ�');	
									return false;
								}
								
								document.groupIframe.location="fg380_delFile.jsp?opCode=<%=opCode%>&opName=<%=opName%>&jituanhao="+jituanhao;
								
								//showBox();
					}
 
  	 });
  	 
  	 
  	 $('#clearBtn').click(function() {
				$('#phoneNo').val('');
				$('#jituanhao22').val('');
	    		window.frames["groupIframe"].clearTable();  
 
  	 });
  	 
  	 $('#opCode').val('<%=opCode%>');
  	 $('#opName').val('<%=opName%>');
  });
  
 function clickss() {
		if (document.getElementsByName("opFlag")[0].checked) {


			document.getElementById("shoujihao").style.display = "block";
			document.getElementById("jituanhao").style.display = "none";

		} else if (document.getElementsByName("opFlag")[1].checked) {
		document.getElementById("shoujihao").style.display = "none";
		document.getElementById("jituanhao").style.display = "block";

		
		}
} 	
</script>

<body>
<form name="frm" action="" method="post" >
<%@ include file="/npage/include/header.jsp" %>
		<div class="title">
			<div id="title_zi">��ѯ����</div>
		</div>
		<input type="hidden" value=""  id="opCode" name="opCode" />
		<input type="hidden" value=""  id="opName" name="opName" />
		<div>
						<table cellspacing=0 style="display:<%if(opCode.equals("g379")){out.print("none");}%>">
					<tr>
				<td class='blue' nowrap width='18%' >�������뷽ʽ</td>
        <td colspan="">
            <input type='radio' id='opFlag' name='opFlag' onClick='clickss()' value='vpmnMulti' checked/>��������
            <input type='radio' id='opFlag' name='opFlag' onClick='clickss()' value='vpmnFile' />�ļ�¼��
        </td>
        </tr>
				<table cellspacing=0 id="shoujihao">
				    <tr>
				    	<td class='blue' nowrap width='18%'>�ֻ�����</td>
						<td>
							<input type="text" name="phoneNo" id="phoneNo" value="" maxlength='11' onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')"/>	
						</td>
				    </tr>

				</table>
								<table cellspacing=0 id="jituanhao" style="display:none">
				    <tr>
				    	<td class='blue' nowrap width='18%'>���ź�</td>
						<td>
							<input type="text" name="jituanhao22" id="jituanhao22" value="" maxlength='11' onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')"/>	
						</td>
				    </tr>

				</table>
				<table>
							    <tr id='footer'>
				        <td colspan='4'>
				            <input type="button"  id="searchBtn" class='b_foot' value="��ѯ" name="searchBtn" />
				            <input type="button"  id="clearBtn" class='b_foot' value="���" name="clearBtn" />
				            <input type="button" class="b_foot" id="closeBtn" name="close" value="�ر�" onclick="removeCurrentTab()"/>
				        </td>
				    </tr>
				    </table>	
		</div>
		<IFRAME frameBorder=0 id="groupIframe" name="groupIframe" style="HEIGHT: 100px; WIDTH: 100%; Z-INDEX: 2">
		</IFRAME>
					
<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>