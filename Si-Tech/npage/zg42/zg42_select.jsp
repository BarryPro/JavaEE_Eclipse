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
    String opCode = "zg42";
    String opName = "�����Ʊ����";
    String beginym = request.getParameter("beginym");
    String endym = request.getParameter("endym");
    String contractno = request.getParameter("contractno");
    String phoneno = request.getParameter("phoneno");

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

	// xl add for ��Ʊ���� begin
	String check_seq="";
	String s_flag="";
	String result_check[][]=new String[][]{};
	String[] inParam2 = new String[2];
	inParam2[0]="select to_char(S_INVOICE_NUMBER),flag from tt_WLOGININVOICE where LOGIN_NO = :workNo";
	inParam2[1]="workNo="+workno;
	%>
	<wtc:service name="TlsPubSelCrm"  outnum="2" >
		<wtc:param value="<%=inParam2[0]%>"/>
		<wtc:param value="<%=inParam2[1]%>"/>
	</wtc:service>
	<wtc:array id="retList" scope="end" />
<%
	result_check = retList;
	if(retList.length != 0)
	{
		check_seq=result_check[0][0];
		s_flag=result_check[0][1];
		//System.out.println("AAAAAAAAAAAAAAAAAAAAAAAAAAAa check_seq is "+check_seq);
	}
	// xl add for ��Ʊ���� end
	//xl add for ȡƷ�� 
	String result_pp[][]=new String[][]{};
	String s_sm_code="";
	String[] inParam_pp = new String[2];
	inParam_pp[0]="select trim(sm_code) from dcustmsg where phone_no=:phoneno";
	inParam_pp[1]="phoneno="+phoneno;
	%>
	<wtc:service name="TlsPubSelBoss"  outnum="1" >
		<wtc:param value="<%=inParam_pp[0]%>"/>
		<wtc:param value="<%=inParam_pp[1]%>"/>
	</wtc:service>
	<wtc:array id="retList_pp" scope="end" />
	<%
	result_pp = retList_pp;
	if(result_pp.length != 0)
	{
		s_sm_code=result_pp[0][0];
		System.out.println("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa s_sm_code is "+s_sm_code);
	}
	else
	{
		//����
		%>
		 <script language='jscript'>			
			rdShowMessageDialog("��ѯ�û�Ʒ�ƴ���!",0);
			history.go(-1);
		 </script>
		<%
	}

    String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
    System.out.println("����������������������������������������������������dddddddddddddddpwrf=" + pwrf+" and phoneno is "+phoneno);
    String op_code = "1352";
    String[] inParas = new String[5];
    inParas[0] = workno;
    inParas[1] = phoneno;
    inParas[2] = contractno;
    inParas[3] = beginym;
    inParas[4] = endym;
    int[] lens = {8, 11};
    //CallRemoteResultValue value = viewBean.callService("2", phoneno, "s1352Init", "19", lens, inParas);
%>
		<wtc:service name="s1352Init" routerKey="phone" routerValue="<%=phoneno%>" outnum="19" >
		<wtc:param value="<%=inParas[0]%>"/>
		<wtc:param value="<%=inParas[1]%>"/>
		<wtc:param value="<%=inParas[2]%>"/>
		<wtc:param value="<%=inParas[3]%>"/>
		<wtc:param value="<%=inParas[4]%>"/>
		</wtc:service>
		<wtc:array id="result" start="0" length="8" scope="end"/>	
		<wtc:array id="result2" start="8" length="11" scope="end"/>	
<%
    String return_code = "";
    String error_msg = "";
    if(result.length>0){
    	return_code = result[0][0];
    	error_msg = result[0][1];
    }

    if (return_code.equals("000000")) {
        int maxlines = result2.length;
        if (maxlines != 0) {
            String cust_name = result[0][2].trim();
            String cust_address = result[0][3].trim();
            String run_name = result[0][4].trim();
            String prepay_fee = result[0][5].trim();
            String owe_fee = result[0][6].trim();
            String unbill_fee = result[0][7].trim();
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
			var pay_money ;
			 
            if (lines == 1)
            {
                login_accept = document.form.radiobutton.value;
                totaldate = document.form.totaldate.value.substring(0, 4) + document.form.totaldate.value.substring(5, 7) + document.form.totaldate.value.substring(8, 10);
                opname = document.form.opname.value;
                re_print = document.form.print_flag.value;
                login_no = document.form.login_no.value;
				pay_money= document.form.pay_money.value; 
            }
            else
            {
                for (var i = 0; i < lines; i++)
                {
                    if (document.form.radiobutton[i].checked == true)
                    {
                        login_accept = document.form.radiobutton[i].value;
                        totaldate = document.form.totaldate[i].value.substring(0, 4) + document.form.totaldate[i].value.substring(5, 7) + document.form.totaldate[i].value.substring(8, 10);
                        opname = document.form.opname[i].value;
                        re_print = document.form.print_flag[i].value;
                        login_no = document.form.login_no[i].value;
						pay_money= document.form.pay_money[i].value; 
                    }
                }
            }
            

            if (re_print == "1") {
                if ("<%=pwrf%>" == "0") {
                    rdShowMessageDialog("���վ��Ѿ������,�������ظ�����!");
                    document.form.sure.disabled = true;
                    return false;
                }
            } else {
                if ("<%=pwrf%>" == "0") {
                    if ((login_no.substr(0, 5) != "~~~~~") && (totaldate != "<%=dateStr%>" || login_no != "<%=workno%>")) {
                        rdShowMessageDialog("�˹��Ų������ӡ�������ŵ��վ�,���߲��ǵ���Ĳ���!");
                        document.form.sure.disabled = true;
                        return false;
                    }

                }
            }
			/*
				xl add ����Ʒ�Ʋ�ͬ ���ò�ͬ�Ĳ���ҳ�� ���²�ͬ
				kf���⴦��
				add new ki
				kf kh ki����
			*/
			if(("<%=s_sm_code%>"=="kf")||("<%=s_sm_code%>"=="kg")||("<%=s_sm_code%>"=="ki"))
			{
				var h=480;
				var w=650;
				var t=screen.availHeight/2-h/2;
				var l=screen.availWidth/2-w/2;
				var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no";
				var path="../s1300/select_invoice_1352.jsp?login_accept="+login_accept+"&ym="+totaldate.substring(0,6);
				//alert("path is "+path);
				var returnValue = window.showModalDialog(path,"",prop);
				//alert("test returnValue is "+returnValue);
				if(returnValue=="1")//��Ʊ
				{
					 document.form.action = 'zg42_print_kf.jsp?pageOpCode=<%=opCode%>&pageOpName=<%=opName%>&contractno=' + document.form.contractno.value + '&payAccept=' + login_accept + '&total_date=' + totaldate + '&workno=<%=workno%>' + '&returnPage=zg42_1.jsp'+'&check_seq=<%=check_seq%>'+'&s_flag=<%=s_flag%>&pay_money='+pay_money+"&s_sm_code=<%=s_sm_code%>";
				}
				else if(returnValue=="3" )
				{
					
					//alert("���ӵ�");
					var s_kpxm="zg42_��Ʊ����";
					var s_ghmfc=document.form.textfield7.value;
					var s_jsheje=pay_money;//��˰�ϼƽ��
					var s_hjbhsje=0;//�ϼƲ���˰���
					var s_hjse=0;
					var s_xmmc="��ͨ���ӷ�Ʊ����";//��Ŀ���� crm����Ϊ����? ����zg17������ô����
					var s_ggxh="";
					var s_hsbz="1";//��˰��־ 1=��˰
					var s_xmdj=pay_money;
					var s_xmje=pay_money;
					var s_sl="*";
					var s_se="0";
					//����
					var op_code="<%=opCode%>";
					var payaccept=login_accept;
					var id_no="0";
					var sm_code="0";
					var phone_no="<%=phoneno%>";
					var pay_note=s_kpxm;
					var returnPage ="../zg42/zg42_1.jsp?activePhone="+phone_no;
					var chbz="1";
					var kphjje=pay_money;
					document.form.action="../s1300/PrintInvoice_dz.jsp?s_kpxm="+s_kpxm+"&s_ghmfc="+s_ghmfc+"&s_jsheje="+s_jsheje+"&hjse="+s_hjse+"&s_xmmc="+s_xmmc+"&s_ggxh="+s_ggxh+"&s_hsbz="+s_hsbz+"&s_xmdj="+s_xmdj+"&s_xmje="+s_xmje+"&s_sl="+s_sl+"&s_se="+s_se+"&op_code="+op_code+"&payaccept="+payaccept+"&id_no="+id_no+"&sm_code="+sm_code+"&phone_no="+phone_no+"&pay_note="+pay_note+"&chbz="+chbz+"&returnPage="+returnPage+"&xmsl=1&hjbhsje="+s_hjbhsje+"&kphjje="+kphjje;
					document.form.submit(); 
					
				}
				else//qx
				{
					var paySeq=login_accept;
					var phoneno="<%=phoneno%>";
					var kphjje=pay_money;//��Ʊ�ϼƽ��
					var s_hjbhsje=0;//�ϼƲ���˰���
					var s_hjse=0;
					var contractno="<%=contractno%>";
					var id_no="0";
					var sm_code="0";
					var s_xmmc="<%=opName%>";//��Ŀ���� crm����Ϊ����? ����zg17������ô����
					var opCode="<%=opCode%>";
					var return_page = "../zg42/zg42_1.jsp";
					document.form.action="../s1300/PrintInvoice_qx.jsp?opCode="+opCode+"&paySeq="+paySeq+"&phoneno="+phoneno+"&kphjje="+kphjje+"&s_hjbhsje="+s_hjbhsje+"&hjse="+s_hjse+"&returnPage="+return_page+"&hsbz=1&xmdj="+kphjje+"&contractno="+contractno+"&id_no="+id_no+"&sm_code="+sm_code+"&chbz=1&s_xmmc="+s_xmmc+"&paynote=�ɷ�";
					
					document.form.submit();
				}
			}
			else if ("<%=s_sm_code%>"=="kh")
			{
				//alert("test kh?");
				document.form.action = 'zg42_print_kf.jsp?pageOpCode=<%=opCode%>&pageOpName=<%=opName%>&contractno=' + document.form.contractno.value + '&payAccept=' + login_accept + '&total_date=' + totaldate + '&workno=<%=workno%>' + '&returnPage=zg42_1.jsp'+'&check_seq=<%=check_seq%>'+'&s_flag=<%=s_flag%>&pay_money='+pay_money+"&s_sm_code=<%=s_sm_code%>";
			}//kh ����ԭ����
			else
			{
				//alert("����Ʒ��");
				document.form.action = 'zg42_print.jsp?pageOpCode=<%=opCode%>&pageOpName=<%=opName%>&contractno=' + document.form.contractno.value + '&payAccept=' + login_accept + '&total_date=' + totaldate + '&workno=<%=workno%>' + '&returnPage=zg42_1.jsp'+'&check_seq=<%=check_seq%>'+'&s_flag=<%=s_flag%>&pay_money='+pay_money+"&s_sm_code=<%=s_sm_code%>";
			}
			
			
		 
            
        }
        //-->
    </script>
</HEAD>
<BODY>
<FORM action="" method=post name=form>
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
    <tr>
        <td class="blue"> �������</td>
        <td>
            <input type="text" name="phoneno" readonly maxlength="11" class="InputGrey" value="<%=phoneno%>">
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
		<div id="title_zi">�ɷ���ʷ��Ϣ</div>
	</div>
<table cellspacing="0">
    <tbody>
        <tr align="center">
            <th>ѡ��</th>
            <th>����/�ʻ�����</th>
            <th>�ɷ�ʱ��</th>
            <th>�ɷ���ˮ</th>
            <th>�ɷ�����</th>
            <th>���ʽ</th>
            <th>�ɷѽ��</th>
            <th>Ԥ���</th>
            <th>����</th>
            <th>���ɽ�</th>
            <th>��������</th>
            <th>�����־</th>
        </tr>
        <%
        	String tbclass="";
          for (int y = 0; y < result2.length; y++) {
          	tbclass=(y%2==0)?"Grey":"";
            if ((y % 2) == 1) {
        %>

        	<tr align="center">
            <td>
              <input type="radio" name="radiobutton" value="<%=result2[y][2]%>" <%if(y==result2.length-1){%>checked<%}%> >
              <input type="hidden" name="totaldate" value="<%=result2[y][1]%>">
              <input type="hidden" name="opname" value="<%=result2[y][3]%>">
              <input type="hidden" name="print_flag" value="<%=result2[y][10]%>">
              <input type="hidden" name="login_no" value="<%=result2[y][9]%>">
			  <input type="hidden" name="pay_money" value="<%=result2[y][5]%>">
            </td>
        <%
        			}else {
        %>
        	<tr align="center">
            <td>
                <div align="center">
                    <input type="radio" name="radiobutton" value="<%=result2[y][2]%>" <%if(y==result2.length-1){%>checked<%}%>>
                    <input type="hidden" name="totaldate" value="<%=result2[y][1]%>">
                    <input type="hidden" name="opname" value="<%=result2[y][3]%>">
                    <input type="hidden" name="print_flag" value="<%=result2[y][10]%>">
                    <input type="hidden" name="login_no" value="<%=result2[y][9]%>">
					<input type="hidden" name="pay_money" value="<%=result2[y][5]%>">
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
			    rdShowMessageDialog("û���ҵ����Բ�����վݣ�");
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

