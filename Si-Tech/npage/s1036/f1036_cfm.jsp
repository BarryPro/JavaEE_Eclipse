<%
/********************
 * version v2.0
 * ������: si-tech
 * author by wangzn @ 2010-7-9 11:26:39
 ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
	String opCode = "1036";
	String opName = "���Ų�Ʒ������ǩ";
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
	String[] newAddRate       = request.getParameterValues("optionalRate");
    
	String iCustId = WtcUtil.repNull((String)request.getParameter("cust_id"));
	String iSmCode = WtcUtil.repNull((String)request.getParameter("sm_code"));
	
	int i=0,j=0,k=0;
	
	i = sInProductCode.indexOf("|"); //�õ�����Ʒ����
	if(i<0)
	i=sInProductCode.length();
	System.out.println("------------i---------------|"+i);
	System.out.println("------------sInProductCode---------------"+sInProductCode);
    sInProductCode = sInProductCode.substring(0, i);
	
	StringTokenizer productToken=new StringTokenizer(sInProductCodeAdd,",");
    StringTokenizer productToken1=new StringTokenizer(sInProductCodeAdd,",");
    
    k = 0;
    k = productToken1.countTokens();//wangleic add 2011-4-28 04:55PM
    
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
%>
<wtc:service name="s1036Cfm" routerKey="region" routerValue="<%=regionCode%>" retcode="s3692retCode" retmsg="s3692retMsg" outnum="1" >
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
        <wtc:param value=""/>
        <wtc:param value=""/>
        <wtc:param value=""/>
        <wtc:param value=""/> 
        <%if(newAddRate == null){%>
            <wtc:param value=""/> 
        <%}else{%>
            <wtc:params value="<%=newAddRate%>"/> 
        <%}%>
        <%if(k == 0){%>
            <wtc:param value=""/> 
        <%}else{%>
            <wtc:params value="<%=ProdAppend%>"/>
        <%}%>
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
        		rdShowMessageDialog("���Ų�Ʒ������ǩ��",2);
        		window.location="f1036.jsp";
        	</script>
        <%
        }else{
            %>
        	<script language="JavaScript">
        		rdShowMessageDialog("���ݱ���ɹ������ѯ��������",2);
        		window.location="f1036.jsp";
        		//history.go(-1);
        	</script>
        	<%
        }
	}else{
%>   
	<script language="JavaScript">
		rdShowMessageDialog("���Ų�Ʒ������ǩʧ��!(<%=retMsg%>,[<%=retCode%>])",0);
		history.go(-1);
	</script>
<%}

	String url = "/npage/contact/onceCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+retCode+"&retMsgForCntt="+retMsg
		+"&opName="+opName+"&workNo="+sInLoginNo+"&loginAccept="+sInLoginAccept+"&pageActivePhone="+sInGrpIdNo
		+"&opBeginTime="+opBeginTime+"&contactId="+sInGrpIdNo+"&contactType=grp";
%>
	<jsp:include page="<%=url%>" flush="true" />
