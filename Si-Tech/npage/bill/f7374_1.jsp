<%
/********************
 * version v2.0
 * ������: si-tech
 * update by qidp @ 2009-01-06
 ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" import="java.sql.*" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="java.io.*"%>

<%
    String opCode = "7374";
    String opName = "Ԥ���Ż���������Ӫ��������";
    String loginNo = (String)session.getAttribute("workNo");
    String loginName = (String)session.getAttribute("workName");
    String powerCode= (String)session.getAttribute("powerCode");
    String orgCode = (String)session.getAttribute("orgCode");
    String ip_Addr = (String)session.getAttribute("ipAddr");
    String regionCode = orgCode.substring(0,2);
    String loginNoPass = (String)session.getAttribute("password");

        //comImpl co1 = new comImpl();
    String paraStr[]=new String[1];
        //String prtSql="select to_char(sMaxSysAccept.nextval) from dual";
        //paraStr[0]=(((String[][])co1.fillSelect(prtSql))[0][0]).trim();

%>
    <wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="seq"/>
<%
    paraStr[0] = seq;
    System.out.println("sysAccept===   "+paraStr[0]);

    String  retFlag="",retMsg="";
    String  bp_name="",sm_code="",family_code="",rate_code="",bigCust_flag="",sm_name="";
    String  rate_name="",bigCust_name="",next_rate_code="",next_rate_name="",back_rate_code="",back_rate_name="",lack_fee="";
    String  total_prepay="",bp_add="",cardId_type="", cardId_no="", cust_id="",cust_belong_code="";
    String  group_type_code="",group_type_name="",imain_stream="",next_main_stream="",hand_fee="";
    String  favorcode="",card_no="",print_note="";
    String  sale_code="",sale_grade="",sale_name="";
    String  deposit_fee="",base_fee="",free_fee="";
    String  base_term="",free_term="",mon_base_fee="",prepay_fee="";

    String iPhoneNo = request.getParameter("srv_no");
    String iLoginNoAccept = request.getParameter("backaccept");
    //String iOrgCode = request.getParameter("iOrgCode");
    String iOpCode = request.getParameter("opcode");
    String[][] tempArr= new String[][]{};
    //SPubCallSvrImpl co = new SPubCallSvrImpl();
	String  inputParsm [] = new String[5];
	inputParsm[0] = iPhoneNo;
	inputParsm[1] = loginNo;
	inputParsm[2] = orgCode;
	inputParsm[3] = iOpCode;
	inputParsm[4] = iLoginNoAccept;
	System.out.println("phoneNO === "+ iPhoneNo);

    //ArrayList retList = new ArrayList();
    //retList = co.callFXService("s7374Init", inputParsm, "39","phone",iPhoneNo);
%>
    <wtc:service name="s7374Init" routerKey="phone" routerValue="<%=iPhoneNo%>" retcode="s7374InitCode" retmsg="s7374InitMsg" outnum="39">
        <wtc:param value="<%=inputParsm[0]%>"/>
        <wtc:param value="<%=inputParsm[1]%>"/>
        <wtc:param value="<%=inputParsm[2]%>"/>
        <wtc:param value="<%=inputParsm[3]%>"/>
        <wtc:param value="<%=inputParsm[4]%>"/>
    </wtc:service>
    <wtc:array id="s7374InitArr" scope="end" />
<%
  String errCode = s7374InitCode;
  String errMsg = s7374InitMsg;

	//co.printRetValue();
  if(s7374InitArr == null)
  {
	   retFlag = "1";
	   retMsg = "s7374Init��ѯ���������ϢΪ��!<br>errCode: " + errCode + "<br>errMsg+" + errMsg;
  }
  else
  {
	  if (errCode.equals("000000")){
	  //tempArr = (String[][])retList.get(3);
	  if(!(s7374InitArr[0][3].equals(""))){
	    bp_name = s7374InitArr[0][3];           //��������
	  }

	  //tempArr = (String[][])retList.get(4);
	  if(!(s7374InitArr[0][4].equals(""))){
	    bp_add = s7374InitArr[0][4];            //�ͻ���ַ
	  }

	  //tempArr = (String[][])retList.get(11);
	  if(!(s7374InitArr[0][11].equals(""))){
	    sm_code = s7374InitArr[0][11];         //ҵ�����
	  }

	  //tempArr = (String[][])retList.get(12);
	  if(!(s7374InitArr[0][12].equals(""))){
	    sm_name = s7374InitArr[0][12];        //ҵ���������
	  }

	  //tempArr = (String[][])retList.get(13);
	  if(!(s7374InitArr[0][13].equals(""))){
	    hand_fee = s7374InitArr[0][13];      //������
	  }

	  //tempArr = (String[][])retList.get(14);
	  if(!(s7374InitArr[0][14].equals(""))){
	    favorcode = s7374InitArr[0][14];     //�Żݴ���
	  }

	  //tempArr = (String[][])retList.get(5);
	  if(!(s7374InitArr[0][5].equals(""))){
	    rate_code = s7374InitArr[0][5];     //�ʷѴ���
	  }

	  //tempArr = (String[][])retList.get(6);
	  if(!(s7374InitArr[0][6].equals(""))){
	    rate_name = s7374InitArr[0][6];    //�ʷ�����
	  }

	  //tempArr = (String[][])retList.get(7);
	  if(!(s7374InitArr[0][7].equals(""))){
	    next_rate_code = s7374InitArr[0][7];//�����ʷѴ���
	  }
	  System.out.println("--------next_rate_code-----"+next_rate_code);

	  //tempArr = (String[][])retList.get(8);
	  if(!(s7374InitArr[0][8].equals(""))){
	    next_rate_name = s7374InitArr[0][8];//�����ʷ�����
	  }

	  //tempArr = (String[][])retList.get(9);
	  if(!(s7374InitArr[0][9].equals(""))){
	    bigCust_flag = s7374InitArr[0][9];//��ͻ���־
	  }

	  //tempArr = (String[][])retList.get(10);
	  if(!(s7374InitArr[0][10].equals(""))){
	    bigCust_name = s7374InitArr[0][10];//��ͻ�����
	  }

	  //tempArr = (String[][])retList.get(15);
	  if(!(s7374InitArr[0][15].equals(""))){
	    lack_fee = s7374InitArr[0][15];//��Ƿ��
	  }

	  //tempArr = (String[][])retList.get(16);
	  if(!(s7374InitArr[0][16].equals(""))){
	    total_prepay = s7374InitArr[0][16];//��Ԥ��
	  }

	  //tempArr = (String[][])retList.get(17);
	  if(!(s7374InitArr[0][17].equals(""))){
	    cardId_type = s7374InitArr[0][17];//֤������
	  }

	  //tempArr = (String[][])retList.get(18);
	  if(!(s7374InitArr[0][18].equals(""))){
	    cardId_no = s7374InitArr[0][18];//֤������
	  }

	  //tempArr = (String[][])retList.get(19);
	  if(!(s7374InitArr[0][19].equals(""))){
	    cust_id = s7374InitArr[0][19];//�ͻ�id
	  }

	  //tempArr = (String[][])retList.get(20);
	  if(!(s7374InitArr[0][20].equals(""))){
	    cust_belong_code = s7374InitArr[0][20];//�ͻ�����id
	  }

	  //tempArr = (String[][])retList.get(21);
	  if(!(s7374InitArr[0][21].equals(""))){
	    group_type_code = s7374InitArr[0][21];//���ſͻ�����
	  }

	  //tempArr = (String[][])retList.get(22);
	  if(!(s7374InitArr[0][22].equals(""))){
	    group_type_name = s7374InitArr[0][22];//���ſͻ���������
	  }

	  //tempArr = (String[][])retList.get(23);
	  if(!(s7374InitArr[0][23].equals(""))){
	    imain_stream = s7374InitArr[0][23];//��ǰ�ʷѿ�ͨ��ˮ
	  }

	  //tempArr = (String[][])retList.get(24);
	  if(!(s7374InitArr[0][24].equals(""))){
	    next_main_stream = s7374InitArr[0][24];//ԤԼ�ʷѿ�ͨ��ˮ
	  }

	  //tempArr = (String[][])retList.get(25);
	  if(!(s7374InitArr[0][25].equals(""))){
	    sale_grade = s7374InitArr[0][25];//�����ȼ�
	  }

	  //tempArr = (String[][])retList.get(26);
	  if(!(s7374InitArr[0][26].equals(""))){
	    sale_code = s7374InitArr[0][26];//��������
	  }

	  //tempArr = (String[][])retList.get(27);
	  if(!(s7374InitArr[0][27].equals(""))){
	    sale_name = s7374InitArr[0][27];//��������
	  }

	  //tempArr = (String[][])retList.get(28);
	  if(!(s7374InitArr[0][28].equals(""))){
	    deposit_fee = s7374InitArr[0][28];//��ѺԤ��
	  }

	  //tempArr = (String[][])retList.get(29);
	  if(!(s7374InitArr[0][29].equals(""))){
	    base_fee = s7374InitArr[0][29];//����Ԥ��
	  }

	  //tempArr = (String[][])retList.get(30);
	  if(!(s7374InitArr[0][30].equals(""))){
	    free_fee = s7374InitArr[0][30];//�Ԥ��
	  }

	  //tempArr = (String[][])retList.get(31);
	  if(!(s7374InitArr[0][31].equals(""))){
	    base_term = s7374InitArr[0][31];//������������
	  }

	  //tempArr = (String[][])retList.get(32);
	  if(!(s7374InitArr[0][32].equals(""))){
	    free_term = s7374InitArr[0][32];//���������
	  }

	  //tempArr = (String[][])retList.get(33);
	  if(!(s7374InitArr[0][33].equals(""))){
	    mon_base_fee = s7374InitArr[0][33];//�µ���
	  }

	  //tempArr = (String[][])retList.get(34);
	  if(!(s7374InitArr[0][34].equals(""))){
	    prepay_fee = s7374InitArr[0][34];//Ԥ���ܽ��
	  }

	  if(!(s7374InitArr[0][35].equals(""))){
	    back_rate_code = s7374InitArr[0][35];//�����ʷѴ���
	  }

	  if(!(s7374InitArr[0][36].equals(""))){
	    back_rate_name = s7374InitArr[0][36];//�����ʷ�����
	  }

	  //tempArr = (String[][])retList.get(37);
	  if(!(s7374InitArr[0][37].equals(""))){
	    print_note = s7374InitArr[0][37];//����
	  }
	 }
	  else{%>
	 <script language="JavaScript">
<!--
  	rdShowMessageDialog("������룺<%=errCode%>������Ϣ��<%=errMsg%>",0);
  	 history.go(-1);
  	//-->
  </script>
<%	 }
	}
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>Ԥ���Ż���������Ӫ�������� </title>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>


<script language="JavaScript">
<!--
  //core.loadUnit("debug");
  //core.loadUnit("rpccore");
  onload=function()
  {

  	document.all.phoneNo.focus();
   	//core.rpc.onreceive = doProcess;
   	self.status="";
   }

//--------1---------doProcess����----------------


  function frmCfm()
  {
         if(!checkElement(document.frm.phoneNo)) return;
 		document.frm.iAddStr.value=document.frm.Sale_Code.value+"|"+document.frm.Prepay_Fee.value+"|"+
	                        document.frm.Base_Fee.value+"|"+document.frm.Free_Fee.value+"|"+
	                        document.frm.Base_Term.value+"|"+document.frm.Free_Term.value+"|"+
	                        document.frm.Mon_Base_Fee.value+"|"+document.frm.backaccept.value+"|"+
	                        document.frm.Sale_Name.value+"|";;
         //alert(document.all.iAddStr.value);
         frm.submit();
  }

//-->
</script>

</head>

<body>
	<form name="frm" method="post" action="f1270_3.jsp" onKeyUp="chgFocus(frm)">     
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">ҵ����Ϣ </div>
</div>
		<input name="oSmCode" type="hidden" class="button" id="oSmCode" value="<%=sm_code%>">
		<input name="oModeCode" type="hidden" class="button" id="oModeCode" value="<%=rate_code%>">
		<input type="hidden" name="back_flag_code" value="">
		<input type="hidden" name="loginAccept" value="<%=paraStr[0]%>">

	<table cellspacing="0">
		<tr>
			<td class=blue>�ֻ�����</td>
            <td >
				<input class="InputGrey"  type="text" v_must="1" v_type="mobphone" v_must=1 name="phoneNo" id="phoneNo" onBlur="if(this.value!=''){if(checkElement(this)==false){return false;}}" maxlength=11 index="3" value="<%=iPhoneNo%>" readonly >
			</td>
			<td class="blue">��������</td>
			<td>
				<input name="oCustName" type="text" class="InputGrey" id="oCustName" value="<%=bp_name%>" readonly>
			</td>
		</tr>
		<tr >
			<td class="blue">ҵ��Ʒ�� </td>
                        <td>
				<input name="oSmName" type="text" class="InputGrey" id="oSmName" value="<%=sm_name%>" readonly>
			</td>
            <td class="blue">�ʷ����� </td>
            <td>
				<input name="oModeName" type="text" class="InputGrey" id="oModeName" value="<%=rate_name%>" readonly>
			</td>
		</tr>
		<tr>
			<td class="blue">
				�ʺ�Ԥ��
			</td>
            <td>
				<input name="oPrepayFee" type="text" class="InputGrey" id="oPrepayFee" value="<%=total_prepay%>" readonly>
			</td>
                     <td class="blue">
            	         ��������
                      </td>
                        <td>
            			<input type="text" class="InputGrey" name="Sale_Code" value="<%=sale_code%>">
				<input name="oMarkPoint" type="hidden" class="InputGrey" id="oMarkPoint" value="" readonly>
			</td>
		</tr>
		<tr>
			<td class="blue">
				��������
			</td>
            <td>
				<input name="Sale_Name" Size='40' type="text" class="InputGrey" id="Sale_Name" value="<%=sale_name%>" readonly>
				<input name="Base_Fee" type="hidden" class="InputGrey" id="Base_Fee" value="<%=base_fee%>" readonly>
				<input name="Base_Term" type="hidden" class="InputGrey" id="Base_Term" value="<%=base_term%>"   readonly>
				<input name="Mon_Base_Fee" type="hidden" class="InputGrey" id="Mon_Base_Fee" value="<%=mon_base_fee%>" readonly>
			</td>
	        <td class="blue">
            	�Ԥ��
                </td>
                 <td>
				<input name="Free_Fee" type="text" class="InputGrey" id="Free_Fee" value="<%=free_fee%>"   readonly>
			  </td>
		</tr>
		<tr>
	            <td class="blue">
            	      ���������
                     </td>
                      <td>
                       	<input name="Free_Term" type="text" class="InputGrey" id="Free_Term" value="<%=free_term%>"   readonly>
		               </td>
                  <td class="blue">
            	        Ԥ���ܽ��
                  </td>
                <td>
            	<input name="Prepay_Fee" type="text" class="InputGrey" id="Prepay_Fee" value="<%=prepay_fee%>"  readonly>
			   </td>
		</tr>
		<tr id="footer">
			<td colspan="4">
				<input name="commit" id="commit" type="button" class="b_foot"   value="��һ��" onClick="frmCfm();">
                <input name="close" onClick="removeCurrentTab()" type="button" class="b_foot" value="�ر�">
			</td>
		</tr>
	</table>

			<input type="hidden" name="iOpCode" value="7374">
			<input type="hidden" name="loginNo" value="<%=loginNo%>">
			<input type="hidden" name="orgCode" value="<%=orgCode%>">
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
			<input type="hidden" name="do_note" value="<%=iPhoneNo%>"+"Ԥ���Ż���������Ӫ��������">
			<input type="hidden" name="favorcode" value="<%=favorcode%>">
			<input type="hidden" name="maincash_no" value="<%=rate_code%>">
			<input type="hidden" name="imain_stream" value="<%=imain_stream%>">
			<input type="hidden" name="next_main_stream" value="<%=next_main_stream%>">

			<input type="hidden" name="i18" value="<%=next_rate_code%>"+"--"+"<%=next_rate_name%>">
			<input type="hidden" name="i19" value="<%=hand_fee%>">
			<input type="hidden" name="i20" value="<%=hand_fee%>">		
			
			<input type="hidden" name="beforeOpCode" value="7371">	
			<input type="hidden" name="opName" value="<%=opName%>">	
			<input type="hidden" name="backaccept" value="<%=iLoginNoAccept%>">		
			
			<input type="hidden" name="return_page" value="/npage/bill/f7374_1.jsp">			
<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>
