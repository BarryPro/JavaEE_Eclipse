<%
  String opName = "����������ѯ";
%>



<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>




<%

String opCode = "1170";

System.out.println("-------------------showBaseInfoj.jsp--------------"+opCode);

String phoneNo = request.getParameter("phoneNo");

String serOId = request.getParameter("serVId");

String opCode1 = request.getParameter("opCode1Hv");

String opCode2 = request.getParameter("opCode2Hv");

String loginAccept = request.getParameter("loginAcceptHv");

/* liujian add workNo and password 2012-4-5 15:59:15 begin */

String workNo = (String)session.getAttribute("workNo");

String password = (String) session.getAttribute("password");

String op_code = request.getParameter("opCode");

/* liujian add workNo and password 2012-4-5 15:59:15 end */







String regionCode = (String)session.getAttribute("regCode");



%>



<%String regionCode_sReverInfo = (String)session.getAttribute("regCode");%>
<wtc:utype name="sReverInfo" id="retVal" scope="end"  routerKey="region" routerValue="<%=regionCode_sReverInfo%>">

          <wtc:uparam value="<%=phoneNo%>" type="String"/>

          <wtc:uparam value="<%=serOId%>" type="String"/>

          <wtc:uparam value="<%=opCode1%>" type="String"/>

          <wtc:uparam value="<%=opCode2%>" type="String"/>

          <wtc:uparam value="<%=loginAccept%>" type="LONG"/>

</wtc:utype>



<wtc:utype name="sPMQryUserInfo" id="retUserInfo" scope="end"  routerKey="region" routerValue="<%=regionCode%>">

     <wtc:uparam value="0" type="LONG"/>

     <wtc:uparam value="<%=phoneNo%>" type="STRING"/>

		 <wtc:uparam value="<%=workNo%>" type="string"/>

     <wtc:uparam value="<%=password%>" type="string"/>	

     <wtc:uparam value="<%=op_code%>" type="string"/>

</wtc:utype>



<%

	StringBuffer logBuffer = new StringBuffer(80);

	WtcUtil.recursivePrint(retVal,1,"2",logBuffer);

	System.out.println(logBuffer.toString());

	String taocLeib = "";

	String taocanMingc = "";


	String czczOffert   = "";

	String czczOffertId = "";

	String czhzOffert = "";

	String czhzOffertId = "";

	String comeFlag = "";



	if(retVal.getSize("2.0")>0){

			czczOffertId  = retVal.getValue("2.0.2");

			czczOffert = retVal.getValue("2.0.2")+"--"+retVal.getValue("2.0.3");

			comeFlag = retVal.getValue("2.0.7");

	}
	String offerIdF3264= "";
  if(retVal.getSize("2.2")>0){
     if(retVal.getSize("2.2.0")>0){

     			offerIdF3264 =retVal.getValue("2.2.0.2");

	         taocanMingc = retVal.getValue("2.2.0.2") +"-->"+ retVal.getValue("2.2.0.3");

           taocLeib  = retVal.getValue("2.2.0.5");

	           }
	         }

	if(retVal.getSize("2.1")>0){

			czhzOffertId = retVal.getValue("2.1.2");

			czhzOffert =retVal.getValue("2.1.2")+"--"+retVal.getValue("2.1.3");

	}



%>

    <wtc:service name="sDynSqlCfm" outnum="1" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="220" />
			<wtc:param value="<%=czczOffertId%>" />
		</wtc:service>
		<wtc:array id="result_t" scope="end" />
<%

String baoNfee = "";

if(result_t.length>0&&result_t[0][0]!=null){

	baoNfee =result_t[0][0];

}





String retCode =retUserInfo.getValue(0);

String retMsg  =retUserInfo.getValue(1);



String stPMvPhoneNo       = ""; /*�ֻ�����*/

String stPMid_no          = "";  /*�û�id*/

String stPMcust_id        = "";  /*�ͻ�id*/

String stPMcontract_no    = "";  /*Ĭ���ʺ�*/

String stPMbelong_code    = "";  /*�û�����*/

String stPMsm_code        = "";  /*ҵ�����ʹ���*/

String stPMsm_name        = "";  /*ҵ����������*/

String stPMsm_kind        = "";  /*c,g,d,e*/

String stPMcust_name      = "";  /*�ͻ�����*/

String stPMuser_passwd    = "";  /*�û�����*/

String stPMrun_code       = "";  /*״̬����*/

String stPMrun_name       = "";  /*״̬����*/

String stPMowner_grade    = "";  /*�ȼ�����*/

String stPMgrade_name     = "";  /*�ȼ�����*/

String stPMowner_type     = "";  /*�û����ʹ���*/

String stPMtype_name      = "";  /*�û���������*/

String stPMcust_address   = "";  /*�ͻ�סַ*/

String stPMid_type        = "";  /*֤������*/

String stPMid_name        = "";  /*֤������*/

String stPMid_iccid       = "";  /*֤������*/

String stPMcard_type      = "";  /*�ͻ�������*/

String stPMcard_name      = "";  /*�ͻ�����������*/

String stPMvip_no         = "";  /*VIP����*/

String stPMgrpbig_flag    = "";  /*���ſͻ���־*/

String stPMgrpbig_name    = "";  /*���ſͻ�����*/

String stPMbak_field      = "";  /*�����ֶ�*/

String stPMgroup_id       = "";  /*������ʶ*/

String stPMcontact_person = "";  /* ��ϵ��  */

String stPMcontact_phone  = "";  /* ��ϵ�绰 */

String stPMowner_code     = "";  /* �û����� */

String stPMcredit_code    = "";  /* �������� */

String stPMmode_code      = "";  /* ���»�����ƷID*/

String stPMmode_name      = "";  /* ���»�����Ʒ����*/

String stPMtotalOwe       = "";  /*��Ƿ��*/

String stPMtotalPrepay    = ""; /*��Ԥ��*/

String unbillFee          = ""; /*δ���ʻ���*/

String accountNo          = ""; /*��һ���ʻ�*/

String accountOwe         = ""; /*��һ���ʻ�Ƿ��*/

String openTime           = ""; /*����ʱ��*/



if(retCode.equals("0"))

{

stPMvPhoneNo       = retUserInfo.getValue("2.0.2.0");   /*�ֻ�����*/

stPMid_no          = retUserInfo.getValue("2.0.2.1");   /*�û�id*/

stPMcust_id        = retUserInfo.getValue("2.0.2.2");   /*�ͻ�id*/

stPMcontract_no    = retUserInfo.getValue("2.0.2.3");   /*Ĭ���ʺ�*/

stPMbelong_code    = retUserInfo.getValue("2.0.2.4");   /*�û�����*/

stPMsm_code        = retUserInfo.getValue("2.0.2.5");   /*ҵ�����ʹ���*/

stPMsm_name        = retUserInfo.getValue("2.0.2.6");   /*ҵ����������*/

stPMsm_kind        = retUserInfo.getValue("2.0.2.7");   /*c,g,d,e*/

stPMcust_name      = retUserInfo.getValue("2.0.2.8");   /*�ͻ�����*/

stPMuser_passwd    = retUserInfo.getValue("2.0.2.9");   /*�û�����*/

stPMrun_code       = retUserInfo.getValue("2.0.2.10");  /*״̬����*/

stPMrun_name       = retUserInfo.getValue("2.0.2.11");  /*״̬����*/

stPMowner_grade    = retUserInfo.getValue("2.0.2.12");  /*�ȼ�����*/

stPMgrade_name     = retUserInfo.getValue("2.0.2.13");  /*�ȼ�����*/

stPMowner_type     = retUserInfo.getValue("2.0.2.14");  /*�û����ʹ���*/

stPMtype_name      = retUserInfo.getValue("2.0.2.15");  /*�û���������*/

stPMcust_address   = retUserInfo.getValue("2.0.2.16");  /*�ͻ�סַ*/

stPMid_type        = retUserInfo.getValue("2.0.2.17");  /*֤������*/

stPMid_name        = retUserInfo.getValue("2.0.2.18");  /*֤������*/

stPMid_iccid       = retUserInfo.getValue("2.0.2.19");  /*֤������*/

stPMcard_type      = retUserInfo.getValue("2.0.2.20");  /*�ͻ�������*/

stPMcard_name      = retUserInfo.getValue("2.0.2.21");  /*�ͻ�����������*/

stPMvip_no         = retUserInfo.getValue("2.0.2.22");  /*VIP����*/

stPMgrpbig_flag    = retUserInfo.getValue("2.0.2.23");  /*���ſͻ���־*/

stPMgrpbig_name    = retUserInfo.getValue("2.0.2.24");  /*���ſͻ�����*/

stPMbak_field      = retUserInfo.getValue("2.0.2.25");  /*�����ֶ�*/

stPMgroup_id       = retUserInfo.getValue("2.0.2.26");  /*������ʶ*/

stPMcontact_person = retUserInfo.getValue("2.0.2.27");  /* ��ϵ��  */

stPMcontact_phone  = retUserInfo.getValue("2.0.2.28");  /* ��ϵ�绰 */

stPMowner_code     = retUserInfo.getValue("2.0.2.29");  /* �û����� */

stPMcredit_code    = retUserInfo.getValue("2.0.2.30");  /* �������� */

stPMmode_code      = retUserInfo.getValue("2.0.2.31");  /* ���»�����ƷID*/

stPMmode_name      = retUserInfo.getValue("2.0.2.32");  /* ���»�����Ʒ����*/

stPMtotalOwe       = retUserInfo.getValue("2.0.2.33");  /*��Ƿ��*/

stPMtotalPrepay    = retUserInfo.getValue("2.0.2.34");  /*��Ԥ��*/

unbillFee          = retUserInfo.getValue("2.0.2.35");  /*δ���ʻ���*/

accountNo          = retUserInfo.getValue("2.0.2.36");  /*��һ���ʻ�*/

accountOwe         = retUserInfo.getValue("2.0.2.37");  /*��һ���ʻ�Ƿ��*/

openTime           = retUserInfo.getValue("2.0.2.38");  /*����ʱ��*/

}



System.out.println("---------------stPMid_no--------------"+stPMid_no);

%>
<%!
String StrToPrice(String v_value)
{
	if(v_value.indexOf(".")!=-1){
  		v_value = v_value+"00";
  	}
  	else{
  		v_value = v_value+".00";
  	}
  	v_value = v_value.substring(0,v_value.indexOf(".")+3);
  	return v_value;
}
%>

<%String regionCode_sQUserOfferInst = (String)session.getAttribute("regCode");%>
<wtc:utype name="sQUserOfferInst" id="retVal1" scope="end"  routerKey="region" routerValue="<%=regionCode_sQUserOfferInst%>">

          <wtc:uparam value="<%=stPMid_no%>" type="LONG"/>

          <wtc:uparam value="99" type="LONG"/>

          <wtc:uparam value="0" type="LONG"/>

          <wtc:uparam value="0" type="LONG"/>

</wtc:utype>



<%

	String beginTime = "";

  String endTime = "";






	int countTempF = 0;

	countTempF = retVal1.getSize("2");



	for(int ij= 0;ij<countTempF;ij++){

		if(retVal1.getValue("2."+ij+".3").equals("10")&&retVal1.getValue("2."+ij+".8").equals("��Ч")){



			beginTime = retVal1.getValue("2."+ij+".5");

			endTime = retVal1.getValue("2."+ij+".6");



		}

	}



String beginTime1 = "";

String endTime1 = "";

try{

 Date tempDateV1 = new java.text.SimpleDateFormat("yyyyMMddHHmmss").parse(beginTime);

 beginTime1 =new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(tempDateV1).toString();

 Date tempDateV2 = new java.text.SimpleDateFormat("yyyyMMddHHmmss").parse(endTime);

 endTime1 =new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(tempDateV2).toString();

 System.out.println("--------------beginTime1----------------"+beginTime1);

System.out.println("--------------endTime1----------------"+endTime1);



}catch(Exception e){



}





%>

<FORM method=post name="frm">

	<%@ include file="/npage/include/header_pop.jsp" %>

<div class="title">

	<div id="title_zi">��ѯ��ϸ��Ϣ</div>

</div>



<div class="input">

 <table cellspacing="0">

<%

if(opCode2.equals("3264")){
%>
<tr>
	<TD class="blue">�ͻ����� </TD>

		  <TD>

		   <%=stPMcust_name%>

		  </TD>
		  <TD class="blue">�ͻ�סַ</TD>

		  <TD>

		  <%=stPMcust_address%>

		  </TD>
		</tr>
		 <tr>
		  <TD class="blue">֤������</TD>

		  <TD>

		   <%=stPMid_name%>

		  </TD>

		  <TD class="blue">֤������ </TD>

		  <TD>

		    <%=stPMid_iccid%>

		  </TD>


     </tr>
<tr>

		  <td  class="blue">ҵ��Ʒ�� </td>

      <td >

        <%=stPMsm_name%>

      </td>

		   <TD class="blue">����״̬ </TD>

		  <TD>

		    <%=stPMrun_name%>

		  </TD>
		</tr>
		<tr>
		  	<td class=blue >�ײ���� </td>


	<td> <%=taocLeib%>  </td>

	<td class="blue" >  �ײ�����</td>

	<td id="tdHit3"> <%=taocanMingc%> </td>
		</tr>


<%} else{%>
      <TR>

		  <TD class="blue">�ƶ�����</TD>

		  <TD>

		   <%=stPMvPhoneNo%>

		  </TD>

		  <TD class="blue">�ͻ�ID </TD>

		  <TD>

		    <%=stPMcust_id%>

		  </TD>

		  <TD class="blue">�ͻ����� </TD>

		  <TD>

		   <%=stPMcust_name%>

		  </TD>

		 </TR>
		 <TR>

		  <TD class="blue">֤������</TD>

		  <TD>

		   <%=stPMid_name%>

		  </TD>

		  <TD class="blue">֤������ </TD>

		  <TD>

		    <%=stPMid_iccid%>

		  </TD>

		  <TD class="blue">�ͻ�סַ</TD>

		  <TD>

		  <%=stPMcust_address%>

		  </TD>

		 </TR>

         <tr>

      <td  class="blue">ҵ��Ʒ�� </td>

      <td >

        <%=stPMsm_name%>

      </td>

		  <td class="blue">����ʱ�� </td>

		  <td>

		     <%=openTime%>

		  </td>



		  <TD class="blue">ҵ������ </TD>

		  <TD>

		    <%=stPMsm_name%>

		  </TD>

		</tr>



	 <TR>

		  <TD class="blue">����״̬ </TD>

		  <TD>

		    <%=stPMrun_name%>

		  </TD>

		  <TD class="blue">δ���ʻ��� </TD>

		  <TD>

		  	<%

		  	if(unbillFee.indexOf(".")!=-1){

		  		unbillFee = unbillFee+"00";

		  	}else{

		  		unbillFee = unbillFee+".00";

		  		}



		  	unbillFee = unbillFee.substring(0,unbillFee.indexOf(".")+3);



		  	%>

		   <%=unbillFee%>

		  </TD>

		  <TD class="blue">����Ԥ�� </TD>

		  <TD>

	 <%

		  	if(stPMtotalPrepay.indexOf(".")!=-1){

		  		stPMtotalPrepay = stPMtotalPrepay+"00";

		  	}else{

		  		stPMtotalPrepay = stPMtotalPrepay+".00";

		  		}
		  	stPMtotalPrepay = stPMtotalPrepay.substring(0,stPMtotalPrepay.indexOf(".")+3);
		  	%>
		    <%=stPMtotalPrepay %>
		  </TD>
   </TR>
	 <TR>
	    <TD class="blue">���ſͻ���� </TD>
		  <TD>
		    <%=stPMgrpbig_name%>
		  </TD>
		  <TD class="blue">��ͻ���� </TD>
		  <TD>
		    <%=stPMcard_name%>
	    </TD>
		  <TD class="blue">��ǰ���ײ� </TD>
		  <TD id="tdHit2"><%=czczOffert%>  </TD>
	 </TR>
 <TR >
	    <TD class="blue">�������ײ� </TD>
		  <TD id="tdHit1">
		  	<%=czhzOffert%>
		  </TD>
		  <TD class="blue"> ��Ч��ʽ </TD>
		  <TD>
		  	<%=comeFlag%>
	    </TD>
		  <TD class="blue"> </TD>
		  <TD>
		  	</TD>
	 </TR>
	 <%
if(opCode2.equals("1257")){
%>
<tr>
	<td class=blue>������</td>
	 <%
		  	if(baoNfee.indexOf(".")!=-1){
		  		baoNfee = baoNfee+"00";
		  	}else{
		  		baoNfee = baoNfee+".00";
		  		}
		  	baoNfee = baoNfee.substring(0,baoNfee.indexOf(".")+3);
		  	%>
	<td><%=baoNfee%></td>
	<td class=blue>ʣ����</td>
	<td><%=baoNfee%></td>
	<td class=blue>���꿪ʼʱ��</td>
	<td><%=beginTime1%></td>
</tr>
<tr>
	<td class=blue>�������ʱ�� </td>
	<td> <%=endTime1%> </td>
	<td > &nbsp;</td>
	<td> &nbsp;</td>
	<td>&nbsp;</td>
	<td>&nbsp;</td>
</tr>
<%}

}%>

</table>

</div>
<%
if(!opCode2.equals("3264")){
%>
<div class="title">
	<div id="title_zi">�ײ���Ϣ</div>
</div>
 <table cellspacing="0">
 	<tr>
 		<th>��ѡ�ײ�����</th>
 		<th>״̬</th>
 		<th>��ʼʱ��</th>
 		<th>����ʱ��</th>
 		<th>�ײ����</th>
 		<th>��Ч��ʽ</th>
 		<th>��ѡ��ʽ</th>
</tr>
<%
		 for(int ih=0;ih<retVal.getSize("2.3");ih++){
		 		%>
		 		<tr>
					<td>		<%=retVal.getValue("2.3."+ih+".3")%> 			</td>
					<td>		<%=retVal.getValue("2.3."+ih+".6")%> 			</td>
					<td>		<%=retVal.getValue("2.3."+ih+".8")%> 			</td>
					<td>		<%=retVal.getValue("2.3."+ih+".9")%> 			</td>
					<td>		<%=retVal.getValue("2.3."+ih+".5")%> 			</td>
					<td>		<%=retVal.getValue("2.3."+ih+".7")%> 			</td>
					<td>		<%=retVal.getValue("2.3."+ih+".10")%> 			</td>
		 		</tr>
		 		<%
		 }
%>
</table>


<%}%>

<%
if(opCode1.equals("1104") || opCode1.equals("q001")){
%>
<div class="title">
	<div id="title_zi">��ط���</div>
</div>
<table cellspacing="0">
	<tr>
		<TD class="blue">������ </TD>
		<TD><%=StrToPrice(retVal.getValue("2.4.0"))%> </TD>
		<TD class="blue">ѡ�ŷ�</TD>
		<TD><%=StrToPrice(retVal.getValue("2.4.1"))%> </TD>
	</tr>
	<tr>
		<TD class="blue">Ԥ��� </TD>
		<TD><%=StrToPrice(retVal.getValue("2.4.2"))%> </TD>
		<TD class="blue">������</TD>
		<TD><%=StrToPrice(retVal.getValue("2.4.3"))%> </TD>
	</tr>
	<tr>
		<TD class="blue">SIM���� </TD>
		<TD><%=StrToPrice(retVal.getValue("2.4.4"))%> </TD>
		<TD class="blue">�ֽ𽻿�</TD>
		<TD><%=StrToPrice(retVal.getValue("2.4.5"))%> </TD>
	</tr>
	<tr>
		<TD class="blue">֧Ʊ���� </TD>
		<TD><%=StrToPrice(retVal.getValue("2.4.6"))%> </TD>
		<TD class="blue">�˿��ܶ�</TD>
		<TD><%=StrToPrice(retVal.getValue("2.4.7"))%> </TD>
	</tr>
</table>
<%}%>

<div class="title">

	<div id="title_zi">��ע��Ϣ</div>

</div>



 <table cellspacing="0">

 	<tr>

 	 <td class="blue" width="15%">ϵͳ��ע</td>

 	 <td></td>

</tr>

</table>





<table>

	<tr>

		<td id="footer">

			<input class="b_foot" name="quit"  onclick="window.close()"  type=button value="�ر�"/>

		</td>

		</tr>

</table>

<%@ include file="/npage/include/footer_new.jsp" %>

 <SCRIPT type=text/javascript>

	var offerIdV1 = "<%=czhzOffertId%>";
	var offerIdV2 = "<%=czczOffertId%>";
	var offerIdV3 = "<%=offerIdF3264%>";


	<%if(opCode2.equals("3264")){%>
			getMidPrompt("10442",offerIdV3,"tdHit3");
	<%}else{%>

	getMidPrompt("10442",offerIdV1,"tdHit1");
	getMidPrompt("10442",offerIdV2,"tdHit2");

<%}%>

	getBeforePrompt();
	getAfterPrompt();

	function getBeforePrompt()
	{
		var packet = new AJAXPacket("/npage/include/getBeforePrompt.jsp","���Ժ�...");
		packet.data.add("opCode" ,"<%=opCode2%>");
	    core.ajax.sendPacketHtml(packet,doGetBeforePrompt,true);//�첽
		packet =null;
	}
	function doGetBeforePrompt(data)
	{
		$('#wait').hide();
		$('#beforePrompt').html(data);
	}
</script>
