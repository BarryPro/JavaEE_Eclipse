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
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
 
<%
	String opCode = "1500";
  	String opName = "�ۺ���Ϣ��ѯ֮��ϸ�ʷ���Ϣ��ѯ";
	
	String region_code = ((String)session.getAttribute("orgCode")).substring(0,2);
	String idNo = request.getParameter("idNo");
	String detNo = request.getParameter("detNo");
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
		inParas[8] = detNo;
	//CallRemoteResultValue callRemoteResultValue = viewBean.callService("0",null,"sPubCustBillDet","13",lens,inParas);
%>
	<wtc:service name="sPubCustBillDet" routerKey="region" routerValue="<%=region_code%>" retcode="retCode1" retmsg="retMsg1" outnum="14" >
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
	      rdShowMessageDialog("��ѯ���Ϊ��,��ϸ������Ϣ������! ");
	      history.go(-1);
	  </script>
<%
	return; 
	}
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<TITLE>��ϸ������Ϣ��ѯ</TITLE>
</HEAD>
<BODY leftmargin="0" topmargin="0">
<FORM action="s1321_3print.jsp" method=post name=form>
  <%@ include file="/npage/include/header.jsp" %>     	
		<div class="title">
			<div id="title_zi">��ϸ�ʷ���Ϣ</div>
		</div>
		 
					
<table width="100%" align="center" border=0 cellspacing="0">
       <tr>
       <table  width="100%"  border=1>
              <tr align="center"> 
        		
			</tr>
       </table>
       </tr>
   <tr>
   <td align="center" width="100%">
    <div  style="width:100%; height:100%; overflow:scroll;">
    <table width="100%" border=1>
    	 <tr align="center"> 
        		<th nowrap>��������</th>
				<th nowrap>�ʷѴ���</th>
				<th nowrap>�ʷ�����</th>
				<th nowrap>�����</th>
				<th nowrap>�Ƿ��̯</th>
				<th nowrap>�Żݴ���</th>
				<th nowrap>�Ż�����</th>	
				<th nowrap>��������</th>
				<th nowrap>С������</th>
				<th nowrap>�Ż�����</th>
				<th nowrap>��ʼʱ��</th>
        		<th nowrap>����ʱ��</th>
				<th nowrap>������ˮ</th>
			</tr>
			
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
              			  <td nowrap class="<%=tbClass%>"><%=result[i][8]%></td>
						  <td nowrap class="<%=tbClass%>"><%=result[i][0]%></td>
						  <td nowrap class="<%=tbClass%>"><%=result[i][1]%></td>
						  <td nowrap class="<%=tbClass%>"><%=result[i][12]%></td>
						  <td nowrap class="<%=tbClass%>"><%=result[i][13]%></td>
						  <td nowrap class="<%=tbClass%>"><%=result[i][2]%></td>
						  <td nowrap class="<%=tbClass%>"><%=result[i][3]%></td>
						  <td nowrap class="<%=tbClass%>"><%=result[i][10]%></td>
						  <td nowrap class="<%=tbClass%>"><%=result[i][11]%></td>
						  <td nowrap class="<%=tbClass%>"><%=result[i][4]%></td>
						  <td nowrap class="<%=tbClass%>"><%=result[i][5]%></td>
						  <td nowrap class="<%=tbClass%>"><%=result[i][6]%></td>
						  <td nowrap class="<%=tbClass%>"><%=result[i][7]%></td>
					  </tr>
					  <% } %>
   </table>
    </div>
   </td>
   </tr>
 </table>


			<table cellspacing="0">
				<tr> 
               	   <td class="blue">�ʷ�����</td>
	               <td> 
	                  <textarea name="" rows="3" readonly cols="68"><%=result[0][9]%></textarea>
				   </td>
	            </tr>
       		</table>
      	<table cellspacing="0">
	    	<tr>
	    		<td id="footer">
		        <input class="b_foot" name=reset type=reset value=���� onclick="JavaScript:history.go(-1)">&nbsp;
		        <input class="b_foot" name=sure type=button value=�ر� onclick="parent.removeTab('<%=opCode%>')">
	        </td>
	      </tr>
	    </table>
    <%@ include file="/npage/include/footer.jsp" %>    
</FORM>
</BODY>
</HTML>


