<%
    /********************
     version v2.0
     ������: si-tech
     *
		 *update:zhanghonga@2008-08-27 ҳ�����,�޸���ʽ
		 *
     ********************/
%>
<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%
    /*
    * ����BOSS-�ײ�ʵ�֣����ʷѱ��  2003-10  
    * @author  ghostlin
    * @version 1.0
    * @since   JDK 1.4
    * Copyright (c) 2002-2003 si-tech All rights reserved.
    */
%>
<%
    /*
    * ע����������������ҳ���ı����λ�õ��Ⱥ�˳�����һ���ı���Ϊi1���Դ����ơ�
            ���ֱ������������ݶԴ˱���ʹ�õ����壬����;��
    */
%>
<HTML>
<META http-equiv=Content-Type content="text/html; charset=gb2312">
</HEAD>
<BODY>
<FORM action="" method=post name="form1">
</FORM>
<BODY>
</HTML>
<%
/*--------------------------------��֯s1272Cfm�Ĵ������-------------------------------*/
    String thework_no = (String) session.getAttribute("workNo");                         //��������                  
    String psw = (String) session.getAttribute("password");                              //��������						 
    String theop_code = "1272";                                                          //��������					 
    String themob = WtcUtil.repNull(request.getParameter("i1"));                         //�ֻ�����					 
    String do_string = WtcUtil.repNull(request.getParameter("kx_code_bunch"));           //�������  1:���� 2:ȡ��
    String addcash_string = WtcUtil.repNull(request.getParameter("kx_habitus_bunch"));   //��ѡ�ײ͵Ĵ��봮
    String ip = (String) session.getAttribute("ipAddr");                                 //��½IP					 
    String favour = "a017";                                                              //�Żݴ���					 
    String realcash = WtcUtil.repNull(request.getParameter("i19"));                      //ʵ��������				 
    String fircash = WtcUtil.repNull(request.getParameter("i20"));                       //�̶�������				 
    String sysnote = WtcUtil.repNull(request.getParameter("sysnote"));                   //ϵͳ��ע					 
    String donote = WtcUtil.repNull(request.getParameter("tonote"));                     //������ע
    String stream = WtcUtil.repNull(request.getParameter("stream"));                     //ϵͳ��ˮ
    String flag_string = WtcUtil.repNull(request.getParameter("kx_operation_bunch"));    //�����ʷ���Ч��־��
    String add_stream_str = WtcUtil.repNull(request.getParameter("kx_stream_bunch"));    //��ѡ�ײ͵Ŀ�ͨ��ˮ��
    float handcash = Float.parseFloat(realcash);                                         //�����ѵ�����
/*--------------------------------��ʼ����s1272Cfm--------------------------------*/
    String strHasEval = WtcUtil.repNull(request.getParameter("haseval"));                //�Ƿ����û���������� 
    String strEvalCode = WtcUtil.repNull(request.getParameter("evalcode"));              //�û���������۴��� 

    System.out.println("strHasEval=" + strHasEval);
    System.out.println("strEvalCode=" + strEvalCode);

%>
<%
		/************************************************************************
			@wt �������ƣ�s1272Cfm
			@wt ����ʱ�䣺2003/11/24
			@wt ������Ա��wangtao
			@wt ������������ѡ�ײͱ����ȷ��
			@wt ���������
			@wt          0  ��������            iLoginNo
			@wt          1  ��������            iLoginPwd
			@wt          2  op_code             iOpCode
			@wt          3  �ƶ�����            iPhoneNo
			@wt          4  ��ѡ�ײ͵Ĵ��봮    iAddModeStr
			@wt          5  ��ѡ�ײ͵�״̬��    iAddChgStr
			@wt          6  ��ѡ�ײͱ����Ч��    iAddSendStr
			@wt          7  �Żݴ���            iFavourCde
			@wt          8  ʵ��������          iRealFee
			@wt          9  Ӧ��������          iShouldFee
			@wt          10 ϵͳ��־            iSysNote
			@wt          11 ������־            iOpNote
			@wt          12 ��ӡ��ˮ            iLoginAccept 
			@wt          13 ��¼IP              iIpAddr
			@wt          14 ��ѡ�ײ͵Ŀ�ͨ��ˮ  iModeAcceptStr
			@wt ���������0 ���ش���
			@wt           1 ������Ϣ
		************************************************************************/
    //retArray = callView.s1272CfmProcess(thework_no, psw, theop_code, themob,do_string, addcash_string,flag_string, favour, realcash,fircash, sysnote, donote, stream, ip, add_stream_str).getList();
%>

	<wtc:service name="s1272Cfm" routerKey="phone" routerValue="<%=themob%>" outnum="3" >
	<wtc:param value="<%=thework_no%>"/>
	<wtc:param value="<%=psw%>"/>
	<wtc:param value="<%=theop_code%>"/>
	<wtc:param value="<%=themob%>"/>
	<wtc:param value="<%=do_string%>"/>
	<wtc:param value="<%=addcash_string%>"/>	
	<wtc:param value="<%=flag_string%>"/>
	<wtc:param value="<%=favour%>"/>
	<wtc:param value="<%=realcash%>"/>
	<wtc:param value="<%=fircash%>"/>
	<wtc:param value="<%=sysnote%>"/>
	<wtc:param value="<%=donote%>"/>
	<wtc:param value="<%=stream%>"/>
	<wtc:param value="<%=ip%>"/>
	<wtc:param value="<%=add_stream_str%>"/>
	</wtc:service>
	<wtc:array id="result" scope="end"/>		
<%
		String ret_code = "999999";
		String ret_msg  = "s1272Cfm����δ�ܳɹ�";
		if(result!=null&&result.length>0){
		    ret_code = result[0][0];
    		ret_msg = result[0][1];
		}
		
		
		System.out.println("%%%%%%%����ͳһ�Ӵ���ʼ%%%%%%%%");
		String cnttLoginAccept = stream;
		String url = "/npage/contact/upCnttInfo.jsp?opCode=1272&retCodeForCntt="+ret_code+"&opName=��ѡ�ʷѱ��&workNo="+thework_no+"&loginAccept="+cnttLoginAccept+"&pageActivePhone="+themob+"&opBeginTime="+opBeginTime+"&contactId="+themob+"&contactType=user";
%>
		<jsp:include page="<%=url%>" flush="true" />
<%		
		System.out.println("%%%%%%%����ͳһ�Ӵ�����%%%%%%%%");
		
//�Է�����Ϣ�Ŀ���
    if (ret_msg.equals("")) {
        ret_msg = SystemUtils.ISOtoGB(ErrorMsg.getErrorMsg(ret_code));
        if (ret_msg.equals("null")) {
            ret_msg = "δ֪������Ϣ";
        }
    }

//���� 2008��1��3�� �޸������û��������������
    String[] ret = new String[]{};
    if (ret_code.equals("000000") && strHasEval.equals("1")) {
        String strParaAray[] = new String[6];
        strParaAray[0] = thework_no;     			//0  ��������                iLoginNo  thework_no
        strParaAray[1] = theop_code;    	 		//1  ��������                iOpCode   theop_code
        strParaAray[2] = themob;              //2  �ƶ�����                iPhoneNo  themob                         
        strParaAray[3] = strEvalCode; 				//3  ���۴���
        strParaAray[4] = stream;              //5  ������ˮ
        strParaAray[5] = "0";

        //ret = impl.callService("sCommEvalCfm", strParaAray, "2", "phone", themob);
%>

				<wtc:service name="sCommEvalCfm" routerKey="phone" routerValue="<%=themob%>" outnum="2" >
				<wtc:param value="<%=strParaAray[0]%>"/>
				<wtc:param value="<%=strParaAray[1]%>"/>
				<wtc:param value="<%=strParaAray[2]%>"/>
				<wtc:param value="<%=strParaAray[3]%>"/>
				<wtc:param value="<%=strParaAray[4]%>"/>
				<wtc:param value="<%=strParaAray[5]%>"/>
				</wtc:service>
				<wtc:array id="result3" start="0" length="2" scope="end"/>		
				<wtc:array id="mainResultArr" start="2" length="13" scope="end"/>
<%
				int iReturnCode = 999999;
				if(retCode!=""){
					iReturnCode = Integer.parseInt(retCode);
				}
        String strReturnMsg = retMsg;

        System.out.println("iReturnCode=" + iReturnCode);
        System.out.println("strReturnMsg=" + strReturnMsg);
    }
    
    /*************************************��ô�ӡ��Ʊ�Ĳ���****************************************/
    String cardno = WtcUtil.repNull(request.getParameter("i7"));                        //���֤����
    String name = WtcUtil.repNull(request.getParameter("i4"));                          //�û�����
    String address = WtcUtil.repNull(request.getParameter("i5"));                       //�û���ַ
		/***********************************************************************************************/
%>
<script language="jscript">
    function printBill() {
        var infoStr = "";
        infoStr += '<%=cardno%>' + "|";//���֤����                                                  
        infoStr += '<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>' + "|";//����
        infoStr += '<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>' + "|";
        infoStr += '<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>' + "|";
        infoStr += '<%=themob%>' + "|";//�ƶ�����                                                   
        infoStr += "" + "|";//��ͬ����                                                          
        infoStr += '<%=name%>' + "|";//�û�����                                                
        infoStr += '<%=address%>' + "|";//�û���ַ
        infoStr += "�ֽ�" + "|";
        infoStr += '<%=handcash%>' + "|";
        infoStr += "��ѡ�ʷѱ����*�����ѣ�" + '<%=realcash%>' + "*��ˮ�ţ�" + '<%=stream%>' + "|";
        location = "chkPrint.jsp?retInfo=" + infoStr + "&dirtPage=f1272_1.jsp&activePhone=<%=themob%>";
    }
</script>


<%if (ret_code.equals("000000") && handcash > 0.0) {%>
		<script language="jscript">
		    rdShowMessageDialog('��ѡ�ʷѱ�������ɹ�����ӡ��Ʊ.......',2);
		    printBill();
		</script>
<%}%>

<%if (ret_code.equals("000000")) {%>
		<script language='jscript'>
		    rdShowMessageDialog('��ѡ�ʷѱ�������ɹ���',2);
		    history.go(-2);
		</script>
<%}%>


<%if (!ret_code.equals("000000")) {%>
<script language='jscript'>
    var ret_code = "<%=ret_code%>";
    var ret_msg = "<%=ret_msg%>";
    rdShowMessageDialog("��ѯ����<br>������룺'<%=ret_code%>'��<br>������Ϣ��'<%=ret_msg%>'��");
    history.go(-1);
</script>
<%}%>



