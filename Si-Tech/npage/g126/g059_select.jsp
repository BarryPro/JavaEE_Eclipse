<%
    /********************
     version v2.0
     ������: si-tech
     *
     *update:zhanghonga@2008-09-19 ҳ�����,�޸���ʽ
     *
     ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
    String opCode = "g126";
    String opName = "�����վ�";
    String beginym = request.getParameter("beginym");
    String endym = request.getParameter("endym");
    String contractno = request.getParameter("contractno"); //ʵ����id_no
    String phoneno = request.getParameter("phoneno");
	String cfmname = request.getParameter("cfmname");
    String belongName = (String) session.getAttribute("orgCode");
    String workno = (String) session.getAttribute("workNo");
    String workname = (String) session.getAttribute("workName");
    String pwrf = "0";
    String[][] favInfo = (String[][]) session.getAttribute("favInfo");
    int infoLen = favInfo.length;
    String tempStr = "";
    for (int i = 0; i < infoLen; i++) {
        tempStr = (favInfo[i][0]).trim();
        System.out.println("aaaaaaaaaaaaaaaatempStr=" + tempStr);
        if (tempStr.compareTo("a292") == 0) {
            pwrf = "1";
        }

    }
    String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
    System.out.println("dddddddssssssssssssssssssssssssssssddddddddpwrf=" + pwrf+" and contractno is "+contractno);
    String op_code = "g059";
    String[] inParas = new String[5];
    inParas[0] = workno;
    inParas[1] = phoneno;
    inParas[2] = contractno;
    inParas[3] = beginym;
    inParas[4] = endym;
    int[] lens = {8, 11};
    //CallRemoteResultValue value = viewBean.callService("2", phoneno, "s1352Init", "19", lens, inParas);
%>
		<wtc:service name="stt_reprint" routerKey="phone" routerValue="<%=phoneno%>" outnum="19"  >
		<wtc:param value="<%=inParas[0]%>"/>
		<wtc:param value="<%=inParas[1]%>"/>
		<wtc:param value="<%=inParas[2]%>"/>
		<wtc:param value="<%=inParas[3]%>"/>
		<wtc:param value="<%=inParas[4]%>"/>
		</wtc:service>
		<wtc:array id="result" start="0" length="8" scope="end" />	
		<wtc:array id="result2" start="8" length="4" scope="end"/>	
<%
    String return_code = "";
    String error_msg = "";
    if(result.length>0){
    	return_code = result[0][0];
    	error_msg = result[0][1];

		
    }

    if (return_code.equals("000000")) {
        int maxlines = result2.length;
		System.out.println("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAaa maxlines is "+maxlines);
        if (maxlines != 0) {
			String cust_name = result[0][4].trim();
			String cust_address = result[0][5].trim();
			String run_name = result[0][6].trim();
			String prepay_fee = result[0][2].trim();
			String owe_fee = result[0][3].trim();
            String cfm_id=result[0][7].trim();
      
%>

<wtc:sequence name="TlsPubSelBoss" key="sMaxSysAccept" routerKey="phone" routerValue="<%=phoneno%>"  id="loginAccept"/>					

<HTML>
<HEAD><TITLE>������BOSS-�����վ�</TITLE>
    <META content="text/html; charset=gb2312" http-equiv=Content-Type>
    <META content=no-cache http-equiv=Pragma>
    <META content=no-cache http-equiv=Cache-Control>
 <script language="JavaScript">
        <!--

        function docheck()
        {
			getAfterPrompt();
            var login_accept;
            var totaldate;
            var opname;
            var re_print;
            var login_no ;
            var lines =<%=maxlines%>;
            if (lines == 1)
            {
                login_accept = document.form.radiobutton.value;
                totaldate = document.form.totaldate.value.substring(0, 4) + document.form.totaldate.value.substring(5, 7) + document.form.totaldate.value.substring(8, 10);
				opname = document.form.opname.value;
				op_code = document.form.op_code.value;
             //   alert("1�� login_accept is "+login_accept+" and totaldate is "+totaldate+" and opname is "+opname );
            }
            else
            {
                for (var i = 0; i < lines; i++)
                {
                    if (document.form.radiobutton[i].checked == true)
                    {
                        login_accept = document.form.radiobutton[i].value;
						opname = document.form.opname[i].value;
						op_code = document.form.op_code[i].value;
                        totaldate = document.form.totaldate[i].value.substring(0, 4) + document.form.totaldate[i].value.substring(5, 7) + document.form.totaldate[i].value.substring(8, 10);
                       // alert("��� login_accept is "+login_accept+" and totaldate is "+totaldate+" and opname is "+opname );
                        
                    }
                }
            }
 
			/***��g059_print.jsp ʹ��sql��ѯ Ȼ���ӡ�� ƴװһ������****/
            document.form.action = 'g059_print.jsp?payAccept=' + login_accept + '&total_date=' + totaldate + '&workno=<%=workno%>' + '&returnPage=g126_1.jsp'+'&opname='+opname+'&op_code='+op_code+'&cust_name=<%=cust_name%>'+'&ttPhone_no=<%=cfm_id%>'+'&id_no=<%=contractno%>';
            document.form.submit();
        }
        //-->
    </script>   
</HEAD>
<BODY>
<FORM action="g059_print.jsp" method=post name=form>
<INPUT TYPE="hidden" name="loginAccept" value="<%=loginAccept%>">
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
    <div id="title_zi"></div>
</div>
<table cellspacing="0">
    <tr>
        <td width="13%" class="blue" nowrap>ҵ������</td>
        <td width="37%"><font class="orange">�����վ�</font></td>
        <td width="13%" class="blue">����</td>
        <td width="37%"><%=belongName%>
        </td>
    </tr>
    <tr><input type="hidden" name="cfmname" value="<%=cfmname%>">
        <td class="blue"> ��ͨ����</td>
        <td>
            <input type="text" name="phoneno" readonly maxlength="11" class="InputGrey" value="<%=cfm_id%>">
        </td>
        <td class="blue" nowrap> �·�����</td>
        <td>
            <input type="text" name="beginym" readonly size="8" class="InputGrey" value="<%=beginym%>">~
            <input type="text" name="endym" readonly size="8" class="InputGrey" value="<%=endym%>">
        </td>
    </tr>
    <tr>
        <td class="blue">�ʻ�����</td>
        <td>
            <input type="text" readonly name="contractno" class="InputGrey" value="<%=contractno%>">
        </td>
        <td class="blue">����״̬</td>
        <td>
            <input type="text" readonly name="textfield9" class="InputGrey" value="<%=run_name%>">
        </td>
    </tr>
    <tr>
        <td class="blue">�ͻ�����</td>
        <td>
            <input type="text" readonly name="textfield7" class="InputGrey" value="<%=cust_name%>">
        </td>
        <td class="blue">�ͻ���ַ</td>
        <td>
            <input type="text" readonly name="textfield8" class="InputGrey" value="<%=cust_address%>" size="50">
        </td>
    </tr>
    <tr>
        <td class="blue">��ǰԤ��</td>
        <td>
            <input type="text" readonly name="textfield1" class="InputGrey" value="<%=prepay_fee%>">
        </td>
        <td class="blue">��ǰǷ��</td>
        <td>
            <input type="text" readonly name="textfield2" class="InputGrey" value="<%=owe_fee%>">
        </td>
    </tr>
</table>
</div>
<div id="Operation_Table"> 
	<div class="title">
		<div id="title_zi">�ɲ���Ʊ��Ϣ</div>
	</div>
<table cellspacing="0">
    <tbody>
        <tr align="center">
            <th>ѡ��</th>
            <th>�ɷ���ˮ</th>
            <th>�ɷ�ʱ��</th>
            <th>ҵ������</th>
			<th>����ҵ��</th>
			<!--
            <th>�ɷ�����</th>
            <th>���ʽ</th>
            <th>�ɷѽ��</th>
            <th>Ԥ���</th>
            <th>����</th>
            <th>���ɽ�</th>
            <th>��������</th>
            <th>�����־</th>
			-->
        </tr>
       <%
        	String tbclass="";
          for (int y = 0; y < result2.length; y++) {
          	tbclass=(y%2==0)?"Grey":"";
            if ((y % 2) == 1) {
        %>

        	<tr align="center">
            <td>
              <input type="radio" name="radiobutton" value="<%=result2[y][0]%>" <%if(y==result2.length-1){%>checked<%}%> onclick="check('<%=result2[y][1]%>','<%=result2[y][3]%>')" >
              <input type="hidden" name="totaldate" value="<%=result2[y][1]%>">
              <input type="hidden" name="opname" value="<%=result2[y][2]%>">
			  <input type="hidden" name="op_code" value="<%=result2[y][3]%>">	
            </td>
        <%
        			}else {
        %>
        	<tr align="center">
            <td>
                <div align="center">
                    <input type="radio" name="radiobutton" value="<%=result2[y][0]%>" <%if(y==result2.length-1){%>checked<%}%> onclick="check('<%=result2[y][1]%>','<%=result2[y][3]%>')">
                    <input type="hidden" name="totaldate" value="<%=result2[y][1]%>">
                    <input type="hidden" name="opname" value="<%=result2[y][2]%>">
					<input type="hidden" name="op_code" value="<%=result2[y][3]%>">
              
                </div>
            </td>
        <%
            	}
            	for (int j = 0; j < result2[0].length; j++) {
        %>
		            <td class="<%=tbclass%>">
		                <div align="center"><%= result2[y][j]%></div>
		            </td>
            <%
                }
            %>
        </tr>
      <%
          }
      %>
    </tbody>
</table>
<table cellspacing="0">
    <tbody>
        <tr>
            <td id="footer">
                <input class="b_foot" name=sure type=button value=��ӡ onClick="docheck()">
                &nbsp;
                <input class="b_foot" name=clear type=button value=���� onClick="window.history.go(-1)">
                &nbsp;
                <input class="b_foot" name=reset type=button value=�ر� onClick="parent.removeTab('<%=opCode%>')">
            </td>
        </tr>
    </tbody>
</table>
<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>
<%
		}else {
%>
			<script language="JavaScript">
			    rdShowMessageDialog("û���ҵ����Բ������ͨҵ��Ʊ��");
			    history.go(-1);
			</script>
<%
    }
	} else {
%>
			<script language="JavaScript">
			    rdShowMessageDialog("��ѯ����<br>������룺'<%=return_code%>'��<br>������Ϣ��'<%=error_msg%>'��");
			    history.go(-1);
			</script>
<%
   }
%>

<script language="javascript">
	function check(dates,opcode)
	{
		 
	}
</script>