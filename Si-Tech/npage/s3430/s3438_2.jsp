<%
/*********************
 * update by qidp @ 2009-09-10 for �����°��Ʒ����
 *********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
 
 <%
	response.setHeader("Pragma","No-Cache"); 
	response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0);
	
	String opCode = "3438";
	String opName = "APN��Ϣ��ѯ";

	String workno = WtcUtil.repNull((String)session.getAttribute("workNo"));
	String workname = WtcUtil.repNull((String)session.getAttribute("workName"));
	String pass = WtcUtil.repNull((String)session.getAttribute("password"));
	String regionCode = WtcUtil.repNull((String)session.getAttribute("regCode"));
	String i_phone_no=request.getParameter("phone_no");
	String inParas[] = new String[4];
	inParas[0] = "3438";
    inParas[1] = workno;
	inParas[2] = pass;
	inParas[3] = i_phone_no;

	//int [] lens ={1,9};
	
	//ScallSvrViewBean viewBean = new ScallSvrViewBean();//ʵ����viewBean
 	//CallRemoteResultValue value = viewBean.callService("2",i_phone_no,"s3438Qry","10",lens,inParas);
     
	%>
        <wtc:service name="s3438QryEXC" routerKey="region" routerValue="<%=regionCode%>" retcode="s3438QryCode" retmsg="s3438QryMsg" outnum="10" >
        	<wtc:param value="<%=inParas[0]%>"/>
        	<wtc:param value="<%=inParas[1]%>"/> 
        	<wtc:param value="<%=inParas[2]%>"/> 
        	<wtc:param value="<%=inParas[3]%>"/> 
        </wtc:service>
        <wtc:array id="s3438QryArr1" start="0" length="1" scope="end"/>
        <wtc:array id="s3438QryArr2" start="1" length="9" scope="end"/>
    <%
	
	//ArrayList list  = value.getList();
    //String[][] result_a = (String[][])list.get(0);
    //String[][] result = (String[][])list.get(1);
    
    String[][] result_a = new String[][]{};
    String[][] result = new String[][]{};
    
    if("000000".equals(s3438QryCode) && s3438QryArr1.length>0){
        result_a = s3438QryArr1;
    }
    
    if("000000".equals(s3438QryCode) && s3438QryArr2.length>0){
        result = s3438QryArr2;
    }
    
    //String iErrorNo = String.valueOf(value.getErrorCode());
 	//String sErrorMessage = value.getErrorMessage();	
 	
 	String iErrorNo = s3438QryCode;
 	String sErrorMessage = s3438QryMsg;
%>

<% if (!iErrorNo.equals("000000")) {%>
  <script language="JavaScript">
    rdShowMessageDialog("���ʲ�ѯʧ��! ������룺<%=iErrorNo%>��������Ϣ��<%=sErrorMessage%>",0);
    history.go(-1);
    //window.location="f1518_1.jsp";
  </script>
<% } else { %>
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<TITLE>������BOSS-APN��Ϣ��ѯ</TITLE>
<META content="text/html; charset=gb2312" http-equiv=Content-Type>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
</HEAD>
<BODY>
<FORM action="s1321_3print.jsp" method=post name=form>
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">APN��Ϣ��ѯ</div>
</div>   
<table cellspacing="0">
    <tr>
        <td nowrap class="blue">�ͻ�����</td>
        <td colspan="8" nowrap class="orange"><%=result_a[0][0]%></td>
    </tr>
    
    <tr>
        <th nowrap>���ű��</th>
        <th nowrap>��������</th>
        <th nowrap>APN����</th>
        <th nowrap>��������</th>
        <th nowrap>��Ȩ����</th>
        <th nowrap>IP��ַ</th>
        <th nowrap>��������</th>
        <th nowrap>����ʱ��</th>
        <th nowrap>������ˮ</th>
    </tr>

<% for (int i = 0;i < result.length; i++) { %>
    <tr> 
    	<td nowrap>
            <%=result[i][0]%>
        </td>
        <td nowrap>
            <%=result[i][1]%>
        </td>
        <td nowrap>
            <%=result[i][2]%>
        </td>
        <td nowrap>
            <%=result[i][3]%>
        </td>
        <td nowrap>
            <%=result[i][4]%>
        </td>
        <td nowrap>
            <%=result[i][5]%>
        </td>
        <td nowrap>
            <%=result[i][6]%>
        </td>
        <td nowrap>
            <%=result[i][7]%>
        </td>
        <td nowrap>
            <%=result[i][8]%>
        </td>                                
    </tr>
<% } %>
    
</table>
        <p id="footer"> 
        <input class="b_foot" name=reset type=reset value=���� onclick="JavaScript:history.go(-1)">
        <input class="b_foot" name=sure type=button value=�ر� onclick="removeCurrentTab();">
		</p>
<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>
<% } %>