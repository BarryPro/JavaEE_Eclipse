<%
/********************
 version v2.0
������: si-tech
*
*update:zhanghonga@2008-08-13 ҳ�����,�޸���ʽ
*
********************/
%>
 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	String opCode = "1500";
  String opName = "�ۺ���Ϣ��ѯ֮�ͻ���ʷ��Ϣ";

	String regionCode = ((String)session.getAttribute("orgCode")).substring(0,2);
	String cust_id=request.getParameter("cust_id");
	String login_accept=request.getParameter("login_accept");
	String work_no=request.getParameter("work_no");
	String work_name=request.getParameter("work_name");
	
	//add by diling for ��ȫ�ӹ��޸ķ����б�
	String loginNo = (String)session.getAttribute("workNo");
	String password = (String) session.getAttribute("password");
	
	String passValidateFlag = WtcUtil.repNull(request.getParameter("passValidateFlag"));//�Ƿ��Ѿ�ͨ������У��
/**
	ArrayList arlist = new ArrayList();
	try{
		s1550view viewBean = new s1550view();//ʵ����viewBean
		arlist = viewBean.s1500_custhis02(cust_id,login_accept,region_code); 
	}
	catch(Exception e)
	{
		//System.out.println("����EJB����ʧ�ܣ�");
	}
	String [][] result = new String[][]{};
	result = (String[][])arlist.get(0);
	**/
	%>
	
	<wtc:service name="s1500_custhis02" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="32" >
		<wtc:param value="<%=login_accept%>"/>
  <wtc:param  value="01"/>
  <wtc:param  value="<%=opCode%>"/>
  <wtc:param  value="<%=loginNo%>"/>
  <wtc:param  value="<%=password%>"/>
  <wtc:param  value=""/>
  <wtc:param  value=""/>
	<wtc:param value="<%=cust_id%>"/>
	<wtc:param value="<%=regionCode%>"/>
	<wtc:param value="<%=passValidateFlag%>"/>
	</wtc:service>
	<wtc:array id="result" scope="end"/>
<%	
	int iretCode=999999; //��Ϊ����ķ���д�ò��淶,��ȷ�Ĳ�һ������������,����Ҫ����ж�
	
	if(retCode1!=null&&!"".equals(retCode1)){
		iretCode=Integer.parseInt(retCode1);
	}
	if(iretCode!=0){
%>
	<script language="javascript">
		history.go(-1);
		rdShowMessageDialog("����δ�ܳɹ�,�������:<%=retCode1%><br>������Ϣ:<%=retMsg1%>!");
	</script>
<%
		return;
	}else if(result==null||result.length==0){
%>
	<script language="javascript">
		history.go(-1);
		rdShowMessageDialog("��ѯ���Ϊ��,�����ͻ���ʷ��ϸ��ϢΪ��!");
	</script>
<%
		return;
	}
	
	
	String return_code =result[0][0];
	String return_message =result[0][1];

	if (!return_code.equals("000000"))
	{
%>
<script language="JavaScript">
	rdShowMessageDialog("<%=return_message%><br>����������:<%=return_code%>");
	history.go(-1);
</script>
<%	
	}
%>

<HTML><HEAD><TITLE>�ͻ���ʷ��Ϣ</TITLE>
</HEAD>
<body>
<FORM method=post name="f1500_custhis02">
	<%@ include file="/npage/include/header.jsp" %>     	
		<div class="title">
			<div id="title_zi">�ͻ���ʷ��Ϣ&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;�ͻ�����:<%=result[0][3]%></div>
		</div>

      <TABLE cellSpacing="0">
        <TBODY>
          <TR>
            <TD class="blue">�ͻ���ʶ</td>
            <td><%=result[0][2]%>&nbsp;</TD>
            <TD class="blue">�ͻ�����</td>
            <td colspan="3"><%=result[0][3]%>&nbsp;</TD>
          </TR>
          <TR>
            <TD class="blue">��������</td>
            <td><%=result[0][4]%>&nbsp;</TD>
            <TD class="blue">��������</td>
            <td><%=result[0][5]%>&nbsp;</TD>
            <TD class="blue">��������</td>
            <td><%=result[0][6]%>&nbsp;</TD>
          </TR>
          <TR>
            <TD class="blue">�ͻ�״̬</td>
            <td><%=result[0][7]%>&nbsp;</TD>
            <TD class="blue">�ͻ�״̬ʱ��</td>
            <td><%=result[0][8]%>&nbsp;</TD>
            <TD class="blue">�ͻ�����</td>
            <td><%=result[0][9]%>&nbsp;</TD>
          </TR>
          <TR>
            <TD class="blue">�ͻ����</td>
            <td><%=result[0][10]%>&nbsp;</TD>
            <TD class="blue">�ͻ���ַ</td>
            <td colspan="3"><%=result[0][11]%>&nbsp;</TD>
          </TR>

	        <tr>
	          <TD class="blue">ͨѶ��ַ</td>
	          <td><%=result[0][12]%>&nbsp;</TD>
	          <TD class="blue">�ͻ�֤������</td>
	          <td colspan="3"><%=result[0][13]%>&nbsp;</TD>
	        </tr>

          <TR>
            <TD class="blue">֤������</td>
            <td><%=result[0][14]%>&nbsp;</TD>
            <TD class="blue">֤����ַ</td>
            <td colspan="3"><%=result[0][15]%>&nbsp;</TD>
          </TR>
        </TBODY>

        <TBODY>
          <TR>
            <TD class="blue">֤����Ч��</td>
            <td><%=result[0][16]%>&nbsp;</TD>
            <TD class="blue">��ϵ������</td>
            <td><%=result[0][17]%>&nbsp;</TD>
            <TD class="blue">��ϵ�˵绰</td>
            <td><%=result[0][18]%>&nbsp;</TD>
          </TR>
        </TBODY>

        <TBODY>
          <TR>
            <TD class="blue">��������</td>
            <td><%=result[0][19]%>&nbsp;</TD>
            <TD class="blue">��ϵ�˵�ַ</td>
            <td colspan="3"><%=result[0][20]%>&nbsp;</TD>
          </TR>

          <TR>
            <TD class="blue">��ϵ�˴���</td>
            <td><%=result[0][21]%>&nbsp;</TD>
            <TD class="blue">��������</td>
            <td><%=result[0][22]%>&nbsp;</TD>
            <TD class="blue">����������ʶ</td>
            <td><%=result[0][23]%>&nbsp;</TD>
          </TR>
          <TR>
            <TD class="blue">����ʱ��</td>
            <td><%=result[0][24]%>&nbsp;</TD>
            <TD class="blue">����ʱ��</td>
            <td><%=result[0][25]%>&nbsp;</TD>
            <TD class="blue">�ϼ��ͻ�</td>
            <td><%=result[0][26]%>&nbsp;</TD>
          </TR>
          <TR>
            <TD class="blue">����ʱ��</td>
            <td><%=result[0][27]%>&nbsp;</TD>
            <TD class="blue">��������</td>
            <td><%=result[0][28]%>&nbsp;</TD>
            <TD class="blue">��������</td>
            <td><%=result[0][29]%>&nbsp;</TD>
          </TR>
          <TR>
            <TD class="blue">������ˮ</td>
            <td><%=result[0][30]%>&nbsp;</TD>
            <TD class="blue">��������</td>
            <td  colspan="3"><%=result[0][31]%>&nbsp;</TD>
          </TR>
        </TBODY>
	    </TABLE>
         
      <table cellspacing=0>
        <tbody> 
          <tr> 
      	    <td id="footer">
    	      &nbsp; <input class="b_foot" name=back onClick="history.go(-1)" type=button value=����>
    	      &nbsp; <input class="b_foot" name=back onClick="window.close()" type=button value=�ر�>
    	      &nbsp; 
    	    	</td>
          </tr>
        </tbody> 
      </table>
     	<%@ include file="/npage/include/footer.jsp" %>
		</FORM>
	</BODY>
</HTML>
