<%
/********************
version v2.0
������: si-tech
*
*update:zhanghonga@2008-09-18 ҳ�����,�޸���ʽ
*
2015/01/08 10:28:51 gaopeng e974��תҳ��
 ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.util.ReqUtil" %>
<%
    /*
    * ������BOSS-�ײ�ʵ�֣����ʷѱ��  2004-1-5
    * @author  ghostlin
    * @version 1.0
    * @since   JDK 1.4
    * Copyright (c) 2002-2003 si-tech All rights reserved.
    *
    * ע����������������ҳ���ı����λ�õ��Ⱥ�˳�����һ���ı���Ϊi1���Դ����ơ�
    *       ���ֱ������������ݶԴ˱���ʹ�õ����壬����;��
    */
%>
<%			
    String[][] favInfo = (String[][]) session.getAttribute("favInfo");//��ȡ�Ż��ʷѴ���
    String workNo = (String)session.getAttribute("workNo");
    String workName = (String)session.getAttribute("workName");
    String groupId =(String)session.getAttribute("groupId");
    String phonepayPhoneNo = WtcUtil.repStr(request.getParameter("phonepayPhoneNo"),"");//�ֻ�֧������
    System.out.println("liangyl-----------------------------------------------"+phonepayPhoneNo);
    
    /* liujian ��ȫ�ӹ��޸� 2012-4-6 16:18:13 begin */
		String op_strong_pwd = (String) session.getAttribute("password");
	  /* liujian ��ȫ�ӹ��޸� 2012-4-6 16:18:13 end */
%>
<!----------------------------------ҳͷ��ʾ����----------------------------------------->
<%
    String subi20 = ReqUtil.get(request, "belong_code").substring(0, 2); //��������
    
    /*2015/04/21 10:27:01 gaopeng ������CRM�����ֻ����ֶһ������Ʒ���ܵ����� ��������ײ� �жϷǿ���Ϣ*/
    String nextMonthF = ReqUtil.get(request,"i18") == null?"":ReqUtil.get(request,"i18");
    String next_main_cash = "";
    System.out.println("gaopengSeeLog=====e974=====nextMonthF="+nextMonthF);
    if(nextMonthF != null && !"".equals(nextMonthF) && !"--".equals(nextMonthF)){
    	next_main_cash = nextMonthF.substring(0,8);
    }else{
  		next_main_cash = "";
  	}
  	System.out.println("gaopengSeeLog=====e974====next_main_cash=="+next_main_cash);
    
%>
<%
    /******************************׼������s1270Must��������ѭ���б�******************************/
    String ret_code1 = "";
    String ret_msg1 = "";
    String send_flag = " ";
    String mainModeCode = "";
    String ipower_right = WtcUtil.repNull((String)session.getAttribute("powerRight"));                                      //��½����Ȩ��
    String icust_id = ReqUtil.get(request, "i2");                           //�ͻ�ID
    String iold_m_code = ReqUtil.get(request, "i16").substring(0, ReqUtil.get(request, "i16").indexOf("-"));        //�����ײʹ��루�ϣ� 
    System.out.println("mylog -- -- ReqUtil.get(request,i16) - ---"+ReqUtil.get(request, "i16"));
    System.out.println("mylog -- -- iold_m_code "+iold_m_code);
    
    
    String inew_m_code = ReqUtil.get(request, "iph");                        //�������ײʹ���(��)
    String ibelong_code = ReqUtil.get(request, "belong_code");              //belong_code
    String iop_code = ReqUtil.get(request, "iOpCode");                      //��������
    String geftFlag = ReqUtil.get(request, "geftFlag"); 
    String broadPhone = ReqUtil.get(request, "broadPhone"); 
    /*2015/04/17 11:10:40 gaopeng ����Э���������ԤԼ�����ϵͳ֧���Ż�����ĺ� ����ȫ����ˮ*/
    String loginAccept = ReqUtil.get(request, "loginAccept"); 
    
    System.out.println("mylog geftFlag-- "+geftFlag);
    
    String endTime = ReqUtil.get(request, "end_time"); 
    if(endTime.length() > 8){
    	endTime = endTime.substring(0,8);
    }
    String print_note = request.getParameter("print_note");                //��������
    String regionCode = ibelong_code.substring(0, 2);
	String smCode = ReqUtil.get(request,"smCode");
	String m_smCode = ReqUtil.get(request,"m_smCode");
    String titleStr = "";
    String showFlag = "style='display:none'";
    String sqlStr2 = "";
    if (iop_code.equals("e974")) {
        titleStr = "���������ǩ";
        showFlag = "style=\"display:''\"";
    } else if (iop_code.equals("e975")) {
        titleStr = "���������ǩ����";
    }else if (iop_code.equals("m215")) {
        titleStr = "���������ǩ����";
    }
    System.out.println("11111111111"+showFlag);
	String opCode = iop_code;
	System.out.println("11111111111!!!!!!!!!@@@@@@@@@@@@@@@@@###########################"+opCode);
	String opName = titleStr;		
    String erpi = "";
    String NsmCode = "";
    String NsmName = "";
    String note = "";
    String note1 = "";
    String daima = "";
    String matureCode = "";
    String erpi_flag = ReqUtil.get(request, "flag_code");
    //String sqlStrSm = "select a.sm_code,b.sm_name from sbillmodecode a,ssmcode b  where a.region_code = '" + regionCode + "' and a.mode_code = '" + inew_m_code + "' and a.region_code=b.region_code and a.sm_code=b.sm_code";
    String  sqlStrSm = "select a.band_id,b.band_name from product_offer a,band b where a.band_id = b.band_id and  a.offer_id ="+inew_m_code;
    System.out.println("sqlStrSm|"+sqlStrSm);
%>
		<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  outnum="2">
		<wtc:sql><%=sqlStrSm%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="result2" scope="end" />
<%	
    System.out.println("@@@@@@@@@result=" + result2);
    for (int i = 0; i < result2.length; i++) {
        NsmCode = (result2[i][0]).trim();
        NsmName = (result2[i][1]).trim();
    }

        erpi = erpi_flag;
        String[] inParas = new String[]{""};
        inParas = new String[3];
        inParas[0] = regionCode;
        inParas[1] = inew_m_code;
        inParas[2] = erpi;
        //value = viewBean.callService("0", null, "s1270ModeNote", "7", inParas);
%>
		<wtc:service name="s1270NoteNew" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="7" >
			<wtc:param value="<%=loginAccept%>"/>
			<wtc:param value=""/>
			<wtc:param value="<%=iop_code%>"/>
			<wtc:param value="<%=workNo%>"/>
			<wtc:param value="<%=op_strong_pwd%>"/>
			<wtc:param value=""/>
			<wtc:param value=""/>
			<wtc:param value="<%=inParas[0]%>"/>
			<wtc:param value="<%=inParas[1]%>"/>
			<wtc:param value="<%=inParas[2]%>"/>
			<wtc:param value="<%=groupId%>"/>
		</wtc:service>
		<wtc:array id="result3" scope="end"/>
<%
        String return_code = "";
        String return_msg = "";
        String before_mode_code = "";
        String before_mode_name = "";
        String before_mode_note = "";
        String after_mature_code = "";
        String after_mature_note = "";
        
		if(result3!=null&&result3.length>0){
            return_code = result3[0][0];
            return_msg = result3[0][1];
            before_mode_code = result3[0][2];
            before_mode_name = result3[0][3];
            before_mode_note = result3[0][4];
            after_mature_code = result3[0][5];
            after_mature_note = result3[0][6];
        }
        daima = daima + " " + erpi;
        note = note + " " + before_mode_note;
        note1 = note1 + " " + after_mature_note;
        matureCode = after_mature_code;
    
    note = note.replaceAll("\"", "");
    note = note.replaceAll("\'", "");
    note1 = note1.replaceAll("\"", "");
    note1 = note1.replaceAll("\'", "");
    matureCode = matureCode.replaceAll("\'", "");
    matureCode = matureCode.replaceAll("\"", "");

    System.out.println("**********note=" + note);

    String mature_Name = "";
    String sqlStr4 = "";
    sqlStr4 = "select mode_name from sbillmodecode where region_code='" + regionCode + "' and     mode_code='" + matureCode + "'";
%>
		<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  outnum="1">
		<wtc:sql><%=sqlStr4%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="result4" scope="end" />
<%
    mature_Name=result4.length>0?result4[0][0]:"";
		
		//getList_must = callView.s1270MustProcess(ipower_right, icust_id,iold_m_code, inew_m_code,ibelong_code, iop_code).getList();
		
		System.out.println("-------------------------workNo-------------------------"+workNo);
		System.out.println("-------------------------icust_id-----------------------"+icust_id);
		System.out.println("-------------------------iold_m_code--------------------"+iold_m_code);
		System.out.println("-------------------------inew_m_code--------------------"+inew_m_code);
		System.out.println("-------------------------groupId------------------------"+groupId);
		System.out.println("-------------------------iop_code-----------------------"+iop_code);
	
	/****�õ���ӡ��ˮ****/
    String printAccept = "";
    
		printAccept = loginAccept;
		
	String[] inParas3 = new String[]{""};
    inParas3 = new String[12];
    inParas3[0] = printAccept;
    inParas3[1] = " ";
    inParas3[2] = iop_code;
    inParas3[3] = workNo;	
    /* liujian ��ȫ�ӹ��޸� 2012-4-6 16:18:13 oneline */
 // inParas3[4] = ReqUtil.get(request,"ipassword");
    inParas3[4] = op_strong_pwd;
    inParas3[5] = ReqUtil.get(request,"i1");
    inParas3[6] = " ";
    inParas3[7] = ipower_right;	
    inParas3[8] = icust_id;
    inParas3[9] = iold_m_code;
    inParas3[10] = inew_m_code;
    inParas3[11] = ReqUtil.get(request,"belong_code");	
%>
		<wtc:service name="s1270Must" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="16" >
			<wtc:param value="<%=inParas3[0]%>"/>
			<wtc:param value="<%=inParas3[1]%>"/>
			<wtc:param value="<%=inParas3[2]%>"/>
			<wtc:param value="<%=inParas3[3]%>"/>
			<wtc:param value="<%=inParas3[4]%>"/>	
			<wtc:param value="<%=inParas3[5]%>"/>
			<wtc:param value="<%=inParas3[6]%>"/>
			<wtc:param value="<%=inParas3[7]%>"/>
			<wtc:param value="<%=inParas3[8]%>"/>
			<wtc:param value="<%=inParas3[9]%>"/>
			<wtc:param value="<%=inParas3[10]%>"/>
			<wtc:param value="<%=inParas3[11]%>"/>
			
		</wtc:service>
		<wtc:array id="result_must" start="0" length="4" scope="end"/>
		<wtc:array id="dataArr" start="4" length="12" scope="end"/>	
<%
		
		ret_code1 = retCode1;
		
		System.out.println("------------------retCode1-------------------"+retCode1);
		System.out.println("------------------retMsg1--------------------"+retMsg1);
		System.out.println("------------------ result_must[0][3]--------------------"+ result_must[0][3]);
		for(int iii=0;iii<dataArr.length;iii++){
				for(int jjj=0;jjj<dataArr[iii].length;jjj++){
					System.out.println("---------------------dataArr["+iii+"]["+jjj+"]=-----------------"+dataArr[iii][jjj]);
				}
		}
		
    ret_msg1 = retMsg1;
		if(result_must!=null&&result_must.length>0){
    	 
		 	 
		    mainModeCode = result_must[0][2];
				 if (iop_code.equals("1257") || iop_code.equals("1258")) {
		        send_flag = "0 24Сʱ֮����Ч";
		     } else {
		     	
		     	if(retCode1.equals("000000")){
		        send_flag = result_must[0][3];
		        
		        }
		     }
		}
		
    /********************�õ���Чʱ��,���ڹ�����ӡ*****************************/
    String exeDateStr = "";
	  String exeDateSqlStr="";
	  
	  System.out.println("---------------------send_flag--------------------"+send_flag);
	  String flag = send_flag.substring(0, 1);
	  
	  System.out.println("-------------------send_flag-----------------"+send_flag);

	  if(flag.equals("0"))
	  {
		  if(iop_code.equals("1255") || iop_code.equals("1258"))
		  {
		    exeDateSqlStr = "select to_char(sysdate+1,'yyyymmdd')||' 0001' from dual";
		  }else
		  {
		    exeDateSqlStr = "select to_char(sysdate,'yyyymmdd hh24mi') from dual";
		  }
	  }else {//ԤԼ��Ч
		  if(iop_code.equals("1258"))
		  {
		    exeDateSqlStr = "select to_char(sysdate+1,'yyyymmdd')||' 0001' from dual";
		  }else if(iop_code.equals("3530")){
				exeDateSqlStr = "select  to_char(add_months(sysdate,12),'yyyymmdd') from dual";
		  }else if(iop_code.equals("1141")){
				exeDateSqlStr = "select  to_char(add_months(sysdate,11),'yyyymm') from dual";
		  }else{
		    exeDateSqlStr = "select  to_char(add_months(sysdate,1),'yyyymm')||'01 0001' from dual";
		  }		  
	  }
	  
	  System.out.println("exeDateSqlStr|"+exeDateSqlStr);
%>
		<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  outnum="1">
		<wtc:sql><%=exeDateSqlStr%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="exeDateArr" scope="end" />
<%
    String exeDate = "";
    exeDate = exeDateArr.length>0?exeDateArr[0][0]:exeDate;
    
    System.out.println("-------------------------exeDate------------------------"+exeDate);
    /*****************************************************************************************/
%>
<%
    /******************new add*********************/
    String goodbz = "";
    String phone_good = ReqUtil.get(request, "i1");
    String modedxpay = "";
    String sqlStrgood = "select mode_dxpay " +
            "from dgoodphoneres a, sGoodBillCfg b " +
            "where a.bill_code = b.mode_code " +
            " and b.region_code = '" + regionCode + "'" +
            " and a.phone_no = '" + phone_good + "' and b.valid_flag='Y' and a.bak_field='1' and end_time>sysdate and b.mode_dxpay>0";
    System.out.println(phone_good);
    System.out.println(sqlStrgood);
%>
		<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  outnum="1">
		<wtc:sql><%=sqlStrgood%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="resultx" scope="end" />
<%
		if(resultx!=null&&resultx.length>0){
		    if (resultx[0][0].equals("")) {
		        goodbz = "N";
		    } else {
		        goodbz = "Y";
		        modedxpay = resultx[0][0];
		        System.out.println("yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy->modedxpay"+modedxpay);
		    }		
		}

    System.out.println("goodbz=" + goodbz);
    /***********************end*********************/
    String bdbz = "N";
    String bdts = "";
    /******************liucm add �ʷ���������ʾ********************/
    String back_bz = "";
    String phoneno = ReqUtil.get(request, "i1");


    if (iop_code.equals("1257") || iop_code.equals("1258") || iop_code.equals("125a")) {
        back_bz = "N";
    } else {
        back_bz = "Y";
    }

    String[] inParas1 = new String[]{""};
    inParas1 = new String[4];
    inParas1[0] = regionCode;
    inParas1[1] = inew_m_code;
    inParas1[2] = back_bz;
    inParas1[3] = phoneno;
    //value1 = viewBean1.callService("0", null, "sModeBindDet", "6", inParas1);
%>
		<wtc:service name="sModeBindDet" routerKey="region" routerValue="<%=regionCode%>"  outnum="6" >
		<wtc:param value="<%=inParas1[0]%>"/>
		<wtc:param value="<%=inParas1[1]%>"/>
		<wtc:param value="<%=inParas1[2]%>"/>
		<wtc:param value="<%=inParas1[3]%>"/>
		</wtc:service>
		<wtc:array id="result5" scope="end"/>
<%
    String return_code1 = "";
    String return_msg1 = "";
    
		if(result5!=null&&result5.length>0){
	    return_code1 = result5[0][0];
	    return_msg1 = result5[0][1];
	    bdbz = result5[0][4];
	    bdts = result5[0][5];		
		}

    System.out.println("lcmlcmlcmlcmlcmbdbz=" + bdbz);
    System.out.println("lcmlcmlcmlcmlcmbdts=" + bdts);
    /**************liucm add end ************/
%>
<%
    String loginNote = "";
    String sqlStr9 = "select back_char1 from snotecode where region_code='" + regionCode + "' and op_code='XXXX'";
%>
		<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  outnum="1">
		<wtc:sql><%=sqlStr9%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="result9" scope="end" />
<%
    for (int i = 0; i < result9.length; i++) {
        loginNote = (result9[i][0]).trim();
    }
    loginNote = loginNote.replaceAll("\"", "");
    loginNote = loginNote.replaceAll("\'", "");
    loginNote = loginNote.replaceAll("\r\n", "   ");
    loginNote = loginNote.replaceAll("\r", "   ");
    loginNote = loginNote.replaceAll("\n", "   ");
%>




<HTML>
<HEAD>
    <TITLE><%=titleStr%></TITLE>
    <META http-equiv=Content-Type content="text/html; charset=GBK">
</HEAD>
<%if (!ret_code1.equals("000000")) {%>
<script language='jscript'>
	
    var ret_code = "<%=ret_code1%>";
    var ret_msg = "<%=ret_msg1%>";
    rdShowMessageDialog("��ѯ����<br>������룺'<%=ret_code1%>'��<br>������Ϣ��'<%=ret_msg1%>'��", 0);
    history.go(-1);
</script>
<%}%>
<body>
<FORM action="" method=post name="form1">
<input type="hidden" name="cust_info">
<input type="hidden" name="opr_info">
<input type="hidden" name="note_info1">
<input type="hidden" name="note_info2">
<input type="hidden" name="note_info3">
<input type="hidden" name="note_info4">
<input type="hidden" name="printcount">
<input type="hidden" id="phonepayPhoneNo" name="phonepayPhoneNo" value="<%=phonepayPhoneNo%>">

<!-- 2014/04/04 11:15:23 gaopeng Ʒ��sm_code -->
<input type="hidden" name="pubSmCode" id="pubSmCode" value="" />
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
    <div id="title_zi">�û���Ϣ</div>
</div>
<TABLE cellSpacing="0">
    <TR>
        <TD width="16%" class="blue">����˺�</td>
        <TD>
            <input name="phone" value="<%=ReqUtil.get(request,"i1")%>" 
             size="20" maxlength=11 v_must=1 type="hidden">
            <input type="text" name="broadPhone" id="broadPhone"
             value="<%=broadPhone%>" class="InputGrey" readonly="readOnly"/>
        </TD>
        <TD width="16%" class="blue">�ͻ�����</TD>
        <TD width="34%">
            <input name="i4" size="20" maxlength=30 value="<%=ReqUtil.get(request,"i4")%>" class="InputGrey" readonly>
        </TD>
        <!--����Ϊ����  �ͻ�ID ���ͻ���ַ��֤���������ƣ�֤�����룬belong_code,-->
        <input type="hidden" name="i2" size="20" value="<%=ReqUtil.get(request,"i2")%>" maxlength=30 readonly>
        <input type="hidden" name="i5" size="30" maxlength=30 value="<%=ReqUtil.get(request,"i5")%>" readonly><!--�ͻ���ַ-->
        <input type="hidden" name="i6" size="20" maxlength=30 value="<%=ReqUtil.get(request,"i6")%>" readonly><!--֤������-->
        <input type="hidden" name="i7" size="20" maxlength=30 value="<%=ReqUtil.get(request,"i7")%>" readonly><!--֤������-->
        <input type="hidden" name="belong_code" value="<%=ReqUtil.get(request,"belong_code")%>">
        <input type="hidden" name="maincash_no" value="<%=ReqUtil.get(request,"maincash_no")%>">
        <input type="hidden" name="kx_code_bunch"><!--��ѡ�ʷѴ��봮-->
        <input type="hidden" name="kx_habitus_bunch"><!--��ѡ�ʷ�״̬��-->
        <input type="hidden" name="kx_operation_bunch"><!--��ѡ�ײ͵���Ч��ʽ��-->
        <input type="hidden" name="kx_explan_bunch"><!--��ѡ�ײ�˵��-->
        <input type="hidden" name="toprintdata">
        <input type="hidden" name="stream" value="<%=printAccept%>">
        <input type="hidden" name="handcash" value="<%=ReqUtil.get(request,"i19")%>">
        <input type="hidden" name="kx_stream_bunch"><!--ԭ��ѡ�ײ͵Ŀ�ͨ��ˮ��-->
        <input type="hidden" name="main_cash_stream" value="<%=ReqUtil.get(request,"imain_stream")%>">
        <input type="hidden" name="next_main_cash" value="<%=next_main_cash %>">
        <input type="hidden" name="next_main_stream" value="<%=ReqUtil.get(request,"next_main_stream")%>">
        <input type="hidden" name="kx_want"><!--��ӡ�������������--->
        <input type="hidden" name="kx_cancle"><!--��ӡ������ȡ������--->
        <input type="hidden" name="kx_running"><!--��ӡ�����п�ͨ���ײ�--->
        <input type="hidden" name="modestr">
        <input type="hidden" name="i1" value="<%=ReqUtil.get(request,"i1")%>"><!--���ǰһҳ�洫����phone_no--->
        <input type="hidden" name="ipassword" value="<%=ReqUtil.get(request,"ipassword")%>"><!--���ǰһҳ�洫����password--->
        <input type="hidden" name="iAddStr" value="<%=ReqUtil.get(request,"iAddStr")%>">
        <input type="hidden" name="iOpCode" value="<%=ReqUtil.get(request,"iOpCode")%>">
        <input type="hidden" name="favorcode" value="<%=ReqUtil.get(request,"favorcode")%>"><!--���ǰһҳ�洫����favorcode--->
        <input type="hidden" name="iAddRateStr" value="<%=ReqUtil.get(request,"iAddRateStr")%>"><!--���ǰһҳ�洫����iAddRateStr--->
        <input type="hidden" name="flag_code" value="<%=ReqUtil.get(request,"flag_code")%>">
        <input type="hidden" name="rateCode" value="<%=ReqUtil.get(request,"rate_code_tmp")%>">
        <input type="hidden" name="cnttOpName" value="<%=opName%>">
        <input type="hidden" name="geftFlag" value="<%=geftFlag%>">
        <input type="hidden" name="endTime" value="<%=endTime%>">
        
        <!----------------------------------------------------------------------->
    </TR>
</TABLE>

<TABLE cellSpacing="0">

    <TR>
        <TD width="16%" class="blue">��ǰ���ײ�</TD>
        <TD width="34%">
            <input name="i16" size="30" value="<%=ReqUtil.get(request,"i16")%>" class="InputGrey" readonly classCode="10431"  classValue="11">
        </TD>
        <TD width="16%"  class="blue">�������ײ�</TD>
        <TD width="34%">
            <input name="i18" size="30" value="<%=nextMonthF%>" class="InputGrey" readonly classCode="10431"  classValue="11">
        </TD>
    </TR>

    </TBODY>
</TABLE>
<TABLE cellSpacing="0">
    <TBODY>
        <TR>
            <TD width="16%" class="blue">�������ײ�</TD>
            <TD width="34%">
                <input type="text" name="ip" value="<%=ReqUtil.get(request,"iph")%>" size="30" class="InputGrey" readonly>
                <script>
                    document.all.ip.value = document.all.ip.value + ' <%=mainModeCode%>';
                </script>
            </TD>
            <TD width="16%" class="blue">��Ч��ʽ</TD>
            <TD width="34%">
                <input type="text" name="tbselect" value="<%=send_flag%>" size="20" class="InputGrey" readonly v_must=1 v_name=��Ч��ʽ>
            </TD>
        </TR>
        <%
            String favorcode = ReqUtil.get(request, "favorcode");
            int m = 0;
            for (int p = 0; p < favInfo.length; p++) {//�Ż��ʷѴ���
                for (int q = 0; q < favInfo[p].length; q++) {
                    if (favInfo[p][q].trim().equals(favorcode)) {
                        ++m;
                    }
                }
            }
            //out.println("m="+m);
        %>
        <TR>
            <%if (m != 0) {%>
            <TD width="16%" class="blue">������</TD>
            <TD width="34%" colspan="3">
                <input name="i19" size="20" maxlength=20 value="<%=ReqUtil.get(request,"i19")%>" v_must=1 v_name=������ v_type=float>
                <input type="hidden" name="i20" size="20" maxlength=20 value="<%=ReqUtil.get(request,"i20")%>" readonly v_name=���������>
            </TD>
            <script language="jscript">
                document.all.i19.focus();
            </script>
            <%} else {%>
            <TD width="16%" class="blue">������</TD>
            <TD width="34%" colspan="3">
                <input name="i19" size="20" maxlength=20 value="<%=ReqUtil.get(request,"i19")%>" v_must=1 v_name=������ v_type=float class="InputGrey" readonly>
                <input type="hidden" name="i20" size="20" maxlength=20 value="<%=ReqUtil.get(request,"i20")%>" readonly v_name=���������>
            </TD>

            <%}%>

        </TR>

        <TR <%=showFlag%>>
            <TD width="16%" class="blue">��ѡ�ײ����</TD>
            <TD width="34%" colspan="3">
<%
                String sm_code = ReqUtil.get(request, "i8").substring(0, 2);//���ҵ��Ʒ��
                System.out.println("---------------sm_code-------------===================="+sm_code);
                String sqlStr = "";
                sqlStr = "select a.MODE_TYPE,a.TYPE_NAME,a.MIN_OPEN,a.MAX_OPEN  from sbillmodetype a,cBillBaDepend b,sBillModeCode c where a.region_code=b.region_code and a.region_code=c.region_code and b.region_code='" + ReqUtil.get(request, "belong_code").substring(0, 2) + "' and b.MODE_CODE='" + ReqUtil.get(request, "i16").substring(0, 8) + "' and b.add_mode=c.MODE_CODE and c.mode_type=a.mode_type and a.mode_flag='2'";
                
                System.out.println("---------------ReqUtil.get(request, i16).substring(0, 8)-------------"+ReqUtil.get(request, "i16").substring(0, 8));
                String tempStr1 = ReqUtil.get(request, "i16");
                if(tempStr1.indexOf("-")!=-1){
                	tempStr1 = tempStr1.substring(0,tempStr1.indexOf("-"));
                }
                
                /*
                if (sm_code.equals("gn") || sm_code.equals("hn") || sm_code.equals("dn") || sm_code.equals("d0") || sm_code.equals("cb") || sm_code.equals("z0")) {
                    sqlStr += " and a.sm_code in('gn','dn','zn')";
                }
                if (sm_code.equals("ip") || sm_code.equals("ww")) {
                    sqlStr += " and a.sm_code in('ip','ww')";
                }
                
                
                sqlStr += " and a.mode_type not in(select distinct mode_type from sAddModeType where active_flag='Y')";
                sqlStr += "  group by a.MODE_TYPE,a.TYPE_NAME,a.MIN_OPEN,a.MAX_OPEN";
                System.out.println("################################sqlStr===" + sqlStr);
                */
				sqlStr =" SELECT b.offer_attr_type,d.mem_role_name,c.role_down_num,c.role_up_num "
										+" FROM product_offer_detail a,product_offer b,PROD_OFFER_DETAIL_ROLE c, group_mbr_role d "
										+" WHERE a.element_type = '10C' "
										+" AND a.offer_id = "+tempStr1+" "
										+" AND a.sel_flag = '2' "
										+" AND a.state = 'A'  "
										+" AND a.element_id = b.offer_id"
										+" AND SYSDATE BETWEEN b.eff_date AND b.exp_date              "
										+" AND b.state = 'A' "
										+" and a.offer_detail_role_cd = c.offer_detail_role_cd "
										+" and c.mem_role_cd = d.mem_role_cd "
										+" and exists (select 1 from product_offer_scene where op_code = '"+iop_code+"' and b.offer_id = offer_id)";
										if(sm_code.equals("gn")||sm_code.equals("hn")||sm_code.equals("dn")||sm_code.equals("d0")||sm_code.equals("cb")||sm_code.equals("zn"))
										{
											sqlStr +=" and b.band_id in('21','23','24')";
										}
										if(sm_code.equals("ip"))
										{
											sqlStr +=" and b.band_id in('29')";
										}
						        sqlStr +=" group by b.offer_attr_type,d.mem_role_name,c.role_down_num,c.role_up_num, a.offer_detail_role_cd";                
						        System.out.println("---------------sqlStr-------------===================="+sqlStr);
%>
								<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  outnum="5">
								<wtc:sql><%=sqlStr%></wtc:sql>
								</wtc:pubselect>
								<wtc:array id="result_select" scope="end" />
<%	
                for (int i = 0; i < result_select.length; i++) {
                    out.println("<a Href='#' onClick='openwindow(" + '"' +
                              +i + '"' + "," + '"' + result_select[i][4] + '"' + "," + '"' + result_select[i][1] + '"' + ")'><font color='#0000FF'>" + result_select[i][0] + " " + result_select[i][1] + "</a>");
                    out.println("<input type=hidden name=oActualOpen value='0'>");    //ʵ�ʿ�ͨ���� 
                    out.println("<input type=hidden name=oDefaultFlag value='N'>");   //�Ƿ���Ĭ�����������
                    out.println("<input type=hidden name=oDefaultOpen value='N'>");   //�Ƿ�Ĭ�������Ƿ����һ������
                    out.println("<input type=hidden name=oTypeValue value=" + result_select[i][0] + ">");
                    out.println("<input type=hidden name=oTypeName value=" + result_select[i][1] + ">");
                    out.println("<input type=hidden name=oMinOpen value=" + result_select[i][2].trim() + ">");
                    out.println("<input type=hidden name=oMaxOpen value=" + result_select[i][3].trim() + ">");
                }
%>

            </TD>
        </TR>
    </TBODY>
</TABLE>
<TABLE cellSpacing="0">
    <TR>
        <TD width="16%" class="blue">ϵͳ��ע</TD>
        <TD colspan="3">
            <input name="sysnote" size="80" class="InputGrey" readonly>
        </TD>
    </TR>
    <TR style="display:none">
        <TD width="16%" class="blue">�û���ע</TD>
        <TD>
            <input name="tonote" size="60" value="<%=ReqUtil.get(request,"do_note")%>">
        </TD>
    </TR>
</TABLE>
</div>

<div id="Operation_Table"> 
	<div class="title">
		<div id="title_zi">�ײ���ϸ</div>
	</div>
<TABLE id=tr  cellSpacing="0" style="display:block">
	<tr align="center">
    <th <%=showFlag%>>ѡ��</th>
    <th>��ѡ�ײ�����</th>
    <th>״̬</th>
    <th>��ʼʱ��</th>
    <th>����ʱ��</th>
    <th>�ײ����</th>
    <th>��Ч��ʽ</th>
    <th>��ѡ��ʽ</th>
	</tr>
	<tr id="tr0" style="display:none">
    <td>
        <div align="center"><input type="checkbox" name="checkId" id="checkId"></div>
    </td>
    <td>
        <div align="center"><input type="text" name="R0" value=""></div>
    </td>
    <td>
        <div align="center"><input type="text" name="R1" value=""></div>
    </td>
    <td>
        <div align="center"><input type="text" name="R2" value=""></div>
    </td>
    <td>
        <div align="center"><input type="text" name="R3" value=""></div>
    </td>
    <td>
        <div align="center"><input type="text" name="R4" value=""></div>
    </td>
    <td>
        <div align="center"><input type="text" name="R5" value=""></div>
    </td>
    <td>
        <div align="center"><input type="text" name="R6" value="">
            <input type="text" name="R7" value="">
            <input type="text" name="R8" value="">
            <input type="text" name="R9" value="">
            <input type="text" name="R10" value="">
            <input type="text" name="R11" value="">
            <input type="text" name="R12" value="">
        </div>
    </td>
</tr>

<%
    		String[][] data = new String[][]{};
        data = dataArr;
        int dataArrLength=dataArr.length;
        for (int y = 0; y < data.length; y++) {
            String addstr = data[y][0] + "#" + data[y][1] + "#" + y;
%>
	<tr id="tr<%=y+1%>" align="center">
 
 
 <%
 String checkedFlag = "";
 String disabledFlag = "";
 


 if(data[y][1].equals("Y")&&data[y][11].equals("d")){
	 	checkedFlag = ""; 
	 	disabledFlag = "disabled";
 }else if(data[y][1].equals("Y")&&(!data[y][11].equals("d"))){
 		checkedFlag = "checked"; 
	 	disabledFlag = "";
 	}else if(data[y][1].equals("N")&&data[y][11].equals("2")){
 		checkedFlag = "checked"; 
	 	disabledFlag = "disabled";
 	}else if(data[y][1].equals("N")&&data[y][11].equals("1")){
 		checkedFlag = "checked"; 
	 	disabledFlag = "";
 	}
 		
 out.print("<td> <input type='checkbox' name='checkId' "+checkedFlag+"   "+disabledFlag+"></td>");
    System.out.println("----------------data[0].length---------------"+data[0].length);
        for (int j = 0; j < data[y].length + 1; j++) {
            String tbstr = "";
            if (j == 0) {
                tbstr = "<TD><a Href='#' onClick='openhref(" + '"' + data[y][7].trim() + '"' + ")'><font color='#0000FF'>" +
                        data[y][j].trim() + "</a><input type='hidden' " +
                        " id='R" + j + "' name='R" + j + "' class='button' value='" +
                        (data[y][j]).trim() + "'readonly>&nbsp;</TD>";
            } else if (j == 1) {
                String habitus = "";
                if (data[y][j].trim().equals("Y")) habitus = "�ѿ�ͨ";
                if (data[y][j].trim().equals("N")) habitus = "δ��ͨ";
                tbstr = "<TD>" + habitus + "<input type='hidden' " +
                        " id='R" + j + "' name='R" + j + "' class='button' value='" +
                        (data[y][j]).trim() + "'readonly>&nbsp;</TD>";
            } else if (j > 6 && j < 12) {
                tbstr = "<input type='hidden' " +
                        " id='R" + j + "' name='R" + j + "' class='button' value='" +
                        (data[y][j]).trim() + "'readonly>";
            } else if (j == 12) {
                tbstr = "<input type='hidden' " +
                        " id='R" + j + "' name='R" + j + "' class='button' value=' '>";
            } else {
                tbstr = "<TD>" + data[y][j].trim() + "<input type='hidden' " +
                        " id='R" + j + "' name='R" + j + "' class='button' value='" +
                        (data[y][j]).trim() + "'readonly>&nbsp;</TD>";
            }
            out.println(tbstr);
        }
    %>
</tr>
<%
        }
%>
</TABLE>

<TABLE cellSpacing="0">
    <TBODY>
        <TR>
            <TD id="footer">
                <input name=sure class="b_foot" type=button value="ȷ��&��ӡ" onclick="if(checknum(i19,i20)) if(senddata()) if(checksel()) printCommit();">&nbsp;&nbsp;
                &nbsp;&nbsp;
                <input name=kkkk class="b_foot" onClick="removeCurrentTab()" type=button value=�ر�>
                
            </TD>
        </TR>
    </TBODY>
</TABLE>
<%@ include file="/npage/include/footer_new.jsp" %>
</FORM>
</BODY>
</HTML>
<%/*------------------------javascript��----------------------------*/%>
<script language="javascript">
var oActualOpenObj = document.getElementsByName("oActualOpen");
//�����ж�
var oDefaultFlagObj = document.getElementsByName("oDefaultFlag");
//�����ж�
var oDefaultOpenObj = document.getElementsByName("oDefaultOpen");
//�����ж�
var oTypeValueObj = document.getElementsByName("oTypeValue");
//�����ж�
var oTypeNameObj = document.getElementsByName("oTypeName");
//�����ж�
var oMinOpenObj = document.getElementsByName("oMinOpen");
//�����ж�
var oMaxOpenObj = document.getElementsByName("oMaxOpen");
//�����ж�
function conf()
{

}
function crmsubmit()
{
    if (rdShowConfirmDialog("�Ƿ��ύ�˴β�����") == 1)
    {
        form1.action = "f1270_q_year.jsp";
        form1.submit();
    }
    else
    {
        canc()
    }

}

function canc()
{
    document.all.sure.disabled = false;
}
/****************************************add by Mengqk begin********************************************/
function printCommit() {
	getAfterPrompt();
    document.all.sure.disabled = true;
    document.all.sysnote.value = document.all.i16.value  + document.all.tbselect.value + document.all.ip.value ;//ϵͳ��ע
    //��ӡ�������ύ��
    var ret = showPrtDlg("Detail", "ȷʵҪ���е��������ӡ��", "Yes");
    if (typeof(ret) != "undefined")
    {
        if ((ret == "confirm"))
        {
            if (rdShowConfirmDialog('ȷ�ϵ����������ȷ��,���ύ����ҵ��!') == 1)
            {
                document.all.printcount.value = "1";
                frmCfm();
            }
        }
        if (ret == "continueSub")
        {
            if (rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��') == 1)
            {		
                document.all.printcount.value = "0";
                frmCfm();
            }
        }
    }
    else
    {
        if (rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��') == 1)
        {	
            document.all.printcount.value = "0";
            frmCfm();
        }
    }
    document.all.sure.disabled = false;
    return true;
}
/****/
function frmCfm() {
	
		<%
			String newurl="";
			newurl="f1270_q_year.jsp";
		%>
    document.form1.action = "<%=newurl%>";
    form1.submit();
    return true;
}

function showPrtDlg(printType, DlgMessage, submitCfm)
{  //��ʾ��ӡ�Ի��� 
    var h = 210;
    var w = 400;
    var t = screen.availHeight / 2 - h / 2;
    var l = screen.availWidth / 2 - w / 2;

 	var rate_code='<%=ReqUtil.get(request,"iAddRateStr")%>';
	var pType="subprint";
	var billType="1"; 

	var mode_code=null;
	var fav_code=null;
	var area_code=null;
	if("<%=iop_code%>"!="125a"){
		if(rate_code=="$"){
			area_code=null;
		}else{
			var rate=rate_code.split("$");
		 	area_code=rate[0];		
		}	
		var oldmode=document.all.i16.value.substring(0, 8); //���ײʹ���
		var newmode1=document.all.ip.value; //�����ײʹ���
		var newmode = "";
		if(newmode1.indexOf(" ")!=-1){
			newmode = newmode1.substring(0,newmode1.indexOf(" ")); 
		}
		if(<%=showFlag%>=="style='display:none'"){
			mode_code=codeChg(newmode);
		}else{
			var kx=""; //��ѡ�ײʹ���
			for (var i = 0; i < document.all.checkId.length; i++){
				if (document.all.checkId[i].checked == true&& document.all.R1[i].value == "N"){
					kx=kx+document.all.R7[i].value+"~";
				}
			}
			mode_code=codeChg(newmode)+"~"+codeChg(kx);
		}
	}
	var sysAccept = "<%=loginAccept%>";
		
    var printStr = printInfo();
    var prop = "dialogHeight:" + h + "px; dialogWidth:" + w + "px; dialogLeft:" + l + "px; dialogTop:" + t + "px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";

	 var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage + "&submitCfm=" + submitCfm;
		path = path  + "&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo=<%=phoneno%>&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
    var ret = window.showModalDialog(path, printStr, prop);
    return ret;
}

function printInfo()
{
    var retInfo = "";
<%if(iop_code.equals("e974") || iop_code.equals("m215")){%>
    retInfo = printInfoe974();
<%}else if(iop_code.equals("1257")){%>
    retInfo = printInfo1257();
<%}%>
    return retInfo;
}

/********��֯��ӡ��Ϣ��һ�麯��  begin***********/


//�ֽ��ַ���
function oneTokSelf(str,tok,loc)
  {
    var temStr=str;
    //if(str.charAt(0)==tok) temStr=str.substring(1,str.length);
    //if(str.charAt(str.length-1)==tok) temStr=temStr.substring(0,temStr.length-1);

	var temLoc;
	var temLen;
    for(ii=0;ii<loc-1;ii++)
	{
       temLen=temStr.length;
       temLoc=temStr.indexOf(tok);
       temStr=temStr.substring(temLoc+1,temLen);
 	}
	if(temStr.indexOf(tok)==-1)
	  return temStr;
	else
      return temStr.substring(0,temStr.indexOf(tok));
  }	

/*2014/04/04 11:02:20 gaopeng ���ù�����ѯ����Ʒ��sm_code*/
function getPubSmCode(kdNo){
		var getdataPacket = new AJAXPacket("/npage/public/pubGetSmCode.jsp","���ڻ�����ݣ����Ժ�......");
		getdataPacket.data.add("phoneNo","");
		getdataPacket.data.add("kdNo",kdNo);
		core.ajax.sendPacket(getdataPacket,doPubSmCodeBack);
		getdataPacket = null;
}
function doPubSmCodeBack(packet){
	retCode = packet.data.findValueByName("retcode");
	retMsg = packet.data.findValueByName("retmsg");
	smCode = packet.data.findValueByName("smCode");
	if(retCode == "000000"){
		$("#pubSmCode").val(smCode);
	}
}


//������ǩ����
function printInfoe974()
{
		getPubSmCode(document.all.broadPhone.value);
		var pubSmCode = $("#pubSmCode").val();
		
    //�õ���ҵ�񹤵���Ҫ�Ĳ���
    var tempStr = document.form1.iAddStr.value;
	  //iAddStr��ʽ pay_type|year_fee|prepay_fee|year_month|card_type|card_name ����card_type��card_name������E�а���
    var year_fee = oneTokSelf(tempStr, "|", 2);//����Ԥ��
    var year_month = oneTokSelf(tempStr, "|", 4);//��������
    var exeDate = "<%=new java.text.SimpleDateFormat("yyyy-MM-dd", Locale.getDefault()).format(new java.util.Date())%>";//��Ч����
    var smName = "";

    var retInfo = "";
    var cust_info = "";
    var opr_info = "";
    var note_info1 = "";
    var note_info2 = "";
    var note_info3 = "";
    var note_info4 = "";
    /********������Ϣ��**********/
    cust_info += "�ͻ�������" + document.all.i4.value + "|";
    cust_info += "����ʺţ�" + document.all.broadPhone.value + "|";

    /********������**********/
    opr_info += "ҵ������ʱ�䣺" + '<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>' + "  " + "�û�Ʒ�ƣ�" + "<%=ReqUtil.get(request,"i8")%>" + "|";


    opr_info += "ҵ���������:" + "<%=opName%>" + "   ������ˮ: " + "<%=printAccept%>" + "|";
    opr_info += "ԭ�����ʷѣ�" + codeChg("<%=ReqUtil.get(request,"i16")%>") + "|";
    opr_info += "������ǩ�ʷѣ�" + codeChg(document.all.ip.value) + "  ��ǩ�ʷ���Чʱ�䣺" +"<%=endTime%>"+ "|";
    /**********������*********/
    note_info2 += "" + "|";
    /* 
     * ����Э������ʡ�������������Ӫ�������ں��ײ�����ĺ�����Ʒ���֣�@2014/7/24 
     * ����ʡ���kg������Ʒ��kh
     */
    if(pubSmCode == "kf" || pubSmCode == "kg" || pubSmCode == "kh"){
    	
    	note_info2 += "��ע��" + "|";
    	note_info2 += "1���û����������ǩ����ǩ�ʷ��ڵ�ǰ�ʷѽ�������Ч��" + "|";
    	note_info2 += "2������ϵ�绰�䶯ʱ���뼰ʱ���ƶ���˾��ϵ���Ա������»�������ʱ��ʱ�յ�֪ͨ��" + "|";
    	note_info2 += "3������������벦��������ߣ�10086��" + "|";
    }
    document.all.cust_info.value = cust_info + "#";
    document.all.opr_info.value = opr_info + "#";
    document.all.note_info1.value = note_info1 + "#";
    document.all.note_info2.value = note_info2 + "#";
    document.all.note_info3.value = note_info3 + "#";
    document.all.note_info4.value = note_info4 + "#";
	//retInfo = cust_info+"#"+opr_info+"#"+note_info1+"#"+note_info2+"#"+note_info3+"#"+note_info4+"#";
	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
    return retInfo;
}
//������ǩ����
function printInfo125a()
{//alert(document.all.kx_code_bunch.value);
    //�õ���ҵ�񹤵���Ҫ�Ĳ���
    var tempStr = document.form1.iAddStr.value;
	  //iAddStr��ʽ pay_type|year_fee|prepay_fee|iOldAccept|iContractNo|iOpType 
    var year_fee = oneTokSelf(tempStr, "|", 2);//����Ԥ��
    var exeDate = "<%=exeDate.substring(0,8)%>";//��Ч����

    var retInfo = "";
    var cust_info = "";
    var opr_info = "";
    var note_info1 = "";
    var note_info2 = "";
    var note_info3 = "";
    var note_info4 = "";
    /********������Ϣ��**********/
    cust_info += "�ͻ�������" + document.all.i4.value + "|";
    cust_info += "�ֻ����룺" + document.all.phone.value + "|";
    cust_info += "�ͻ���ַ��" + document.all.i5.value + "|";
    cust_info += "֤�����룺" + document.all.i7.value + "|";

    /********������**********/
    opr_info += "ҵ������ʱ�䣺" + '<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>' + "  " + "�û�Ʒ�ƣ�" + "<%=ReqUtil.get(request,"i8")%>" + "|";

    opr_info += "����ҵ��:  ������ǩ����" + "|";

<%if(goodbz.equals("Y")){%>
    opr_info += "����ҵ��: ������ǩ����" + "  ������ˮ: " + "<%=printAccept%>" + "  �������ѽ�" + "<%=modedxpay%>" + "Ԫ" + "|";
<%}else{%>
    opr_info += "����ҵ��: ������ǩ����" + "  ������ˮ: " + "<%=printAccept%>" + "|";
<%}%>
    opr_info += "ִ������:  " + exeDate + "|";
    /*******��ע��**********/
    if ("<%=bdbz%>" == "Y") {
        note_info1 += "<%=bdts%>" + "|";
    }
    /**********������*********/
    if (document.all.modestr.value.length > 0) {
        note_info2 += " " + "|";
        note_info2 += "���ʷ���Чʱ����ȡ���Ŀ�ѡ�ʷ�:" + document.all.modestr.value + "|";
    }
    note_info3 += " " + "|";
    note_info3 += "<%=print_note%>" + "|";
<%if(goodbz.equals("Y")){%>
    note_info4 += " " + "|";
    note_info4 += "��ע���ú���Ϊ������룬������ѡ����ʷѵĻ��������õ������ѣ����߲�������Ϣ�ѣ��������������ѵĻ��ѣ���������Ϣ�ѣ�������߶�ȣ��������߱�׼��ȡ��" + "|";
<%}%>
    note_info4 += " " + "|";
    note_info4 += "��ע��" + document.all.tonote.value + "|";
    document.all.cust_info.value = cust_info + "#";
    document.all.opr_info.value = opr_info + "#";
    document.all.note_info1.value = note_info1 + "#";
    document.all.note_info2.value = note_info2 + "#";
    document.all.note_info3.value = note_info3 + "#";
    document.all.note_info4.value = note_info4 + "#";
	//retInfo = cust_info+"#"+opr_info+"#"+note_info1+"#"+note_info2+"#"+note_info3+"#"+note_info4+"#";
	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
    return retInfo;
}

/*************************************add by MengQK  end*************************************************************/

/*--------------------------������У�麯��--------------------------*/

function checknum(obj1, obj2)
{
    var num2 = parseFloat(obj2.value);
    var num1 = parseFloat(obj1.value);

    if (num2 < num1)
    {
        var themsg = "'" + obj1.v_name + "'���ô���'" + obj2.value + "'���������룡";
        rdShowMessageDialog(themsg, 0);
        obj1.focus();
        return false;
    }
    return true;
}

/*-------------------------ҳ���ύ��ת����----------------------------*/

var dynTbIndex = 0;
var token = "|";

/*------------------------- ɾ����Ӧҵ���߼����---------------------------*/

function tohidden(s)// s ��ʾ �ײ����ͣ���openwindow ����
{
    var tmpTr = "";
    for (var a = document.all('tr').rows.length - 2; a > 0; a--)//ɾ����tr1��ʼ��Ϊ������
    {
        if (document.all.R8[a].value == s && document.all.R1[a].value == "N")
        {
            if (document.all.R11[a].value.trim() == "0" || document.all.R11[a].value.trim() == "c")//choice_flag0��cɾ��
            {
                document.all.tr.deleteRow(a + 1);
            }
        }
    }

    return true;
}

function openwindow(theNo, p, q)
{
  
}

function codeChg(s)
{
  var str = s.replace(/%/g, "%25").replace(/\+/g, "%2B").replace(/\s/g, " "); // % + \s
  str = str.replace(/-/g, "%2D").replace(/\*/g, "%2A").replace(/\//g, "%2F"); // - * /
  str = str.replace(/\&/g, "%26").replace(/!/g, "%21").replace(/\=/g, "%3D"); // & ! =
  str = str.replace(/\?/g, "%3F").replace(/:/g, "%3A").replace(/\|/g, "%7C"); // ? : |
  str = str.replace(/\,/g, "%2C").replace(/\./g, "%2E").replace(/#/g, "%23"); // , . #
  return str;
}

function getStr(srcStr, token)
{
    var field_num = 13;
    var i = 0;
    var inString = srcStr;
    var retInfo = "";
    var tmpPos = 0;
    var chPos;
    var valueStr;
    var retValue = "";

    var a0 = "";
    var a1 = "";
    var a2 = "";
    var a3 = "";
    var a4 = "";
    var a5 = "";
    var a6 = "";
    var a7 = "";
    var a8 = "";
    var a9 = "";
    var a10 = "";
    var a11 = "";
    var a12 = "";
    var a1Tmp = "";
    retInfo = inString;
    chPos = retInfo.indexOf(token);
    while (chPos > -1)
    {
        for (i = 0; i < field_num; i++)
        {
            valueStr = retInfo.substring(0, chPos);

            if (i == 0) a0 = valueStr;
            if (i == 1) a1 = valueStr;
            if (a1 == "Y")a1Tmp = "�ѿ�ͨ";
            if (a1 == "N")a1Tmp = "δ��ͨ";
            if (i == 2) a2 = valueStr;
            if (i == 3) a3 = valueStr;
            if (i == 4) a4 = valueStr;
            if (i == 5) a5 = valueStr;
            if (i == 6) a6 = valueStr;
            if (i == 7) a7 = valueStr;
            if (i == 8) a8 = valueStr;
            if (i == 9) a9 = valueStr;
            if (i == 10) a10 = valueStr;
            if (i == 11) a11 = valueStr;
            if (i == 12) a12 = valueStr;
            retInfo = retInfo.substring(chPos + 1);
            chPos = retInfo.indexOf(token);
            if (!(chPos > -1)) break;
        }
        insertTab(a0, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a1Tmp);
    }


}
function insertTab(a0, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a1Tmp)
{
    var tr1 = tr.insertRow();
    var divid = "div"+dynTbIndex;
    tr1.id = "tr" + dynTbIndex;
	td1 = tr1.insertCell();
	td2 = tr1.insertCell();
	td3 = tr1.insertCell();
	td4 = tr1.insertCell();
	td5 = tr1.insertCell();
	td6 = tr1.insertCell();
	td7 = tr1.insertCell();
	td8 = tr1.insertCell();
	td2.id="div"+dynTbIndex;    
    td1.innerHTML = '<div align="center"><input type="checkbox" name="checkId" checked></input></div>';
    td2.innerHTML = '<div align="center" id="'+divid+'"><a Href="#"  onClick="openhref(' + "'" + a7 + "'" + ')"><font color="#0000FF">' + a0 + '</a><input id=R0 type=hidden value=' + a0 + ' class=button size=10 readonly></input></div>';
    td3.innerHTML = '<div align="center">' + a1Tmp + '<input id=R1 type=hidden value=' + a1 + ' class=button size=10 readonly></input></div>';
    td4.innerHTML = '<div align="center">' + a2 + '<input id=R2 type=hidden value=' + a2 + ' class=button size=18 readonly></input></div>';
    td5.innerHTML = '<div align="center">' + a3 + '<input id=R3 type=hidden value=' + a3 + ' class=button size=10 readonly></input></div>';
    td6.innerHTML = '<div align="center">' + a4 + '<input id=R4 type=hidden value=' + a4 + ' class=button size=10 readonly></input></div>';
    td7.innerHTML = '<div align="center">' + a5 + '<input id=R5 type=hidden value=' + a5 + ' class=button size=10 readonly></input></div>';
    td8.innerHTML = '<div align="center">' + a6 + '<input id=R6 type=hidden value=' + a6 + ' class=button size=10 readonly><input id=R7 type=hidden value=' + a7 + ' class=button size=10 readonly><input id=R8 type=hidden value=' + a8 + ' class=button size=10 readonly><input id=R9 type=hidden value=' + a9 + ' class=button size=10 readonly><input id=R10 type=hidden value=' + a10 + ' class=button size=10 readonly><input id=R11 type=hidden value=' + a11 + ' class=button size=10 readonly><input name=R12 id="R12'+dynTbIndex+'" type=hidden class=button size=10 readonly></input></div>';
    $("#R12"+dynTbIndex).val(a12);   //Ϊ�˽������������Ϣ�еĻس����������ʾ��ȫ
    getMidPrompt("10442",a7,divid);
    dynTbIndex++;

}
/*------------------------------��֯��������һҳ����---------------------------------------*/
function senddata()
{		
    var kx_code_bunch = "";                                     //��ѡ�ʷѴ��봮
    var kx_habitus_bunch = "";                                   //��ѡ�Է�״̬��
    var kx_operation_bunch = "";                                  //��ѡ�ײ͵���Ч��ʽ��
    var kx_stream_bunch = "";                                     //��ѡ�ײ�ԭ��ͨ��ˮ��
    var kx_explan_bunch = "";									//��ѡ�ײ�����
    var tempnm = "";												 //��ʱ��������
    var kx_want = "";											 //��ӡ���������
    var kx_cancle = "";											 //��ӡ��ȡ������
    var kx_running = "";											 //��ӡ�����п�ͨ����
    var kx_want_chgrow = "0";								     //��ӡ���������,���б�־
    var kx_cancle_chgrow = "0";									 //��ӡ��ȡ������,���б�־
    var kx_running_chgrow = "0";									 //��ӡ�����п�ͨ����,���б�־
    kx_want = "�������룺" + document.all.ip.value.substring(8);
    kx_cancle = "����ȡ����" + document.all.i16.value.substring(8);
    if (document.all.i16.value.substring(0, 8) != document.all.i18.value.substring(0, 8))
        kx_cancle = kx_cancle + " " + document.all.i18.value.substring(8);
    var modestr = "";
    var modestr_lj = "";
    var modestr_yy = "";
    var mynum=<%=dataArrLength%>;
    
    for (var i = 1; i < mynum+1; i++)
    {
        /********liucm��ѡ�ʷ�ȡ����ʾ*******************/
    <% if(iop_code.equals("1257")||iop_code.equals("1258")||iop_code.equals("125a")) {%>
        //if(document.all.main_cash_stream.value==document.all.R10[i].value){
        //modestr_lj=modestr_lj+document.all.R7[i].value+"("+document.all.R0[i].value+")����";
        //document.all.modestr.value=modestr;
        //rdShowMessageDialog("��ѡ�ʷ�"+modestr+"����һ���ʷ���Чʱ����ȡ��������ʾ�ͻ���");
        //}

    <%}else{%>
        if (document.all.checkId[i].checked == false && document.all.R1[i].value == "Y") {
            //����δ���߷�
            if (document.all.R9[i].value == "0") {
                modestr_lj = modestr_lj + document.all.R7[i].value + "(" + document.all.R0[i].value + "),";
            } else {
                modestr_yy = modestr_yy + document.all.R7[i].value + "(" + document.all.R0[i].value + "),";
            }��

            //modestr=modestr+document.all.R7[i].value+"("+document.all.R0[i].value+")����";
        }

    <%}%>
    //alert("document.all.R1["+i+"].value|"+document.all.R1[i].value+"\n"+"document.all.R11["+i+"].value|"+document.all.R11[i].value);
        if((document.all.R1[i].value=="Y"&&document.all.R11[i].value=="d")||(document.all.R1[i].value=="N"&&document.all.R11[i].value=="2")||(document.all.R1[i].value=="Y"&&document.all.R11[i].value!="d"&&document.all.checkId[i].checked==false)||(document.all.R1[i].value=="N"&&document.all.R11[i].value=="1"&&document.all.checkId[i].checked==true))
        {
        	
            kx_code_bunch = kx_code_bunch + document.all.R7[i].value + "#"; //��ѡ�ʷѴ��봮
            kx_habitus_bunch = kx_habitus_bunch + document.all.R1[i].value + "#";       //��ѡ�ʷ�״̬��
            kx_operation_bunch = kx_operation_bunch + document.all.R9[i].value + "#";   //��ѡ�ײ͵���Ч��ʽ��
            kx_stream_bunch = kx_stream_bunch + document.all.R10[i].value + "#";//��ѡ�ײ�ԭ��ͨ��ˮ��
            if (document.all.R12[i].value == "��������Ϣ") {
                kx_explan_bunch = kx_explan_bunch;
						//��ѡ�ײ�����
            } else {
                kx_explan_bunch = kx_explan_bunch + " " + document.all.R12[i].value;
            }
						//��ѡ�ײ�����

            if (document.all.checkId[i].checked == true && document.all.R1[i].value == "N") //���п�ͨ���
            {
                kx_want = kx_want + " " + document.all.R0[i].value;  //���봮
                kx_want_chgrow = 1 * kx_want_chgrow + 1;
                if (kx_want_chgrow == 2) kx_want += "|";
            }
            if (document.all.checkId[i].checked == false && document.all.R1[i].value == "Y")//ȡ�����
            {
                kx_cancle = kx_cancle + " " + document.all.R0[i].value;              //ȡ����
                kx_cancle_chgrow = 1 * kx_cancle_chgrow + 1;
                if (kx_cancle_chgrow == 2) kx_cancle += "|";
            }

        }
        if (document.all.checkId[i].checked == true)
        {
            kx_running = kx_running + " " + document.all.R0[i].value;     //���п�ͨ��
            kx_running_chgrow = 1 * kx_running_chgrow + 1;
            if (kx_running_chgrow == 3) kx_running += "|";
        }
    }
    document.all.modestr.value = "";
	 
    if (modestr_lj.length > 0) {
        document.all.modestr.value = document.all.modestr.value + modestr_lj + "��������ȡ��, "
    }
    if (modestr_yy.length > 0) {
        document.all.modestr.value = document.all.modestr.value + modestr_yy + "��������1�ձ�ȡ��, "
    }
    if (document.all.modestr.value.length > 0) {
        rdShowMessageDialog("��ѡ�ʷ�" + document.all.modestr.value + "����ʾ�ͻ�!");
    }

    if (kx_running == "")kx_running = "��";
    kx_running = "��ͨ��ѡ�ײͣ�" + kx_running + "|";
    kx_want = kx_want + "|";
    kx_cancle = kx_cancle + "|";


    
    
    //alert("document.all.checkId.length|"+document.all.checkId.length+"\n"+"mynum|"+mynum);
    for (var i = mynum+1; i < document.all.checkId.length; i++){
    	//alert("i|"+i+"\n"+"kx_code_bunch|"+kx_code_bunch);
    			if(document.all.checkId[i].checked==true){
    			  kx_code_bunch = kx_code_bunch + document.all.R7[i].value + "#"; //��ѡ�ʷѴ��봮
            kx_habitus_bunch = kx_habitus_bunch + document.all.R1[i].value + "#";       //��ѡ�ʷ�״̬��
            kx_operation_bunch = kx_operation_bunch + document.all.R9[i].value + "#";   //��ѡ�ײ͵���Ч��ʽ��
    			 }
    }
    
    if (kx_habitus_bunch == "") {
        kx_habitus_bunch = " #";
    }
    if (kx_operation_bunch == "") {
        kx_operation_bunch = " #";
    }
    if (kx_stream_bunch == "") {
        kx_stream_bunch = " #";
    }
    
    document.all.kx_code_bunch.value = kx_code_bunch;                        //��ѡ�ʷѴ��봮
    document.all.kx_habitus_bunch.value = kx_habitus_bunch;                  //��ѡ�ʷ�״̬��
    document.all.kx_operation_bunch.value = kx_operation_bunch;            //��ѡ�ײ͵���Ч��ʽ��
    document.all.kx_stream_bunch.value = kx_stream_bunch;                  //��ѡ�ײ͵Ŀ�ͨ��ˮ��
    document.all.kx_explan_bunch.value = kx_explan_bunch;						//��ѡ�ײ�����
    document.all.kx_want.value = kx_want;                                  //��ӡ�������������-��
    document.all.kx_cancle.value = kx_cancle;                              //��ӡ������ȡ������-��
    document.all.kx_running.value = kx_running;                            //��ӡ�����п�ͨ���ײ�-��

    return true;
}
/*----------------------------------�ж�ҵ���ײ��Ƿ���Բ���-----------------------------------*/
function checksel()
{
    with (document.all)
    {
        for (j = 0; j < oTypeNameObj.length; j++)
        {
            oDefaultFlagObj[j].value = "N";
            oDefaultOpenObj[j].value = "N";
            oActualOpenObj[j].value = "0";
        }
        for (var i = 1; i < checkId.length; i++)
        {
            if (R11[i].value == "b")
            {
                rdShowMessageDialog("��" + R0[i].value + "������Чʱ������ʷʱ���ͻ���������뵼�´˴β���ʧ�ܣ�", 0);
                return false;
            }
            for (var j = 0; j < oTypeNameObj.length; j++)
            {
                if (oTypeValueObj[j].value == R8[i].value)
                {
                    if (checkId[i].checked == true)
                    {
                        oActualOpenObj[j].value = 1 * oActualOpenObj[j].value + 1;
                    }
                    if (R11[i].value == "1" || R11[i].value == "a")
                    {
                        oDefaultFlagObj[j].value = "Y";
                        if (checkId[i].checked == true) oDefaultOpenObj[j].value = "Y";
                    }
                    break;
                }
            }
        }
        for (j = 0; j < oTypeNameObj.length; j++)
        {
            if (Math.round(oActualOpenObj[j].value) < Math.round(oMinOpenObj[j].value) || Math.round(oActualOpenObj[j].value) > Math.round(oMaxOpenObj[j].value))
            {		
                rdShowMessageDialog("��" + oTypeNameObj[j].value + "�����ײ�ʵ�ʿ�ͨ" + oActualOpenObj[j].value + "��Ӧ��" + oMinOpenObj[j].value + "��" + oMaxOpenObj[j].value + "֮��", 0);
                return false;
            }
            if (oDefaultFlagObj[j].value == "Y" && oDefaultOpenObj[j].value == "N")
            {
                rdShowMessageDialog("��ȷ�ϡ�" + oTypeNameObj[j].value + "�����ѡ��ʽΪ��Ĭ�ϡ����ײ����ٿ�ͨһ��");
                return false;
            }
        }
        var tempflag = "0";
        var threeflag = "0";
        for (V = 0; V < R11.length; V++)
        {
            if (R11[V].value == "4")
            {
                tempflag = 1 * tempflag + 1;
            }//��ͳ����û�е���3�����ݣ����������һ���ж�
        }
        if (tempflag > 0)
        {
            for (m = 0; m < R11.length; m++)
            {
                if (R11[m].value == "4" && checkId[m].checked == true)
                {
                    threeflag = 1 * threeflag + 1;
                }
            }
            if (threeflag < 1)
            {
                rdShowMessageDialog("����'����ѡһ'�ײ����ٿ�ͨһ��");
                return false;
            }
        }

    }
    return true;
}
/*-----------------------------------�ж��Ƿ�����Чʱ������ʷʱ���ͻ����������Ĵ�������-----------------------*/
//��ȡҳ��ʱ
onload = function()
{    
    if ("<%=bdbz%>" == "Y") {
        rdShowMessageDialog("<%=bdts%>");
    }
    for (var i = 1; i < document.all.checkId.length; i++)
    {
        if (document.all.R11[i].value == "b")
        {
            rdShowMessageDialog("��" + document.all.R0[i].value + "������Чʱ������ʷʱ���ͻ���������뵼�´˴β���ʧ�ܣ�", 0);
        }
    }
}
function openhref(p)
{
   
}
</script>
