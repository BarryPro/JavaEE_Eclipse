<%
/**
�һ���ɾ��session�д�����map�������֤��Ϣ
hejwa 2010��10��9��13:24:07 add

*/
   try{
   		
   		java.util.HashMap hm2 = new java.util.HashMap();    
   		java.util.HashMap hm1 = (java.util.HashMap)session.getAttribute("phoneKfCheck");
   		session.setAttribute("phoneKfCheck",hm2);
   		
      }catch(Throwable e)
      {
   
      }
%>
	
