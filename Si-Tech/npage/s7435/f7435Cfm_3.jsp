<%
/********************
 * version v3.0
 * ������: si-tech
 * ��  �ܣ�7435 - ���Ų�Ʒ�������Ʊ�����
 * ��  �������÷���sGrpSmAttr�������ñ�cGrpSmAttrDeal������ɾ���ġ���
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
	
	String smCode = request.getParameter("grpSmAttrSmCode");
	String smAttr = request.getParameter("grpSmAttrSmAttr");
	String limitFlag = request.getParameter("grpSmAttrLimitFlag");
	String dealType = request.getParameter("grpSmAttrDealType");
	String opeType  = request.getParameter("grpSmOpType");
	String attrName = request.getParameter("grpSmAttrName");
	String requestType = request.getParameter("grprequestType");
	
	String[] delArr = request.getParameterValues("grpSmAttrCheck");
	int delLength = 0;
	if(delArr != null){
	    delLength = delArr.length;
	}
	
	String[] in_smCodeArr = null;
	String[] in_smAttrArr = null;
	String[] in_dealTypeArr = null;
	String[] in_opeTypeArr = null;
	String[] in_attrNameArr = null;
	String[] in_requestTypeArr = null;
	
	String in_limitFlag = "";
	
	
	String smCodeTmp = "";
	String smAttrTmp = "";
	String dealTypeTmp = "";
	String opeTypeTmp = "";
	String attrNameTmp = "";
	String requestTypeTmp = "";
	
	if("00".equals(opType)){//ɾ��
	    in_smCodeArr = new String[delLength];
    	in_smAttrArr = new String[delLength];
    	in_dealTypeArr = new String[delLength];
    	in_opeTypeArr = new String[delLength];
    	in_attrNameArr = new String[delLength];
    	in_requestTypeArr = new String[delLength];
    	
	    for(int i=0;i<delLength;i++){
	        smCodeTmp = request.getParameter("grpSmAttrSmCode"+delArr[i]);
	        System.out.println("###>in_smCodeArr["+i+"]="+smCodeTmp);
	        in_smCodeArr[i] = smCodeTmp;
	        
	        smAttrTmp = request.getParameter("grpSmAttrSmAttr"+delArr[i]);
	        System.out.println("###>in_smAttrArr["+i+"]="+smAttrTmp);
	        in_smAttrArr[i] = smAttrTmp;
	        
	        dealTypeTmp = request.getParameter("grpSmAttrDealType"+delArr[i]);
	        System.out.println("###>in_dealTypeArr["+i+"]="+dealTypeTmp);
	        in_dealTypeArr[i] = dealTypeTmp;

	        opeTypeTmp = request.getParameter("grpSmOpType"+delArr[i]);
	        System.out.println("###>in_opeTypeArr["+i+"]="+opeTypeTmp);
	        in_opeTypeArr[i] = opeTypeTmp;
	        
	        attrNameTmp = request.getParameter("grpSmAttrName"+delArr[i]);
	        System.out.println("###>in_attrNameArr["+i+"]="+smAttrTmp);
	        in_attrNameArr[i] = smAttrTmp;
	        
	        requestTypeTmp = request.getParameter("grprequestType"+delArr[i]);
	        System.out.println("###>in_requestTypeArr["+i+"]="+requestTypeTmp);
	        in_requestTypeArr[i] = requestTypeTmp;	       
	    }
	    in_limitFlag = "";
    }else if("01".equals(opType) || "02".equals(opType)){//�޸ġ�����
        in_smCodeArr = new String[1];
    	in_smAttrArr = new String[1];
    	in_dealTypeArr = new String[1];
    	in_opeTypeArr = new String[1];
    	in_attrNameArr = new String[1];
    	in_requestTypeArr = new String[1]; 
    	
    	in_smCodeArr[0] = smCode;
    	in_smAttrArr[0] = smAttr;
    	in_dealTypeArr[0] = dealType;
    	in_opeTypeArr[0] = opeType;
    	in_attrNameArr[0] = attrName;
    	in_requestTypeArr[0] = requestType; 
    	in_limitFlag = limitFlag;
   	
    }

try{
%>
    <wtc:service name="sGrpSmAttr" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="2" >
    	<wtc:param value="<%=opType%>"/>
    	<wtc:param value="<%=in_limitFlag%>"/>
    	<wtc:params value="<%=in_smCodeArr%>"/>
        <wtc:params value="<%=in_smAttrArr%>"/>
        <wtc:params value="<%=in_dealTypeArr%>"/>
    	<wtc:params value="<%=in_opeTypeArr%>"/>
        <wtc:params value="<%=in_attrNameArr%>"/>
        <wtc:params value="<%=in_requestTypeArr%>"/>        	
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
    System.out.println("���÷���sGrpSmAttrʧ��!");
    e.printStackTrace();
%>
    <script type="text/javascript">
        rdShowMessageDialog("���÷���ʧ�ܣ�");
        history.go(-1);
    </script>
<%
}
%>