
 <%
	/********************
	 version v2.0
	������: si-tech
	update:anln@2009-02-15ҳ�����,�޸���ʽ
	********************/
%>

<%@ page contentType="text/html;charset=Gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>

<%
	    String regionCode = (String)session.getAttribute("regCode");
            //�õ��������
            String cust_id = request.getParameter("cust_id");
            String retType = request.getParameter("retType");
            String Pwd1 = request.getParameter("Pwd1");
            ArrayList retArray = new ArrayList();
            //String[][] result = new String[][]{};
            //SPubCallSvrImpl callView = new SPubCallSvrImpl();
            String retResult  = "false";
            String retCode="000000";
            String retMessage="����У��ɹ���";
            try
            {
                String sqlStr = "select user_passwd from dCustMsg where phone_no ='"+ cust_id+"'";
				System.out.println("sqlStr="+sqlStr);
                //retArray = callView.sPubSelect("1",sqlStr);
                %>
                	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="1">
				<wtc:sql><%=sqlStr%></wtc:sql>
			</wtc:pubselect>
			<wtc:array id="result" scope="end" />
                <%
                //result = (String[][])retArray.get(0);
                String cust_passwd = (result[0][0]).trim();
                Pwd1 = Encrypt.encrypt(Pwd1);
                if (Encrypt.checkpwd2(cust_passwd,Pwd1) == 1)
                    retResult = "true";
                System.out.println("�ͻ�����У����:" + retResult);
            }catch(Exception e){
                e.printStackTrace();
                retCode="0001";
                retMessage="����У��ʧ�ܣ�";
            }
%>
var response = new AJAXPacket();
var retType = "<%=retType%>";
var retMessage="<%=retMessage%>";
var retCode= "<%=retCode%>";
var retResult = "<%=retResult%>";

response.data.add("retType",retType);
response.data.add("retResult",retResult);
response.data.add("retCode",retCode);
response.data.add("retMessage",retMessage);
core.ajax.receivePacket(response);
