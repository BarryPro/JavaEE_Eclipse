<%
/*************************************
* ��  ��: g392����ѡ�ʷѲ�ѯ
* ��  ��: version v1.0
* ������: si-tech
* ������: liujian @ 2012-12-31 13:52:45
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
		if(phoneNo.length != 11) {
			rdShowMessageDialog('��������ȷ���ֻ����룡');	
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
  	
  	function setSearchClassBtnEditStatus(flag) {
  		$('#qryClass').attr('disabled',!flag);
  		$('#offerType').attr('disabled',flag);
  		$('#searchBtn').attr('disabled',flag);
  	}
  	
  	function showGroupTable(flag) {
  		if(flag) {
  			$('#groupTable').css('display','block');	
  		}else {
  			$('#groupTable').css('display','none');	
  		}		
  	}
  	
	$(function() {
		setSearchClassBtnEditStatus(true);
		$('#phoneNo').keyup(function() {
  			setSearchClassBtnEditStatus(true);
  		});
		$('#qryClass').click(function() {
			showGroupTable(false);
			var packet = new AJAXPacket("fg392_ajax.jsp","���ڻ�������Ϣ�����Ժ�......");
			var _data = packet.data;
			_data.add("opCode","<%=opCode%>");
			_data.add("phoneNo",$('#phoneNo').val());
			_data.add("method","getWholeClass");
			core.ajax.sendPacket(packet,getClassProcess);
			packet = null;	
		});
  	 	
  	 	
  	 
  	 $('#searchBtn').click(function() {
		if(checkQuestion()) {
			/*
			$('#groupTbody').empty();
			var classId = $('#offerType').val();
			var phoneNo = $('#phoneNo').val();
			var packet = new AJAXPacket("../s1270/qryAddOffer.jsp","���Ժ�...");
			packet.data.add("servId",$('#id_no').val());//id_no
			packet.data.add("relMainOfferId",$('#offerId').val());//��ǰ���ʷ�
			packet.data.add("roleId",classId);//�ʷ����ʹ���
			packet.data.add("offerName","");
			packet.data.add("opCode","<%=opCode%>");
			core.ajax.sendPacket(packet,doQryOfferList);
			packet =null;	
			*/
			var lines_one_page = 10;
			document.groupIframe.location="fg392_2.jsp?toPage=1&lines_one_page=" + lines_one_page + "&opCode=<%=opCode%>&servId="+ $('#id_no').val() + "&relMainOfferId=" + $('#offerId').val() + '&classId=' + $('#offerType').val();
		} 
  	 });
  	 
  	 
  	 $('#clearBtn').click(function() {
		$('#phoneNo').val('');
		$('#offerType').empty();
		setSearchClassBtnEditStatus(true);
		showGroupTable(false);
	 //	window.frames["groupIframe"].clearTable();
  	 });
  	 
  	 $('#opCode').val('<%=opCode%>');
  	 $('#opName').val('<%=opName%>');
  });
  
  
  function showIfTable() {
  	window.frames["groupIframe"].showTable();	
  }
  	
  	
  	function getClassProcess(packet){
		var errorCode = packet.data.findValueByName("errorCode");
		var errorMsg = packet.data.findValueByName("errorMsg");
		var id_no = packet.data.findValueByName("id_no");
		var offerId = packet.data.findValueByName("offerId");
		$('#id_no').val(id_no);
		$('#offerId').val(offerId);
		if(errorCode == '000000'){
			setSearchClassBtnEditStatus(false);
			var retAry = packet.data.findValueByName("retAry");
			$("#offerType").empty();
			var tempStr = '';
			if(retAry.length > 0){
				tempStr = '<option value="ALL">ȫ��</option>';
				for(var i = 0;i<retAry.length;i++){
					tempStr += "<option value='"+retAry[i][0]+"' >"+ retAry[i][1] + "</option>";
				}
			}else{
				tempStr = '<option value="ALL">ȫ��</option>';
			}
			$("#offerType").append(tempStr);
		}else{
			rdShowMessageDialog("������룺" + errorCode + "��������Ϣ��" + errorMsg,0);
			return false;	
		}
	}
	
	function doQryOfferList(packet) {
		var errorCode = packet.data.findValueByName("errorCode");
		var errorMsg = packet.data.findValueByName("errorMsg");	
		if(errorCode == 0){
			var retAry = packet.data.findValueByName("retAry");
			var strArr = new Array();
			var offer_id = "";
			var offer_name = "";
			var offer_desc = "";
			for(var i=0 ; i<retAry.length; i++){
				offer_id = retAry[i][0];
				offer_name = retAry[i][1];
				offer_desc = retAry[i][9];
				strArr.push('<tr><td>' + offer_id + '</td>');
				strArr.push(    '<td>' + offer_name + '</td>');
				strArr.push(    '<td>' + offer_desc + '</td></tr>');
			}
			if(strArr.length > 0) {
				$('#groupTbody').append(strArr.join(''));
			}
			showGroupTable(true);
		}else{
			rdShowMessageDialog(errorMsg);
			return false;	
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
		<input type="hidden" value=""  id="id_no" name="id_no" />
		<input type="hidden" value=""  id="offerId" name="offerId" />
		<div>
				<table cellspacing=0>
				    <tr>
						<td class='blue'>�ֻ�����</td>
						<td >
							<input type="text" name="phoneNo" id="phoneNo" value="" maxlength="11"  onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')" />
							<input type="button" value="��ѯ�ײͷ���" id="qryClass" class="b_text"/>
						</td>
						<td class='blue'>��ѡ�ײͷ���</td>
						<td>
							<select id="offerType">
								
							</select>
						</td>
				    </tr>
				    <tr id='footer'>
				        <td colspan='4'>
				            <input type="button"  id="searchBtn" class='b_foot' value="��ѯ" name="searchBtn" />
				            <input type="button"  id="clearBtn" class='b_foot' value="���" name="clearBtn" />
				            <input type="button" class="b_foot" id="closeBtn" name="close" value="�ر�" onclick="removeCurrentTab()"/>
				        </td>
				    </tr>
				</table>
		</div>

		<IFRAME frameBorder=0 id="groupIframe" name="groupIframe" style="HEIGHT: 0px; WIDTH: 100%; Z-INDEX: 2"></IFRAME>
		<!--
		<div id="groupTable" style="display:none;height:200p;overflow: auto">
			<div id="Operation_Table" style="padding:0px">
					<table id="tabList2" cellspacing=0>
							<thead>	
								<tr>
									<th>����ƷID</th>			
									<th>����Ʒ����</th>
									<th>����Ʒ����</th>
								</tr>
							</thead>
							<tbody id="groupTbody">
									
							</tbody>
							
					</table>
			</div>
		</div>
		-->		
<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>