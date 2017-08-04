   
<%
/********************
 version v2.0
 开发商 si-tech
 update hejw@2009-2-9
********************/
%>


<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="java.io.*" %>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>

<%

						System.out.println("------------------------------HERE------------------------------------");	
						String regionCode = (String)session.getAttribute("regCode");
							
            //得到输入参数
            String cust_id = WtcUtil.repStr(request.getParameter("cust_id")," ");
            String phone_no = WtcUtil.repStr(request.getParameter("phone_no")," ");
            String retType = WtcUtil.repStr(request.getParameter("retType")," ");
            String Pwd1 = WtcUtil.repStr(request.getParameter("Pwd1")," ");
            String[][] result = new String[][]{};
            String retResult  = "false";
            String retCode="000000";
            String retMessage="密码校验成功！";
            try
            {
                String sqlStr = "";
                if (cust_id.trim().length() > 0) {
                    sqlStr = "select cust_passwd from dCustDoc where cust_id = " + cust_id;
                } else if (phone_no.trim().length() > 0) {
                    sqlStr = "select user_passwd from dCustMsg where phone_no = '" + phone_no + "' and substr(run_code,2,1) < 'a'";
                }
                //retArray = callView.sPubSelect("1",sqlStr);
                
%>

		<wtc:pubselect name="sPubSelect" outnum="1" retmsg="msg2" retcode="code2" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sqlStr%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_t1" scope="end"/>

<%                
			System.out.println("------------------------------code2------------------------------------"+code2);						
			System.out.println("------------------------------msg2------------------------------------"+msg2);						
                result = result_t1;
                String cust_passwd = (result[0][0]).trim();
                Pwd1 = Encrypt.encrypt(Pwd1);
                if (Encrypt.checkpwd2(cust_passwd,Pwd1) == 1)
                    retResult = "true";
                System.out.println("客户密码校验结果:" + retResult);
            }catch(Exception e){
                e.printStackTrace();
                retCode="0001";
                retMessage="密码校验失败！";
            }
  System.out.println("------------------------------retMessage------------------------------------"+retMessage);		          
            
            
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
