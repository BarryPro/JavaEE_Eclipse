<%
/********************
 version v2.0
 ������: si-tech
 update sunaj at 2009.9.3
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html  xmlns="http://www.w3.org/1999/xhtml">

<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page language="java" import="java.sql.*" %>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.boss.common.viewBean.comImpl"%>
<%@ page import="com.sitech.boss.s1210.pub.Pub_lxd"%>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="com.sitech.boss.spubcallsvr.viewBean.SPubCallSvrImpl"%>
<%@ page import="java.io.*"%>

<%
  String opCode = request.getParameter("opcode");
  String opName = "Ԥ�滰����TD����̻�����";
  String iPhoneNo = request.getParameter("srv_no");
	  /**** ningtn add for pos start ****/
	  String  payType="",Response_time="",TerminalId="",Rrn="",Request_time="";
	  /**** ningtn add for pos end ****/
  String loginNo = (String)session.getAttribute("workNo");
  String orgCode = (String)session.getAttribute("orgCode");

  //String paraStr[]=new String[1];
  //String prtSql="select to_char(sMaxSysAccept.nextval) from dual";
  //paraStr[0]=(((String[][])co1.fillSelect(prtSql))[0][0]).trim();
%>
	<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="phone" routerValue="<%=iPhoneNo%>"  id="paraStr"/>
<%

  String  retFlag="",retMsg="";
  String  bp_name="",sm_code="",family_code="",rate_code="",bigCust_flag="",sm_name="";
  String  rate_name="",bigCust_name="",next_rate_code="",next_rate_name="",back_rate_code="",back_rate_name="",lack_fee="";
  String  total_prepay="",bp_add="",cardId_type="", cardId_no="", cust_id="",cust_belong_code="";
  String  group_type_code="",group_type_name="",imain_stream="",next_main_stream="",hand_fee="";
  String  favorcode="",card_no="",print_note="",mon_base_fee="";
  String  sale_code="",market_price="",sale_name="",type_name="",brand_name="";
  String  base_fee="",free_fee="",sale_price="";
  String  active_term="",consume_term="",price="",all_gift_price="";

  String iLoginNoAccept = request.getParameter("backaccept");
  //String iOrgCode = request.getParameter("iOrgCode");
  String iOpCode = request.getParameter("opcode");
  SPubCallSvrImpl co = new SPubCallSvrImpl();
	String  inputParsm [] = new String[5];
	inputParsm[0] = iPhoneNo;
	inputParsm[1] = loginNo;
	inputParsm[2] = orgCode;
	inputParsm[3] = iOpCode;
	inputParsm[4] = iLoginNoAccept;
	System.out.println("phoneNO === "+ iPhoneNo);

	//sunzx add at 20070904
  String sqlStr = "select res_info from wawarddata where flag = 'Y' and phone_no = '"+iPhoneNo+"'"+" and login_accept="+iLoginNoAccept ;
  String[] inParam = new String[2];
  inParam[0] = "select res_info from wawarddata where flag = 'Y' and phone_no =:phone_no and login_accept=:login_accept" ;
  inParam[1] = "phone_no=" + iPhoneNo + ",login_accept=" + iLoginNoAccept;
  //ArrayList retArray = co.sPubSelect("1",sqlStr);
%>
	<wtc:service name="TlsPubSelCrm" routerKey="phone" routerValue="<%=iPhoneNo%>" retcode="retCode1" retmsg="retMsg1" outnum="1">
	<wtc:param value="<%=inParam[0]%>"/>
	<wtc:param value="<%=inParam[1]%>"/>
	</wtc:service>
	<wtc:array id="result"  scope="end"/>
<%
  if(retCode1.equals("000000") && result.length>0)
  {
	  String awardName = result[0][0];
	  System.out.println("awardName2="+awardName);
	  if(!awardName.equals("")){
%>
	 <script language="JavaScript" >

	  rdShowMessageDialog("���û����ڴ���Ʒͳһ�����н���<%=awardName%>�콱������д���Ʒͳһ������������ȷ����Ʒ���");
		location='f8044_login.jsp?opCode=8044&opName=������ũ���������ֻ�Ӫ��';
		</script>
<%
		}
  }
	//sunzx add end

	String IMEINo="";
	sqlStr="select imei_no from wMachSndOprhis where phone_no ='"+iPhoneNo+"'"+
		    " and login_accept="+iLoginNoAccept;
	String[] inParamA = new String[2];
	inParamA[0] = "select imei_no from wMachSndOprhis where phone_no =:phone_no and login_accept=:login_accept" ;
	inParamA[1] = "phone_no=" + iPhoneNo + ",login_accept=" + iLoginNoAccept;
%>
	<wtc:service name="TlsPubSelCrm" routerKey="phone" routerValue="<%=iPhoneNo%>" retcode="retCode1" retmsg="retMsg1" outnum="1">
	<wtc:param value="<%=inParamA[0]%>"/>
	<wtc:param value="<%=inParamA[1]%>"/>
	</wtc:service>
	<wtc:array id="retArray"  scope="end"/>
<%
  if(retCode1.equals("000000") && retArray.length>0)
  {
	if(retArray!=null&& retArray.length > 0){
  	IMEINo = retArray[0][0];
  	System.out.println("IMEINo="+IMEINo);
  	}
  }
  //retList = co.callFXService("s7899Init", inputParsm, "39","phone",iPhoneNo);
%>
	<wtc:service name="s7899Init" routerKey="phone" routerValue="<%=iPhoneNo%>" retcode="retCode1" retmsg="retMsg1" outnum="46">
	<wtc:param value="<%=inputParsm[0]%>"/>
	<wtc:param value="<%=inputParsm[1]%>"/>
	<wtc:param value="<%=inputParsm[2]%>"/>
	<wtc:param value="<%=inputParsm[3]%>"/>
	<wtc:param value="<%=inputParsm[4]%>"/>
	</wtc:service>
	<wtc:array id="tempArr"  scope="end"/>
<%
  String errCode = retCode1;
  String errMsg = retMsg1;

	//co.printRetValue();
  if(tempArr.length==0)
  {
	   retFlag = "1";
	   retMsg = "s7899Init��ѯ���������ϢΪ��!<br>errCode: " + errCode + "<br>errMsg+" + errMsg;
  }
  else if(errCode.equals("000000") && tempArr.length>0)
  {

	    bp_name = tempArr[0][3];           //��������

	    bp_add = tempArr[0][4];            //�ͻ���ַ

	    sm_code = tempArr[0][11];         //ҵ�����

	    sm_name = tempArr[0][12];        //ҵ���������

	    hand_fee = tempArr[0][13];      //������

	    favorcode = tempArr[0][14];     //�Żݴ���

	    rate_code = tempArr[0][5];     //�ʷѴ���

	    rate_name = tempArr[0][6];    //�ʷ�����

	    next_rate_code = tempArr[0][7];//�����ʷѴ���

	    next_rate_name = tempArr[0][8];//�����ʷ�����

	    bigCust_flag = tempArr[0][9];//��ͻ���־

	    bigCust_name = tempArr[0][10];//��ͻ�����

	    lack_fee = tempArr[0][15];//��Ƿ��

	    total_prepay = tempArr[0][16];//��Ԥ��

	    cardId_type = tempArr[0][17];//֤������

	    cardId_no = tempArr[0][18];//֤������

	    cust_id = tempArr[0][19];//�ͻ�id

	    cust_belong_code = tempArr[0][20];//�ͻ�����id

	    group_type_code = tempArr[0][21];//���ſͻ�����

	    group_type_name = tempArr[0][22];//���ſͻ���������

	    imain_stream = tempArr[0][23];//��ǰ�ʷѿ�ͨ��ˮ

	    next_main_stream = tempArr[0][24];//ԤԼ�ʷѿ�ͨ��ˮ

	    market_price = tempArr[0][25];//�г���

	    sale_code = tempArr[0][26];//Ӫ������

	    sale_name = tempArr[0][27];//��������

	    price = tempArr[0][28];//TD����̻���

	    base_fee = tempArr[0][29];//���ͻ���

	    consume_term = tempArr[0][30];//������������

	    free_fee = tempArr[0][31];//������

	    active_term = tempArr[0][32];//��������������

	    mon_base_fee = tempArr[0][33];//�µ���

	    all_gift_price=tempArr[0][34];//������

	    sale_price = tempArr[0][35];//Ԥ���ܽ��

	    back_rate_code = tempArr[0][36];//�������ʷ�

	    back_rate_name = tempArr[0][37];//�������ʷ�����

	    print_note = tempArr[0][38];//����

	    type_name = tempArr[0][39];//�ֻ�����

	    brand_name = tempArr[0][40];//�ֻ�Ʒ��
	    
	    /*** ningtn add for pos start ***/	   	 
				payType       = tempArr[0][41].trim();
				Response_time = tempArr[0][42].trim();
				TerminalId    = tempArr[0][43].trim();
				Rrn           = tempArr[0][44].trim();
				Request_time  = tempArr[0][45].trim();
				System.out.println("--------------------------payType-----------------"+payType);
				System.out.println("--------------------------Response_time-----------"+Response_time);
				System.out.println("--------------------------TerminalId--------------"+TerminalId);
				System.out.println("--------------------------Rrn---------------------"+Rrn);
				System.out.println("--------------------------Request_time------------"+Request_time);
			/*** ningtn add for pos end ***/
	 }
	else{%>
	 <script language="JavaScript">
	<!--
  	 rdShowMessageDialog("������룺<%=errCode%>������Ϣ��<%=errMsg%>",0);
  		//window.location="f7898_login.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=iPhoneNo%>";
  	 history.go(-1);
  	//-->
  </script>
<%
	}
%>

<head>
<title>Ԥ�滰����TD����̻�����</title>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>

<script language="JavaScript">
<!--

  onload=function()
  {

  	document.all.phoneNo.focus();
   	self.status="";
   }


  function frmCfm()
  {
  		 //getAfterPrompt();
         if(!checkElement(document.all.phoneNo)) return;
         document.frm.iAddStr.value=document.frm.backaccept.value+"|"+document.frm.Sale_Code.value+"|"+document.all.Brand_Name.value+"|"+
	                        document.all.Type_Name.value+"|"+document.frm.Sale_Price.value+"|"+document.frm.Base_Fee.value+"|"+
	                        document.frm.Consume_Term.value+"|"+document.frm.Free_Fee.value+"|"+document.frm.Active_Term.value+"|"+
	                        document.frm.Price.value+"|"+document.frm.Market_Price.value+"|"+document.frm.IMEINo.value+"|";
	      //alert(document.frm.iAddStr.value);
	     document.frm.commit.disabled=true;
         frm.submit();
  }
//-->
</script>

</head>

<body>
	<form name="frm" method="post" action="f1270_3.jsp?activePhone=<%=iPhoneNo%>" onKeyUp="chgFocus(frm)">
		<%@ include file="/npage/include/header.jsp" %>   
		<div class="title">
			<div id="title_zi"><%=opName%></div>
		</div>
		<input name="oSmCode" type="hidden" class="button" id="oSmCode" value="<%=sm_code%>">
		<input name="oModeCode" type="hidden" class="button" id="oModeCode" value="<%=rate_code%>">
		<input type="hidden" name="back_flag_code" value="">
		<input type="hidden" name="loginAccept" value="<%=paraStr%>">
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
			<input name="oModeName" type="text" size='40' class="InputGrey" id="oModeName" value="<%=rate_name%>" readonly>
		</td>
	</tr>
	<tr>
		<td class="blue">�ʺ�Ԥ��</td>
		<td>
			<input name="oPrepayFee" type="text" class="InputGrey" id="oPrepayFee" value="<%=total_prepay%>" readonly>
		</td>
		<td class="blue">Ӫ������</td>
		<td>
			<input type="text" name="Sale_Code" value="<%=sale_code%>" readonly class="InputGrey">
			<input name="oMarkPoint" type="hidden" class="InputGrey" id="oMarkPoint" value="" readonly>
			<input name="Market_Price" type="hidden" class="InputGrey" id="Market_Price" value="<%=market_price%>" readonly>
			<input name="All_Gift_Price" type="hidden" class="InputGrey" id="All_Gift_Price" value="" readonly>
		</td>
	</tr>
	<tr>
		<td class="blue">TD����̻�Ʒ��</td>
		<td>
			<input name="Brand_Name" type="text" class="InputGrey" id="Brand_Name" value="<%=brand_name%>" readonly>
		</td>
		<td class="blue">TD����̻�����</td>
		<td>
			<input name="Type_Name" type="text" class="InputGrey" id="Type_Name" value="<%=type_name%>" readonly>
		</td>
	</tr>
	<tr>
		<td class="blue">��TD����̻���</td>
		<td>
			<input name="Price" type="text" class="InputGrey" id="Price" value="<%=price%>" readonly>
		</td>
		<td class="blue">���ͻ���</td>
		<td>
			<input name="Base_Fee" type="text" class="InputGrey" id="Base_Fee" value="<%=base_fee%>" readonly >
		</td>
	</tr>
	<tr>
		<td class="blue">������������</td>
		<td>
			<input name="Consume_Term" type="text" class="InputGrey" id="Consume_Term" value="<%=consume_term%>"  readonly>
		</td>
		<td class="blue">����������</td>
		<td>
			<input name="Free_Fee" type="text" class="InputGrey" id="Free_Fee"  value="<%=free_fee%>" readonly>
		</td>
	</tr>
	<tr>
		<td class="blue">��������������</td>
		<td>
			<input name="Active_Term" type="text" class="InputGrey" id="Active_Term"  value="<%=active_term%>" readonly>
		</td>
 		<td class="blue">Ԥ���ܽ��</td>
		<td>
			<input name="Sale_Price" type="text" class="InputGrey" id="Sale_Price" value="<%=sale_price%>"  readonly>
		</td>
	</tr>
	<tr>
		<td colspan="4" id="footer">
		<div align="center">
        &nbsp;
		<input name="commit" id="commit" type="button" class="b_foot"   value="��һ��" onClick="frmCfm();">
        &nbsp;
        <input name="reset" type="reset" class="b_foot" value="���" >
        &nbsp;
        <input name="close" onClick="removeCurrentTab();" type="button" class="b_foot" value="�ر�">
        &nbsp;
		</div>
	</td>
	</tr>
	</table>

	    <input type="hidden" name="iOpCode" value="7899">
	    <input type="hidden" name="opName" value="<%=opName%>">
	    <input type="hidden" name="loginNo" value="<%=loginNo%>">
	    <input type="hidden" name="orgCode" value="<%=orgCode%>">
	    <input type="hidden" name="IMEINo" value="<%=IMEINo%>" >
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
		<input type="hidden" name="i16"  value="<%=rate_code%>">
		<input type="hidden" name="ip" 	value="<%=back_rate_code%>">

		<input type="hidden" name="belong_code" value="<%=cust_belong_code%>">
		<input type="hidden" name="print_note" value="<%=print_note%>">
		<input type="hidden" name="iAddStr" value="">

		<input type="hidden" name="i1" value="<%=iPhoneNo%>">
		<input type="hidden" name="i4" value="<%=bp_name%>">
		<input type="hidden" name="i5" value="<%=bp_add%>">
		<input type="hidden" name="i6" value="<%=cardId_type%>">
		<input type="hidden" name="i7" value="<%=cardId_no%>">
		<input type="hidden" name="i8" value="<%=sm_code%>"+"--"+"<%=sm_name%>">

		<input type="hidden" name="ipassword" value="">
		<input type="hidden" name="group_type" value="<%=group_type_code%>--<%=group_type_name%>">
		<input type="hidden" name="ibig_cust" value="<%=bigCust_flag%>--<%=bigCust_name%>">
		<input type="hidden" name="do_note" value="<%=iPhoneNo%>"+"Ԥ�滰����TD����̻�����">
		<input type="hidden" name="favorcode" value="<%=favorcode%>">
		<input type="hidden" name="maincash_no" value="<%=rate_code%>">
		<input type="hidden" name="imain_stream" value="<%=imain_stream%>">
		<input type="hidden" name="next_main_stream" value="<%=next_main_stream%>">

		<input type="hidden" name="i18" value="<%=next_rate_code%>"+"--"+"<%=next_rate_name%>">
		<input type="hidden" name="i19" value="<%=hand_fee%>">
		<input type="hidden" name="i20" value="<%=hand_fee%>">

		<input type="hidden" name="beforeOpCode" value="7898">
		<input type="hidden" name="backaccept" value="<%=iLoginNoAccept%>">

		<input type="hidden" name="return_page" value="/npage/bill/f7898_login.jsp?opName="Ԥ�滰����TD����̻�"&opCode=7898&activePhone=<%=iPhoneNo%>">	
		<input type="hidden" name="ipAddr" value="<%=(String)session.getAttribute("ipAddr")%>" >
		
		<!-- ningtn add at 20100520 for POS�ɷ�����*****start*****-->
		<input type="hidden" name="payType" value="<%=payType%>" >
		<input type="hidden" name="Response_time" value="<%=Response_time%>" >
		<input type="hidden" name="TerminalId" value="<%=TerminalId%>" >
		<input type="hidden" name="Rrn" value="<%=Rrn%>" >
		<input type="hidden" name="Request_time" value="<%=Request_time%>" >
		<!-- ningtn add at 20100520 for POS�ɷ�����*****end*****-->	
		
		<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>
