<%
/********************
 version v2.0
������: si-tech
*
*update:zhanghonga@2008-08-12 ҳ�����,�޸���ʽ
*
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
 
<%
	String opCode = "1500";
  	String opName = "�ۺ���Ϣ��ѯ֮��ϸ�ʷ���Ϣ��ѯ";
	
	String region_code = ((String)session.getAttribute("orgCode")).substring(0,2);
	String idNo = request.getParameter("idNo");
	String cust_name=request.getParameter("custName");
	String recodeIDd=request.getParameter("recodeIDd");
	String iLoginNo=request.getParameter("workNo");
	String loginAccept=request.getParameter("loginAccept");
	//add by diling for ��ȫ�ӹ��޸ķ����б�
	String password = (String) session.getAttribute("password");
	
	String inParas[] = new String[9];
		inParas[0] = loginAccept;
		inParas[1] = "01";
		inParas[2] = opCode;
		inParas[3] = iLoginNo;
		inParas[4] = password;
		inParas[5] = "";
		inParas[6] = "";
		inParas[7] = idNo;
		inParas[8] = "X";
		
	
 	//CallRemoteResultValue callRemoteResultValue = viewBean.callService("0",null,"sPubCustBillDet","6",lens,inParas);
%>
	<wtc:service name="sPubCustBillDet" routerKey="region" routerValue="<%=region_code%>" retcode="retCode1" retmsg="retMsg1" outnum="7" >
	<wtc:param value="<%=inParas[0]%>"/>
	<wtc:param value="<%=inParas[1]%>"/>
	<wtc:param value="<%=inParas[2]%>"/>
	<wtc:param value="<%=inParas[3]%>"/>
	<wtc:param value="<%=inParas[4]%>"/>
	<wtc:param value="<%=inParas[5]%>"/>
	<wtc:param value="<%=inParas[6]%>"/>
	<wtc:param value="<%=inParas[7]%>"/>
	<wtc:param value="<%=inParas[8]%>"/>
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
	$(document).ready(function(){
		try{
			parent.parent.oprInfoRecode('','','','',"<%=recodeIDd%>");
		}catch(e){
		}
	});
</script>
</HEAD>
<BODY leftmargin="0" topmargin="0">
<FORM method=post name=form>
	<%@ include file="/npage/include/header.jsp" %>     	
		<div class="title">
			<div id="title_zi">��ϸ�ʷ���Ϣ</div>
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
						<td class="<%=tbClass%>"><a href="f1500_sPubCustBillDet2.jsp?idNo=<%=idNo%>&detNo=<%=i%>&workNo=<%=iLoginNo%>&loginAccept=<%=loginAccept%>"><font color="#3366CC"><%=result[i][1]%></font></a></td>
						<td class="<%=tbClass%>"><%=result[i][2]%></td>
						<td class="<%=tbClass%>"><%=result[i][3]%></td>
						<td class="<%=tbClass%>"><%=result[i][4]%></td>
					 </tr>
			<% 
					} 
			%>
					  
        </table>
    </div>
    
    <table cellspacing="0">
    	<tr>
    		<td id="footer">
	        <input class="b_foot" name=reset type=reset value=���� onclick="doBack()">&nbsp;
	        <input class="b_foot" name=sure type=button value=�ر� onclick="parent.removeTab('<%=opCode%>')">
        </td>
      </tr>
    </table>
    <%@ include file="/npage/include/footer.jsp" %>    
</FORM>
</BODY>
</HTML>
<% } %>

