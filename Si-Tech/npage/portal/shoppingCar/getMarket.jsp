<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	
<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="../../login/dispatch.jsp" %>
<%
		String opName ="������BOSS-Ӫ����ʾ";
		String regionCode= (String)session.getAttribute("regCode");
    /*�õ��������*/
    String phoneNo=request.getParameter("phoneNo");
    String loginNo = (String)session.getAttribute("workNo");
    String loginNoPass = (String)session.getAttribute("password");
    System.out.println("=========getMarket.jsp" + phoneNo);
    String opcodeurl = getLink("4","market/14936/4938/f4938_main1.jsp?isPreengage=N","e177",session,request,"Ӫ��ִ��");
    System.out.println("yanpx opcodeurl="+opcodeurl);
%> 	
	<wtc:service name="sCollInitNew" routerKey="region" routerValue="<%=regionCode%>" 
		 outnum="4" retcode="retCode1GetMarket" retMsg="retMsgGetMarket">
		<wtc:param value=""/> 
		<wtc:param value="01"/>
		<wtc:param value=""/>
		<wtc:param value="<%=loginNo%>"/>
		<wtc:param value="<%=loginNoPass%>"/>
		<wtc:param value="<%=phoneNo%>"/>
		<wtc:param value=""/>
	</wtc:service>
	<wtc:array id="resultGetMarket" scope="end"/>
 
<HEAD>
<TITLE>������BOSS-Ӫ����ʾ</TITLE>
<script language="javascript">
	function closeWindow(){
		window.parent.hideDiv('pop-div');
	}
	function saveAction(btnObj){
		var activeArr = "";
		var activeIdArr = "";
		var belongGroupArr = "";
		/* ��¼�Ƿ��нӴ��� */
		var activeFlag = "0";
		activeLength = "<%=resultGetMarket.length%>";
		for(var i = 0; i < activeLength; i++){
			var searchName = "active" + i;
			var activeId = "vActiveId" + i;
			var belongGroup = "vBelongGroup" + i;
			var activeVal = $("input[@name='" + searchName + "'][@checked]").val();
			var activeIdVal = $("#" + activeId + "").val();
			var belongGroupVal = $("#" + belongGroup + "").val();
			
			if(typeof(activeVal) == "undefined" && btnObj == "1"){
				activeVal = 4;
				activeFlag = "1";
			}else if(btnObj == "2") 
			{
				if(typeof(activeVal) != "undefined")
				{
					activeFlag = "1";
				}
				else
				{
					activeVal = 4;
				}
			}else{
				activeFlag = "1";
			}
			activeArr += activeVal;
			activeArr += ",";
			
			activeIdArr += activeIdVal;
			activeIdArr += ",";
			
			belongGroupArr += belongGroupVal;
			belongGroupArr += ",";
		}
		
		
		//alert(activeIdArr + " | " + belongGroupArr + " | " + activeArr);
		if("0" == activeFlag){
			rdShowMessageDialog("��ѡ��Ӫ������!");
			return false;
		}else{
			var getdataPacket = new AJAXPacket("marketCfm.jsp","�����ύ�������Ժ�......");
			getdataPacket.data.add("phoneNo","<%=phoneNo%>");
			getdataPacket.data.add("activeIdArr",activeIdArr);
			getdataPacket.data.add("belongGroupArr",belongGroupArr);
			getdataPacket.data.add("activeArr",activeArr);
			core.ajax.sendPacket(getdataPacket);
			getdataPacket = null;
		}
	}
	function doProcess(packet){
		var retCode2 = packet.data.findValueByName("retcode");
		var retMsgGetMarket = packet.data.findValueByName("retMsgGetMarket");
		if("000000" != retCode2){
			rdShowMessageDialog("������룺" + retCode2 + "������Ϣ��" + retMsgGetMarket);
		}
		closeWindow();
	}
	function openSale(){
		window.parent.openSale("<%=opcodeurl%>");
	  closeWindow();
	}
</script>
</HEAD>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<BODY>
<FORM method=post name="fPubSimpSel">   
	<%@ include file="/npage/include/header_pop.jsp" %>
	<div class="title">
		<div id="title_zi">Ӫ����ʾ</div>
	</div>
	<div  style="overflow-y:auto; overflow-x:auto; width:580px; height:300px;">
	<table cellspacing="0" style="width:96%">
		<tr>
			<th>Ӫ��������</th>
			<th>Ӫ������</th>
			<th>����</th>
		</tr>
		<%
			String vActiveId = "";
			String vBelongGroup = "";
			String vSaleNote = "";
			String vActiveName = "";
			for(int i = 0;i < resultGetMarket.length; i++){
				if(resultGetMarket[i][0] != null){
					vActiveId = resultGetMarket[i][0];
				}
				if(resultGetMarket[i][1] != null){
					vBelongGroup = resultGetMarket[i][1];
				}
				if(resultGetMarket[i][2] != null){
					vSaleNote = resultGetMarket[i][2];
				}
				if(resultGetMarket[i][3] != null){
					vActiveName = resultGetMarket[i][3];
				}
		%>
		<tr>
			<td>
				<input type="hidden" name="marketId<%=i%>" id="marketId<%=i%>" value="hide1" />
				<input type="hidden" name="vActiveId<%=i%>" id="vActiveId<%=i%>" value="<%=vActiveId%>" />
				<input type="hidden" name="vBelongGroup<%=i%>" id="vBelongGroup<%=i%>" value="<%=vBelongGroup%>" />
				<%=vActiveName%>
			</td>
			<td>
				<%=vSaleNote%>
			</td>
			<td width="40%">
				&nbsp;&nbsp;
				<input type="radio" name="active<%=i%>" id="interest<%=i%>" value="2" />����Ȥ
				&nbsp;&nbsp;
				<input type="radio" name="active<%=i%>" id="turnDown<%=i%>" value="3" />�ܾ�
			</td>
		</tr>
		<%
			}
		%>
		<tr>
			<td  colspan="3">
			<a href="#" onclick="openSale();">Ӫ������ƽ̨�������</a>
			</td>
		</tr>		
		<tr id="footer">
			<td colspan="3">
				<input type="button" name="close" id="close" value="ȷ��" 
				  class="b_foot" onclick="saveAction(2)" rownum="99" />
				<input type="button" name="close" id="close" value="�ر�" 
				  class="b_foot" onclick="saveAction(1);" rownum="99" />
			</td>
		</tr>

	</table>
	</div>
	<%@ include file="/npage/include/footer_pop.jsp" %>
</FORM>
</BODY>
</HTML>    
