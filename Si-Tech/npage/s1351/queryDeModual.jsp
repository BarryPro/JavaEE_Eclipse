<%
/********************
 version v2.0
������: si-tech
����:
create zhangss@2010-8-13
********************/
%>
 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	//������� �û�ID���ֻ����롢�������š�����Ա����ɫ������
	 	response.setHeader("Pragma","No-Cache");
		response.setHeader("Cache-Control","No-Cache");
		response.setDateHeader("Expires", 0);
	 
	 String opCode = "";
	 String opName = "�����˻�ͳһ�˵�Ĭ��ģ������";
	
	String contract_no  = request.getParameter("contractNo");
	String bank_cust  = request.getParameter("bankCust");
	String work_no=request.getParameter("workNo");
	String work_name=request.getParameter("workName");
	String regionCode = ((String)session.getAttribute("orgCode")).substring(0,2);
 

   
	String sql_str="select b.region_name,b.region_code,a.show_mode,a.show_name from sDefaultModual a,sregioncode b where a.region_code=b.region_code";
	
	/**ArrayList arlist = new ArrayList();
	try{
	 	S1100View callView = new S1100View();
		arlist = callView.view_spubqry32("5",sql_str);
	}
	catch(Exception e)
	{
		//System.out.println("����EJB����ʧ�ܣ�");
	}
	String [][] result = new String[][]{{"0","1","2","3","4"}};
	int result_row = Integer.parseInt((String)arlist.get(1));
	**/
%>

<wtc:pubselect name="TlsPubSelBoss" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="4">
	<wtc:sql><%=sql_str%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="result" scope="end" />
		
<%	
	if(!retCode1.equals("000000")){
%>
		<script language="javascript">
			rdShowMessageDialog("����δ�ܳɹ�,�������:<%=retCode1%><br>������Ϣ:<%=retMsg1%>");
			history.go(-1);
		</script>
<%
		return;
	}


	if (result==null||result.length==0)
	{
%>
<script language="JavaScript">
	rdShowMessageDialog("û�з�������������!");
	history.go(-1);
</script>
<%	}
%>
<HTML><HEAD><TITLE>�����˻�ͳһ�˵�Ĭ��ģ������</TITLE>
</HEAD>
<body>
<FORM method=post name="f1500_dConMsgHis01">
      	<%@ include file="/npage/include/header.jsp" %>     	
			<div class="title">
				<div id="title_zi">�����˻�ͳһ�˵�Ĭ��ģ������</div>
			</div>
            <TABLE  cellSpacing="0">
              <TBODY>
                <tr align="center">
                  <th>���д���</th>
                  <th>��������</th>
                  <th>ģ�����</th>
                  <th>ģ������</th>
                  <th>����</th>
                </TR>
<%	      
			String tbClass="";
			for(int y=0;y<result.length;y++){
				if(y%2==0){
					tbClass="Grey";
				}
				else{
					tbClass="";
				}
%>
	 				<tr align="center">
<%    	        
				for(int j=0;j<result[y].length;j++)
	        {
%>
	          <td class="<%=tbClass%>"><%= result[y][j]%></td>
<%	        }
%>
	          <td class="<%=tbClass%>"> 
	         	<a href="makeDeModual.jsp?show_mode=<%=result[y][2]%>&action=select&modetype=0&flag=1">�鿴 </a>
	         	<a href="delDeModual.jsp?show_mode=<%=result[y][2]%>">ɾ�� </a>
	         	</td>
	       
	        </tr>
<%	      }
%>
              </TBODY>
	    </TABLE>
       
      <table cellspacing="0">
        <tbody> 
          <tr> 
      	    <td id=footer>
    	      &nbsp; <input class="b_foot" name=back onClick="history.go(-1)" type=button value=����>
    	      &nbsp; <input class="b_foot" name=back onClick="javascript:window.location.replace('makeDeModual.jsp');" type=button value=����>
    	      &nbsp; <input class="b_foot" name=back onClick="history.go(-1)" type=button value=�ر�>
    	      &nbsp; 
    	    </td>
          </tr>
        </tbody> 
      </table>
            <%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY></HTML>
