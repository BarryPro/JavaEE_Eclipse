<%
/********************
 version v2.0
������: si-tech
update:liutong@2008-8-13
********************/
%>
 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	//������� �û�ID���ֻ����롢�ʻ�ID���ʻ����ơ���ʼʱ�䡢����ʱ�䡢�������š�����Ա����ɫ������
	
	String regionCode = ((String)session.getAttribute("orgCode")).substring(0,2);
	 String opCode = "1500";
	 String opName = "�ۺ���Ϣ��ѯ֮�ʻ�������Ϣ";
	

   String id_no=request.getParameter("idNo");
	String phone_no=request.getParameter("phoneNo");
	String contract_no=request.getParameter("contractNo");
	String bank_cust=request.getParameter("bankCust");
	String begin_time=request.getParameter("beginTime");
	String end_time=request.getParameter("endTime");
	String work_no=request.getParameter("workNo");
	String work_name=request.getParameter("workName");
	
	/**ArrayList arlist = new ArrayList();
	try{
		s1550view viewBean = new s1550view();//ʵ����viewBean
		arlist = viewBean.s1500_wConPayQ(phone_no,id_no,contract_no,begin_time,end_time); 
	}
	catch(Exception e)
	{
		//System.out.println("����EJB����ʧ�ܣ�");
	}
	String [][] result = new String[][]{};
	result = (String[][])arlist.get(0);
	String return_code =result[0][0];
	String return_message =result[0][1];
	**/
%>
    <wtc:service name="s1500_wConPayQ" routerKey="region" routerValue="<%=regionCode%>"    retcode="return_code" retmsg="return_message" outnum="18">
	 	 <wtc:param value="<%=phone_no%>"/>
        <wtc:param value="<%=id_no%>"/>
        <wtc:param value="<%=contract_no%>"/>
        <wtc:param value="<%=begin_time%>"/>
        <wtc:param value="<%=end_time%>"/>
	</wtc:service>
	<wtc:array id="result" scope="end" />
	
<%
	if(Integer.parseInt(return_code)==0){
		if(result!=null){
			if(result.length>0){
				return_code =result[0][0];
				return_message =result[0][1];				
			}
		}
	}
	
	if (!return_code.equals("0"))
	{
%>
		<script language="JavaScript">
			rdShowMessageDialog("<%=return_message%><br>�������:<%=return_code%>");
			history.go(-1);
		</script>
<%	
	}
%>

<HTML><HEAD><TITLE>�ʻ�������Ϣ</TITLE>
</HEAD>
<body>


<FORM method=post name="f1500_wConPayQry">
	<%@ include file="/npage/include/header.jsp" %>     	
			<div class="title">
				<div id="title_zi">�ʻ�������Ϣ</div>
			</div>
    
            <TABLE cellSpacing="0">
              <TBODY>
                <TR>
                  <td class="blue">�������</td>
                  <td><%=phone_no%></td>
                  <td class="blue">�� �� �� </td>
                  <td><%=contract_no%></td>
                </TR>
                <TR>
                  <td class="blue">��ʼʱ��</td>
                  <td><%= result[0][2]%></td>
                  <td class="blue">����ʱ��</td>
                  <td><%= result[0][3]%></td>
                </TR>
              </TBODY>
	    </TABLE>
	  </div>
	  <div id="Operation_Table"> 
       <div class="title">
				<div id="title_zi">������Ϣ��ϸ</div>
			</div>
      <table  cellspacing="0">
              <TBODY>
                <TR align="center">
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
                </TR>
<%	 	String tbClass="";
			for(int y=0;y<result.length;y++){
				if(y%2==0){
					tbClass="Grey";
				}else{
					tbClass="";
				}
%>
	        <tr align="center">
<%    		for(int j=4;j<result[0].length;j++)
		{
%>
		  <td class="<%=tbClass%>"> <%= result[y][j]%> </td>
<%		}
%>
	        </tr>
<%	      }
%>
              </TBODY>
	    </TABLE>
         
      <table  cellspacing="0">
        <tbody> 
          <tr align="center"> 
      	    <td id="footer">
    	      &nbsp; <input class="b_foot" name=back onClick="history.go(-1)" type=button value=����>
    	      &nbsp; <input class="b_foot" name=back onClick="parent.removeTab('<%=opCode%>')" type=button value=�ر�>
    	      &nbsp; 
    	    </td>
          </tr>
        </tbody> 
      </table>
         <%@ include file="/npage/include/footer.jsp" %>
     </FORM>
   </BODY>
 </HTML>
