<%
/********************
 version v2.0
������: si-tech
*
*
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
 
<%
	String opCode = "";
  	String opName = "��ϸ�ʷ���Ϣ��ѯ";
	
	String region_code = (String)session.getAttribute("regCode");
	String idNo = request.getParameter("idNo");
	String cust_name=request.getParameter("custName");
	
	String inParas[] = new String[2];
  	inParas[0] = idNo;
	inParas[1] = "X";
	
 	//CallRemoteResultValue callRemoteResultValue = viewBean.callService("0",null,"sPubCustBillDet","6",lens,inParas);
%>
	<wtc:service name="sPubCustBillDet" routerKey="region" routerValue="<%=region_code%>" retcode="retCode1" retmsg="retMsg1" outnum="7" >
	<wtc:param value="<%=inParas[0]%>"/>
	<wtc:param value="<%=inParas[1]%>"/>
	</wtc:service>
	<wtc:array id="result" scope="end"/>
<% 

	if (result==null||result.length==0) {
%>
	  <script language="JavaScript">
	      rdShowMessageDialog("��ѯ���Ϊ��,��ϸ�ʷ���Ϣ������! ");
	      history.go(-1);
	  </script>
<% 
	}else{ 
%>
<HTML>
<HEAD>
<TITLE>��ϸ�ʷ���Ϣ��ѯ</TITLE>
<script language="javascript">
	<!--
		/**��Ϊ1556 ��ϸ�ʵ���ѯ ���������ҳ��,���һֱ��history.go(-1),1556�оͻᱨ�����������ҳ�Ѿ�ʧЧ**/
		function doBack(){
			var opFlag = '<%=WtcUtil.repNull(request.getParameter("opFlag"))%>';
			if(opFlag=="1556"){
				history.go(-2);	
			}else{
				history.go(-1);	
			}
		}
	//-->
</script>
</HEAD>
<BODY leftmargin="0" topmargin="0">
<FORM method=post name=form>
<div id="Main">
   <DIV id="Operation_Table"> 
		<div class="title">
			<div id="title_zi">��ϸ�ʷ���Ϣ(�漰�ʷѱ���ͻ��Ŀ�ѡ�ײ���ͨ�����ʷ������в�ѯ)</div>
		</div>
    <div id=article>      
	     <table cellspacing="0">
          <tr align="center"> 
            <th>��������</th>
            <th>�ʷѴ���</th>
						<th>�ʷ�����</th>
            <th>��ʼʱ��</th>
						<th>����ʱ��</th>
            <th>������ˮ</th>

      <% 
		      String tbClass="";
					for(int i=0;i<result.length;i++){
						if(i%2==0){
							tbClass="Grey";
						}else{
							tbClass="";
						}
		  %>
          <tr align="center"> 
            <td class="<%=tbClass%>"><font class="orange">(<%=i%>)</font><%=result[i][5]%></td>
						<td class="<%=tbClass%>"><%=result[i][0]%></td>
						<td class="<%=tbClass%>"><a href="showCustBillDet.jsp?idNo=<%=idNo%>&detNo=<%=i%>"><font color="#3366CC"><%=result[i][1]%></font></a></td>
						<td class="<%=tbClass%>"><%=result[i][2]%></td>
						<td class="<%=tbClass%>"><%=result[i][3]%></td>
						<td class="<%=tbClass%>"><%=result[i][4]%></td>
					 </tr>
			<% 
					} 
			%>
					  
        </table>
    </div>
    
     
    <%@ include file="/npage/include/footer_pop.jsp" %>    
</FORM>
</BODY>
</HTML>
<% } %>

