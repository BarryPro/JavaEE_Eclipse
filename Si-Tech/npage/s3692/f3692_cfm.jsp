<%
/********************
 * version v2.0
 * ������: si-tech
 * author by leimd @ 2009-04-13
 ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
	String opCode = "3692";
	String opName = "���Ų�Ʒ�ʷѱ��";
	String regionCode = (String)session.getAttribute("regCode");				//���д���
	
	String sInLoginNo = (String)session.getAttribute("workNo");					//��������
	String sInLoginPasswd = (String)session.getAttribute("password");			//��������
	String sInOpCode = opCode;													//��������
	String sInOpNote = (String)request.getParameter("opNote");					//��������
	String sInLoginAccept = (String)request.getParameter("loginAccept");		//������ˮ
	
	String sInSystemNote = (String)request.getParameter("sysnote");				//ϵͳ��ע
	String sInIpAddr = (String)session.getAttribute("ipAddr");					//��¼IP
	String sInGrpIdNo = (String)request.getParameter("grp_id");					//�����û�ID(�����Ų�ƷID)
	String sInProductCode = (String)request.getParameter("product_code");		//��Ʒ����
	String gongnengfee   = request.getParameter("gongnengfee");					//���ܸ��ѷ�ʽ
	
	String mainRate = (String)request.getParameter("oldMainRate");				//����ԭ�����ʴ���
	String newRate = (String)request.getParameter("newRate");					//�·��ʴ���
	String grpOutNo = (String)request.getParameter("user_no");					//�����û��ⲿ����(�������û����)
	
	String sInProductCodeAdd = (String)request.getParameter("product_append");	//���Ӳ�Ʒ����
	String sInProductPrices = (String)request.getParameter("product_prices");	//��Ʒ�۸����
	String sInProductAttr = (String)request.getParameter("product_attr");		//��Ʒ����
	String sInProductType = (String)request.getParameter("product_type");		//��Ʒ����
	String sInServiceCode = (String)request.getParameter("service_code");		//�������
	String sInServiceAttr = (String)request.getParameter("service_attr");		//��������
	String sInShouldPay = (String)request.getParameter("shouldPay");			//һ���Է���
	
	
	String F10964 = (String)request.getParameter("F10964");			//���ԭ��
	String F10965 = (String)request.getParameter("F10965");			//��ز�Ʒ�˺�
	
	
	String[] newAddRate = new String[100];
	if(request.getParameterValues("optionalRate")!=null){
		newAddRate = request.getParameterValues("optionalRate");
	}
	//String[] newAddRate       = request.getParameterValues("optionalRate");
    
	String iCustId = WtcUtil.repNull((String)request.getParameter("cust_id"));
	String iSmCode = WtcUtil.repNull((String)request.getParameter("sm_code"));
	
	String messhotxftime = WtcUtil.repNull((String)request.getParameter("messhotxftime"));
	String messshotinfos = WtcUtil.repNull((String)request.getParameter("messshotinfos"));
	
	int i=0,j=0,k=0;
	
	i = sInProductCode.indexOf("|"); //�õ�����Ʒ����
	if(i<0)
	i=sInProductCode.length();
	System.out.println("------------i---------------|"+i);
	System.out.println("------------sInProductCode---------------"+sInProductCode);
    sInProductCode = sInProductCode.substring(0, i);
	
	StringTokenizer productToken=new StringTokenizer(sInProductCodeAdd,",");
    StringTokenizer productToken1=new StringTokenizer(sInProductCodeAdd,",");
    j = 0;
    while (productToken.hasMoreElements()){
        System.out.println("---4444---"+productToken.nextElement());
	    j++;
    }
    String[] ProdAppend = new String[j]; //�����Ӳ�Ʒ����Ʒ�۸񡢲�Ʒ���Էֽ⵽������
    i = 0;
    while (productToken1.hasMoreElements()){
        ProdAppend[i] = (String)productToken1.nextElement();
        i++;
    }
	if(ProdAppend.length==0){
		ProdAppend = new String[1];
	}
	/*
	String[] ProdAppend = new String[j+1]; //�����Ӳ�Ʒ����Ʒ�۸񡢲�Ʒ���Էֽ⵽������
    ProdAppend[0] = sInProductCode;
    for(i=1; i<j+1; i++) {
        k = sInProductCodeAdd.indexOf(',');
        if (k > 0)
            ProdAppend[i] = sInProductCodeAdd.substring(0, k);
        else
            ProdAppend[i] = sInProductCodeAdd;
    }
    */
	
	System.out.println("1111111111111111111111111111111111111111+newAddRate="+newAddRate);
	System.out.println("1111111111111111111111111111111111111111+mainRate="+mainRate);
	System.out.println("1111111111111111111111111111111111111111+newRate="+newRate);
	System.out.println("1111111111111111111111111111111111111111+grpOutNo="+grpOutNo);
	System.out.println("1111111111111111111111111111111111111111+sInProductCodeAdd="+sInProductCodeAdd);
	System.out.println("1111111111111111111111111111111111111111+ProdAppend.length="+ProdAppend.length);
    System.out.println("# sInProductPrices = "+sInProductPrices);
    
    
    
    String wa_no1 = (String)request.getParameter("wa_no1");			
    
%>

	<wtc:service name="s3692Cfm" routerKey="region" routerValue="<%=regionCode%>" retcode="s3692retCode" retmsg="s3692retMsg" outnum="1" >
    	<wtc:param value="<%=sInLoginNo%>"/>
        <wtc:param value="<%=sInLoginPasswd%>"/> 
        <wtc:param value="<%=sInOpCode%>"/>
        <wtc:param value="<%=sInOpNote%>"/>
        <wtc:param value="<%=sInLoginAccept%>"/>
        
        <wtc:param value="<%=sInSystemNote%>"/>
        <wtc:param value="<%=sInIpAddr%>"/>
        <wtc:param value="<%=sInGrpIdNo%>"/>
        <wtc:param value="<%=sInProductCode%>"/>
        <wtc:param value="<%=gongnengfee%>"/>
        
        <wtc:param value="<%=mainRate%>"/>
        <wtc:param value="<%=newRate%>"/>
        <wtc:param value="<%=grpOutNo%>"/>
        <wtc:param value="u03"/>
        <wtc:param value="1"/> 
        <wtc:param value="<%=sInProductPrices%>"/>    
        <wtc:param value="<%=sInShouldPay%>"/>
        <wtc:param value=""/>
        <wtc:param value=""/>
        <wtc:param value=""/> 
        <%if(newAddRate == null){%>
            <wtc:param value=""/> 
        <%}else{%>
            <wtc:params value="<%=newAddRate%>"/> 
        <%}%>
        <%if(ProdAppend == null){%>
            <wtc:param value=""/> 
        <%}else{%>
            <wtc:params value="<%=ProdAppend%>"/>
        <%}%>
        <wtc:param value="<%=wa_no1%>"/>
        <wtc:param value="<%=messhotxftime%>"/>
        <wtc:param value="<%=messshotinfos%>"/>
        
        <wtc:param value="<%=F10964%>"/>
        <wtc:param value="<%=F10965%>"/>		
        	
        	
        
    </wtc:service>
    <wtc:array id="retArr" scope="end"/>
    	
<%
	String retCode = s3692retCode ; 
	String retMsg = s3692retMsg ;
	System.out.println("retCode === "+ retCode);
	System.out.println("retMsg === "+ retMsg);
	
	if (retCode.equals("000000"))
	{
    	if(!"va".equals(iSmCode)){
        %>
        	<script language="JavaScript">
        		rdShowMessageDialog("�����û���Ʒ����ɹ���",2);
        		window.location="f3692_1.jsp";
        		//history.go(-1);
        	</script>
        <%
        }else{
            %>
        	<script language="JavaScript">
        		rdShowMessageDialog("���ݱ���ɹ������ѯ��������",2);
        		window.location="f3692_1.jsp";
        		//history.go(-1);
        	</script>
        	<%
        }
	}else{
%>   
	<script language="JavaScript">
		rdShowMessageDialog("�����û���Ʒ���ʧ��!(<%=retMsg%>,[<%=retCode%>])",0);
		history.go(-1);
	</script>
<%}

	String url = "/npage/contact/onceCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+retCode+"&retMsgForCntt="+retMsg
		+"&opName="+opName+"&workNo="+sInLoginNo+"&loginAccept="+sInLoginAccept+"&pageActivePhone="+sInGrpIdNo
		+"&opBeginTime="+opBeginTime+"&contactId="+sInGrpIdNo+"&contactType=grp";
%>
	<jsp:include page="<%=url%>" flush="true" />
