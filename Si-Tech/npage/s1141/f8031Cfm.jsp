<%
/********************
 version v2.0
 ������ si-tech
 update hejw@2009-2-6
********************/
%>

<%@ include file="/npage/include/public_title_name.jsp" %>   

<%@ page contentType="text/html;charset=gbk"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.boss.s1100.viewBean.*" %>
<!-- **** ningtn add for pos @ 20100722 ******���ؽ��пؼ�ҳ BankCtrl ******** -->
<%@ include file="/npage/public/posCCB.jsp" %>
<!-- **** ningtn add for pos @ 20100722 ******���ع��пؼ�ҳ KeeperClient ******** -->
<%@ include file="/npage/public/posICBC.jsp" %>

<%	
	String work_no = (String)session.getAttribute("workNo");
	String work_name = (String)session.getAttribute("workName");
	String regionCode = (String)session.getAttribute("regCode");
	
	
	String cust_name=request.getParameter("cust_name"); 
	String sum_money=request.getParameter("sum_money");
	String prepay_fee=request.getParameter("limit_pay"); 
	String sale_name=request.getParameter("sale_name");
	String card_info=request.getParameter("");
	String card_money=request.getParameter("");   
	String machine_type=request.getParameter("machine_type");
	String paraAray[] = new String[23];
	String opNamew = request.getParameter("opName");
	String opCodew = request.getParameter("opCode");
	///////<!-- ningtn add for pos start @ 20100722 -->
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
	
	///////<!-- ningtn add for pos end @ 20100722 -->
	paraAray[0] =request.getParameter("login_accept");
	paraAray[1] = request.getParameter("phone_no");
	paraAray[2] = request.getParameter("opcode");
 	paraAray[3] = work_no;
  	paraAray[4] = request.getParameter("backaccept");
	paraAray[5] = request.getParameter("opNote");
	///////<!-- ningtn add for pos start @ 20100722 -->
	paraAray[6]  = payType		   ;
	paraAray[7]  = MerchantNameChs ;
	paraAray[8]  = MerchantId      ;
	paraAray[9]  = TerminalId      ;
	paraAray[10] = IssCode         ;
	paraAray[11] = AcqCode         ;
	paraAray[12] = CardNo          ;
	paraAray[13] = BatchNo         ;
	paraAray[14] = Response_time   ;
	paraAray[15] = Rrn             ;
	paraAray[16] = AuthNo          ;
	paraAray[17] = TraceNo         ;
	paraAray[18] = Request_time    ;
	paraAray[19] = CardNoPingBi    ;
	paraAray[20] = ExpDate         ;
	paraAray[21] = Remak           ;
	paraAray[22] = TC              ;
	///////<!-- ningtn add for pos end @ 20100722 -->
  	String vUnitId =  request.getParameter("vUnitId");
  	String chinaFee="";
    	
	
              

	//String[] ret = impl.callService("s8031Cfm",paraAray,"2","region",regionCode);
%>

    <wtc:service name="s8031Cfm" outnum="2" retmsg="msg1" retcode="code1" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=paraAray[0]%>" />
			<wtc:param value="<%=paraAray[1]%>" />
			<wtc:param value="<%=paraAray[2]%>" />	
			<wtc:param value="<%=paraAray[3]%>" />
			<wtc:param value="<%=paraAray[4]%>" />
			<wtc:param value="<%=paraAray[5]%>" />
			<wtc:param value="<%=paraAray[6]%>" />
			<wtc:param value="<%=paraAray[7]%>" />
			<wtc:param value="<%=paraAray[8]%>" />	
			<wtc:param value="<%=paraAray[9]%>" />
			<wtc:param value="<%=paraAray[10]%>" />
			<wtc:param value="<%=paraAray[11]%>" />
			<wtc:param value="<%=paraAray[12]%>" />
			<wtc:param value="<%=paraAray[13]%>" />
			<wtc:param value="<%=paraAray[14]%>" />	
			<wtc:param value="<%=paraAray[15]%>" />
			<wtc:param value="<%=paraAray[16]%>" />
			<wtc:param value="<%=paraAray[17]%>" />
			<wtc:param value="<%=paraAray[18]%>" />	
			<wtc:param value="<%=paraAray[19]%>" />
			<wtc:param value="<%=paraAray[20]%>" />
			<wtc:param value="<%=paraAray[21]%>" />
			<wtc:param value="<%=paraAray[22]%>" />
		</wtc:service>

<%	
	String errCode = code1;
	String errMsg = msg1;
%>

<%String url = "/npage/contact/onceCnttInfo.jsp?opCode="+opCodew+
								 "&retCodeForCntt="+errCode+
								 "&retMsgForCntt="+errMsg+
	               "&opName="+opNamew+
     	    			 "&workNo="+work_no+
     	    			 "&loginAccept="+paraAray[4]+
     	    			 "&pageActivePhone="+paraAray[1]+
     	    			 "&opBeginTime="+opBeginTime+
     	    			 "&contactId="+paraAray[1]+
     	    			 "&contactType=user";%>
     	    			 
<jsp:include page="<%=url%>" flush="true" />

<%	
	if (errCode.equals("000000") )
	{
		//S1100View callView = new S1100View();
		//String chinaFee = ((String[][])(callView.view_sToChinaFee(WtcUtil.formatNumber(sum_money,2)).get(0)))[0][2];//��д���
%>
	<script language="javascript">
		/*** ningtn add for pos start @ 20100722 *****/
		if("<%=payType%>"=="BX"){
			BankCtrl.TranOK();
		}
		if("<%=payType%>"=="BY"){
			var IfSuccess = KeeperClient.UpdateICBCControlNum();
		}
		/*** ningtn add for pos end  @ 20100722 *****/
	</script>
	<wtc:service name="sToChinaFee" routerKey="region" routerValue="<%=regionCode%>" retcode="sToChinaFeeCode" retmsg="sToChinaFeeMsg" outnum="3">
		<wtc:param value="<%=WtcUtil.formatNumber(sum_money,2)%>"/>
	</wtc:service>
	<wtc:array id="result" scope="end"/>
<%
    if(result.length>0 && sToChinaFeeCode.equals("0")){
        chinaFee = result[0][2];
    }
			
	System.out.print("------------------------chinaFee-------------------"+chinaFee);
%>
<script language="JavaScript">
   rdShowMessageDialog("�ύ�ɹ�! ���潫��ӡ��Ʊ��");
   var infoStr="";
   infoStr+="<%=work_no%>  <%=work_name%>"+"       �����û�Ԥ�滰���Żݹ�������"+"|";//����  
   infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";
   infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
   infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
   infoStr+='<%=cust_name%>'+"|";
   infoStr+=" "+"|";
   infoStr+='<%=paraAray[1]%>'+"|";
   infoStr+=" "+"|";//Э�����                                                          
   infoStr+="�ֻ��ͺţ�"+"<%=machine_type%>"+"|";//�ֻ��ͺ� 
   infoStr+="<%=chinaFee%>"+"|";//�ϼƽ��(��д)
   infoStr+="<%=WtcUtil.formatNumber(sum_money,2)%>"+"|";//Сд 
   
   
    /********* tianyang add for ֧Ʊ�ɷ� start **************************************/
	var money_pos = "<%=WtcUtil.formatNumber(0,2)%>" ;
	var money_9 = "<%=WtcUtil.formatNumber(0,2)%>" ;
	var money_0 = "<%=WtcUtil.formatNumber(0,2)%>" ;		
	if("<%=payType%>"=="BX"||"<%=payType%>"=="BY"){
		money_pos = "<%=WtcUtil.formatNumber(sum_money,2)%>" ;
	}else if("<%=payType%>"=="9"){
		money_9 = "<%=WtcUtil.formatNumber(sum_money,2)%>" ;
	}else{
		money_0 = "<%=WtcUtil.formatNumber(sum_money,2)%>" ;
	}
	infoStr+="�˿�ϼƣ��ֽ�:"+money_0+"��֧Ʊ:"+money_9+"��POS��:"+money_pos+
		 "������Ԥ�滰�ѣ� <%=prepay_fee%>Ԫ"+"|";
	/********* tianyang add for ֧Ʊ�ɷ� end **************************************/
   
   /*infoStr+="�˿�ϼƣ�  <%=sum_money%>"+
		 "��Ԥ�滰�ѣ� <%=prepay_fee%>"+"|";*/
		

	 infoStr+="<%=work_name%>"+"|";//��Ʊ��
	 infoStr+=" "+"|";//�տ���
	 /**** ningtn add for pos start @ 20100722 ****/      
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
	/**** ningtn add for pos end  @ 20100722****/  
  // location="/page/s1210/chkPrint.jsp?retInfo="+infoStr+"&dirtPage=/page/s1775/f1775_1.jsp";
   var dirtPage="/npage/s1141/f8030.jsp?opCode=<%=opCodew%>&opName=<%=opNamew%>&activePhone=<%=paraAray[1]%>"
   //location="/npage/public/hljBillPrint.jsp?retInfo="+infoStr+"&dirtPage="+codeChg(dirtPage);
   location="/npage/public/hljBillPrintNew.jsp?retInfo="+infoStr+"&op_code=<%=opCodew%>&loginAccept=<%=paraAray[4]%>&dirtPage="+codeChg(dirtPage);
</script>
<%
	}else{
%>   
<script language="JavaScript">
	rdShowMessageDialog("�����û�Ԥ�滰���Żݹ�������ʧ��!(<%=errMsg%>");
		 location="f8030.jsp?opCode=<%=opCodew%>&opName=<%=opNamew%>&activePhone=<%=paraAray[1]%>";
</script>
<%}%>
