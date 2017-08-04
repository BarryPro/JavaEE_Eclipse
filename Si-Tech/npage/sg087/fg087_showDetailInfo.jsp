<%
    /*************************************
    * ��  ��: һ��֧����Ա�嵥��ѯ չʾ��ϸ g087
    * ��  ��: version v1.0
    * ������: si-tech
    * ������: diling @ 2012-9-13
    **************************************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.text.*" %>
<%
  response.setHeader("Pragma","No-Cache");
  response.setHeader("Cache-Control","No-Cache");
  response.setDateHeader("Expires", 0);
%>
<%
  String regCode = (String)session.getAttribute("regCode");
  String loginNo = (String)session.getAttribute("workNo");
  String opCode = WtcUtil.repNull((String)request.getParameter("opCode"));
  String opName = WtcUtil.repNull((String)request.getParameter("opName"));
  String idNo = WtcUtil.repNull((String)request.getParameter("idNo"));/*�û�idNo*/
  String accountNo = WtcUtil.repNull((String)request.getParameter("accountNo"));/*��Ʒ�˺�*/
  String monthList = WtcUtil.repNull((String)request.getParameter("monthList"));/*�������£�yyyyMM */
  String qryPhoneNo = WtcUtil.repNull((String)request.getParameter("qryPhoneNo"));
  DecimalFormat numFormat  =   new  DecimalFormat("##0.00");  
  
  /*������dCustOwe+����+�˺ź���λ*/
  String operateTableName = "dCustOwe"+monthList+(accountNo.substring(accountNo.length()-2,accountNo.length()));
  
  /* ��ȡ���ڴ����� */
  String  inParams [] = new String[2];
  inParams[0] = "select nvl(to_char(sum(a.should_pay-a.favour_fee)),0.00) from "+operateTableName+" a where a.id_no=:idno and a.contract_no=:contractno";
  inParams[1] = "idno="+idNo+",contractno="+accountNo;
  
  String period_fee = "";
%>  
<wtc:service name="TlsPubSelBoss" routerKey="region" routerValue="<%=regCode%>" retcode="retCode1" retmsg="retMsg1" outnum="1"> 
<wtc:param value="<%=inParams[0]%>"/>
<wtc:param value="<%=inParams[1]%>"/> 
</wtc:service>  
<wtc:array id="ret"  scope="end"/>
<%
if("000000".equals(retCode1)){
  if(ret.length>0){
    period_fee = numFormat.format(Float.parseFloat(ret[0][0]));
  }
}else{
%>
    <SCRIPT language="JavaScript">
      rdShowMessageDialog("������룺<%=retCode1%><br>������Ϣ��<%=retMsg1%>",0);
      window.close();
    </SCRIPT>
<%
  System.out.println("------��ȡ�������ڴ�����-----period_fee="+period_fee);
}
  System.out.println("------���ڴ�����-----period_fee="+period_fee);
%>

<wtc:service name="se610SQ" routerKey="region" routerValue="<%=regCode%>" retcode="retCode2" retmsg="retMsg2" outnum="18">
	<wtc:param value="<%=qryPhoneNo%>"/>
	<wtc:param value="<%=monthList%>"/> 
	<wtc:param value="<%=loginNo%>"/>
</wtc:service>
<wtc:array id="result"  scope="end"/>

<HTML>
  <HEAD>
  </HEAD>
  <BODY>
    <%
    if("000000".equals(retCode2)){
    %>
  <div id="Main">
    <DIV id="Operation_Table">
      <div class="title">
        <div id="title_zi">�й��ƶ�ͨ�ż��ſͻ���Ա�˵�һ��֧��������Ա�嵥</div>
      </div>
        <table>
          <tr>
            <th>�ֻ�����</th>
            <th>ʡ��</th>
            <th>���ڴ�����</th>
            <th>�ײͼ��̶���</th>
            <th>����ͨѶ��</th>
            <th>������</th>
            <th>����/���ŷ�</th>
            <th>��ֵҵ���</th>
            <th>����ҵ���</th>
            <th>��������</th>
            <th>�Żݼ�����</th>
            <th>�ܼ�</th>
          </tr>
        <%
        		if(result.length==0){
        			out.println("<tr height='25' align='center'><td colspan='12'>");
        			out.println("û���κμ�¼��");
        			out.println("</td></tr>");
        		}else if(result.length>0){
        			String tbclass = "";
        			for(int i=0;i<result.length;i++){
        					tbclass = (i%2==0)?"Grey":"";
        					float addValueFee = Float.parseFloat(result[i][11])+Float.parseFloat(result[i][12]);
                  //float addValueFeeFormat = (float)(Math.round(addValueFee*100))/100;
        					float anotherValues = Float.parseFloat(result[i][8])+Float.parseFloat(result[i][13])+Float.parseFloat(result[i][15]);
        					//float anotherValuesFormat = (float)(Math.round(anotherValues*100))/100;
        					
        					   
                  String  addValueFeeFormat = numFormat.format(addValueFee);    
                  String  anotherValuesFormat = numFormat.format(anotherValues); 
                  
                   System.out.println("------addValueFee="+addValueFee+"---------------addValueFeeFormat="+addValueFeeFormat);
                   System.out.println("------anotherValues="+anotherValues+"---------------anotherValuesFormat="+anotherValuesFormat);
                  
                  String sumFeeFormat = numFormat.format(Float.parseFloat(result[i][3]));
        %>
        			<tr align="center" id="row_<%=i%>">
        				<td class="<%=tbclass%>"><%=qryPhoneNo%></td>
        				<td class="<%=tbclass%>">������</td>
        				<td class="<%=tbclass%>"><%=period_fee%></td>
        				<td class="<%=tbclass%>"><%=result[i][6]%></td>
        				<td class="<%=tbclass%>"><%=result[i][7]%></td>
        				<td class="<%=tbclass%>"><%=result[i][9]%></td>
        				<td class="<%=tbclass%>"><%=result[i][10]%></td>
        				<td class="<%=tbclass%>"><%=addValueFeeFormat%></td>
        				<td class="<%=tbclass%>"><%=result[i][14]%></td>
        				<td class="<%=tbclass%>"><%=anotherValuesFormat%></td>
        				<td class="<%=tbclass%>"><%=result[i][5]%></td>
        				<td class="<%=tbclass%>"><%=sumFeeFormat%></td>
        			</tr>
        <%
        			}
        		}
        %>
        </table>
       
        <table>
        <tr>
          <td align="center" id="footer" colspan="12">
            <input class="b_foot" id=closebtn type=button value="�ر�" onClick="window.close()">
          </td>
        </tr>
        </table>
     </div>
  </div>
 <%}else{
    System.out.println("-------�����ˣ�����----retCode2="+retCode2+"------------retMsg2="+retMsg2);
  %>
      <SCRIPT language="JavaScript">
        rdShowMessageDialog("������룺<%=retCode2%><br>������Ϣ��<%=retMsg2%>",0);
        window.close();
      </SCRIPT>
  <%
  }
  %>
  </BODY>
</HTML>