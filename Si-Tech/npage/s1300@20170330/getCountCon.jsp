<%
    /********************
     version v2.0
     ������: si-tech
		 *
		 *update:zhanghonga@2008-08-19 ҳ�����,�޸���ʽ
		 *     
     ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
		response.setHeader("Pragma","No-cache");
		response.setHeader("Cache-Control","no-cache");
		response.setDateHeader("Expires", 0);
%>
<%
		String opCode = "";
		String opName = "������BOSS-�ʺŲ�ѯ";
    String phoneNo = request.getParameter("phoneNo");
    String custPasswd = request.getParameter("password");
    String orgCode = (String)session.getAttribute("orgCode");
    String regionCode = orgCode.substring(0,2);
    /*
    String inParas[] = {"select to_char(a.contract_no),a.bank_cust from dConMsg a,dCustMsg b, dConUserMsg c where a.contract_no=c.contract_no and c.serial_no=0 and b.phone_no='"+phoneNo+"' and substr(b.run_code,2,1) < 'a' and b.id_no = c.id_no" };
    */
    String inParas = "select to_char(a.contract_no),a.bank_cust,d.type_name,e.pay_name,to_char(a.owe_fee) from dConMsg a,dCustMsg b, dConUserMsg c,sAccountType d,sPayCode e where a.contract_no=c.contract_no and c.serial_no=0 and b.phone_no='?' and substr(b.run_code,2,1) < 'a' and b.id_no = c.id_no and a.account_type=d.account_type and e.region_code=substr(a.belong_code,1,2) and e.pay_code=a.pay_code";
%>
		<wtc:pubselect name="TlsPubSelBoss" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="5">
		<wtc:sql><%=inParas%></wtc:sql>
		<wtc:param value="<%=phoneNo%>"/>
		</wtc:pubselect>
		<wtc:array id="result" scope="end"/>
<%
		if(result!=null&&result.length==1){
%>
			<SCRIPT LANGUAGE="JavaScript">
			    <!--
			    window.returnValue = "<%=result[0][0].trim()%>";
			    window.close();
			    //-->
			</SCRIPT>
<%
    }else{
%>
<HTML>
<HEAD>
		<TITLE>������BOSS-�ʺŲ�ѯ</TITLE>
    <META content=no-cache http-equiv=Pragma>
    <META content=no-cache http-equiv=Cache-Control>

    <script language="JavaScript">
        window.returnValue = '';
        function selAccount()
        {
						if(document.frm.account==null){
							return false;	
						}
						
						
            for (i = 0; i < document.frm.account.length; i++)
            {
                if (document.frm.account[i].checked == true)
                {
                    window.returnValue = document.frm.account[i].value;
                    break;
                }
            }
            window.close();
        }
    </script>

</head>

<BODY>
<form name="frm" method="post" action="">
    <%@ include file="/npage/include/header_pop.jsp" %>
    <div class="title">
        <div id="title_zi">�ʺŲ�ѯ</div>
    </div>
    <div id="">
        <table cellspacing="0">
            <tr align="center">
                <th>ѡ��</th>
                <th>�ʺ�</th>
                <th>�ʻ�����</th>
                <th>�ʻ�����</th>
                <th>���ѷ�ʽ</th>
                <th>Ƿ��</th>
            </tr>
				<%
						if(!retCode1.equals("000000")){
				        out.println("<tr align='center'><td colspan='6'><font class='orange'>����δ��ȡ���ʻ���Ϣ,�������:"+retCode1+"<br>������Ϣ:"+retMsg1+"</font></td></tr>");
				    }else if(result.length==0){
				    	  out.println("<tr align='center'><td colspan='6'><font class='orange'>��ѯ���Ϊ��,�޴˲�ѯ����������˺���Ϣ!</font></td></tr>");
				    }	
				%>           
        <%
            String tbClass = "";
            for (int y=0; y <result.length; y++) {
                if (y % 2 == 0) {
                    tbClass = "Grey";
                }else{
                    tbClass = "";
                }
        %>
            <tr>
                <td class="<%=tbClass%>">
                    <div align="center">
                        <input type="radio" name="account" value="<%=result[y][0].trim()%>" <%if (y==0) {%>checked<%}%>>
                    </div>
                </td>
                <%
                    for (int j = 0; j < result[0].length; j++) {


                %>

                <td class="<%=tbClass%>">
                    <div align="center"><%=result[y][j]%>
                    </div>
                </td>

                <%
                    }
                %>
            </tr>
            <%
                }
            %>

            <tr>
                <td id="footer" colspan="6">
                    <div align="center">
                        <input class="b_foot" type="button" name="Button" value="ȷ��" onClick="selAccount()">
                        <input class="b_foot" type="button" name="return" value="�ر�" onClick="window.close()">
                    </div>
                </td>
            </tr>
        </table>
        <%@ include file="/npage/include/footer_pop.jsp" %>
			</form>
		</body>
	</html>
<%}%>

