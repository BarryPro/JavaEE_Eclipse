<%
    /*************************************
    * ��  ��: �����˵���ѯ g334
    * ��  ��: version v1.0
    * ������: si-tech
    * ������: diling @ 2011-12-4
    **************************************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	String phoneNo = WtcUtil.repStr(request.getParameter("phoneNo"), "");
	String opCode = WtcUtil.repStr(request.getParameter("opCode"), "");
  String regCode=WtcUtil.repNull((String)session.getAttribute("regCode"));
  
  String  inParams [] = new String[2];
  inParams[0] = "select 'E-MAIL�ʵ�',decode(count(post_type),'0','δ��ͨ','�ѿ�ͨ') from Dcustpostprtbill a, dcustmsg b where a.id_no = b.id_no "
                 +" and b.phone_no =:phoneno "
                 +" and a.op_code = '1451' "
                 +" and a.tran_type = '1' "
                 +" and a.post_type ='2' "
                 +" and valid_time > sysdate "
                 +" union all "
                 +" select '�����ʵ�',decode(count(post_type),'0','δ��ͨ','�ѿ�ͨ') from Dcustpostprtbill a, dcustmsg b where a.id_no = b.id_no "
                 +" and b.phone_no =:phoneno "
                 +" and a.op_code = '1451' "
                 +" and a.tran_type = '1' "
                 +" and a.post_type ='5' "
                 +" and valid_time > sysdate "
                 +" union all "
                 +" select  '�����ʵ�',decode(count(post_type),'0','δ��ͨ','�ѿ�ͨ') from Dcustpostprtbill a, dcustmsg b where a.id_no = b.id_no  "
                 +" and b.phone_no =:phoneno "
                 +" and a.op_code = '1451' "
                 +" and a.tran_type = '1' "
                 +" and a.post_type ='6' "
                 +" and valid_time > sysdate ";
  inParams[1] = "phoneno="+phoneNo;
%>

	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regCode%>" retcode="retCode" retmsg="retMsg" outnum="2"> 
    <wtc:param value="<%=inParams[0]%>"/>
    <wtc:param value="<%=inParams[1]%>"/> 
  </wtc:service>  
  <wtc:array id="ret"  scope="end"/>
<%
    if("000000".equals(retCode)){
    
%>

  <div id="Main">
		<div id="Operation_Table">
			<div class="title">
				<div id="title_zi">�����˵���ѯ���</div>
			</div>
			<table cellspacing="0" name="t1" id="t1">
				<tr>
					<th>�����ʵ�</th>
					<th>�����ʵ�</th>
					<th>E-MAIL�ʵ�</th>
				</tr>
<%
				if(ret.length==0){
					out.println("<tr height='25' align='center'><td colspan='3'>");
					out.println("û���κμ�¼��");
					out.println("</td></tr>");
				}else if(ret.length>0){
					String tbclass = "";
%>
					<tr align="center" id="row">
						<td class="<%=tbclass%>"><%=ret[2][1]%></td>
						<td class="<%=tbclass%>"><%=ret[1][1]%></td>
						<td class="<%=tbclass%>"><%=ret[0][1]%></td>
					</tr>
<%
				}
%>
			</table>
	</div>
</div>
<%}%>
<input type="hidden" id="retCode" name="retCode" value="<%=retCode%>" />
<input type="hidden" id="retMsg" name="retMsg" value="<%=retMsg%>" />