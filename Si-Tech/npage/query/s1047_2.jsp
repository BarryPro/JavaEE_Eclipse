<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%request.setCharacterEncoding("GBK");%>
<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>

<%
    String opCode = "1047";
    String opName = "ͳ����ʷ��ѯ���";
	  String phoneNO=request.getParameter("phoneNo");
	  String contractno=request.getParameter("contractno");
	  String yearmonth=request.getParameter("yearmonth");
	  String ret_val[][];
	  int iPageNumber = request.getParameter("pageNumber")==null?1:Integer.parseInt(request.getParameter("pageNumber"));
		int iPageSize = 10;
		int iStartPos = (iPageNumber-1)*iPageSize;
		int iEndPos = iPageNumber*iPageSize;
		int recordcount=0;
	
		
 
 
 

System.out.println("----------------"+phoneNO+"--------------"+contractno+"-----------"+yearmonth);
	  if(phoneNO!=null&&!phoneNO.equals(""))
	  {
String sql1="select * from (select to_char(aa.bcontract_name),aa.contract_name,aa.phone_no,aa.op_time as a,b.pay_name,to_char(aa.payed_money),aa.login_no,to_char(aa.op_time,'YYYY-MM-DD HH24:MI:SS'),c.function_name,rownum id from wTDUnifyPay aa, spaytype b,sfunccode c where aa.bcontract_no="+contractno+"  and aa.pay_time="+yearmonth+" and aa.op_code=Trim(c.function_code) and trim(aa.pay_type) = b.pay_type ) where id>"+iStartPos+" and id<"+(iEndPos+1);
 System.out.println("---sql1="+sql1);
%>
   
	<wtc:pubselect name="TlsPubSelBoss"   retcode="retCode1" retmsg="retMsg1" outnum="9">
	<wtc:sql><%=sql1%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="ret_val1" scope="end" />
  

<%
 ret_val=ret_val1;
   
%>
  <wtc:pubselect name="TlsPubSelBoss"   retcode="retCode1" retmsg="retMsg1" outnum="1">
	<wtc:sql>select to_char(count(*)) from wTDUnifyPay where bcontract_no='?' and phone_no='?' and pay_time='?'</wtc:sql>
	<wtc:param value="<%=contractno%>"/>
	<wtc:param value="<%=phoneNO%>"/>
	<wtc:param value="<%=yearmonth%>"/>
	</wtc:pubselect>
	<wtc:array id="ret_val2" scope="end" />
    <%
    if(ret_val2.length>0)
    recordcount=Integer.parseInt(ret_val2[0][0].trim());
    System.out.println("---recordcount="+recordcount);
}
else //�ֻ�����δ����
	{
	%>
	<wtc:pubselect name="TlsPubSelBoss"   retcode="retCode1" retmsg="retMsg1" outnum="1">
	<wtc:sql>select to_char(count(*))  from wTDUnifyPay where bcontract_no='?'  and pay_time='?'</wtc:sql>
	<wtc:param value="<%=contractno%>"/>
  <wtc:param value="<%=yearmonth%>"/>
	</wtc:pubselect>
	<wtc:array id="ret_val2" scope="end" />
	<%
	if(ret_val2.length>0)
    recordcount=Integer.parseInt(ret_val2[0][0].trim());
     System.out.println("---recordcount="+recordcount);
		 String sql2="select * from (select to_char(aa.bcontract_name),aa.contract_name,aa.phone_no,aa.op_time as a,b.pay_name,to_char(aa.payed_money),aa.login_no,to_char(aa.op_time,'YYYY-MM-DD HH24:MI:SS'),c.function_name, rownum id from wTDUnifyPay aa,spaytype b,sfunccode c where aa.bcontract_no="+contractno+"  and aa.pay_time="+yearmonth+" and aa.op_code=Trim(c.function_code) and trim(aa.pay_type) = b.pay_type ) where id>"+iStartPos+" and id<"+(iEndPos+1);
		 System.out.println("---sql2="+sql2);
		%>
	<wtc:pubselect name="TlsPubSelBoss"   retcode="retCode1" retmsg="retMsg1" outnum="9">
	<wtc:sql><%=sql2%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="ret_val1" scope="end" />
	<%
	
	 ret_val=ret_val1;
	}
  System.out.println("----------------ret_val.length="+ret_val.length);
	if (ret_val.length==0)
	{
%>
    <script language="JavaScript">
    	rdShowMessageDialog("���ݿ���û�и���Ϣ��",0);
    	history.go(-1);
    </script>
<% 
  } 
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD><TITLE>ͳ����ʷ��ѯ���</TITLE>
</HEAD>
<body>


<FORM method=post name="frm1508_2">
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">��ѯ���</div>
</div>

      <table cellspacing="0">
                <tr> 
                  <th>��������</th>
                  <th>�ʻ�����</th>
                  <th>�ֻ�����</th>
                  <th>ͳ����ϵ����ʱ��</th>
                  <th>������ʽ</th>
                  <th>�������</th>
                  <th>����</th>
                  <th>����ʱ��</th>
                  <th>�������</th>
                </tr>
<%	      for(int y=0;y<ret_val.length;y++)
	      {
%>
	        <tr>
<%    	        for(int j=0;j<ret_val[0].length;j++)
	        {
%>
	              <td><%= ret_val[y][j]%></td>
<%	        }
%>
	        </tr>
<%	      }
%>

         
          <tr id="footer"> 
      	    <td colspan="9">
    	      <input class="b_foot" name=back onClick="history.go(-1)" type=button value=����>
    	      <input class="b_foot" name=back onClick="window.close();" type=button value=�ر�>
    	    </td>
          </tr>
          
      </table>
      <tr id="footer"> 
      	       
    	      ҳ����
    	     
    	    
    	        <%
      	  int end=recordcount%iPageSize==0?recordcount/iPageSize:(recordcount/iPageSize)+1;
      	  System.out.println("------end="+end);
      	  
      	  for(int i=1;i<=end;i++)
      	  {
    	    %>
    	     <a href="s1047_2.jsp?pageNumber=<%=i%>&phoneNo=<%=phoneNO%>&contractno=<%=contractno%>&yearmonth=<%=yearmonth%>"><%=i%></a>
          <%
          }
          %>
          </tr>
    
      	
    	    
        

<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY></HTML>

