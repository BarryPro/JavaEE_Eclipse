<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%@ page contentType= "text/html;charset=GBK" %>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UtypeUtil"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UElement"%>
<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>
<HEAD>
<TITLE></TITLE>
<%
  //Session ��Ϣ	
	String groupId = (String)session.getAttribute("groupId");
  String workNo = (String)session.getAttribute("workNo");
	String opCode = WtcUtil.repNull(request.getParameter("opCode"));
	String opName = WtcUtil.repNull(request.getParameter("opName"));
	
  //ȡֵ��Ϣ
	String srv_no      = WtcUtil.repNull(request.getParameter("phoneNo"));	
	String offerId     = WtcUtil.repNull(request.getParameter("offerId"));	
	String offerName   = WtcUtil.repNull(request.getParameter("offerName"));	
	String groupTypeId = WtcUtil.repNull(request.getParameter("groupTypeId"));	
	String brandID     = WtcUtil.repNull(request.getParameter("brandID"));	
	String curDate     = WtcUtil.repNull(request.getParameter("curDate"));		
	String effTime     = WtcUtil.repNull(request.getParameter("effTime"));	
    String expTime     = WtcUtil.repNull(request.getParameter("expTime"));	
    String loginAccept = WtcUtil.repNull(request.getParameter("loginAccept"));	
    String servId      = WtcUtil.repNull(request.getParameter("servId"));	
	String custName    = WtcUtil.repNull(request.getParameter("custName"));	
	
	System.out.println("srv_no      ="+srv_no      );
	System.out.println("offerId     ="+offerId     );
	System.out.println("offerName   ="+offerName   );
	System.out.println("groupTypeId ="+groupTypeId );
	System.out.println("brandID     ="+brandID     );
	System.out.println("curDate     ="+curDate     );
	System.out.println("effTime     ="+effTime     );
	System.out.println("expTime     ="+expTime     );
	System.out.println("loginAccept ="+loginAccept );
	System.out.println("servId      ="+servId      );
	System.out.println("custName    ="+custName    );
	
  String curnentTime = new java.text.SimpleDateFormat("yyyyMMdd HH:mm:ss").format(new java.util.Date()); //��ǰʱ��
%>
<wtc:utype name="sQryGrpMem" id="retVal" scope="end">
  	<wtc:uparam value="<%=offerId%>" type="int"/>
  	<wtc:uparam value="<%=servId%>" type="long"/>
  	<wtc:uparam value="<%=loginAccept%>" type="long"/>			
</wtc:utype>

<%
	String retCode = retVal.getValue(0);
	String retMsg  = retVal.getValue(1).replaceAll("\\n"," ");;
	StringBuffer logBuffer = new StringBuffer(80);
	WtcUtil.recursivePrint(retVal,1,"2",logBuffer);
	System.out.println(logBuffer.toString());

%>
<script language="javascript" type="text/javascript" src="/njs/si/validate_class.js"></script>
<SCRIPT language=javascript>
var tempPram1="0";
var	num=10000;
var tempPram2="";	
$().ready(function(){
  <%	
	if(retCode.equals("0")){
					System.out.println("retValNum_old=="+retVal.getUtype("2").getSize());
	
	  if(retVal.getUtype("2").getSize()>0){	
				int retValNum_old = retVal.getUtype("2").getSize();

				for(int i=0;i<retValNum_old;i++){
					 UType uType = retVal.getUtype("2."+i);
					  System.out.println(uType.getValue(i));
						%>
							var offerName ='<%=offerName%>';
							var phoneNo = '<%=uType.getValue(0)%>';
						  var effTime = '<%=uType.getValue(1).substring(0,8)%>';  
						  var expTime = '<%=uType.getValue(2).substring(0,8)%>';                        
							var offerId = '<%=offerId%>';
							var groupId = '<%=groupId%>';
							var val = 3+"|"+offerId+"|"+groupId+"|"+phoneNo;
						$("#currentInfoTab").append("<tr name='"+val+"'><td>"+offerName+"</td><td>"+phoneNo+"</td><td>"+effTime+"</td><td>"+expTime+"</td><td><input type='button' class='b_text' value='ɾ��' onClick='delCurTr(this,"+phoneNo+")' /></td></tr>");	
						<%	
				 }
		 }
	 }else{
%>
		alert("<%=retMsg%>");
		window.close();
<%		
	}
%>
		//������Ҫ�趨������������Ʒ
		var offerId = '<%=offerId%>';
		
		var myPacket = new AJAXPacket("consNoSum.jsp","���Ժ�......");	
		myPacket.data.add("offerId",offerId);
		core.ajax.sendPacket(myPacket,doSetMaxNum,true);
		myPacket=null; 	 
});


function doSetMaxNum(packet){
	var retCode = packet.data.findValueByName("retCode");
	var retMsg = packet.data.findValueByName("retMsg");
	
	var maxV1 = packet.data.findValueByName("maxV1");
	var maxV2 = packet.data.findValueByName("maxV2");
	var maxV3 = packet.data.findValueByName("maxV3");
	var maxV4 = packet.data.findValueByName("maxV4");	
	 $("#span_maxNum4").text(maxV4);
	 $("#span_maxNum3").text(maxV3);
	 $("#span_maxNum2").text(maxV2);
	 $("#span_maxNum1").text(maxV1);
	}
	
//�����Ѱ�����������
function docheck(packet){
		tempPram1 = packet.data.findValueByName("retcode");
		tempPram2 = packet.data.findValueByName("retmsg");		
		if(num==10000){
			num=parseInt(packet.data.findValueByName("num"));
		}
}

function addPhoneNO(){
  if(!validateElement($("#phoneNo").get(0))){
	  return false;	
   }
	
	if($("#phoneNo").val().length < 11){
		rdShowMessageDialog("��������ʽ����ȷ,����������!");	
		return false;	
	}
	
	var phoneNoAry = new Array();
	$("#currentInfoTab tr:gt(0)").find("td:eq(1)").each(function(i,n){
  		phoneNoAry.push($(n).text());
  });
	for(var i=0;i<phoneNoAry.length;i++){
		var phoneNo = phoneNoAry[i];
		if($("#phoneNo").val().trim() == phoneNo){
			rdShowMessageDialog("�ú�������ӹ�!");	
			return false;
		}
	}
	
	var offerInfoStr = $("#offerListRad").val();		
	var phoneNo = $("#phoneNo").val();
	var offerAry = offerInfoStr.split("|");
	var offerId = offerAry[0];
	var groupId = offerAry[1];
	var offerName = offerAry[3];
	
	var effTime =  '<%=effTime%>';
	var expTime =  '<%=expTime%>';
	var servId =  '<%=servId%>';
	var loginAccept = '<%=loginAccept%>';
	var srv_no =  '<%=srv_no%>';
  var opCode =  '<%=opCode%>';
  phoneNoCheck(offerId,$("#phoneNo").val().trim())
}

function doadd(packet){
	var retCode = packet.data.findValueByName("errorCode");
	var retMsg = packet.data.findValueByName("errorMsg");
	if(retCode == 0){
		var offerInfoStr = $("#offerListRad").val();	
		var phoneNo = $("#phoneNo").val();
		var offerAry = offerInfoStr.split("|");
		var offerId = offerAry[0];
		var groupId = offerAry[1];
		var offerName = offerAry[3];
		var effTime =  '<%=effTime%>';
		var expTime =  '<%=expTime%>';
		var val = 1+"|"+offerId+"|"+groupId+"|"+phoneNo;
		$("#currentInfoTab").append("<tr name='"+val+"'><td>"+offerName+"</td><td>"+phoneNo+"</td><td>"+effTime+"</td><td>"+expTime+"</td><td><input type='button' class='b_text' value='ɾ��' onClick='delCurTr(this,"+phoneNo+")' /></td></tr>");	
		return;
	}else{
		alert(retMsg);
	}
}

//��Ӻ���ʱУ�����ĺϷ���
function phoneNoCheck(offerId,phoneNo){
	var offerInfoStr = $("#offerListRad").val();	
	var offerAry = offerInfoStr.split("|");
	var groupId = offerAry[1];
	var srv_no = "<%=srv_no%>";
	var servId =  '<%=servId%>';
	var loginAccept = '<%=loginAccept%>';
	
	var myPacket = new AJAXPacket("phoneCheck.jsp","���Ժ�......");	
	myPacket.data.add("offerId",offerId);
	myPacket.data.add("phoneNo",phoneNo);
	myPacket.data.add("servId",servId);
	myPacket.data.add("loginAccept",loginAccept);
	core.ajax.sendPacket(myPacket,doPhoneNoCheck);
	myPacket=null; 	
}

function doPhoneNoCheck(packet){
	var retCode = packet.data.findValueByName("errorCode");
	var retMsg = packet.data.findValueByName("errorMsg");
	if(retCode == 0){

   	var offerInfoStr = $("#offerListRad").val();		
		var phoneNo = $("#phoneNo").val();
		var offerAry = offerInfoStr.split("|");
		var offerId = offerAry[0];
		var groupId = offerAry[1];
		var offerName = offerAry[3];
		
		var effTime =  '<%=effTime%>';
		var expTime =  '<%=expTime%>';
		var servId =  '<%=servId%>';
		var loginAccept = '<%=loginAccept%>';
		var srv_no =  '<%=srv_no%>';
	  var opCode =  '<%=opCode%>';

	  var offerInfoAry = new Array();
	  $("#currentInfoTab tr:gt(0)").each(function(i,n){
	  		var val = n.name + "| ";	//������Ч��ʽ
	  		offerInfoAry.push(val);
	  });  
		var val = "|  "+ "|  " +"|"+ $("#phoneNo").val().trim() + "|  ";
		offerInfoAry.push(val);
		
		var myPacket = new AJAXPacket("famChgCfm.jsp","���Ժ�......");	
		myPacket.data.add("offerId",offerId);
		myPacket.data.add("srv_no",srv_no);
		myPacket.data.add("groupId",groupId);
		myPacket.data.add("opCode",opCode);
		myPacket.data.add("servId",servId);
		myPacket.data.add("loginAccept",loginAccept);
		myPacket.data.add("effTime",effTime);
		myPacket.data.add("expTime",expTime);
		myPacket.data.add("offerInfoAry",offerInfoAry);
		core.ajax.sendPacket(myPacket,doadd,false);
		myPacket=null; 	
     
	}else{
		rdShowMessageDialog(retMsg);	
		return false;	
	}
}


////ɾ�����β���ҵ��
function delCurTr(_this,phoneNo){
	var servId = "<%=servId%>";
	var loginAccept ='<%=loginAccept%>';
	var offerId = '<%=offerId%>';	
	var myPacket = new AJAXPacket("famChgMain_ajax.jsp","���Ժ�......");	
	myPacket.data.add("phoneNo",phoneNo);
	myPacket.data.add("servId",servId);
	myPacket.data.add("offerId",offerId);
	myPacket.data.add("loginAccept",loginAccept);
	core.ajax.sendPacket(myPacket,delPhoneNo,false);
	myPacket=null; 	
	
	num=num-1;
	$(_this).parents("tr").remove();
	
	//$("#cfmBtn").attr("disabled",true);	//δ�������ǰ����ȷ��
}

//ɾ���Ѱ�����������
function delPhoneNo(packet){			
  var retCode = packet.data.findValueByName("retcode");
	var retMsg = packet.data.findValueByName("retmsg");
	if(retCode == 0){
		//alert("ɾ���ɹ�");	
	}else{
		alert(retMsg);
	}
	//if(tempPram1=="0"){
	//	}else{
	//	rdShowMessageDialog(tempPram2,"0");
	//	return false;
	//}
	//num=num+1;
	//if(num>4){	
	//	rdShowMessageDialog("ɾ����������4��");
	//	return false;
	//}
}


function  Cfm(packet){
		rdShowMessageDialog("����Ⱥ�����");	
		window.returnValue='0';
		window.close();
}

</SCRIPT>
<META content="MSHTML 6.00.6000.16762" name=GENERATOR>
</HEAD>
<BODY onload="">
<DIV id=operation>
<FORM name=frm action="" method=post>
	<%@ include file="/npage/include/header_pop.jsp" %>                         
<DIV id=operation_table>
	<div class="title"><div id="title_zi">�����������</div></div>
	<div class="input">
		<table>
			<tr>
				<td class=blue> <font class="orange">*</font> ������� </td>
				<td><%=srv_no%></td>
				<td class=blue>�ͻ�����</td>
				<td><%=custName%></td>
			</tr>
		</table>
	</div>			
	<div class="title"><div id="title_zi">�趨���������</div></div>
	<div style="overflow-y:auto;height:100px;overflow-x:hidden;" class="list">
		<table id="newOfferListTab">
			<input type='hidden'  id='offerListRad' value='<%=offerId%>|<%=groupId%>|<%=effTime%>|<%=offerName%>|<%=expTime%>'>
			<tr>
				<th>����Ʒ����</th>
				<th>��Чʱ��</th>
				<th>ʧЧʱ��</th>
			</tr>
			<tr>
				<td><%=offerName%></td>
				<td><%=effTime%></td>
				<td><%=expTime%></td>
			</tr>	
		</table>
	</div>
	<div class="input">
		<table>
			<tr>
				<th>������룺</th>
				<td><input type="text" name="phoneNo" id="phoneNo" maxlength="11" class="required andCellphone" val /><input type="button" value="��Ӻ���" onClick="addPhoneNO()" class="b_text"></td>
			</tr>
		</table>
		<p style="color:#ff8000;font-size:12px" >��ʾ���ܹ���ӵ������������Ϊ<span id="span_maxNum1"></span>�����룻�ܹ���ӵ����������������Ϊ<span id="span_maxNum2"></span>�����룻 
			 �ܹ���ӵ��������������������Ϊ<span id="span_maxNum3"></span>�����룻�ܹ���ӵ��������������������Ϊ<span id="span_maxNum4"></span>������ 

		</p>
	</div>		
	
	<div class="title"><div id="title_zi">���β�����Ϣ</div></div>
	<div class="list">
		<table id="currentInfoTab">
			<tr>
				<th>����Ʒ����</th>
				<th>�������</th>
				<th>��Чʱ��</th>
				<th>ʧЧʱ��</th>
				<th>����</th>
			</tr>
		</table>
	</div>	
					
	<div class="input">
		<table>
			<tr>  
				<td id="footer" colspan=4>
					<input class="b_foot" type="button" name="cfmBtn" id="cfmBtn" value="ȷ��" onClick="Cfm()" index="2"  />      
	  			<input class="b_foot" type="button" name=closebutton value="�ر�" onClick="window.close()"  >	
					</td>
				</tr>
		</table>
	</div>	
	
</DIV>
<input type="hidden" name="srv_no" value="<%=srv_no%>" />
<input type="hidden" name="offerInfoAry" id="offerInfoAry" />
<input type="hidden" name="effTimeStr" id="effTimeStr" value="">
<input type="hidden" name="expTimeStr" id="expTimeStr" value="">
<%@ include file="/npage/include/footer_pop.jsp" %>
</FORM>
</DIV>
</BODY>
</HTML>
