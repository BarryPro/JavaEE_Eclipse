<%
/********************
 * version v2.0
 * ������: si-tech
 * update by qidp @ 2009-01-09
 ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" import="java.sql.*" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="org.apache.log4j.Logger"%>

<%
    String opCode = "8045";
    String opName = "������ũ���������ֻ�Ӫ������";

    String loginNo = (String)session.getAttribute("workNo");
    String loginName = (String)session.getAttribute("workName");
    String orgCode = (String)session.getAttribute("orgCode");
    String ip_Addr = (String)session.getAttribute("ipAddr");
    System.out.println("       =======ip_Addr=======       "+ip_Addr);
    String regionCode = orgCode.substring(0,2);
    String loginNoPass = (String)session.getAttribute("password");
	  /**** ningtn add for pos start ****/
	  String  payType="",Response_time="",TerminalId="",Rrn="",Request_time="";
	  /**** ningtn add for pos end ****/
        //comImpl co1 = new comImpl();
    String paraStr[]=new String[1];
        //String prtSql="select to_char(sMaxSysAccept.nextval) from dual";
        //paraStr[0]=(((String[][])co1.fillSelect(prtSql))[0][0]).trim();
%>
    <wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="seq"/>
<%
    paraStr[0] = seq;
  /****�õ���ӡ��ˮ****/
  String printAccept="";
  printAccept = seq;
    System.out.println("loginAccept === "+paraStr[0]);

    String  retFlag="",retMsg="";
    String  bp_name="",sm_code="",family_code="",rate_code="",bigCust_flag="",sm_name="";
    String  rate_name="",bigCust_name="",next_rate_code="",next_rate_name="",lack_fee="";
    String  total_prepay="",bp_add="",cardId_type="", cardId_no="", cust_id="",cust_belong_code="";
    String  group_type_code="",group_type_name="",imain_stream="",next_main_stream="",hand_fee="";
    String  favorcode="",card_no="",print_note="";
    String  gift_code="",gift_grade="",gift_name="";
    String  base_fee="",free_fee="";
    String  mark_subtract="",consume_term="",mon_base_fee="",prepay_fee="",oImeiNo="";
    String  oSecondPhone="",oSimNo="",oModeCodeSm="",oBlackCode="",oMachFee="",ocostprice="";

    String iPhoneNo = request.getParameter("srv_no");
    String iLoginNoAccept = request.getParameter("backaccept");
        //String iOrgCode = request.getParameter("iOrgCode");
    String iOpCode = request.getParameter("opcode");
        //String[][] tempArr= new String[][]{};
        //SPubCallSvrImpl co = new SPubCallSvrImpl();
	String  inputParsm [] = new String[5];
	inputParsm[0] = iPhoneNo;
	inputParsm[1] = loginNo;
	inputParsm[2] = orgCode;
	inputParsm[3] = iOpCode;
	inputParsm[4] = iLoginNoAccept;
	System.out.println("phoneNO === "+ iPhoneNo);

	//sunzx add at 20070904
    //String sqlStr = "select res_info from wawarddata where flag = 'Y' and phone_no = '"+iPhoneNo+"'"+
    //	    " and login_accept="+iLoginNoAccept ;

    String sqlStr = "select res_info from wawarddata where flag = 'Y' and phone_no = :iPhoneNo and login_accept=:iLoginNoAccept";

    String [] paraIn = new String[2];
    paraIn[0] = sqlStr;
    paraIn[1]="iPhoneNo="+iPhoneNo+",iLoginNoAccept="+iLoginNoAccept;

    //ArrayList retArray = co.sPubSelect("1",sqlStr);
%>
    <wtc:service name="TlsPubSelCrm" routerKey="phone" routerValue="<%=iPhoneNo%>" retcode="retCode1" retmsg="retMsg1" outnum="1" >
    	<wtc:param value="<%=paraIn[0]%>"/>
    	<wtc:param value="<%=paraIn[1]%>"/>
    </wtc:service>
    <wtc:array id="result" scope="end"/>
<%

  if(result.length > 0 && retCode1.equals("000000"))
  {
	  //String[][] result = (String[][])retArray.get(0);
	  String awardName = result[0][0];

	  System.out.println("awardName2="+awardName);
	  if(!awardName.equals("")){
%>
    <script language="JavaScript" >
        rdShowMessageDialog("���û����ڴ���Ʒͳһ�����н���<%=awardName%>�콱������д���Ʒͳһ������������ȷ����Ʒ���");
        location='f8044_login.jsp?activePhone=<%=iPhoneNo%>&opCode=8045&opName=������ũ���������ֻ�Ӫ������';
    </script>
<%
		}
  }
	//sunzx add end

  //ArrayList retList = new ArrayList();
  //retList = co.callFXService("s8045Init", inputParsm, "42","phone",iPhoneNo);
%>
    <wtc:service name="s8045Init" routerKey="phone" routerValue="<%=iPhoneNo%>" retcode="s8045InitCode" retmsg="s8045InitMsg" outnum="47">
    	<wtc:param value="<%=inputParsm[0]%>"/> 
    	<wtc:param value="<%=inputParsm[1]%>"/> 
        <wtc:param value="<%=inputParsm[2]%>"/> 
        <wtc:param value="<%=inputParsm[3]%>"/>
        <wtc:param value="<%=inputParsm[4]%>"/>
    </wtc:service>
    <wtc:array id="s8045InitArr" scope="end" />
<%
  String errCode = s8045InitCode;
  String errMsg = s8045InitMsg;

	//co.printRetValue();
  if(s8045InitArr == null)
  {
	   retFlag = "1";
	   retMsg = "s126bInit��ѯ���������ϢΪ��!<br>errCode: " + errCode + "<br>errMsg+" + errMsg;
  }
  else
  {
	  if (errCode.equals("000000")){
	  //tempArr = (String[][])retList.get(3);
	  if(!(s8045InitArr[0][3].equals(""))){
	    bp_name = s8045InitArr[0][3];           //��������
	  }

	  //tempArr = (String[][])retList.get(4);
	  if(!(s8045InitArr[0][14].equals(""))){
	    bp_add = s8045InitArr[0][14];            //�ͻ���ַ
	  }

	  //tempArr = (String[][])retList.get(11);
	  if(!(s8045InitArr[0][11].equals(""))){
	    sm_code = s8045InitArr[0][11];         //ҵ�����
	  }

	  //tempArr = (String[][])retList.get(12);
	  if(!(s8045InitArr[0][12].equals(""))){
	    sm_name = s8045InitArr[0][12];        //ҵ���������
	  }

	  //tempArr = (String[][])retList.get(13);
	  if(!(s8045InitArr[0][13].equals(""))){
	    hand_fee = s8045InitArr[0][13];      //������
	  }

	  //tempArr = (String[][])retList.get(14);
	  if(!(s8045InitArr[0][14].equals(""))){
	    favorcode = s8045InitArr[0][14];     //�Żݴ���
	  }

	  //tempArr = (String[][])retList.get(5);
	  if(!(s8045InitArr[0][5].equals(""))){
	    rate_code = s8045InitArr[0][5];     //�ʷѴ���
	  }

	  //tempArr = (String[][])retList.get(6);
	  if(!(s8045InitArr[0][6].equals(""))){
	    rate_name = s8045InitArr[0][6];    //�ʷ�����
	  }

	  //tempArr = (String[][])retList.get(7);
	  if(!(s8045InitArr[0][7].equals(""))){
	    next_rate_code = s8045InitArr[0][7];//�����ʷѴ���
	  }

	  //tempArr = (String[][])retList.get(8);
	  if(!(s8045InitArr[0][8].equals(""))){
	    next_rate_name = s8045InitArr[0][8];//�����ʷ�����
	  }

	  //tempArr = (String[][])retList.get(9);
	  if(!(s8045InitArr[0][9].equals(""))){
	    bigCust_flag = s8045InitArr[0][9];//��ͻ���־
	  }

	  //tempArr = (String[][])retList.get(10);
	  if(!(s8045InitArr[0][10].equals(""))){
	    bigCust_name = s8045InitArr[0][10];//��ͻ�����
	  }

	  //tempArr = (String[][])retList.get(15);
	  if(!(s8045InitArr[0][15].equals(""))){
	    lack_fee = s8045InitArr[0][15];//��Ƿ��
	  }

	  //tempArr = (String[][])retList.get(16);
	  if(!(s8045InitArr[0][16].equals(""))){
	    total_prepay = s8045InitArr[0][16];//��Ԥ��
	  }

	  //tempArr = (String[][])retList.get(17);
	  if(!(s8045InitArr[0][17].equals(""))){
	    cardId_type = s8045InitArr[0][17];//֤������
	  }

	  //tempArr = (String[][])retList.get(18);
	  if(!(s8045InitArr[0][18].equals(""))){
	    cardId_no = s8045InitArr[0][18];//֤������
	  }

	  //tempArr = (String[][])retList.get(19);
	  if(!(s8045InitArr[0][19].equals(""))){
	    cust_id = s8045InitArr[0][19];//�ͻ�id
	  }

	  //tempArr = (String[][])retList.get(20);
	  if(!(s8045InitArr[0][20].equals(""))){
	    cust_belong_code = s8045InitArr[0][20];//�ͻ�����id
	  }

	  //tempArr = (String[][])retList.get(21);
	  if(!(s8045InitArr[0][21].equals(""))){
	    group_type_code = s8045InitArr[0][21];//���ſͻ�����
	  }

	  //tempArr = (String[][])retList.get(22);
	  if(!(s8045InitArr[0][22].equals(""))){
	    group_type_name = s8045InitArr[0][22];//���ſͻ���������
	  }

	  //tempArr = (String[][])retList.get(23);
	  if(!(s8045InitArr[0][23].equals(""))){
	    imain_stream = s8045InitArr[0][23];//��ǰ�ʷѿ�ͨ��ˮ
	  }

	  //tempArr = (String[][])retList.get(24);
	  if(!(s8045InitArr[0][24].equals(""))){
	    next_main_stream = s8045InitArr[0][24];//ԤԼ�ʷѿ�ͨ��ˮ
	  }

	  //tempArr = (String[][])retList.get(25);
	  if(!(s8045InitArr[0][25].equals(""))){
	    gift_code = s8045InitArr[0][25];//Ӫ������
	  }

	  //tempArr = (String[][])retList.get(26);
	  if(!(s8045InitArr[0][26].equals(""))){
	    gift_name = s8045InitArr[0][26];//��������
	  }

	  //tempArr = (String[][])retList.get(27);
	  if(!(s8045InitArr[0][27].equals(""))){
	    prepay_fee = s8045InitArr[0][27];//Ӧ��
	  }

	  //tempArr = (String[][])retList.get(28);
	  if(!(s8045InitArr[0][28].equals(""))){
	    free_fee = s8045InitArr[0][28];//����Ԥ��
	  }
	  //tempArr = (String[][])retList.get(29);
	  if(!(s8045InitArr[0][29].equals(""))){
	    consume_term = s8045InitArr[0][29];//��������
	  }
	  //tempArr = (String[][])retList.get(30);
	  if(!(s8045InitArr[0][30].equals(""))){
	    mon_base_fee = s8045InitArr[0][30];//�µ���
	  }
	  //tempArr = (String[][])retList.get(31);
	  if(!(s8045InitArr[0][31].equals(""))){
	    base_fee = s8045InitArr[0][31];//����Ԥ��
	  }

	  //tempArr = (String[][])retList.get(35);
	  if(!(s8045InitArr[0][35].equals(""))){
	    print_note = s8045InitArr[0][35];//����
	  }

	  //tempArr = (String[][])retList.get(36);
	  if(!(s8045InitArr[0][36].equals(""))){
	    oSimNo = s8045InitArr[0][36];//SIM����
	  }
	  //tempArr = (String[][])retList.get(37);
	  if(!(s8045InitArr[0][37].equals(""))){
	    oMachFee = s8045InitArr[0][37];//������
	  }
	  //tempArr = (String[][])retList.get(38);
	  if(!(s8045InitArr[0][38].equals(""))){
	    ocostprice = s8045InitArr[0][38];//�ֻ�ԭ��
	  }
	  //tempArr = (String[][])retList.get(39);
	  if(!(s8045InitArr[0][39].equals(""))){
	    oImeiNo = s8045InitArr[0][39];//IMEI
	  }
	  //tempArr = (String[][])retList.get(40);
	  if(!(s8045InitArr[0][40].equals(""))){
	    oBlackCode = s8045InitArr[0][40];//�����ײʹ���
	  }
	  //tempArr = (String[][])retList.get(41);
	  if(!(s8045InitArr[0][41].equals(""))){
	    oModeCodeSm = s8045InitArr[0][41];//�����ײ�����
	  }
	  
	    	/*** ningtn add for pos start ***/	   	 
				payType       = s8045InitArr[0][42].trim();
				Response_time = s8045InitArr[0][43].trim();
				TerminalId    = s8045InitArr[0][44].trim();
				Rrn           = s8045InitArr[0][45].trim();
				Request_time  = s8045InitArr[0][46].trim();
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
  	 history.go(-1);
  	//-->
  </script>
<%	 }
	}
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>������ũ���������ֻ�Ӫ������</title>
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
   	self.status="";
   }

  function frmCfm()
  {
         if(!checkElement(document.frm.phoneNo)) return;
         document.frm.iAddStr.value=document.frm.backaccept.value+"|"+document.frm.Gift_Code.value+"|"+document.frm.Prepay_Fee.value+"|"+
	                        document.frm.Base_Fee.value+"|"+document.frm.Free_Fee.value+"|"+
	                        +document.frm.Consume_Term.value+"|"+document.frm.Mon_Base_Fee.value+"|"+
	                        document.frm.Gift_Name.value+"|"+document.frm.MachFee.value+"|"+document.frm.ocostprice.value+"|"+
	                        document.frm.ImeiNo.value+"|"+
	                        document.frm.oblack_code.value+" "+document.frm.omodecode_sm.value+"|";;

	// alert(document.frm.iAddStr.value);

		   		frm.submit();


  }

//-->
</script>
</head>
<body>
<form name="frm" method="post" action="f1270_3.jsp" onKeyUp="chgFocus(frm)">
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">ҵ����Ϣ</div>
</div>
<input name="oSmCode" type="hidden" class="button" id="oSmCode" value="<%=sm_code%>">
<input name="oModeCode" type="hidden" class="button" id="oModeCode" value="<%=rate_code%>">
<input type="hidden" name="back_flag_code" value="">
<input type="hidden" name="loginAccept" value="<%=paraStr[0]%>">
<table cellspacing="0">
    <tr>
        <td class="blue">�ֻ�����</td>
        <td>
            <input class="InputGrey"  type="text" v_must="1" v_type="mobphone" v_must=1 name="phoneNo" id="phoneNo" onBlur="if(this.value!=''){if(checkElement(this)==false){return false;}}" maxlength=11 index="3" value="<%=iPhoneNo%>" readonly >
            <!--	<input class="button" type="button" name="qryId_No" value="��ѯ" onClick="chkPass()">-->
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
            Ӫ������
        </td>
        <td>
            <input type="text" name="Gift_Code" class="InputGrey" readOnly value="<%=gift_code%>">
        </td>
    </tr>
    <tr>
        <input name="Gift_Grade" type="hidden" id="Gift_Grade" value="<%=gift_grade%>" readonly >
        <td class="blue">
            ����
        </td>
        <td>
            <input name="Gift_Name" type="text" class="InputGrey" id="Gift_Name" value="<%=gift_name%>" readonly>
        </td>
        <td class="blue">
            ����Ԥ��
        </td>
        <td>
            <input name="Base_Fee" type="text" class="InputGrey" id="Base_Fee" readonly value="<%=base_fee%>">
        </td>
    </tr>
    <tr>
        <td class="blue">
            ����Ԥ��
        </td>
        <td>
            <input name="Free_Fee" type="text" class="InputGrey" id="Free_Fee"  value="<%=free_fee%>" readonly>
        </td>
        <td class="blue">
            ��������
        </td>
        <td>
            <input name="Consume_Term" type="text" class="InputGrey" id="Consume_Term"  value="<%=consume_term%>" readonly>
        </td>
    </tr>
    <tr>
        <td class="blue">
            �µ���
        </td>
        <td>
            <input name="Mon_Base_Fee" type="text" class="InputGrey" id="Mon_Base_Fee" value="<%=mon_base_fee%>" readonly>
        </td>
        <td class="blue">
            Ӧ�˽��
        </td>
        <td colspan="3">
            <input name="Prepay_Fee" type="text" class="InputGrey" id="Prepay_Fee" value="<%=prepay_fee%>"  readonly>
        </td>
    </tr>
    <tr id="footer">
        <td colspan="4">
            <input name="commit" id="commit" type="button" class="b_foot"   value="��һ��" onClick="frmCfm();">
            <input name="reset" type="reset" class="b_foot" value="���" >
            <input name="close" onClick="removeCurrentTab()" type="button" class="b_foot" value="�ر�">
        </td>
    </tr>
</table>
<input type="hidden" name="iOpCode" value="8045">
<input type="hidden" name="opCode" value="8045">
<input type="hidden" name="MachFee" value="<%=oMachFee%>">
<input type="hidden" name="ImeiNo" value="<%=oImeiNo%>">
<input type="hidden" name="loginNo" value="<%=loginNo%>">
<input type="hidden" name="orgCode" value="<%=orgCode%>">
<input type="hidden" name="oblack_code" value="<%=oBlackCode%>">
<input type="hidden" name="omodecode_sm" value="<%=oModeCodeSm%>">
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
<input type="hidden" name="ip" 	value="<%=next_rate_code%>">

<input type="hidden" name="belong_code" value="<%=cust_belong_code%>">
<input type="hidden" name="print_note" value="<%=print_note%>">
<input type="hidden" name="iAddStr" value="">

<input type="hidden" name="i1" value="<%=iPhoneNo%>">
<input type="hidden" name="opName" value="<%=opName%>">
<input type="hidden" name="i4" value="<%=bp_name%>">
<input type="hidden" name="i5" value="<%=bp_add%>">
<input type="hidden" name="i6" value="<%=cardId_type%>">
<input type="hidden" name="i7" value="<%=cardId_no%>">
<input type="hidden" name="i8" value="<%=sm_code%>--<%=sm_name%>">

<input type="hidden" name="ipassword" value="">
<input type="hidden" name="group_type" value="<%=group_type_code%>--<%=group_type_name%>">
<input type="hidden" name="ibig_cust" value="<%=bigCust_flag%>--<%=bigCust_name%>">
<input type="hidden" name="do_note" value="<%=iPhoneNo%>������ũ���������ֻ�Ӫ������">
<input type="hidden" name="favorcode" value="<%=favorcode%>">
<input type="hidden" name="maincash_no" value="<%=rate_code%>">
<input type="hidden" name="imain_stream" value="<%=iLoginNoAccept%>">
<input type="hidden" name="next_main_stream" value="<%=next_main_stream%>">

<input type="hidden" name="i18" value="<%=next_rate_code%>--<%=next_rate_name%>">
<input type="hidden" name="i19" value="<%=hand_fee%>">
<input type="hidden" name="i20" value="<%=hand_fee%>">
<input type="hidden" name="printAccept" value="<%=printAccept%>">
<input type="hidden" name="beforeOpCode" value="8044">
<input type="hidden" name="backaccept" value="<%=iLoginNoAccept%>">
<input type="hidden" name="ocostprice" value="<%=ocostprice%>">
<input type="hidden" name="return_page" value="/npage/bill/f8045_1.jsp">	
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
