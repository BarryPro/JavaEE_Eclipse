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
  String opName = "�ۺ���Ϣ��ѯ֮�û�������Ϣ";
  String regionCode = ((String)session.getAttribute("orgCode")).substring(0,2);
	String id_no  = request.getParameter("idNo");
	String phone_no  = request.getParameter("phoneNo");
	String begin_time  = request.getParameter("beginTime");
	String end_time  = request.getParameter("endTime");
	String work_no=request.getParameter("workNo");
	String work_name=request.getParameter("workName");
%>
	<wtc:service name="s1500_wPayQry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="20" >
	<wtc:param value="<%=phone_no%>"/>
	<wtc:param value="<%=id_no%>"/>
	<wtc:param value="<%=begin_time%>"/>
	<wtc:param value="<%=end_time%>"/>
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
		history.go(-1);
		rdShowMessageDialog("����δ�ܳɹ�,�������:<%=retCode1%><br>������Ϣ:<%=retMsg1%>!");
	</script>
<%
		return;
	}else if(result==null||result.length==0){
%>
	<script language="javascript">
		history.go(-1);
		rdShowMessageDialog("��ѯ���Ϊ��,�û�������Ϣ������!");
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
			rdShowMessageDialog("<%=return_message%><br>�������:<%=return_code%>.");
			history.go(-1);
		</script>
<%	
	}
%>

<!--xl add for ������Ϣ��ѯ-->
<wtc:service name="s1500_PointQry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2" outnum="20" >
	<wtc:param value="<%=phone_no%>"/>
	<wtc:param value="<%=id_no%>"/>
	<wtc:param value="<%=begin_time%>"/>
	<wtc:param value="<%=end_time%>"/>
	</wtc:service>
	<wtc:array id="result2" scope="end"/>
<%	
	int iretCode2=999999; 
	
	if(retCode2!=null&&!"".equals(retCode2)){
		iretCode2=Integer.parseInt(retCode2);
	}
	if(iretCode2!=0){
%>
	<script language="javascript">
		history.go(-1);
		rdShowMessageDialog("����δ�ܳɹ�,�������:<%=retCode2%><br>������Ϣ:<%=retMsg2%>!");
	</script>
<%
		return;
	}
	String return_code2 =result2[0][0];
	String return_message2 =result2[0][1];

	if ((!return_code2.equals("000000"))&&(!return_code2.equals("150010")))
	//if (!return_code2.equals("000000"))
	{
%>
		<script language="JavaScript">
			rdShowMessageDialog("<%=return_message2%><br>�������:<%=return_code2%>.");
			history.go(-1);
		</script>
<%	
	}
%>
<!--xl end ������Ϣ��ѯ-->

<HTML><HEAD><TITLE>�û�������Ϣ</TITLE>
</HEAD>
<body>

<FORM method=post name="f1500_wPayQry">
<%@ include file="/npage/include/header.jsp" %>     	
		<div class="title">
			<div id="title_zi">�û�������Ϣ</div>
		</div>
    <table cellspacing="0">
      <TBODY>
        <TR>
          <TD class="blue">�������</td>
          <td><%=phone_no%></TD>
          <TD class="blue">��ʼʱ��</td>
          <td><%=result[0][2]%></TD>
          <TD class="blue">����ʱ��</td>
          <td><%=result[0][3]%></TD>
        </TR>
      </TBODY>
    </table>
  	</div>
		<div id="Operation_Table"> 
		<div class="title">
			<div id="title_zi">�û�������ϸ</div>
		</div>
    <table cellspacing="0">
      <tbody>
        <tr align="center">
          <th>����ʱ��</th>
          <th>���ѹ���</th>
          <th>������ˮ</th>
          <th>����ģ��</th>
          <th>���ѷ�ʽ</th>
          <th>���ѽ��</th>
          <th>����Ԥ��</th>
          <th>��ʱԤ��</th>
          <th>����Ƿ��</th>
          <th>���ɽ�</th>
          <th>����������</th>
          <th>���ճ���</th>
          <th>�˿��־</th>
          <th>ת��Ԥ��</th>
		  <th>����</th>
		  <th>Ӫҵ������</th>
        </tr>
<%	      
			String tbClass="";
			for(int y=0;y<result.length;y++)
			{
				if(y%2==0)
				{
					tbClass="Grey";
				}else
				{
					tbClass="";
				}
%>
	        <tr align="center">
<%    		
				for(int j=4;j<result[0].length;j++)
				{
%>
		  			<td class="<%=tbClass%>"><%= result[y][j]%>&nbsp;</td>
<%			
				}
			
%>
	        </tr>
<%	        }
			// xl add
			//Ϊ���޳���Ϊ0����ʾ
			 
			if(result2.length>0 &&(!return_code2.equals("150010")) )
			{
				for(int y2=0;y2<result2.length;y2++)
				{
					if(y2%2==0)
					{
						tbClass="Grey";
					}else
					{
						tbClass="";
					}
	%>
				<tr align="center">
	<%    		
					for(int j=4;j<result2[0].length;j++)
					{
	%>
						<td class="<%=tbClass%>"><%= result2[y2][j]%>&nbsp;</td>
	<%			
					}
				
	%>
				</tr>
	<%	        }
			}
			
			// xl end
%>
         </TBODY>
	    </TABLE>
          
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
