<%
/********************
 version v2.0
������: si-tech
*
*update:zhanghonga@2008-09-16 ҳ�����,�޸���ʽ
*
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*"%>
 
 <%
	response.setHeader("Pragma","No-Cache"); 
	response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0); 

	String opCode = "1350";
	String opName = "�˵���ӡ";
	
	String printway=request.getParameter("printway");//��ӡ��ʽ
	String mobileno	 = request.getParameter("mobileno");//�û�ID
	String contractno	 = request.getParameter("contractno");//�ʻ�ID
	String billmonth = request.getParameter("billmonth");//�ʵ�����
	String custPasswd = WtcUtil.repNull(request.getParameter("password"));//�û��ʻ�����
	String regionCode = ((String)session.getAttribute("orgCode")).substring(0,2);
	    	
  String workno = (String)session.getAttribute("workNo");
  String workname = (String)session.getAttribute("workName");
	String belongName = (String)session.getAttribute("orgCode");
  String org_code = (String)session.getAttribute("orgCode");

  String[][] temfavStr=(String[][])session.getAttribute("favInfo");
	String[] favStr=new String[temfavStr.length];
	for(int i=0;i<favStr.length;i++)
 	favStr[i]=temfavStr[i][0].trim();
	boolean pwrf=false;
	if(WtcUtil.haveStr(favStr,"a272"))
		pwrf=true;
				
	String sql = "";
	String error_msg = "";
	String rtnPage = "./s1350.jsp";
	
	if(printway.equals("0"))
	{
		sql = "select user_passwd from dcustmsg where phone_no = '"+mobileno+"'";
		error_msg = "�������������û��������������������Ϣ��<br>";
	}else if(printway.equals("1")){
		sql = "select contract_passwd from dconmsg where contract_no = '"+contractno+"'";
		error_msg = "�ʻ�����������ʻ��������������������Ϣ��<br> ";
	}
	//System.out.println(" s1350_select.sql=  ["+sql+"]");
%>
	  <wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="1">
		<wtc:sql><%=sql%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="agentCodeStr" scope="end" />	
<%	
	if (agentCodeStr.length==0)
	{	
%>
	<script>
		rdShowMessageDialog('<%=error_msg%>');
		document.location.replace('<%=rtnPage%>');
	</script>
<%	
	}else{
	if((0==Encrypt.checkpwd1(custPasswd,agentCodeStr[0][0])) && !pwrf)
	{			
%>
	<script>		
		rdShowMessageDialog('<%=error_msg%>');
		document.location.replace('<%=rtnPage%>');
	</script>
<%						
	}
	
	
	String dateStr=new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
	String ny = dateStr.substring(0,4);
	String nm = dateStr.substring(4,6);
	String nd = dateStr.substring(6,8);

	String op_code  =  "1350";
	String billy = billmonth.substring(0,4);
	String billm = billmonth.substring(4,6);
	String billd = "";
	//�ж��������£�ȡ�ʵ�"��",��ʼ:
	if (billm.equals("01")||billm.equals("03")||billm.equals("05")||billm.equals("07")||billm.equals("08")||billm.equals("10")||billm.equals("12")){
	       billd = "31";
	}else if (billm.equals("04")||billm.equals("06")||billm.equals("09")||billm.equals("11")) {
	       billd = "30";
	}else if (billm.equals("02")) {
		if ((Integer.parseInt(billy)%4==0)&&(Integer.parseInt(billy)%100!=0) || (Integer.parseInt(billy)%400==0)) {
	      	billd = "29";
		}else{
	        billd = "28";
		}
	}
 	String id = "";
	String printname ="";
	//0:mobileno,1:contractno
	if (printway.equals("0")) 
	{
		id = mobileno;
		printname = "�������";
	}
	else if(printway.equals("1"))
	{
		id = contractno;
		printname = "�ʻ�����";
	}
	
	String[] inParas = new String[4];
	inParas[0] = printway;
	inParas[1] = id;
	inParas[2] = billmonth;
	inParas[3] = workno;
  
  for(int i=0;i<inParas.length;i++){
  	System.out.println("##############inParas["+i+"]->"+inParas[i]);
  }
%>
	<wtc:service name="s1350Init" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="11">
	<wtc:param value="<%=inParas[0]%>"/>
	<wtc:param value="<%=inParas[1]%>"/>
	<wtc:param value="<%=inParas[2]%>"/>
	<wtc:param value="<%=inParas[3]%>"/>
	</wtc:service>
	<wtc:array id="result" start="0" length="7" scope="end"/> 
	<wtc:array id="result2" start="7" length="2" scope="end"/>
	<wtc:array id="result3" start="9" length="1" scope="end"/>
	<wtc:array id="result4" start="10" length="1" scope="end"/>
<% 
	//CallRemoteResultValue  value  = viewBean.callService("1", org_code.substring(0,2) ,  "s1350Init", "11"  ,   lens , inParas) ;
		String return_code = retCode1;
		error_msg = SystemUtils.ISOtoGB(ErrorMsg.getErrorMsg(return_code));
   
   if(return_code.equals("000000")) {
   
   if(result==null||result.length==0){
%>
		<script language="javascript">
			rdShowMessageDialog("��ѯ���˵���ϢΪ��!");
			window.location.href = "s1350.jsp";
		</script>
<%
			return;
   }
   
     String username = result[0][1];
	   String user_jifen =result[0][2];
	   String user_total_fee =result[0][3];
	   String pre_total_fee =result[0][4];
	   String shoud_pay_fee =result[0][5];
	   String user_total_mark =result[0][6];
%>
				
<wtc:sequence name="TlsPubSelBoss" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="retListString1"/>					
<%
 String loginAccept=retListString1;
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
    <TITLE>������BOSS-�ʵ���ӡ</TITLE>
    <META content="text/html; charset=gb2312" http-equiv=Content-Type>
    <META content=no-cache http-equiv=Pragma>
    <META content=no-cache http-equiv=Cache-Control>
    <script language="JavaScript">
        <!--
        function doPrint() {
            document.form.submit();
        }
        //-->
    </script>
</HEAD>
<BODY leftmargin="0" topmargin="0">
<FORM action="s1350_print.jsp" method=post name=form>
<INPUT TYPE="hidden" name="printway" value="<%=printway%>">
<INPUT TYPE="hidden" name="mobileno" value="<%=mobileno%>">
<INPUT TYPE="hidden" name="loginAccept" value="<%=loginAccept%>">
<INPUT TYPE="hidden" name="contractno" value="<%=contractno%>">
<INPUT TYPE="hidden" name="billmonth" value="<%=billmonth%>">
<%@ include file="/npage/include/header.jsp" %>

<div class="title">
    <div id="title_zi">��ӡ��ʽ</div>
</div>
<table cellspacing="0">
    <tbody>
        <tr>
            <td width="13%" class="blue">��ӡ��ʽ</td>
            <td width="20%">��<%=printname%>
            </td>
            <td class="blue" width="13%">��ɫ</td>
            <td width="20%">(��)</td>
            <td width="13%" class="blue">����</td>
            <td><%=belongName%>
            </td>
        </tr>
    </tbody>
</table>
</div>
<div id="Operation_Table">
    <div class="title">
        <div id="title_zi">�û���Ϣ</div>
    </div>
    <table cellspacing="0">
        <tr>
            <td width="13%" class="blue" nowrap>�ͻ�����</td>
            <td width="20%" nowrap><%=username%></td>
            <td width="13%" class="blue" nowrap><%=printname%></td>
            <td nowrap><%=id%></td>
        </tr>
        <tr>
            <td class="blue" nowrap>�Ʒ�����</td>
            <td nowrap><%=billy%>��<%=billm%>��01�� <span>��</span>
                <%=billy%>��<%=billm%>��<%=billd%>��
            </td>
            <td class="blue" nowrap>��ӡ����</td>
            <td nowrap><%=ny%>��<%=nm%>��<%=nd%>��</td>
        </tr>
    </table>
</div>
<div id="Operation_Table">
<div class="title">
    <div id="title_zi">�˵���Ϣ</div>
</div>
<table cellspacing="0">
<tr align="center" height="40">
    <td colspan="6"><font size="4" class="orange"><b>�й��ƶ�ͨ�ſͻ��˵�</b></font></td>
</tr>
<tr align="center">
    <th>������Ŀ</th>
    <th>���(Ԫ)</th>
    <th>������Ŀ</th>
    <th>���(Ԫ)</th>
    <th>������Ŀ</th>
    <th>���(Ԫ)</th>
</tr>
<tr align="center">
<td width="22%" valign="top" nowrap><br>
    <%
        int resultlength = result2.length;
        int len = 0;
        if (resultlength <= 15) {
            len = 5;
        } else if (resultlength <= 30 && resultlength > 15) {
            len = 10;
        } else if (resultlength <= 60 && resultlength > 30) {
            len = 20;
        } else {
            len = 30;
        }

        int len1 = 0;
        int len2 = 0;
        int len3 = 0;

        if (resultlength > 2 * len) {
            len1 = len;
            len2 = len;
            len3 = resultlength - 2 * len;
        } else if (resultlength <= 2 * len && resultlength > len) {
            len1 = len;
            len2 = resultlength - len;
            len3 = 0;
        } else if (resultlength <= len) {
            len1 = resultlength;
            len2 = 0;
            len3 = 0;
        }
    %>

    <% //��һ�п�ʼ
        for (int i = 0; i < len1; i++) {
            String d1 = result2[i][0].trim();
            String d2 = result2[i][1].trim();

            if (d2.equals("")) {
    %>
    <b><%=d1%>
    </b><br>
    <%} else if (d1.substring(0, 1).equals(" ")) {%>
    <br>
    <br>
    <%} else {%>
    &nbsp;&nbsp;<%=d1%><br>
    <%
            }
        }//��һ�н���
    %>
    <br>
</td>
<td width="11%" valign="top" nowrap><br>
    <%
        //�ڶ��п�ʼ
        for (int i = 0; i < len1; i++) {
            String d1 = result2[i][0].trim();
            String d2 = result2[i][1].trim();
            if (d2.equals("")) {
    %>
    <b><%=d2%>
    </b><br>
    <%
    } else if (d1.substring(0, 1).equals(" ")) {
    %>
    <br>
    <br>
    <%
    } else {%>
    <%=d2%><br>
    <%
            }
        }//�ڶ��н���
    %>
    <br>
</td>
<td width="22%" valign="top" nowrap><br>
    <%
        //�����п�ʼ
        for (int j = len1; j < len2 + len1; j++) {
            String d1 = result2[j][0].trim();
            String d2 = result2[j][1].trim();
            if (d2.equals("")) {
    %>
    <b><%=d1%>
    </b><br>
    <%
    } else if (d1.substring(0, 1).equals(" ")) {
    %>
    <br>
    <br>
    <%
    } else {%>
    &nbsp;&nbsp;<%=d1%><br>
    <%
            }
        }//�����н���
    %>
    <br>
</td>
<td width="11%" valign="top" nowrap><br>
    <%
        //�����п�ʼ
        for (int j = len1; j < len2 + len1; j++) {
            String d1 = result2[j][0].trim();
            String d2 = result2[j][1].trim();
            if (d2.equals("")) {
    %>
    <b><%=d2%>
    </b><br>
    <%
    } else if (d1.substring(0, 1).equals(" ")) {
    %>
    <br>
    <br>
    <%
    } else {%>
    <%=d2%><br>
    <%
            }
        }//�����н���
    %>
    <br>
</td>


<td width="22%" valign="top" nowrap><br>
    <%
        //�����п�ʼ
        for (int k = len2 + len1; k < len2 + len1 + len3; k++) {
            String d1 = result2[k][0].trim();
            String d2 = result2[k][1].trim();

            if (d2.equals("")) {
    %>
    <b><%=d1%>
    </b><br>
    <% } else if (d1.substring(0, 1).equals(" ")) { %>
    <br>
    <br>
    <% } else {%>
    &nbsp;&nbsp;<%=d1%><br>
    <% }
    }//�����н���
    %>
    <br>
</td>

<td valign="top" nowrap width="11%"><br>
    <%
        //�����п�ʼ
        for (int k = len2 + len1; k < len2 + len1 + len3; k++) {
            String d1 = result2[k][0].trim();
            String d2 = result2[k][1].trim();

            if (d2.equals("")) {
    %>
    <b><%=d2%>
    </b><br>
    <%} else if (d1.substring(0, 1).equals(" ")) { %>
    <br>
    <br>
    <% } else {%>
    <%=d2%><br>
    <%
            }
        }//�����н���
    %>
    <br>
</td>
</tr>
    <tr>
        <td width="22%" class="blue">���úϼ�</td>
        <td>��<%=user_total_fee%>
        </td>
        <td width="22%" class="blue">Ԥ�滰�����</td>
        <td>��<%=pre_total_fee%>
        </td>
        <td width="22%" class="blue">Ӧ���ϼ�</td>
        <td>��<%=shoud_pay_fee%>
        </td>
    </tr>
    <tr>
        <td width="22%" class="blue" nowrap>�����ڿͻ�����</td>
        <td><%=user_total_mark%>
        </td>

        <td width="22%" class="blue" nowrap>�ۼƿͻ�����</td>
        <td colspan="3"><%=user_jifen%>
        </td>
    </tr>
    <tr>
        <td class="blue">��ע</td>
        <td colspan="5">
            <table>
                <%
                    for (int m = 0; m < result3.length; m++) {
                        for (int n = 0; n < result3[m].length; n++) {
                %>

                <tr>
                    <td><%=result3[m][n]%>
                    </td>
                </tr>

                <%
                        }
                    }
                %>

            </table>
        </td>
    </tr>
    <tr>
        <td id="footer" colspan="6">
            <input class="b_foot" name=sure type=button value=��ӡ onClick="doPrint();">&nbsp;
            <input class="b_foot" name="backButton" type="reset" value=���� onClick="window.history.go(-1)">
        </td>
    </tr>
</table>
</FORM>
</BODY>
</HTML>
<%
	}else{
	  if(return_code.equals("130011")){
%>
			<script language="JavaScript">
				rdShowMessageDialog("�˵���ѯ��Χ��������£������ѯ!");
				document.location.replace("s1350.jsp");
			</script>
<%
		
      }else{
%>
		 <script language="JavaScript">
		 		rdShowMessageDialog("�ʵ���ѯ����<br>������룺'<%=return_code%>'��<br>������Ϣ��'<%=error_msg%>'��");
				document.location.replace("s1350.jsp");
		</script>

<%}
  }}
%>
