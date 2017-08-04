<%@ page contentType= "text/html;charset=gb2312" %>
<%@ page errorPage="../common/errorpage.jsp" %>

<%@ page import="java.io.*" %>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%@ page import="com.sitech.boss.spubcallsvr.viewBean.SPubCallSvrImpl"%>

<%
            //�õ��������
            String retType = request.getParameter("retType");
            String rightPass = request.getParameter("rightPass");
			String inputPass = request.getParameter("inputPass");
            String retResult  = "";
            String retCode="";
            String retMessage="";
            
            inputPass = Encrypt.encrypt(inputPass);
             
            if (Encrypt.checkpwd1(rightPass,inputPass) == 1){
                retResult  = "true";
                retCode="000000";
                retMessage="����У��ɹ���";
			}
			else{
			    retResult = "false";
                retCode="0001";
                retMessage="����У��ʧ�ܣ�";
				}
            System.out.println(retMessage);
%>
var response = new RPCPacket();
var retType = "<%=retType%>";
var retMessage="<%=retMessage%>";
var retCode= "<%=retCode%>";
var retResult = "<%=retResult%>";

response.guid = '<%= request.getParameter("guid") %>';
response.data.add("retType",retType);
response.data.add("retResult",retResult);
response.data.add("retCode",retCode);
response.data.add("retMessage",retMessage);
core.rpc.receivePacket(response);
