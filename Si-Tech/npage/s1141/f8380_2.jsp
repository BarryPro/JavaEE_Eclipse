<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * ����: ����Ԥ������8380
   * �汾: 1.0
   * ����: 2008/12/30
   * ����: leimd
   * ��Ȩ: si-tech
   * update:
  */
%>
<%@ page contentType="text/html;charset=gbk"%>
<%@ page import="com.sitech.boss.spubcallsvr.viewBean.*" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.s1100.viewBean.*" %>
<!-- **** ningtn add for pos @  ******���ؽ��пؼ�ҳ BankCtrl ******** -->
<%@ include file="/npage/public/posCCB.jsp" %>
<!-- **** ningtn add for pos @  ******���ع��пؼ�ҳ KeeperClient ******** -->
<%@ include file="/npage/public/posICBC.jsp" %>
<%
	String opCode="8380";
	String opName="����Ԥ������";
	String work_no = (String)session.getAttribute("workNo");
	String work_name = (String)session.getAttribute("workName");
	String cust_name = request.getParameter("cust_name");
	String sum_money = request.getParameter("sum_money");
	String regionCode = (String)session.getAttribute("regCode");			//����									
	String phoneNo = (String)request.getParameter("phone_no");				//�ֻ�����
	String password = (String)session.getAttribute("password");
	String ip_Addr = (String)session.getAttribute("ipAddr");
	String chinaFee = "";	                                            	//��д���
		
	///////<!-- ningtn add for pos start @  -->
	String payType		   = request.getParameter("payType");/**�ɷ����� payType=BX �ǽ��� payType=BY �ǹ���**/
	String MerchantNameChs = request.getParameter("MerchantNameChs");/**�Ӵ˿�ʼ����Ϊ���в���**/
	String MerchantId      = request.getParameter("MerchantId");
	String TerminalId      = request.getParameter("TerminalId");
	String IssCode         = request.getParameter("IssCode");
	String AcqCode         = request.getParameter("AcqCode");
	String CardNo          = request.getParameter("CardNo");
	String BatchNo         = request.getParameter("BatchNo");
	String Response_time   = request.getParameter("Response_time");
	String Rrn             = request.getParameter("Rrn");
	String AuthNo          = request.getParameter("AuthNo");
	String TraceNo         = request.getParameter("TraceNo");
	String Request_time    = request.getParameter("Request_time");
	String CardNoPingBi    = request.getParameter("CardNoPingBi");
	String ExpDate         = request.getParameter("ExpDate");
	String Remak           = request.getParameter("Remak");
	String TC              = request.getParameter("TC");
	
	System.out.println("payType : " + payType);
	System.out.println("MerchantNameChs : " + MerchantNameChs);
	System.out.println("MerchantId : " + MerchantId);
	System.out.println("Response_time : " + Response_time);
	System.out.println("TerminalId : " + TerminalId);
	System.out.println("Request_time : " + Request_time);
	System.out.println("Rrn : " + Rrn);
	///////<!-- ningtn add for pos end @  -->
	String paraAray[] = new String[27];
	paraAray[0] = request.getParameter("login_accept");						//��ˮ
	paraAray[1] ="01";
	paraAray[2] = request.getParameter("opcode");
	paraAray[3] = work_no;
	paraAray[4] = password;
	paraAray[5] = request.getParameter("phone_no");							//�ֻ�����
	paraAray[6] = "";
    paraAray[7] = request.getParameter("backaccept");                       //����ˮ
	paraAray[8] = request.getParameter("opNote");  
	paraAray[9] = request.getParameter("ip_Addr");
///////<!-- ningtn add for pos start @  -->
	paraAray[10]  = payType		   ;
	paraAray[11]  = MerchantNameChs ;
	paraAray[12]  = MerchantId      ;
	paraAray[13]  = TerminalId      ;
	paraAray[14] = IssCode         ;
	paraAray[15] = AcqCode         ;
	paraAray[16] = CardNo          ;
	paraAray[17] = BatchNo         ;
	paraAray[18] = Response_time   ;
	paraAray[19] = Rrn             ;
	paraAray[20] = AuthNo          ;
	paraAray[21] = TraceNo         ;
	paraAray[22] = Request_time    ;
	paraAray[23] = CardNoPingBi    ;
	paraAray[24] = ExpDate         ;
	paraAray[25] = Remak           ;
	paraAray[26] = TC              ;
///////<!-- ningtn add for pos end @  -->
%>
	<wtc:service name="s8380Cfm" routerKey="region" routerValue="<%=regionCode%>" outnum="2" retcode="retCode" retmsg="retMsg">
		<wtc:param value="<%=paraAray[0]%>"/>
		<wtc:param value="<%=paraAray[1]%>"/>
		<wtc:param value="<%=paraAray[2]%>"/>
		<wtc:param value="<%=paraAray[3]%>"/>
		<wtc:param value="<%=paraAray[4]%>"/>
		<wtc:param value="<%=paraAray[5]%>"/>
		<wtc:param value="<%=paraAray[6]%>"/>
		<wtc:param value="<%=paraAray[7]%>"/>
		<wtc:param value="<%=paraAray[8]%>"/>
		<wtc:param value="<%=paraAray[9]%>"/>
		<wtc:param value="<%=paraAray[10]%>"/>
		<wtc:param value="<%=paraAray[11]%>"/>
		<wtc:param value="<%=paraAray[12]%>"/>
		<wtc:param value="<%=paraAray[13]%>"/>
		<wtc:param value="<%=paraAray[14]%>"/>
		<wtc:param value="<%=paraAray[15]%>"/>
		<wtc:param value="<%=paraAray[16]%>"/>
		<wtc:param value="<%=paraAray[17]%>"/>
		<wtc:param value="<%=paraAray[18]%>"/>
		<wtc:param value="<%=paraAray[19]%>"/>
		<wtc:param value="<%=paraAray[20]%>"/>
		<wtc:param value="<%=paraAray[21]%>"/>
		<wtc:param value="<%=paraAray[22]%>"/>
		<wtc:param value="<%=paraAray[23]%>"/>
		<wtc:param value="<%=paraAray[24]%>"/>
		<wtc:param value="<%=paraAray[25]%>"/>
		<wtc:param value="<%=paraAray[26]%>"/>
	</wtc:service>
	<wtc:array id="result" scope="end"/>
<%
	String errCode = retCode;
	String errMsg = retMsg;
	if (errCode.equals("000000") )
	{
%>
	<script language="javascript">
		/*** ningtn add for pos start @  *****/
		if("<%=payType%>"=="BX"){
			BankCtrl.TranOK();
		}
		if("<%=payType%>"=="BY"){
			var IfSuccess = KeeperClient.UpdateICBCControlNum();
		}
		/*** ningtn add for pos end  @  *****/
	</script>

	<wtc:service name="sToChinaFee" routerKey="region" routerValue="<%=regionCode%>" retcode="sToChinaFeeCode" retmsg="sToChinaFeeMsg" outnum="3">
		<wtc:param value="<%=WtcUtil.formatNumber(sum_money,2)%>"/>
	</wtc:service>
	<wtc:array id="result" scope="end"/>
<%
    if(result.length>0 && sToChinaFeeCode.equals("0")){
        chinaFee = result[0][2];
    }
	System.out.print(chinaFee);
%>
<%
	String url ="/npage/contact/upCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+retCode+"&opName="+opName+"&workNo="+work_no+"&loginAccept="+paraAray[0]+"&pageActivePhone="+phoneNo+"&retMsgForCntt="+retMsg+"&opBeginTime="+opBeginTime;
	System.out.println("url===="+url);
%>
	<jsp:include page="<%=url%>" flush="true" />
		<script language="JavaScript">
		if("<%=sum_money%>">0)
		{
		   rdShowMessageDialog("ȷ�ϳɹ�! ���潫��ӡ��Ʊ��",2);
		   var infoStr="";
		   infoStr+="<%=work_no%>  <%=paraAray[0]%>"+"       ����Ԥ������"+"|";//����
		   infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";
		   infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
		   infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
		   infoStr+='<%=cust_name%>'+"|";
		   infoStr+=" "+"|";
		   infoStr+='<%=paraAray[5]%>'+"|";
		   infoStr+=" "+"|";//Э�����
		   infoStr+=" "+"|";
		   infoStr+="<%=chinaFee%>"+"|";//�ϼƽ��(��д)
		   infoStr+="<%=WtcUtil.formatNumber(sum_money,2)%>"+"|";//Сд
		   infoStr+="��Ԥ��  <%=sum_money%>Ԫ"+"|";

			infoStr+="<%=work_name%>"+"|";//��Ʊ��
			infoStr+=" "+"|";//�տ���
			/**** ningtn add for pos start @  ****/      
			if("<%=payType%>"=="BX"||"<%=payType%>"=="BY"){      
				infoStr+=" "+"|";/*ռλ��15������*/               
				infoStr+=" "+"|";/*ռλ��16������*/               
				infoStr+="<%=payType%>"+"|";                      
				infoStr+="<%=MerchantNameChs%>"+"|";              
				infoStr+="<%=CardNoPingBi   %>"+"|";              
				infoStr+="<%=MerchantId     %>"+"|";              
				infoStr+="<%=BatchNo        %>"+"|";              
				infoStr+="<%=IssCode        %>"+"|";              
				infoStr+="<%=TerminalId     %>"+"|";              
				infoStr+="<%=AuthNo         %>"+"|";              
				infoStr+="<%=Response_time  %>"+"|";              
				infoStr+="<%=Rrn            %>"+"|";              
				infoStr+="<%=TraceNo        %>"+"|";              
				infoStr+="<%=AcqCode        %>"+"|";              
			}                                                    
			/**** ningtn add for pos end  @ ****/      
			dirtPate = "/npage/s1141/f8379_login.jsp?activePhone=<%=phoneNo%>&opCode=8380&opName=����Ԥ������";
			//location="/npage/public/hljBillPrint.jsp?retInfo="+infoStr+"&dirtPage="+codeChg(dirtPate);
			location="/npage/public/hljBillPrintNew.jsp?retInfo="+infoStr+"&dirtPage="+codeChg(dirtPate)+"&op_code=8380&loginAccept=<%=paraAray[0]%>";
		  }else
		  {
				rdShowMessageDialog("ȷ�ϳɹ�!",2);
				window.location="/npage/s1141/f8379_login.jsp?activePhone=<%=phoneNo%>&opCode=8380&opName=����Ԥ������";
		  }
		</script>
<%
	}else{
%>
<script language="JavaScript">
	rdShowMessageDialog("����Ԥ������ʧ��!(<%=errMsg%>",0);
	window.location="f8379_login.jsp?activePhone=<%=phoneNo%>&opCode=8380&opName=����Ԥ������";
</script>
<%}%>
