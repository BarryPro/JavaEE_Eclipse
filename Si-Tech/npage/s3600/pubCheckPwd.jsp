<%
/********************
 version v2.0
 开发商: si-tech
 update hejw@2009-1-16
********************/
%>

<%@ page contentType= "text/html;charset=gb2312" %>
 <%@ include file="/npage/include/public_title_ajax.jsp" %> 
 <%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%@ page import="java.io.*" %>

<%
						String regionCode = (String)session.getAttribute("regCode");
            //得到输入参数
            String custId = request.getParameter("CUST_ID");
            String grpIdNo = request.getParameter("GRP_ID");
            String idNo = request.getParameter("ID_NO");
            String retType = request.getParameter("retType");
            String inPwd = request.getParameter("inPwd");
            String[][] result = new String[][]{};
            String retResult  = "false";
            String retCode="000000";
            String retMessage="密码校验成功！";
            try
            {
                String sqlStr = null;
                
                if (custId != null)
                {
                	sqlStr="select cust_passwd from dCustDoc where cust_id = " + custId;
                }
                else if (grpIdNo != null)
                {
                	sqlStr="select USER_PASSWD from dGrpUserMsg where id_no = " + grpIdNo;
                }
            	else if (idNo != null)
            	{
            		sqlStr="select USER_PASSWD from dCustMsg where id_no = " + idNo;
            	}
            	else
            	{
            		 retCode="100001";
            		 retMessage="错误的输入参数(CUST_ID、GRP_ID或ID_NO)！";
            	}
               // retArray = callView.sPubSelect("1",sqlStr);
               
%>

		<wtc:pubselect name="sPubSelect" outnum="1" retmsg="msg2" retcode="code2" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sqlStr%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_t" scope="end"/>

<%               
						//System.out.println("----------------msg2----------------hjw-------------"+msg2);
		        retCode = code2;
		        //System.out.println("Sql="+sqlStr);
		        if (retCode.equals("000000"))
		        {
	                result = result_t;
	                String cust_passwd = (result[0][0]).trim();
		        	   //System.out.println("cust_passwd="+cust_passwd + "inPwd=" + inPwd);
	                inPwd = Encrypt.encrypt(inPwd);
	                if (Encrypt.checkpwd2(cust_passwd,inPwd) == 1)
	                {
	                    retResult = "true";
	                }
	            	else
	            	{
	                    retResult = "false";
	                    retMessage="密码校验失败！";
	            	}
            	}
            //System.out.println("----------------retResult----------------hjw-------------"+retResult);	
            	
            }
            catch(Exception e)
            {
                System.out.println(e.toString());
                retCode="100002";
                retMessage="密码校验失败！";
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
