 <%
	/********************
	 version v2.0
	������: si-tech
	update:anln@2009-01-22 ҳ�����,�޸���ʽ
	********************/
%> 

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.text.*" %>

 <%
 	String opCode = "2123";	
	String opName = "���ż�ͥͳһ�˵�����";	//header.jsp��Ҫ�Ĳ���   

	
	String contract_no = request.getParameter("contract_no");
	String show_mode = request.getParameter("show_mode");
  
	System.out.println("^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"+contract_no+","+show_mode);


    //String strsql="select c.cust_name,b.phone_no,to_char(b.id_no) from dconusermsg a,dcustmsg b,dcustdoc c where b.cust_id=c.cust_id and a.id_no=b.id_no and a.contract_no="+contract_no;
	//xl add for zlc ��ȫ�ӹ� �ڶ���
	String inParas[] = new String[24];
	String workNo = (String)session.getAttribute("workNo");
	String workName = (String)session.getAttribute("workName");
	String org_code = (String)session.getAttribute("orgCode");
	String region_code = org_code.substring(0,2);
	String nopass = (String)session.getAttribute("password");
	String s_note="";
	s_note="�����ʺ�"+contract_no+"���в�ѯ";
%>			

<wtc:service name="sGrpCustQry"  retcode="sConMoreQryCode" retmsg="sConMoreQryMsg" outnum="3">
    <wtc:param value=""/> 
	<wtc:param value="01"/>
	<wtc:param value="d003"/>
	<wtc:param value="<%=workNo%>"/>
	<wtc:param value="<%=nopass%>"/>
	<wtc:param value=""/>
	<wtc:param value=""/> 
	<wtc:param value=""/>
	<wtc:param value=""/>
	<wtc:param value=""/>
	<wtc:param value=""/>
	<wtc:param value="d003"/>
	<wtc:param value=""/> 
	<wtc:param value=""/>
	<wtc:param value=""/>
	<wtc:param value=""/>
	<wtc:param value=""/>
	<wtc:param value="2"/>
	<wtc:param value=""/> 
	<wtc:param value="1"/>
	<wtc:param value=""/>
	<wtc:param value=""/>
	<wtc:param value="<%=contract_no%>"/>
	<wtc:param value=""/>
	<wtc:param value="<%=s_note%>"/>
</wtc:service>
<wtc:array id="result_t" scope="end"/>
 

<% if (result_t.length==0) {%>
	  <script language="JavaScript">
	    rdShowMessageDialog("���ʻ���û�г�Ա! ");
	    window.location="f2765_2.jsp";
	  </script>

<% } else { 
%>
<HTML>
	<HEAD>
		<TITLE>���ż�ͥͳһ�˵�����</TITLE>
		<SCRIPT LANGUAGE="JavaScript">
	
		function allChoose()
		{   //��ѡ��ȫ��ѡ��
		    var k = <%=result_t.length%>;
		    for(i=0;i<k;i++)
		    {
		        if (k==1)
		        {
		        	if(document.form.unchange.type=="checkbox")
		        	{
		        		if(document.form.unchange.disabled == false)
		               document.form.unchange.checked = true;
		        	}
		        }
		        else if(document.form.unchange[i].type=="checkbox")
		        {    //�ж��Ƿ��ǵ�ѡ��ѡ��
		            if(document.form.unchange[i].disabled == false)
		               document.form.unchange[i].checked = true;
		        }
		    }
		}
		function cancelChoose()
		{   //ȡ����ѡ��ȫ��ѡ��
			var k = <%=result_t.length%>;
		    for(i=0;i<k;i++)
		    {
		        if (k==1)
		        {
		        	if(document.form.unchange.type=="checkbox")
		        	{
		        		if(document.form.unchange.disabled == false)
		               document.form.unchange.checked = false;
		        	}
		        }
		        else if(document.form.unchange[i].type =="checkbox")
		        {    //�ж��Ƿ��ǵ�ѡ��ѡ��
		            if(document.form.unchange[i].disabled == false)
		               document.form.unchange[i].checked = false;
		        }
		    }
		}
		//add by anln 2009.02.04
		function backMain(){
			window.location.href="f2765_2.jsp";
		}
		function dingzhi()
		{
			
			    var zxk = document.getElementsByName('unchange');
		      var str1="";
		    
		     
 					for(j=0;j<zxk.length;j++)
 					  {
 					  	 if (zxk[j].checked==true)
 					  	 {
 					  	
 					  	 	
 					  	 
 					  	  str1+=zxk[j].value+",";
 					  	 	
 					  	
 					  	 	}
			
		        }
		       // alert(str1);
		        if(checktype())
		        {
		        	
		        	document.form.action="JModeConfirm.jsp?contract_no=<%=contract_no%>&users="+str1+"&show_mode=<%=show_mode%>";
		        	form.submit();
		        }
		       
		}
		function checktype()
		{
			     var flag=0;
		       var type= document.getElementsByName('type1');
		       for(i=0;i<type.length;i++)
		       {
		         if	(type[i].checked==true)
		           flag=1;
		       }
		       if(flag==0)
		       {
		     
		       rdShowMessageDialog("��ѡ���ӡ����! ");
		       return false;
		       }
		       
		       return true;
			
			
		}
		//-->
		</SCRIPT>
	</HEAD>
	<BODY>
	<FORM action="JModeConfirm.jsp" method=post name=form>
		       
		<%@ include file="/npage/include/header.jsp" %>     	
		<div class="title">
			<div id="title_zi">��Աѡ��</div>
		</div> 
		<table  cellspacing="0">
			  <tr>
			       <th width="8%">
				      <div align="center">ѡ��</div>
			       </th>
			       <th width="10%">
				      <div align="center">�û�����</div>
			       </th>
			       <th width="14%">
				      <div align="center">�ֻ�����</div>
			       </th>
			        <th width="14%">
				      <div align="center">�û�ID</div>
			       </th>
			   </tr>			  
			<% 
				for(int i=0; i < result_t.length  ; i++){
			%>
				<tr>
				  <td>
					<div align="center">
					  <input type="checkbox" name="unchange" value="<%=result_t[i][2].trim()%>" checked  >
				  </div>
				  </td>
				  <td>
					  <div align="center"><%=result_t[i][0]%></div>
				  </td>                               
				   <td>                               
					  <div align="center"><%=result_t[i][1]%></div>
				  </td>                               
				   <td>                               
					  <div align="center"><%=result_t[i][2]%></div>
				  </td>                               
				  
				</tr>
	    	<%}%>
		</table>
		<table cellspacing="0" align="center">
              <tr>
              <div class="title"  align="center">
	            <div id="title_zi">ѡ���ӡ��Ŀ</div>
              </div>
									<td nowrap align="center">
									        
			        ��Աȫ����Ŀ<input id="type1"   name="type1" type=radio value="al" >
					&nbsp;
			        ������Ŀ    <input id="type1"   name="type1" type=radio value="pa" >
					&nbsp;
									</td>
									
              </tr>
               </table>
                </table>
		
		<TABLE  cellSpacing="0">
		 <tbody>	  
			<tr>
				<td id="footer">
		             
			        <input  class="b_foot" name=allchoose type=button value=ȫѡ onclick="allChoose()">
					&nbsp;
			        <input  class="b_foot" name=cancelAll type=button value=ȡ��ȫѡ onclick="cancelChoose()">
					&nbsp;
			        <input  class="b_foot" name=sure type=button value=���� onclick="dingzhi()">
					&nbsp;
			        <input  class="b_foot" name=reset type=reset value=���� onclick="backMain()">
	       		
	       		</td>
	       		</tr>
	       	</tbody>
	        </table>	      
	       
     		<%@ include file="/npage/include/footer.jsp" %>	  
	</FORM>
	</BODY>
	</HTML>
<% 
} 
%>

