<%
    /********************
     * @ OpCode    :  6992
     * @ OpName    :  ���ŷ���
     * @ CopyRight :  si-tech
     * @ Author    :  qidp
     * @ Date      :  2010-01-26
     * @ Update    :  
     ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
    String regionCode = WtcUtil.repNull((String)session.getAttribute("regCode"));
    
    String opCode = WtcUtil.repNull((String)request.getParameter("op_code"));
    String opName = WtcUtil.repNull((String)request.getParameter("op_name"));
    String workNo = WtcUtil.repNull((String)request.getParameter("work_no"));
    String workName = WtcUtil.repNull((String)request.getParameter("work_name"));
    String iPhoneNo = WtcUtil.repNull((String)request.getParameter("phone_no"));
    String iSmsCont = WtcUtil.repNull((String)request.getParameter("sms_cont"));
    String iLoginAccept = WtcUtil.repNull((String)request.getParameter("login_accept"));
    String iOpTime = WtcUtil.repNull((String)request.getParameter("op_time"));
    
    
    /*********************
     ** wdsmpshortmsg ����Ϣ��
     ** �ֶ���	        �ֶ�����	    �Ƿ�ɿ�	��д˵��
     ** COMMAND_ID  	NUMBER(22)   	��	        �·����Ŷ˿ڣ��硰10086789��
     ** LOGIN_ACCEPT	NUMBER(22)   	��	        Ψһ��ˮ
     ** MSG_LEVEL   	NUMBER(10)   	��	        ���ͼ����1��
     ** PHONE_NO    	CHAR(15)     	��	        Ŀ���ֻ�����
     ** MSG         	VARCHAR2(255)	��	        ��������
     ** ORDER_CODE  	NUMBER(10)   	��	        �0��
     ** BACK_CODE   	NUMBER(10)   	��	        �0��
     ** DX_OP_CODE  	CHAR(4)      	��	        �������룬op_code
     ** LOGIN_NO    	CHAR(6)      	��	        ��������
     ** OP_TIME     	DATE         	��	        ����ʱ��
     ** SENT_TIME   	DATE         	��	        Ĭ�����
     *********************/
    String insertSql = "insert into wdsmpshortmsg (COMMAND_ID,LOGIN_ACCEPT,MSG_LEVEL,PHONE_NO,MSG,ORDER_CODE,BACK_CODE,DX_OP_CODE,LOGIN_NO,OP_TIME) values "
        + "(10086,"+iLoginAccept+",1,'"+iPhoneNo+"','"+iSmsCont+"',0,0,'6992','"+workNo+"',to_date('"+iOpTime+"', 'yyyy/mm/dd hh24:mi:ss'))";
        
    System.out.println("insertSql = "+insertSql);
    
%>
    <wtc:pubselect name="sPubSelect" retcode="retCode" retmsg="retMsg" outnum="2" routerKey="region" routerValue="<%=regionCode%>">
    	<wtc:sql><%=insertSql%></wtc:sql>
    </wtc:pubselect>
<%
    if("000000".equals(retCode)){
        System.out.println("retCode = "+retCode);
        System.out.println("retMsg = " +retMsg);
    %>
        <script type=text/javascript>
            rdShowMessageDialog("���ŷ��ͳɹ���",2);
            history.go(-1);
        </script>
    <%
    }else{
        %>
        <script type=text/javascript>
            rdShowMessageDialog("���ŷ���ʧ�ܣ�������룺<%=retCode%>��������Ϣ��<%=retMsg%>��",0);
            history.go(-1);
        </script>
    <%
    }
%>
