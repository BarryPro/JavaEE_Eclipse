<%
/********************
 version v2.0
 ������: si-tech
 author: liujian at 2011.12.21
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html  xmlns="http://www.w3.org/1999/xhtml">

<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%
	String opCode = request.getParameter("opCode");
	String opName = request.getParameter("opName");
	String iLoginNoAccept = request.getParameter("backaccept");
	String iPhoneNo = activePhone;
	System.out.println("---------liujian-------iPhoneNo=" + iPhoneNo + "--------iLoginNoAccept=" + iLoginNoAccept);

  String loginNo = (String)session.getAttribute("workNo");
  String loginNoPass = (String)session.getAttribute("password");
  String orgCode = (String)session.getAttribute("orgCode");
  String regionCode = (String)session.getAttribute("regCode");
%>
		<wtc:sequence name="TlsPubSelCrm" key="sMaxSysAccept" routerKey="regioncode" 
			routerValue="<%=regionCode%>"  id="loginAccept" />
<%
  /**********************************************liujian se529 ������ʼ********************************************/
  
  String  retFlag="",retMsg="";
  /**** tianyang add for pos start ****/
  String  payType="",Response_time="",TerminalId="",Rrn="",Request_time="";
  /**** tianyang add for pos end ****/
 
  String bp_name="",bp_add="",oldMode="",oldName="",group_type_code="",group_type_name="",sm_code="",sm_name="";
	String prepay_Fee="",id_name="",id_iccid="",cust_id="",belong_code="",imain_stream="",next_main_stream="",modeCode="";
	String modeName="",print_note="",next_rate_code="",next_rate_name="",handFee="",favorcode="",saleCode="",machPrice="";
	String resName="",prepayFee="",cashPay="",brandName="",baseFee="",prepay_Gift="",consumeTerm="",ativeTer="",sale_name="";
  
  /*
  // ��������
  String bp_name="123",bp_add="123",oldMode="123",oldName="123",group_type_code="123",group_type_name="123",sm_code="123",sm_name="123";
	String prepay_Fee="123",id_name="123",id_iccid="123",cust_id="123",belong_code="123",imain_stream="123",next_main_stream="123",modeCode="123";
	String modeName="123",print_note="123",next_rate_code="123",next_rate_name="123",handFee="123",favorcode="123",saleCode="123",machPrice="123";
	String resName="123",prepayFee="123",cashPay="123",brandName="123",baseFee="123",prepay_Gift="123",consumeTerm="123",ativeTer="123";
 	String sale_name="�Ա�����Լ�ƻ�";
 	*/
 /* 
  	inputParsm[0]   ��ˮ
		inputParsm[1]   ������ʶ(��������01-BOSS��02-����Ӫҵ����03-����Ӫҵ����04-����Ӫҵ����05-��ý���ѯ����06-10086)
		inputParsm[2]   ��������	
		inputParsm[3]   ����
		inputParsm[4]   ��������
		inputParsm[5]   �ƶ�����
		inputParsm[6]   ��������
		inputParsm[7]   ����ʱҵ�������ˮ
 */
	String  inputParsm [] = new String[8];
	inputParsm[0] = loginAccept;
	inputParsm[1] = "01";
	inputParsm[2] = opCode;
	inputParsm[3] = loginNo;
	inputParsm[4] = loginNoPass;
	inputParsm[5] = iPhoneNo;
	inputParsm[6] = "";
	inputParsm[7] = iLoginNoAccept;
	System.out.println("phoneNO === "+ iPhoneNo);
	 
  /**********************************************liujian se529 ��������********************************************/
%>
	
	<wtc:service name="se506Qry" routerKey="phone" routerValue="<%=iPhoneNo%>" retcode="retCodeQry" retmsg="retMsgQry" outnum="42">
		<wtc:param value="<%=inputParsm[0]%>"/>
		<wtc:param value="<%=inputParsm[1]%>"/>
		<wtc:param value="<%=inputParsm[2]%>"/>
		<wtc:param value="<%=inputParsm[3]%>"/>
		<wtc:param value="<%=inputParsm[4]%>"/>
		<wtc:param value="<%=inputParsm[5]%>"/>
		<wtc:param value="<%=inputParsm[6]%>"/>
		<wtc:param value="<%=inputParsm[7]%>"/>
	</wtc:service>
	<wtc:array id="tempArr"  scope="end"/>
	
	
<%
 
  String errCode = retCodeQry;
  String errMsg = retMsgQry;
  System.out.println("----------lj---------");
  if(errCode.equals("000000"))
  {
  		
  		bp_name    		= tempArr[0][1];   //��������
	    bp_add     		= tempArr[0][2];   //�ͻ���ַ
	    oldMode    		= tempArr[0][3];   //��ǰ�ʷѴ���
			oldName 	 		= tempArr[0][4]; 	 //��ǰ�ʷ�����
			group_type_code  = tempArr[0][5];//���ſͻ�����
	    group_type_name  = tempArr[0][6];//���ſͻ���������
	    sm_code 	 		= tempArr[0][7];   //ҵ��������
	    sm_name 	 		= tempArr[0][8];   //ҵ���������
			prepay_Fee 		= tempArr[0][10];  //����Ԥ��
			id_name		 		= tempArr[0][11];  //֤������
			id_iccid	 		= tempArr[0][12];  //֤������
			cust_id       = tempArr[0][13];  //�ͻ�id 
			belong_code		= tempArr[0][14];  //����
			imain_stream 	= tempArr[0][15];
			next_main_stream = tempArr[0][16];
			print_note 			 = tempArr[0][19];
			next_rate_code   = tempArr[0][21];//�����ʷѴ���
	    next_rate_name   = tempArr[0][22];//�����ʷ�����
			handFee 				 = tempArr[0][23]; //������
			favorcode				 = tempArr[0][24]; //�Żݴ���
			saleCode	 		= tempArr[0][30];  //���۴���
			machPrice  		= tempArr[0][31];  //������
			resName				= tempArr[0][32];  //�����ͺ�  
			prepayFee 		= tempArr[0][33]; //����Ԥ��
			cashPay       = tempArr[0][34];  //�ɷѺϼ� 
			brandName			= tempArr[0][35];  //�ֻ�Ʒ��
			resName   		= tempArr[0][36];  //�ֻ��ͺ�
			baseFee       = tempArr[0][37];  //����Ԥ��
			prepay_Gift 	= tempArr[0][38];  //�Ԥ��
			consumeTerm  	= tempArr[0][39];//��������
			ativeTer 		  = tempArr[0][40];//�������
			sale_name		  = tempArr[0][41];//�׶λ����
     
     
     
		  payType       = tempArr[0][25].trim();
		  Response_time = tempArr[0][26].trim();
		  TerminalId    = tempArr[0][27].trim();
		  Rrn           = tempArr[0][28].trim();
		  Request_time  = tempArr[0][29].trim();
	 	 
		  System.out.println("--------------------------payType-----------------"+payType);
		  System.out.println("--------------------------Response_time-----------"+Response_time);
		  System.out.println("--------------------------TerminalId--------------"+TerminalId);
		  System.out.println("--------------------------Rrn---------------------"+Rrn);
		  System.out.println("--------------------------Request_time------------"+Request_time);

	 }
	else{%>
	 <script language="JavaScript">
  	rdShowMessageDialog("������룺<%=errCode%>������Ϣ��<%=errMsg%>",0);
  		window.location="se528_login.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=iPhoneNo%>";
  </script>
<%
	}
%>
<head>
<title><%=opName%></title>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>

<script language="JavaScript">
	$(function() {
		var sale_name = '<%=sale_name%>';
		if(sale_name != null && sale_name != "") {
				$('#sale_name_span').text(sale_name + '--');
				$('#sale_name').val(sale_name + '--');
			}
	})
  function frmCfm(){
     if(!checkElement(document.all.phoneNo)) return;
     	/*
     		������ˮ��Ӫ������|Ʒ������|Ʒ���ͺţ��û��ɷѺϼƣ�����Ԥ����������ޣ��Ԥ���������ޣ�������Ԥ������0��imei���
				iOldAccept|iSaleCode|iBrandName|iTypeName|iSalePrice|iBaseFee|iConsumeTerm|iFreeFee|iActiveTerm|iPrice|iMarketPrice|iImeiNo|
				109774294520|10165615|M-;M-*M-NM-*|F561|240|240|12|0|0|0|0|868597000046173|
     	*/
     	//����ôƴ���ˣ�Ч�ʵͣ�������
    	var arr = [];
    	arr.push('<%=iLoginNoAccept%>');
    	arr.push('|');
    	arr.push('<%=saleCode%>');
    	arr.push('|');
    	arr.push('<%=brandName%>');
    	arr.push('|');
    	arr.push('<%=resName%>');
    	arr.push('|');
    	arr.push('<%=cashPay%>');
    	arr.push('|');    	
    	arr.push('<%=baseFee%>');
    	arr.push('|');
    	arr.push('<%=consumeTerm%>');
    	arr.push('|');
    	arr.push('<%=prepay_Gift%>');
    	arr.push('|');
    	arr.push('<%=ativeTer%>');
    	arr.push('|');
    	arr.push('<%=machPrice%>');
    	arr.push('|');
    	arr.push('0');
    	arr.push('|');
    	arr.push('0');
    	arr.push('|');
      $('input[name="iAddStr"]').val(arr.join(''));
      frm.submit();
}
</script>

</head>

<body>
	<form name="frm" method="post" action="../bill/f1270_3.jsp?activePhone=<%=iPhoneNo%>" onKeyUp="chgFocus(frm)">
		<%@ include file="/npage/include/header.jsp" %>
		<input type="hidden" name="opName" value="<%=opName%>">
		<div class="title">
			<div id="title_zi"><span id="sale_name_span"></span><%=opName%></div>
		</div>

	<table cellspacing="0">
		<tr>
			<td class="blue">�ֻ�����</td>
      <td>
				<input class="InputGrey"  type="text" v_must="1" v_type="mobphone" v_must=1 name="phoneNo" id="phoneNo" onBlur="if(this.value!=''){if(checkElement(document.all.phoneNo)==false){return false;}}" maxlength=11 index="3" value="<%=iPhoneNo%>" readonly >
			</td>
			<td class="blue">��������</td>
			<td>
				<input name="oCustName" type="text" class="InputGrey" id="oCustName" value="<%=bp_name%>" readonly>
			</td>
		</tr>
		<tr>
			<td class="blue">ҵ��Ʒ��</td>
      <td>
				<input name="oSmName" type="text" class="InputGrey" id="oSmName" value="<%=sm_name%>" readonly>
			</td>
      <td class="blue">�ʷ�����</td>
      <td>
				<input name="oModeName" type="text" class="InputGrey" id="oModeName" value="<%=oldName%>" readonly>
			</td>
		</tr>
		<tr>	
			<td class="blue">�ֻ�Ʒ��</td>
      <td>
				<input name="brandName" type="text" class="InputGrey" id="brandName" value="<%=brandName%>" readonly>
			</td>
			<td class="blue">�ֻ��ͺ�</td>
      <td>
				<input name="resName" type="text" class="InputGrey" id="resName" value="<%=resName%>" readonly>
			</td>
		</tr>
		<tr>
			<td class="blue">������Ԥ���</td>
      <td>
				<input name="machPrice" type="text" class="InputGrey" id="machPrice" value="<%=machPrice%>" readonly>
			</td>
			<td class="blue">�Ԥ��</td>
      <td>
				<input name="prepay_Gift" type="text" class="InputGrey" id="prepay_Gift" value="<%=prepay_Gift%>" readonly>
			</td>
		</tr>
		<tr>
			<td class="blue">ҵ����Ч��</td>
      <td>
				<input name="consumeTerm" type="text" class="InputGrey" id="consumeTerm" value="<%=consumeTerm%>" readonly>
			</td>

			<td class="blue">����Ԥ��</td>
      <td>
				<input name="baseFee" type="text" class="InputGrey" id="baseFee" value="<%=baseFee%>" readonly>
			</td>
		</tr>
		<tr>
			<td class="blue">�ɷѺϼ�</td>
      <td colspan="3">
				<input name="cashPay" type="text" class="InputGrey" id="cashPay" value="<%=cashPay%>" readonly>
			</td>
		</tr>
		<tr>  	
		<tr>
			<td colspan="4" id="footer">
				<div align="center">
                &nbsp;
				<input name="commit" id="commit" type="button" class="b_foot"   value="��һ��" onClick="frmCfm();">
                &nbsp;
                <input name="close" onClick="removeCurrentTab();" type="button" class="b_foot" value="�ر�">
                &nbsp;
				</div>
			</td>
		</tr>
	</table>

			<input type="hidden" name="iOpCode" value="<%=opCode%>">
			<input type="hidden" name="loginNo" value="<%=loginNo%>">
			<input type="hidden" name="orgCode" value="<%=orgCode%>">
			<input type="hidden" name="sale_name" id="sale_name">
	    <!--���²�����Ϊ��f1270_3.jsp������Ĳ���
			i2:�ͻ�ID
			i16:��ǰ���ײʹ���
			ip:�������ײʹ���
			belong_code:belong_code
			print_note:��������

			i1:�ֻ�����
			i5:�ͻ���ַ
			i6:֤������
			i7:֤������
			i8:ҵ��Ʒ��

			ipassword:����
			group_type:���ſͻ����
			ibig_cust:��ͻ����
			do_note:�û���ע
			favorcode:�������Ż�Ȩ��
			maincash_no:�����ײʹ��루�ϣ�
			imain_stream:��ǰ���ʷѿ�ͨ��ˮ
			next_main_stream:ԤԼ���ʷѿ�ͨ��ˮ

			i18:�������ײ�
			i19:������
			i20:���������

			beforeOpCode:ԭҵ������op_code
			-->
			<input type="hidden" name="i2" value="<%=cust_id%>"> 
			<input type="hidden" name="i16"  value="<%=oldMode%>"> 
			<input type="hidden" name="ip" 	value="<%=next_rate_code%>"> 

			<input type="hidden" name="belong_code" value="<%=belong_code%>">  
			<input type="hidden" name="print_note" value="<%=print_note%>">
			<input type="hidden" name="iAddStr" value="">

			<input type="hidden" name="i1" value="<%=iPhoneNo%>">  
			<input type="hidden" name="i4" value="<%=bp_name%>">  
			<input type="hidden" name="i5" value="<%=bp_add%>">    
			<input type="hidden" name="i6" value="<%=id_name%>"> 
			<input type="hidden" name="i7" value="<%=id_iccid%>"> 
			<input type="hidden" name="i8" value="<%=sm_code+"--"+sm_name%>">	

			<input type="hidden" name="ipassword" value="">
			<input type="hidden" name="group_type" value="<%=group_type_code+"--"+group_type_name%>">  
			<input type="hidden" name="ibig_cust" value="<%=group_type_code+"--"+group_type_name%>">        
			<input type="hidden" name="do_note" value="<%=iPhoneNo+"--"+opName%>">                           
			<input type="hidden" name="favorcode" value="<%=favorcode%>"> 
			<input type="hidden" name="maincash_no" value="<%=oldMode%>"> 
			<input type="hidden" name="imain_stream" value="<%=imain_stream%>">
			<input type="hidden" name="next_main_stream" value="<%=next_main_stream%>"> 

			<input type="hidden" name="i18" value="<%=next_rate_code+"--"+next_rate_name%>">  
			<input type="hidden" name="i19" value="0">  
			<input type="hidden" name="i20" value="0">  


			<input type="hidden" name="beforeOpCode" value="<%=opCode%>">
			<input type="hidden" name="backaccept" value="<%=iLoginNoAccept%>"> 
			<input type="hidden" name="printAccept" value="<%=loginAccept%>">

			<input type="hidden" name="return_page" value="/npage/se528/se528_login.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=iPhoneNo%>">
			<input type="hidden" name="ipAddr" value="<%=(String)session.getAttribute("ipAddr")%>" >		
			
			<!-- tianyang add at 20100201 for POS�ɷ�����*****start*****-->
			<input type="hidden" name="payType" value="<%=payType%>" >
			<input type="hidden" name="Response_time" value="<%=Response_time%>" >
			<input type="hidden" name="TerminalId" value="<%=TerminalId%>" >
			<input type="hidden" name="Rrn" value="<%=Rrn%>" >
			<input type="hidden" name="Request_time" value="<%=Request_time%>" >
			<!-- tianyang add at 20100201 for POS�ɷ�����*****end*****-->
			
			<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>
