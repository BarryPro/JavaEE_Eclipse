<%
/********************
 version v2.0
������: si-tech
update:liutong@2008.09.03
********************/
%>

<%@ page contentType= "text/html;charset=gb2312" %>
<%@ page errorPage="../common/errorpage.jsp" %>

<%
        //�õ��������      
      //  ArrayList retArray = new ArrayList();
      //  String return_code,return_message;
      //  String[][] result = new String[][]{};
 	//	comImpl co=new comImpl();
	    //--------------------------
	    String retType = request.getParameter("retType"); 
	    String pack_creditNo = request.getParameter("pack_creditNo"); 
 	    String region_code = request.getParameter("region_code");
	    
	    //����ֵ����
      //  String retCode = "";
      //  String retMessage = "";		   

		//��ѯ���
		String sq1="select count(*) from dPackMsg where substr(belong_code,1,2)='"+region_code+"' and pack_id='"+pack_creditNo+"'";     

%>
<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=region_code%>"  retcode="retCode" retmsg="retMessage" outnum="1">
<wtc:sql><%=sq1%></wtc:sql>
</wtc:pubselect>
<wtc:array id="result" scope="end" />

<%       
          //  retArray = co.spubqry32("1",sq1,"region",region_code);
          //  result = (String[][])retArray.get(0);            

if(retCode.equals("000000")||retCode.equals("0")){

              if(result.length!=0){
                    	if(result[0][0].trim().equals("0"))
						{
			              retCode="000000";
						  retMessage="û�д�Ӫ����ƾ֤�ţ�";
						}
			            else
						{
			              retCode="000001";
						  retMessage="��Ӫ����ƾ֤���Ѵ��ڣ�"; 			  
			 			}
              }
			       

}else{
		   retCode="000002";
			retMessage="��ѯӪ����ƾ֤��Ϣ����";
	}
		
                      
       
		

		
%>
var response = new AJAXPacket();
var retType = "";
var retCode = "";
var retMessage = "";
  
retType = "<%=retType%>";
retCode = "<%=retCode%>";
retMessage = "<%=retMessage%>";
  
response.data.add("retType",retType);
response.data.add("retCode",retCode);
response.data.add("retMessage",retMessage);
core.ajax.receivePacket(response);