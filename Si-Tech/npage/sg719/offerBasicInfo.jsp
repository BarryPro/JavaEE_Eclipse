<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.text.ParsePosition"%>
<HTML><HEAD><TITLE></TITLE>
<%	
	String loginAccept = WtcUtil.repNull(request.getParameter("loginAccept"));
	String offerId = WtcUtil.repNull(request.getParameter("offerId"));	
	String effTime = WtcUtil.repNull(request.getParameter("effTime"))+"  00:00:00";
	String expTime = WtcUtil.repNull(request.getParameter("expTime"))+"  00:00:00";
	String offerInstId = WtcUtil.repNull(request.getParameter("offerInstId"));
	String servId = WtcUtil.repNull(request.getParameter("servId"));
	String phoneNo = WtcUtil.repNull(request.getParameter("phoneNo"));
	
	Calendar cal = Calendar.getInstance(); 
	cal.add(Calendar.MONTH,1);
	cal.set(Calendar.DAY_OF_MONTH,1);
	String nextMonth = new java.text.SimpleDateFormat("yyyy-MM-dd 00:00:00").format(cal.getTime()); //����һ��
	
	java.text.SimpleDateFormat sdf= new java.text.SimpleDateFormat("yyyy-MM-dd G 'at' 00:00:00 z");
	ParsePosition pos = new ParsePosition(0);
	Date expDate = sdf.parse(expTime,pos);
	System.out.println("expDate=="+expDate);
	
	//Calendar cal1 = Calendar.getInstance(); 
	//cal1.setTime(expDate);
	//cal1.add(Calendar.MONTH,1);
	//cal.set(Calendar.DAY_OF_MONTH,1);
	//String nextMonthOfExp = new java.text.SimpleDateFormat("yyyy-MM-dd 00:00:00").format(cal1.getTime()); 
	
	String nextMonthOfExp = expTime ; 
	
	System.out.println("nextMonthOfExp=="+nextMonthOfExp);
	
%>
<SCRIPT language=javascript>
function showOffer(data){
	$("#offerinfo").html(data);
}

function saveto(){
	var newEffTime = $("#effTd").html();
	var newExpTime = $("#expTd").html();
	
	var packet = new AJAXPacket("modifyDate.jsp","���Ժ�...");
	packet.data.add("loginAccept","<%=loginAccept%>");
	packet.data.add("offerId","<%=offerId%>");
	packet.data.add("offerInstId","<%=offerInstId%>");
	packet.data.add("servId","<%=servId%>");
	packet.data.add("phoneNo","<%=phoneNo%>");
	packet.data.add("newEffTime",newEffTime);
	packet.data.add("newExpTime",newExpTime);
	core.ajax.sendPacket(packet,doModifyDate);
	packet =null;	
}
function doModifyDate(packet){
	var newEffTime = $("#effTd").html();
	var newExpTime = $("#expTd").html();

	var errorCode = packet.data.findValueByName("errorCode");
	var errorMsg = packet.data.findValueByName("errorMsg");
	if(errorCode == 0){
		window.returnValue=newEffTime+"|"+newExpTime;
	}else{
		rdShowMessageDialog(errorMsg);
	}
	
	window.close();
}


function chgEffType(_this){
	if(_this.value == 0){
		$("#effTd").html("<%=effTime.substring(0,10)%>");
		$("#expTd").html("<%=expTime.substring(0,10)%>");		
	}else{
		$("#effTd").html("<%=nextMonth.substring(0,10)%>");	
		$("#expTd").html("<%=nextMonthOfExp.substring(0,10)%>");	
	}	
}
</SCRIPT>
<META content="MSHTML 6.00.6000.16762" name=GENERATOR>
</HEAD>
<BODY>
<DIV id=operation>
<FORM name=frm1104 action="" method=post><!-- operation_table -->
	<div id=operation_table>
	<div class="title"><div id="title_zi">������Ϣ</div></div>
	<DIV class="input">
	<table>
		<tr>
			<th>��Ч��ʽ:</th>
			<td>
				<select onchange="chgEffType(this)">
					<option value='0'>������Ч</option>
					<option value='1' selected>������Ч</option>
				</select>
			</td>
			<th>��Чʱ��:</th>
			<td id="effTd"><%=nextMonth.substring(0,10)%></td>
			<th>ʧЧʱ��:</th>
			<td id="expTd"><%=nextMonthOfExp.substring(0,10)%></td>
		</tr>
		<!--tr>
			<td>֤������:</td>
			<td>18λ���֤</td>
			<td>֤������:</td><td>23243243214324312432</td>
		</tr-->
	</table>
	</DIV>
	</div>

	<DIV id=operation_button>
		<INPUT class=b_foot onclick="saveto()" type=button value="ȷ��">
		<INPUT class=b_foot onclick="window.close()" type=button value="�ر�">
	</DIV>

</FORM>
</DIV>
</BODY>
</HTML>
