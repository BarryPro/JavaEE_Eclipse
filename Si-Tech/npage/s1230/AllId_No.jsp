<!DOCTYPE html PUBLIC "-//W3C//DTD Xhtml 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
  /*
   * ����: �ͻ���������1231/�޸�1230
   * �汾: 1.0
   * ����: 2009/1/14
   * ����: zhanghonga
   * ��Ȩ: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<html xmlns="http://www.w3.org/1999/xhtml">
	<HEAD>
<TITLE>�ͻ�ID��ѯ</TITLE>

<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content=expired http-equiv=0>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>

<%
	String opCode="1231";
	String opName="�ͻ���������";
	String regionCode=(String)session.getAttribute("regCode"); 
	String id_no = request.getParameter("id_no");
	String  qrySql = "select cust_id, cust_name from dCustDoc where  id_iccid = '" + id_no + "'" ;
	//System.out.println(qrySql);
	String work_no = (String)session.getAttribute("workNo");
	String loginPwd    = (String)session.getAttribute("password");
	String notestr="����iccid=["+id_no+"]���в�ѯ";
%>
<wtc:service name="sUserCustInfo" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg1" outnum="100" >
  <wtc:param value="0"/>
  <wtc:param value="01"/>
  <wtc:param value="<%=opCode%>"/>
  <wtc:param value="<%=work_no%>"/>	
  <wtc:param value="<%=loginPwd%>"/>		
  <wtc:param value=""/>	
  <wtc:param value=""/>
  <wtc:param value=""/>
  <wtc:param value="<%=notestr%>"/>
  <wtc:param value=""/>
  <wtc:param value=""/>
  <wtc:param value="<%=id_no%>"/>
  <wtc:param value=""/>
</wtc:service>
<wtc:array id="returnFlag" start="0" length="1" scope="end"/>
<wtc:array id="allcus_idStr" start="1" length="17" scope="end"/>
<script>
 function ret(p)
 {
   window.returnValue=p;
   window.close();
 }
</script>
<BODY>
<FORM action="" method=post name="form1" >
	<%@ include file="/npage/include/header_pop.jsp" %>
	<div class="title">
		<div id="title_zi">�ͻ���Ϣ</div>
	</div>
<table cellspacing="0">
	<TR>
		<th width="20%"><div align="center">�ͻ�ID</div></th>
		<th width="80%"><div align="center">�ͻ�����</div></th>
	</TR>
	
<%
  if("000000".equals(retCode)){
    if(allcus_idStr.length>0){
      for(int i = 0 ; i < allcus_idStr.length; i ++)
      {
      	String tdClass = ((i%2)==1)?"Grey":"";
      	if("02".equals(returnFlag[0][0])){
      	   %>
          <tr>
            <td width="20%" align=left>
              <div align="center"><a href="#"  onclick="ret('<%=allcus_idStr[i][0].trim()%>')"><%=(String)allcus_idStr[i][0].trim()%></a></div>
            </td>
            <td width="80%" class="<%=tdClass%>"><div align="center"><%=allcus_idStr[i][4].trim()%></div>
            </td>		             
          </tr>
          <%
      	}
      }
    }
  }else{
%>
    <tr>
      <td align=left colspan="3">
        <div align="center">������룺<%=retCode%><br>������Ϣ��<%=retMsg1%></div>
      </td>           
    </tr>
<%
  }
%>
	<tr>
		<td align="center" id="footer" colspan="2"> 
			<input class="b_foot" type=button name=qryPage value="�ر�" onClick="window.close()">
		</td>
	</tr>
</table>
    <%@ include file="/npage/include/footer_pop.jsp" %>
</FORM>
 </BODY>
 </HTML>
