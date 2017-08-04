<%
/********************
 * version v3.0
 * ������: si-tech
 * ��  �ܣ�7435 - ���Ų�Ʒ�������Ʊ�����
 * ��  �������÷���sSrvNoLimit�������ñ�cServerNoLimit������ɾ���ġ���
 * author: qidp @ 2009-06-30
 ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.util.page.*"%>


<%
	String opCode="7435";
	String opName="���Ų�Ʒ�������Ʊ�����";
	
	String regionCode = (String)session.getAttribute("regCode");
	
	String tableName = request.getParameter("tableName");//�����ı���
	String opType = request.getParameter("opType");//�������ͣ�00-ɾ�� 01-�޸� 02-����
	
	String netAttr = request.getParameter("serverNoNetAttr");
	String smCode = request.getParameter("serverNoSmCode");
	String maxLength = request.getParameter("serverNoMaxLength");
	String minLength = request.getParameter("serverNoMinLength");
	String accessFlag = request.getParameter("serverNoAccessFlag");
	String lengthFlag = request.getParameter("serverNoLengthFlag");
	String[] delArr = request.getParameterValues("serverNoCheck");
	int delLength = 0;
	if(delArr != null){
	    delLength = delArr.length;
	}
	
	String[] in_netAttrArr = null;
	String[] in_smCodeArr = null;
	String in_maxLength = "";
	String in_minLength = "";
	String in_accessFlag = "";
	String in_lengthFlag = "";
	
	String netAttrTmp = "";
	String smCodeTmp = "";
	
	if("00".equals(opType)){//ɾ��
	    in_netAttrArr = new String[delLength];
    	in_smCodeArr = new String[delLength];
    	
	    for(int i=0;i<delLength;i++){
	        netAttrTmp = request.getParameter("serverNoNetAttr"+delArr[i]);
	        System.out.println("###>in_netAttrArr["+i+"]="+netAttrTmp);
	        in_netAttrArr[i] = netAttrTmp;
	        
	        smCodeTmp = request.getParameter("serverNoSmCode"+delArr[i]);
	        System.out.println("###>in_smCodeArr["+i+"]="+smCodeTmp);
	        in_smCodeArr[i] = smCodeTmp;
	    }
	    
	    in_maxLength = "";
    	in_minLength = "";
    	in_accessFlag = "";
    	in_lengthFlag = "";
    }else if("01".equals(opType) || "02".equals(opType)){//�޸ġ�����
        in_netAttrArr = new String[1];
    	in_smCodeArr = new String[1];
    	
    	in_netAttrArr[0] = netAttr;
    	in_smCodeArr[0] = smCode;
    	
    	in_maxLength = maxLength;
    	in_minLength = minLength;
    	in_accessFlag = accessFlag;
    	in_lengthFlag = lengthFlag;
    }

try{
%>
    <wtc:service name="sSrvNoLimit" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="2" >
    	<wtc:param value="<%=opType%>"/>
    	<wtc:param value="<%=in_minLength%>"/>
        <wtc:param value="<%=in_maxLength%>"/>
        <wtc:param value="<%=in_accessFlag%>"/>
        <wtc:param value="<%=in_lengthFlag%>"/>
        <wtc:params value="<%=in_netAttrArr%>"/>
        <wtc:params value="<%=in_smCodeArr%>"/>
    </wtc:service>
    <wtc:array id="retArr" scope="end"/>
<%
    if("000000".equals(retCode)){
%>
        <script type="text/javascript">
            rdShowMessageDialog("ҵ����ɹ���",2);
            location.href = "f7435_1.jsp";
        </script>
<%
    }else{
%>
        <script type="text/javascript">
            rdShowMessageDialog("ҵ����ʧ�ܣ�<%=retCode%><br/>[<%=retMsg%>]",0);
            history.go(-1);
        </script>
<%
    }
}catch(Exception e){
    System.out.println("���÷���sSrvNoLimitʧ��!");
    e.printStackTrace();
%>
    <script type="text/javascript">
        rdShowMessageDialog("���÷���ʧ�ܣ�");
        history.go(-1);
    </script>
<%
}
%>