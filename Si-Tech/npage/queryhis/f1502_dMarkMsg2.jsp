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
	
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	String opCode = "1502";
  String opName = "�ۺ���Ϣ��ʷ��ѯ֮�û��������ɼ�¼";
	
	String regionCode = ((String)session.getAttribute("orgCode")).substring(0,2);
	String phoneNo  = request.getParameter("phoneNo");
	String orgCode  = "0101001";
	String beginMonth = request.getParameter("beginMonth");
	String endMonth = request.getParameter("endMonth");
			//arlist = wrapper.wrapper_s1500MarkQry(phoneNo,orgCode,beginMonth,endMonth); 
	%>
	<wtc:service name="sMarkDetQry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="6" >
		<wtc:param value="0"/>
		<wtc:param value="01"/>
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value=""/>
		<wtc:param value=""/>
		<wtc:param value="<%=phoneNo%>"/>
		<wtc:param value=""/>
		<wtc:param value="<%=orgCode%>"/>
		<wtc:param value="<%=beginMonth%>"/>
		<wtc:param value="<%=endMonth%>"/>
		</wtc:service>
	<wtc:array id="result" scope="end"/>
<%	
	int iretCode=999999; 
	
	if(retCode1!=null&&!"".equals(retCode1)){
		iretCode=Integer.parseInt(retCode1);
	}
	if(iretCode!=0){
%>
	<script language="javascript">
		rdShowMessageDialog("����δ�ܳɹ�,�������:<%=retCode1%><br>������Ϣ:<%=retMsg1%>!");
		history.go(-1);
	</script>
<%
		return;
	}else if(result==null||result.length==0){
%>
	<script language="javascript">
		rdShowMessageDialog("��ѯ���Ϊ��,�������ɼ�¼������!");
		history.go(-1);
	</script>
<%
		return;
	}
%>


<HTML><HEAD><TITLE>�������ɼ�¼</TITLE>
</HEAD>
<body>
<FORM method=post name="f1500_dMarkMsg">
	<%@ include file="/npage/include/header.jsp" %> 
		<div class="title">
			<div id="title_zi">�������ɼ�¼</div>
		</div>
    <table cellspacing="0">
    	<tbody>
        <tr align="center"> 
	        <th>�ֻ�����</th>
	        <th>��  ��</th>
	        <th>���ִ���</th>
	        <th>��������</th>
	        <th>���ɻ���</th>
	      </tr>
		<%
			String tbClass="";
			for(int y=0;y<result.length;y++){
				if(y%2==0){
					tbClass="Grey";
				}else{
					tbClass="";
				}
		%>
						<tr align="center">
		<%    
						for(int j=0;j<result[y].length-1;j++){
		%>
						<td class="<%=tbClass%>"><%=result[y][j]%></td>
		<%
						}
		%>
		</tr>
		<%
		    }
		%>
	</table>

      
      <table cellspacing="0">
        <tbody> 
          <tr> 
      	    <td id="footer">
    	      &nbsp; <input class="b_foot" name=back onClick="history.go(-1)" type=button value=����>
    	      &nbsp; <input class="b_foot" name=back onClick="parent.removeTab(<%=opCode%>)" type=button value=�ر�>
    	    </td>
          </tr>
        </tbody> 
      </table>
		<%@ include file="/npage/include/footer.jsp" %>
		</FORM>
	</BODY>
</HTML>
