
<%
/********************
 version v2.0
������: si-tech
*
*update:zhanghonga@2008-08-15 ҳ�����,�޸���ʽ
*
********************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	
<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	String workNo =WtcUtil.repNull((String)session.getAttribute("workNo"));
	String Phone_no         = request.getParameter("Phone_no")       ; // �û���ʶ	        
	String Marketing_group  = request.getParameter("Marketing_group"); // Ӫ��������ʶ	
	String Marketing_id     = request.getParameter("Marketing_id")   ; // Ӫ�����ʶ	    
	String Accepted_degree  = request.getParameter("Accepted_degree"); // ���̶ܳ�	        
	String Instalment       = request.getParameter("Instalment")     ; // �����	   
	String Marketing_name   = request.getParameter("Marketing_name") ; // Ӫ�������
	String Return_message   = request.getParameter("Return_message") ; // ������Ϣ	
  String Product_code     = "none"; 
  String Accepted_name    = "";                                      // ���̶ܳ�����
	System.out.println("Phone_no="+Phone_no);                                                      
	int errCode =0;                                        
  String errMsg           ="";                              
	String paramsIn[]       = new String[10]   ;  
	String paramsIn1[]      = new String[7]   ;  
	if(Accepted_degree.equals("3"))
	{
	  Accepted_name="�ܾ�";
	}
	if(Accepted_degree.equals("2"))
	{
	  Accepted_name="����";
	}
	if(Accepted_degree.equals("1"))
	{
	  Accepted_name="�Ӵ���δӪ��";
	}
	if(Accepted_degree.equals("1"))
	{
	  paramsIn1[0] = "131001"         ; // function_code 
    paramsIn1[1] =  Accepted_degree;  // ���̶ܳ�	            
    paramsIn1[2] =  workNo         ;  // ����Ա����
    paramsIn1[3] =  Return_message ;  // ������Ϣ
    paramsIn1[4] =  Product_code   ;  // ��Ʒ�ʷ�ID	     
    paramsIn1[5] =  Phone_no       ;  // �û���ʶ	        
    paramsIn1[6] =  Phone_no       ;  // �û���ʶ	     
    for(int i=0;i<paramsIn1.length;i++){
    	System.out.println("##################paramsIn1["+i+"]->"+paramsIn1[i]);
    }   
    //acceptList = impl.callService("sDynSqlCfm",paramsIn1,"0");
 %>
 	<wtc:service name="sDynSqlCfm" routerKey="phone" routerValue="<%=Phone_no%>" retcode="retCode1" retmsg="retMsg1" outnum="0" >
	<wtc:param value="<%=paramsIn1[0]%>"/>
	<wtc:param value="<%=paramsIn1[1]%>"/>
	<wtc:param value="<%=paramsIn1[2]%>"/>
	<wtc:param value="<%=paramsIn1[3]%>"/>
	<wtc:param value="<%=paramsIn1[4]%>"/>
	<wtc:param value="<%=paramsIn1[5]%>"/>
	<wtc:param value="<%=paramsIn1[6]%>"/>
	</wtc:service>
 <%
 		if(retCode1!=null&&!"".equals(retCode1)){
 			errCode = Integer.parseInt(retCode1);
 		}
	  errMsg=retMsg1;
	}else{
  	paramsIn[0] = "131000"; // function_code 1310:�ɷ�Ӫ������
    paramsIn[1] =  Phone_no;  // �û���ʶ	              
    paramsIn[2] =  Marketing_group;  // Ӫ��������ʶ 
    paramsIn[3] =  Marketing_id;  // Ӫ�����ʶ	   
    paramsIn[4] =  Accepted_degree;  // ���̶ܳ�	       
    paramsIn[5] =  workNo;  // ����Ա����	     
    paramsIn[6] =  Return_message;  // ������Ϣ	       
    paramsIn[7] =  Product_code;  // ��Ʒ�ʷ�ID	     
    paramsIn[8] =  Instalment;  // �����	       
    paramsIn[9] =  Marketing_name;  // Ӫ�������	
    
    for(int i=0;i<paramsIn.length;i++){
    	System.out.println("##################paramsIn["+i+"]->"+paramsIn[i]);
    }
  
    //acceptList = impl.callService("sDynSqlCfm",paramsIn,"0");
 %>
 	<wtc:service name="sDynSqlCfm" routerKey="phone" routerValue="<%=Phone_no%>" retcode="retCode1" retmsg="retMsg1" outnum="0" >
	<wtc:param value="<%=paramsIn[0]%>"/>
	<wtc:param value="<%=paramsIn[1]%>"/>
	<wtc:param value="<%=paramsIn[2]%>"/>
	<wtc:param value="<%=paramsIn[3]%>"/>
	<wtc:param value="<%=paramsIn[4]%>"/>
	<wtc:param value="<%=paramsIn[5]%>"/>
	<wtc:param value="<%=paramsIn[6]%>"/>
	<wtc:param value="<%=paramsIn[7]%>"/>
	<wtc:param value="<%=paramsIn[8]%>"/>
	<wtc:param value="<%=paramsIn[9]%>"/>
	</wtc:service>
 <%    
	  if(retCode1!=null&&!"".equals(retCode1)){
 			errCode = Integer.parseInt(retCode1);
 		}
	  errMsg=retMsg1;
  }
  	
     
                                               
  	if(errCode != 0)
  	{
%>
    <script language='javascript'>
    	rdShowMessageDialog("<%=errCode%>[<%=errMsg%>]");
      window.close();
    </script>
<%	
	}else{
	   if(Accepted_degree.equals("1"))
	   {
%>
          <script language='javascript'>
          	rdShowMessageDialog("��<%=Marketing_name%>��Ӫ��������Ϣ��¼�ɹ���<%=Accepted_name%>",2);
	      		window.close();
          </script>
 <%
	  }else{
 %>
	    
          <script language='javascript'>
          	rdShowMessageDialog("��<%=Marketing_name%>��Ӫ��������Ϣ��¼�ɹ���<%=Accepted_name%>",2);
	      		window.close();
          </script>
 <%
       }  
	}
%>

