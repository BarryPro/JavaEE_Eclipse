<%
/********************
 * version v3.0
 * ������: si-tech
 * ��  �ܣ�7435 - ���Ų�Ʒ�������Ʊ�����
 * ��  �������÷���sSmLimitSrv�������ñ�cGrpSmLimit������ɾ���ġ���
 * author: qidp @ 2009-06-29
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
	
	String smCode = request.getParameter("grpSmSmCode");
	String limitType = request.getParameter("grpSmLimitType");
	String limitValue = request.getParameter("grpSmLimitValue");
	String limitFlag = request.getParameter("grpSmLimitFlag");
	
	String[] delArr = request.getParameterValues("grpSmCheck");
	int delLength = 0;
	if(delArr != null){
	    delLength = delArr.length;
	}
	
	String[] in_smCodeArr = null;
	String[] in_limitTypeArr = null;
	String[] in_limitValueArr = null;
	String in_limitFlag = "";
	
	String smCodeTmp = "";
	String limitTypeTmp = "";
	String limitValueTmp = "";
	
	if("00".equals(opType)){//ɾ��
	    in_smCodeArr = new String[delLength];
    	in_limitTypeArr = new String[delLength];
    	in_limitValueArr = new String[delLength];
    	
	    for(int i=0;i<delLength;i++){
	        smCodeTmp = request.getParameter("grpSmSmCode"+delArr[i]);
	        System.out.println("###>in_smCodeArr["+i+"]="+smCodeTmp);
	        in_smCodeArr[i] = smCodeTmp;
	        
	        limitTypeTmp = request.getParameter("grpSmLimitType"+delArr[i]);
	        System.out.println("###>in_limitTypeArr["+i+"]="+limitTypeTmp);
	        in_limitTypeArr[i] = limitTypeTmp;
	        
	        limitValueTmp = request.getParameter("grpSmLimitValue"+delArr[i]);
	        System.out.println("###>in_limitValueArr["+i+"]="+limitValueTmp);
	        in_limitValueArr[i] = limitValueTmp;
	    }
	    in_limitFlag = "";
    }else if("01".equals(opType) || "02".equals(opType)){//�޸ġ�����
        in_smCodeArr = new String[1];
    	in_limitTypeArr = new String[1];
    	in_limitValueArr = new String[1];
    	
    	in_smCodeArr[0] = smCode;
    	in_limitTypeArr[0] = limitType;
    	in_limitValueArr[0] = limitValue;
    	in_limitFlag = limitFlag;
    }

try{
%>
    <wtc:service name="sSmLimitSrv" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="2" >
    	<wtc:param value="<%=opType%>"/>
    	<wtc:param value="<%=in_limitFlag%>"/>
    	<wtc:params value="<%=in_smCodeArr%>"/>
        <wtc:params value="<%=in_limitTypeArr%>"/>
        <wtc:params value="<%=in_limitValueArr%>"/>
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
    System.out.println("���÷���sSmLimitSrvʧ��!");
    e.printStackTrace();
%>
    <script type="text/javascript">
        rdShowMessageDialog("���÷���ʧ�ܣ�");
        history.go(-1);
    </script>
<%
}
%>