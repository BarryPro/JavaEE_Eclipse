<%
    /********************
     * @ OpCode    :  6992
     * @ OpName    :  短信发送
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
     ** wdsmpshortmsg 表信息：
     ** 字段名	        字段类型	    是否可空	填写说明
     ** COMMAND_ID  	NUMBER(22)   	否	        下发短信端口，如“10086789”
     ** LOGIN_ACCEPT	NUMBER(22)   	否	        唯一流水
     ** MSG_LEVEL   	NUMBER(10)   	否	        发送级别，填“1”
     ** PHONE_NO    	CHAR(15)     	否	        目标手机号码
     ** MSG         	VARCHAR2(255)	否	        短信内容
     ** ORDER_CODE  	NUMBER(10)   	否	        填“0”
     ** BACK_CODE   	NUMBER(10)   	否	        填“0”
     ** DX_OP_CODE  	CHAR(4)      	否	        操作代码，op_code
     ** LOGIN_NO    	CHAR(6)      	否	        操作工号
     ** OP_TIME     	DATE         	否	        操作时间
     ** SENT_TIME   	DATE         	是	        默认填空
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
            rdShowMessageDialog("短信发送成功！",2);
            history.go(-1);
        </script>
    <%
    }else{
        %>
        <script type=text/javascript>
            rdShowMessageDialog("短信发送失败！错误代码：<%=retCode%>，错误信息：<%=retMsg%>。",0);
            history.go(-1);
        </script>
    <%
    }
%>
