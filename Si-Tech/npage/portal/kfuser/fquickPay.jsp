<%
   /*
   *   ����: ���ٽɷ�
�� * �汾: v1.0
�� * ����: 2008/06/16 
�� * ����: ranlf
�� * ��Ȩ: sitech
   * �޸���ʷ
   * �޸�����      �޸���      �޸�Ŀ��
 ��*/
%>
<%@ page import="java.text.*" %>
<%@ page import="com.sitech.boss.pub.util.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%@ page contentType= "text/html;charset=gb2312" %>
<script type="text/javascript" src="/njs/redialog/redialog.js"></script>
<%
     String phoneNo =  WtcUtil.repNull((String)session.getAttribute("activePhone"));
     String workNo = (String)session.getAttribute("workNo");
     String password = (String)session.getAttribute("password");
     String orgCode = (String)session.getAttribute("orgCode");
		 String contractNo =  WtcUtil.repNull(request.getParameter("contractNo"));
		 String idNo = WtcUtil.repNull(request.getParameter("idNo"));
		
		double totalFee = 0.00;
		double owe_fee = 0.00;
		double delay_fee = 0.00;
		double remonth_fee  = 0.00;
		DecimalFormat df = new DecimalFormat("0.00"); 
		
		String Delay_Favourable = "readonly";        //a040  ���ɽ���Ż�
		String Predel_Favourable = "readonly";       //a041  ����������Ż�
		
		String[][] fourInfoSession = (String[][])session.getAttribute("favInfo");
    String[] favStr = new String[fourInfoSession.length];
    for(int i = 0;i < favStr.length; i++) {
        favStr[i]=fourInfoSession[i][0].trim();
    }
    if(contractNo.equals(""))
    { 
			String sqlStr = "select to_char(contract_no),ids,to_char(id_no) from dCustMsg where  phone_no=:phone and substr(run_code,2,1) < 'a'";
			
			String param = "phone="+phoneNo; 
		
			%>
		  <wtc:service name="TlsPubSelCrm"  routerKey="phone" routerValue="<%=phoneNo%>" outnum="3">
					<wtc:param value="<%=sqlStr%>"/>
					<wtc:param value="<%=param%>"/>
			</wtc:service>
			<wtc:array id="result0"  scope="end"/>
		  <%
		   	 if (result0.length != 0) {
			     contractNo = result0[0][0];
			     idNo = result0[0][2];
		     }
     } 
     
%>
		
		 <wtc:service name="s1300_Valid" routerKey="phone" routerValue="<%=phoneNo%>" outnum="23" >
      <wtc:param value="<%=phoneNo%>"/>
      <wtc:param value="<%=contractNo%>"/> 
      <wtc:param value="1"/>  
      <wtc:param value="<%=orgCode%>"/>         	
      <wtc:param value="<%=password%>"/>
      <wtc:param value="<%=workNo%>"/>
	   </wtc:service>
	   <wtc:array id="result4" start="0" length="10" scope="end"/>
	   <wtc:array id="result5" start="10" length="8" scope="end"/>

<%
   if(retCode.equals("000000"))
   {
     	remonth_fee = Double.parseDouble(result4[0][7]);
		  double prepay_fee = Double.parseDouble(result4[0][4]);
			
			for(int i = 0 ; i < result5.length; i++){
			System.out.println(result5[i][0]);
				owe_fee = MathPrecision.add(owe_fee,Double.parseDouble(result5[i][2]));
				 delay_fee = MathPrecision.add(delay_fee,Double.parseDouble(result5[i][3]));
				if (WtcUtil.haveStr(favStr,"a040") && Double.parseDouble(result5[i][3]) > 0.005) {
		     	Delay_Favourable = "";
				}
			  if(WtcUtil.haveStr(favStr,"a041") && remonth_fee > 0.005){
	        Predel_Favourable = "";     
	      }
		}
		totalFee = MathPrecision.sub(MathPrecision.add(MathPrecision.add(owe_fee, delay_fee), remonth_fee),prepay_fee);
		//totalFee = owe_fee + delay_fee + remonth_fee + prepay_fee;
		if (totalFee < 0) {
			totalFee = 0.00;
		}
   }
   
%>
	       
	       <div id="content">
				<table width=100% border="1" >		
					 <form name="layer4_form" id="layer4_form" method="post" action="">
						<input type="hidden" name="choiceNum" id="choiceNum" value="<%=result5.length%>">
						<input type="hidden" name="delay_fee" id="delay_fee" value="<%=delay_fee%>">
		       	<tr class="jiange">
	         <td class="orange" width="30%"><b>������룺</b></td>
	         <td colspan="3">
			     	<input type="text" name="phoneTxt"  style="background:transparent;border:0pt" id="phoneTxt" value="<%=phoneNo%>" readOnly>
	         </td>
			 	 </tr>
			  	<tr class="jiange">
         	<td class="jiange"><b>�˻����룺</b></td>
          <td colspan="3">
          <%--<input type="text" name="contract_no"  style="background:transparent;border:0pt" id="contract_no"  value="<%=contractNo%>" readOnly>--%>
           
          <div style="width:220px"   >   
          	<select id="contract_no" name="contract_no" style="width:220px" onchange="conNoChange();">
          	</select>
          </div>
          </td>
			 		</tr>
			  <tr class="jiange">
         	<td><b>Ԥ��</b></td>
          <td colspan="3">
          	<input type="text"   style="background:transparent;border:0pt" name="prepay_fee" id="prepay_fee" value="<%=result4[0][4].trim()%>"  readOnly>
          </td>
			 	</tr>
			 	<tr class="jiange">
         	<td><b>�������⣺</b></td>
          <td colspan="3">
          	<input type="text" name="remonth_fee"  style="background:transparent;border:0pt" id="remonth_fee" value="<%=remonth_fee%>"  readOnly>
          </td>
			 	</tr>
		  	<tr class="jiange" id="quickFeeTab">
          	<td colspan="4" height="20">
          		  <div id="payTr" class="bluegray">
                </div>
            </td>
			 		</tr>
	  	<tr class="jiange">
	         <td ><b>���ɽ��Ż��ʣ�</b></td>
	         <td colspan="3">
			       <input type="text"  onChange="CheckRate()" name="delayRate" id="delayRate" onKeyPress="return isKeyNumberdot(1)" value="0.00">
	         </td>
			 	 </tr>
			 	 <tr class="jiange">
	         <td nowrap><b>���������Ż��ʣ�</b></td>
	         <td colspan="3">
			       <input type="text" onChange="CheckRate()" name="remonthRate" id="remonthRate" onKeyPress="return isKeyNumberdot(1)" value="0.00">
	         </td>
			</tr>
			<tr class="jiange">
	         <td><b>�ϼ���Ӧ�գ�</b></td>
	         <td colspan="3"> 
			       <input name="sumshoudPay"  id="sumshoudPay" type="text" style="background:transparent;border:0pt" readonly maxlength="20" value="<%=totalFee%>"  value="0" v_type="String" v_must=1>
	         </td>
			 	 </tr>
			 <tr class="jiange"> 
                  <td><b>�Żݺ�Ӧ��</b></td>
                  <td colspan="3"> 
								    <input type="text"  class="InputGrey" name="min_pay" style="background:transparent;border:0pt" readonly value="<%=totalFee%>">
                  </td>
       </tr>
	  	<tr class="jiange">
	         <td><b>�ɷѽ�</b></td>
	         <td colspan="3">
			     		<input name="payMoneyTxt"  id="payMoneyTxt" style="border:none" style="ime-mode:disabled" onpaste="return !clipboardData.getData('text').match(/\D/)" ondragenter="return false" type="text" value="<%=totalFee%>" onKeyPress="return isKeyNumberdot(1)" onBlur="changepayMoneyTxt()" maxlength="20">
	         </td>
			 	 </tr>
	  	   <tr>
						<td align=center colspan=4 class="buttonbg">
								<input type="button" class="b_text" id=save2 name="submit2" onClick="ConfirmJsp()" value="ȷ��" >
						</td>
					</tr>
					<INPUT TYPE="hidden" name="total_date" value="">
					<INPUT TYPE="hidden" name="payAccept" value="">
					<INPUT TYPE="hidden" name="payNote" value="">
					<INPUT TYPE="hidden" name="print_type" value="">
					<INPUT TYPE="hidden" name="print_com" value="">
								</form>
				</table>
				
			</div>
<script language="javaScript">

	$(document).ready(function ()
	{
      loadFeeInfo();
			
	});
			
/*
  * �������ɽ���
*/

function loadFeeInfo()
{
	var innerStr = "";
 	if(parseInt('<%=result5.length%>')>0){
		innerStr +='<table width=100% border="1">';
		innerStr +='<tr align="center">';
		innerStr +='<th class="title">ѡ��</th>';
		innerStr +='<th class="title">�������</th>';
		innerStr +='<th class="title">Ƿ����</th>';
		innerStr +='<th class="title">Ƿ�ѽ��</th>';
		innerStr +='<th class="title">���ɽ�</th>';
		innerStr +='</tr>'
		<%for(int i=0;i<result5.length;i++)
		{%>

			innerStr += '<tr align="center">';	
			innerStr +='<td><input type="checkbox" name="check_id" id="check_id"  value="'+'<%=result5[i][2].trim() + "|" + result5[i][3].trim()%>'+'" disabled checked="true"></td>';
			innerStr +='<td>'+'<%=result5[i][0]%>'+'</td>';
			innerStr +='<td>'+'<%=result5[i][1]%>'+'</td>';
	    innerStr +='<td>'+'<%=result5[i][2]%>'+'</td>';
	    innerStr +='<td>'+'<%=result5[i][4]%>'+'</td>';
			innerStr +='</tr>';
		<%}%>
	 innerStr +='</table>';
  }else{
  	$("#payTr").attr('align','center');
  	innerStr = "�ú���û��Ƿ����Ϣ";
   }
  
  if('<%=Delay_Favourable%>'=="readonly")
  {
  	 $("#delayRate").attr('readOnly','true');
  	 $("#delayRate").attr('style','background:transparent;border:0pt');
  }
  if('<%=Predel_Favourable%>'=="readonly")
  {
  	 $("#remonthRate").attr('readOnly','true');
  	  $("#remonthRate").attr('style','background:transparent;border:0pt');
  }
 	$("#payTr").empty(); 
	$("#payTr").html(innerStr);
	$("#payMoneyTxt").select();

	 var myPacket = new AJAXPacket("/npage/portal/quickPayFee/getContractNoInfo.jsp","���ڻ�ȡ��Ϣ���Ժ򡭡�");
	 myPacket.data.add("retType","getContractNoInfo");
	 myPacket.data.add("phoneNo","<%=phoneNo%>");
	 core.ajax.sendPacket(myPacket,doProcess);
	 myPacket=null;
}
function conNoChange()
{
	$("#quickPayFee").load("fquickPay.jsp?contractNo="+document.layer4_form.contract_no.value+"&idNo=<%=idNo%>");
}	

function CheckRate() 
{

	 	 var derate = 1;	 
	 if (document.layer4_form.delayRate.value != "") {
	    derate = parseFloat(document.layer4_form.delayRate.value);
        if (derate > 1) {
		   if (derate > document.layer4_form.delay_fee.value) {
		       rdShowMessageDialog("���ܴ������ɽ��",0);
               document.layer4_form.delayRate.value = "";
			   document.layer4_form.delayRate.focus();
		   } else {
			   derate = derate/document.layer4_form.delay_fee.value;
		   }
	    }
	 }

	 var remonthrate = 1;
	 if (document.layer4_form.remonthRate.value != "") {
	    remonthrate = parseFloat(document.layer4_form.remonthRate.value);
        if (remonthrate > 1) {
		   if (remonthrate > document.layer4_form.remonth_fee.value) {
		       rdShowMessageDialog("���ܴ��ڲ��������",0);
               document.layer4_form.remonthRate.value = "";
			   document.layer4_form.remonthRate.focus();
		   } else {
		       remonthrate = remonthrate/document.layer4_form.remonth_fee.value;
		   }
	    }
	 }

	 document.layer4_form.delayRate.value = parseFloat(derate).toFixed(2);
	 document.layer4_form.remonthRate.value = parseFloat(remonthrate).toFixed(2);
     
	 //ĳ���ֻ����ɽ��Żݺ�Ӧ��
	 //var checkIdObj = eval("document.layer4_form.check_id");
	 var checkIdObj = document.getElementsByName("check_id");
     
	 var paymoney = 0;
	 if (checkIdObj != undefined) {
	     if (checkIdObj.length == undefined) {
		     if(checkIdObj.checked) {
			     owe_fee = parseFloat(checkIdObj.value.split("|")[0]);
			     delay_fee = parseFloat(checkIdObj.value.split("|")[1]);

				 paymoney += owe_fee + delay_fee*(1-derate);
			 }
		 } else {
	          for (i=0; i<checkIdObj.length; i++) {
	 	         if(checkIdObj[i].checked) {
	                 owe_fee = parseFloat(checkIdObj[i].value.split("|")[0]);
			         delay_fee = parseFloat(checkIdObj[i].value.split("|")[1]);
		    
			         paymoney += owe_fee + delay_fee*(1-derate);
		         }
	          }	 
		 }         
     }
     
     

	 remonth_fee = parseFloat(document.layer4_form.remonth_fee.value);
     prepay_fee = parseFloat(document.layer4_form.prepay_fee.value);
     
	 paymoney += remonth_fee*(1-remonthrate) - prepay_fee;

	 if (parseFloat(paymoney) < 0) {
	     paymoney = 0.00;
	 }
     
	 document.layer4_form.payMoneyTxt.value = parseFloat(paymoney).toFixed(2);
	 document.layer4_form.min_pay.value = parseFloat(paymoney).toFixed(2);
}
function doProcess(packet)
{
	  var retType = packet.data.findValueByName("retType");		
		var retCode = packet.data.findValueByName("retCode");
		var retMsg = packet.data.findValueByName("retMsg");		
		if(retType=='getContractNoInfo')
		{
			var backArrMsg = packet.data.findValueByName("backArrMsg");
			var optionName = "";
			var optionValue = "";	
			//var myEle;
      var strOption = "";
			if(backArrMsg!=null)
			{				
        document.layer4_form.contract_no.length = 0;
				for(var i=0;i<backArrMsg.length;i++)
				{
					optionValue = backArrMsg[i][0];
				  optionName = backArrMsg[i][0] + "~" + backArrMsg[i][1]+"("+backArrMsg[i][2]+")";
				  
				  strOption = strOption + "<option value='" + optionValue + "'  " 
                      + ">" + optionName + "</option>";				
				}
				$("#contract_no").append(strOption);
				document.layer4_form.contract_no.value = '<%=contractNo%>';
			}
		}
    if(retType=='quickPayCfm')
    {
    	if(retCode=='000000')
    	{
    		var paySeq = packet.data.findValueByName("paySeq");
    		var total_date = packet.data.findValueByName("totalDate");
    		var payNote = packet.data.findValueByName("payNote");
    			document.layer4_form.payAccept.value = paySeq;
	        document.layer4_form.total_date.value = total_date;
	        document.layer4_form.payNote.value = payNote;
    		var needPrint = packet.data.findValueByName("needPrint");
    		 rdShowMessageDialog("��ͨ�ɷѳɹ�,��ѡ���ӡ������",2);
				 if(needPrint=="true"){
					showPrintTypeWindow(); 
				 }		
    	}
    	else{
			rdShowMessageDialog("��ѯ����!<br>������룺" + retCode + "," + "������Ϣ��" + retMsg + "��",0);
      }
    }
}
//ѡ���ӡ����
function showPrintTypeWindow() {
	var h=480;
	var w=650;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;

	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no";


	var returnValue = window.showModalDialog('/npage/portal/quickPayFee/quickPayFee_getPrintType.jsp',"",prop);

	var print_bill = returnValue[0];      //��Ʊ����
 	var print_billfee = returnValue[1];   //ͨ�ŷ��ʵ�
    
	document.layer4_form.print_type.value = print_bill;
	document.layer4_form.print_com.value = print_billfee;

	var params = "";
	params +="&contractno="+$("#contract_no").val();
	params +="&payAccept="+document.all.payAccept.value;
	params +="&workno="+'<%=workNo%>';
	params +="&total_date="+document.all.total_date.value;
	params +="&idNo="+'<%=idNo%>';
	params +="&print_type="+print_bill;
	params +="&print_com="+print_billfee;
	params +="&phoneNo="+'<%=phoneNo%>';
	params +="&payNote="+document.all.payNote.value;
  var path = "/npage/portal/quickPayFee/quickPayFeePrint.jsp?1=1";
  path +=params;
  var prop = "height=1000,width=1000,top=-100,left=-100,toolbar=no,menubar=no,scrollbars=no, resizable=no,location=no, status=no";
  var ret=window.open(path,"",prop); 
}
function ConfirmJsp()
{
	if($("#payMoneyTxt").val()!="")
	{
    var myPacket = new AJAXPacket("/npage/portal/quickPayFee/quickPayFeeCfm.jsp","�����ύ�����Ժ�......");
		myPacket.data.add("contract_no",$("#contract_no").val());
		myPacket.data.add("phoneTxt",$("#phoneTxt").val());
		myPacket.data.add("payMoneyTxt",$("#payMoneyTxt").val());
		myPacket.data.add("idNo","<%=idNo%>");
		myPacket.data.add("delayRate",$("#delayRate").val());
		myPacket.data.add("remonthRate",$("#remonthRate").val());
	
		core.ajax.sendPacket(myPacket,doProcess);
		myPacket=null;
    $("#payMoneyTxt").val("");
  }else
  	{
  	 rdShowMessageDialog("������ɷѽ��!",1);
  	 $("#payMoneyTxt").select();
  	 return false;
   }
}

	 $("#wait9").hide();	
	 
	 	function changepayMoneyTxt() {
    var payMoneyTxt = document.layer4_form.payMoneyTxt;

    if(payMoneyTxt.value =="") {
        document.layer4_form.payMoneyTxt.value = "0.00";
	}

	if (!forMoney(payMoneyTxt,"1")) {
		 rdShowMessageDialog("�ɷѽ�����Ϊ���֣�");
     $("#payMoneyTxt").select();
     return false;
	}
}

</script>
