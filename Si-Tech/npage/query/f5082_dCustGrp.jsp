 <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html; charset=GBK" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<%request.setCharacterEncoding("GB2312");%>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="com.sitech.boss.s1100.viewBean.*" %>
<%@ page import="com.sitech.boss.spubcallsvr.viewBean.SPubCallSvrImpl" %>
<%@ page import="com.sitech.boss.common.viewBean.comImpl"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%
	String opCode = "5082";
	String opName = "������Ϣ��ѯ";
	//������� �û�ID���ֻ����롢�������š�����Ա����ɫ������
	String workNo = WtcUtil.repNull((String)session.getAttribute("workNo"));
	String workName = WtcUtil.repNull((String)session.getAttribute("workName"));
	String regionCode=WtcUtil.repNull((String)session.getAttribute("regCode"));
	String phoneNo  = request.getParameter("phoneNo");
	/*String sql_str="select unit_id, unit_name, BOSS_VPMN_CODE, service_no, b.login_name, contact_phone, c.product_code, c.product_name "
		+"from dCustDocOrgAdd a, dLoginMsg b, (select cust_id,a.PRODUCT_CODE,b.product_name from dGrpUserMsg a, sProductCode b where a.product_code=b.product_code and id_no=(select unit_id_no from dGrpMemberMsg where id_no=(select id_no from dCustMsg where phone_no='"+phoneNo+"'))) c "
		+"where a.service_no=b.login_no and a.cust_id=c.cust_id and a.cust_id=(select cust_id from dGrpUserMsg where id_no=(select unit_id_no from dGrpMemberMsg where id_no=(select id_no from dCustMsg where phone_no='"+phoneNo+"')))";
	*/
	String sql_str="select c.unit_id,c.unit_name,c.boss_vpmn_code,c.service_no,c.contact_phone,a.product_code,d.product_name "
	         +"from dGrpUsermsg a,dGrpUserMebMsg b,dGrpcustmsg c,sproductcode d "
	         +"where a.id_no = b.id_no and b.member_no = '"+phoneNo+"' and a.cust_id = c.cust_id and a.product_code = d.product_code ;";
	
	System.out.println(sql_str);
	//SPubCallSvrImpl impl = new SPubCallSvrImpl();
	//ArrayList arlist = new ArrayList();
	/*int errCode=0;
	String errMsg="";
		arlist = impl.sPubSelect("7",sql_str,"region",regionCode);
		errCode=impl.getErrCode();   
		errMsg=impl.getErrMsg(); */

	//ArrayList arlist = new ArrayList();
	//int[] colNum=new int[1];
	//colNum[0]=7;
	//comImpl co=new comImpl();
	//arlist=co.multiSql(colNum,sql_str); 
	//String [][] result = new String[][]{};
	//result = (String[][])arlist.get(0); 
%>
    <wtc:service name="s5082EXC"  outnum="20" retcode="errCode" retmsg="errMsg" routerKey="region" routerValue="<%=regionCode%>">
    	<wtc:param value="5082" />
    	<wtc:param value="<%=workNo%>" />
    	<wtc:param value="3" />    	
    	<wtc:param value="<%=phoneNo%>" />     			
    	</wtc:service>
    <wtc:array id="result" scope="end"/>
<%	

 	if (result.length==0)
	{
%>
<script language="javascript">
	rdShowMessageDialog("û���ҵ��κ�����");
	history.go(-1);
</script>
<%	}else{
	
%>

<HEAD><TITLE>�û�����������Ϣ</TITLE>
</HEAD>
<body>



<FORM method=post name="f1500_dCustInnet">

<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">�û�����������Ϣ</div>
</div>
            <TABLE cellSpacing="0" >
                <TR >
                  <TD class="blue">�ֻ����� <input class="InputGrey" value="<%=phoneNo%>" maxlength="25" size=25 readonly /></TD>
                  <TD></TD>
                  <TD></TD>
                </TR>                
             <TR bgcolor="EEEEEE" >
                  <TD class="blue">���ű��<input class="InputGrey" value="<%=result[0][0]%>" maxlength="25" size=25 readonly></TD>
                  <TD class="blue">��������<input class="InputGrey" value="<%=result[0][1]%>" maxlength="25" size=25 readonly></TD>
                  <TD class="blue">VPMN���<input class="InputGrey" value="<%=result[0][2]%>" maxlength="25" size=25 readonly></TD>
                </TR>
                <TR>
                  <TD class="blue">�ͻ�����<input class="InputGrey" value="<%=result[0][3]%>" maxlength="25" size=25 readonly></TD>
                  <!--TD>�������ƣ�<input class="button" value="<%=result[0][4]%>" maxlength="25" size=25 readonly></TD-->
                  <TD colspan="3" class="blue">��ϵ�绰��<input class="InputGrey" value="<%=result[0][4]%>" maxlength="25" size=25 readonly ></TD>
                </TR>
                <TR>
                  <Th>��Ʒ���� </Th>
                  <Th>��Ʒ���� </Th>
                  <Th>ҵ���ϵȼ� </Th>
                </TR>
                  <%
					for(int y=0;y<result.length;y++){
				  %>
				  
				  <tr>
				   	<TD><input class="InputGrey" value="<%=result[y][5]%>" maxlength="25" size=25 readonly></TD>
                  	<TD><input class="InputGrey" value="<%=result[y][6]%>" maxlength="45" size=45 readonly></TD>
	                <TD><input class="InputGrey" value="<%=result[y][7]%>" maxlength="45" size=45 readonly></TD>
			 	  </tr>
				  <%
				    }
				  %>
            </table>
          </td>
        </tr>
      </table>
      <table cellSpacing="0">
          <tr> 
      	    <td id="footer">
    	      &nbsp; <input class="b_foot" name=back onClick="history.go(-1)" type=button value=����>
    	      &nbsp; <input class="b_foot" name=back onClick="window.close()" type=button value=�ر�>
    	      &nbsp; 
    	    </td>
          </tr>
      </table>

</FORM>


<%}%>
<%@ include file="/npage/include/footer.jsp" %>
</BODY>
</HTML>