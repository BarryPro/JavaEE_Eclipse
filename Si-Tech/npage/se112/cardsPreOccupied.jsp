<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/se112/public_title_name.jsp"%>
<%@ include file="/npage/se112/footer.jsp"%>
<%@page import="com.sitech.crmpd.core.bean.MapBean"%>
<%@page import="java.util.*"%>
<%@page import="com.sitech.crmpd.core.util.SiUtil"%>
<%
	String meansId = request.getParameter("meansId");
	String phoneNo = request.getParameter("phoneNo");
	String xml = request.getParameter("priceCard");
	String orderId = request.getParameter("orderId");
	String svcNum = request.getParameter("svcNum");
	System.out.println("********cardsPreOccupied.jsp   "+"+meansId="+meansId  +" phoneNo="+phoneNo+  "  orderId="+orderId+ "svcNum ="+svcNum);
 	MapBean mb = new MapBean();
 %>
 <%@ include file="getMapBean.jsp"%>
 <%
	Iterator it =null;
	
	List paylist = null;
	if(null != mb){
		paylist = mb.getList("OUT_DATA.H48.SPECIAL_CARDS_LIST.SPECIAL_CARDS_INFO");
		if(null!=paylist)
			it =paylist.iterator();
	}
	
	
 %>
<html>
	<head>
	<title></title>
	</head>
	<body>
		<div id="operation">
		<form method="post" name="frm4938" action="">
				<div id="operation_table">
						<%
						if(null!=it){
							int num = 1;
							while(it.hasNext()){
								
								Map stMap = mb.isMap(it.next());
								if(null==stMap) continue;
								//�мۿ�����
								String CARD_NAME=(String)stMap.get("CARD_NAME") == null?"":(String)stMap.get("CARD_NAME");
								System.out.println("CARD_NAME=" + CARD_NAME);
								//�мۿ�����g0��g1...
								String CARD_NO=(String)stMap.get("CARD_NO") == null?"":(String)stMap.get("CARD_NO");
								System.out.println("CARD_NO=" + CARD_NO);
								//�мۿ�����
								String CARD_COUNT=(String)stMap.get("CARD_COUNT") == null?"":(String)stMap.get("CARD_COUNT");
								System.out.println("CARD_COUNT" + CARD_COUNT);
					 %>
						 <div class="title">
							<div class="text">
								�мۿ�Ԥռ<%=num %>
							</div>
						</div>
						<div class="input">
						 <table>
							<tr>
								<th>
								�мۿ�����
								</th>
								<th>
								�мۿ�����
								</th>
								<th>
								�мۿ�����
								</th>
								<th>
								�мۿ�Ԥռ
								</th>
							</tr>
							<tr>
								
								<td>
								<input name="cardType" type="hidden"  id="cardType_<%=num%>" value="<%=CARD_NO%>"  />
								 <%=CARD_NO%>
								</td>
								<td>
								<input name="cardName" type="hidden"  id="cardName_<%=num%>" value="<%=CARD_NAME%>"  />
								<%=CARD_NAME%>
								</td>
								<td>
								<input name="cardCount" type="hidden"  id="cardCount_<%=num%>" value="<%=CARD_COUNT%>"  />
								<%=CARD_COUNT%>
								</td>
								<td>
								<input name="cardNo" type="hidden"  id="cardNo_<%=num%>" value=""  />
								<input name="cardButton" type="button" class="b_text" id="button_<%=num%>"  value="Ԥռ"										  
												   onclick="seeWorkFlow('<%=CARD_NO%>','<%=CARD_COUNT%>','<%=orderId%>','<%=num%>');" />
								</td>
							</tr>

						  </table>
						</div>
						<%	 
						    num++;
						  }
						}%>
					<div id="operation_button">
						<input type="button" class="b_foot"   value="ȷ��" id="btnSubmit"
							name="btnSubmit" onclick="btnRsSubmit()" />
						<input type="button" class="b_foot" value="�ر�" id="btnCancel"
							name="btnCancel" onclick="closeWin()" />
					</div>
			</form>
		</div>
	</body>
	<script type="text/javascript">

	function closeWin(){
		closeDivWin();
	}

	function seeWorkFlow(CARD_NO,CARD_COUNT,orderId,num){
		var myPacket = null;
		myPacket = new AJAXPacket("getcardsPreOccupied.jsp","���Ժ�...");
		myPacket.data.add("ORDER_ID",orderId);
		myPacket.data.add("MEANS_ID","<%=meansId%>");
		myPacket.data.add("CARD_NO",CARD_NO);
		myPacket.data.add("CARD_COUNT",CARD_COUNT);
		myPacket.data.add("num",num);
		core.ajax.sendPacket(myPacket,doResourceCats);
		myPacket =null;
	}

	function doResourceCats(packet){
		var RETURN_CODE = packet.data.findValueByName("RETURN_CODE");//�ɹ���ʧ�ܴ���0�ɹ���1ʧ��,2�Ѿ�Ԥռ
		
		var RETURN_MSG = packet.data.findValueByName("RETURN_MSG");//ʧ����Ϣ
		
		var occupy_card_no = packet.data.findValueByName("OCCUPY_CARD_NO");//����(���ʱ��","�ָ�)
	
		var occupy_card_num = packet.data.findValueByName("OCCUPY_CARD_NUM");//����
		
		var occupy_accept = packet.data.findValueByName("OCCUPY_ACCEPT");//��ˮ
		
		var num = packet.data.findValueByName("num");
		
		if(trim(RETURN_CODE)=="0"){
		$("#cardNo_"+num).val(occupy_card_no);
		jQuery("#button_"+num).attr("disabled", true);
		showDialog(RETURN_MSG,1);
		}else if(trim(RETURN_CODE)=="2") {
		$("#cardNo_"+num).val(occupy_card_no);
		jQuery("#button_"+num).attr("disabled", true);
		showDialog("Ԥռ�ɹ�",1);
		}
		else{
			showDialog(RETURN_MSG,0);
			return false;
		}
		
	}

function doPhoneCat(packet){
			var RETURN_CODE = packet.data.findValueByName("RETURN_CODE");
			var RETURN_MSG = packet.data.findValueByName("RETURN_MSG");
			var CUST_NAME = packet.data.findValueByName("CUST_NAME");
			var FLAG = packet.data.findValueByName("FLAG");
			var num = packet.data.findValueByName("num");
			if(RETURN_CODE != "000000"){
			   return false;
			}
			if(trim(FLAG)=="0")
			{
				var td1 = document.getElementById("td1"+num);
		 		td1.innerHTML=trim(RETURN_MSG);
		 		$("#assName"+num).attr("readonly",true);
				$("#assPhoneNo"+num).attr("readonly",true);
				$("#assName"+num).val(trim(CUST_NAME));
				$("#verify_flag"+num).val("1");
			}else if(trim(FLAG)=="1")
			{
				var td1 = document.getElementById("td1");
		 		td1.innerHTML=trim(RETURN_MSG);
			}	
}
function btnRsSubmit(){
		var items = jQuery("[id*=button_]");
		var cardnos = jQuery("[id*=cardNo_]");//����
		var cardtypes = jQuery("[id*=cardType_]");//������
		var cardcounts =	jQuery("[id*=cardCount_]");//������
		for (var i = 0; i < items.length; i++){
		var item = jQuery(items[i]);
		var id = item.attr("id");
		var val = item.val();
		 if(document.getElementById(id).disabled == false) {
		 	
		 	showDialog('������δԤռ���мۿ�',1);
		 	return false;
		    }
		  }
		
		var cardno = "";
		var cardtype = "";
		var cardcount = "";  
		for(var j =0;j<cardnos.length;j++){
	//	cardno = $(cardnos[j]).val();
	//	cardtype = $(cardtypes[j]).val();
	//	cardcount = $(cardcounts[j]).val();
	//	cardno += "|"+$(cardnos[j]).val();
		cardno +=  $(cardnos[j]).val()+"#";
		cardtype += $(cardtypes[j]).val()+"#";
		cardcount += $(cardcounts[j]).val()+"#";
		
		}
		parent.builCardXml(cardtype,cardno,cardcount);	
		parent.card_Checkfuc();
		parent.submit_disabled();
		closeDivWin();
		
}

	
	
	</script>
</html>