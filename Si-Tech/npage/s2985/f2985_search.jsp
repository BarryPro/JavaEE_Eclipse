 <%
   /*
   * ����: ��������ϸ����
�� * �汾: v1.0
�� * ����: 2008/05/12
�� * ����: wuln
�� * ��Ȩ: sitech
   * �޸���ʷ
   * �޸�����:2009/05/14   �޸���:leimd   �޸�Ŀ��:��Ӧ������
 ��*/
%>  
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%
	String regionCode=(String)session.getAttribute("regCode");
	String opName = "��������ϸ�����б�";
  	String  param_set=request.getParameter("param_set");
	int len=0;
	String sqlStr1="";
	sqlStr1 = "select a.param_code,b.param_name from sBizParamDetail a,sBizParamCode b where a.param_code=b.param_code and a.param_set like '%"+param_set+"%'";

%>
<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" outnum="2" retcode="retCode" retmsg="retMessage">
	<wtc:sql><%=sqlStr1%></wtc:sql>
</wtc:pubselect>
<wtc:array id="rows" scope="end"/>
<%		
	
	if(rows.length>0)
	{	
	      System.out.println("rows.length="+rows.length);
      
        len=rows.length;
      }
	else{
%>    
		<script language=javascript>	
			rdShowMessageDialog("��ѯ����������򲻴��ڣ�!",0);
			//document.location.replace("<%=request.getContextPath()%>/npage/s2985/f2985.jsp");
		</script>
<%
		}
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%=opName%></title>
<META content="text/html; charset=GBK" http-equiv=Content-Type>
<meta http-equiv="Expires" content="0">
<script language=javascript>   
 	
	onload=function() {
		self.status="";
	 	core.ajax.onreceive = doProcess;
	}
	
//����rpc���ؽ��
function doProcess(packet) {	
	  self.status="";	

	 var qryType=packet.data.findValueByName("rpcType");
	 var errCode=packet.data.findValueByName("errCode");
	 var errMsg=packet.data.findValueByName("errMsg");
	
 if(qryType == "checkParamSet"){	 
	 if(errCode == "000000")
	    {
		  rdShowMessageDialog("������Ϣ��"+errMsg + "<br>���ش��룺"+errCode,1);
		  document.form1.AddBtn.disabled=false; 
		  document.form1.allSelectt.disabled=false;
		  document.form1.noSelectt.disabled=false;
		  //document.form1.param_set.readOnly=true;
		 // document.form1.checkP.disabled=true;
	   }else
	   	   {		   	   	
	   	   rdShowMessageDialog("������Ϣ��"+errMsg + "<br>������룺"+errCode, 0);
	        }
      }	
}	 
</script>
</head>
<body>

       <table cellspacing="0">
				
			<TR> 
					
				      <TD colspan='16' class="blue"><B>��������ѯ�б�</B></TD> 
				    
				                 	                             	              
        	</TR>
			<TR> 
					
			      	<TD colspan='8' class="blue">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;��������</TD> 
			      	<TD colspan='8' class="blue">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;��������</TD>
				                 	                             	              
        	</TR>
					<%
				  for(int i = 0; i < len; i++)
					{
			        %>
				        <TR>
					         <TD colspan='8' class="blue">	
						           &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <%=rows[i][0].trim()%>
						                 
                  </TD>
					        <TD colspan='8' class="blue">
					              &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;<%=rows[i][1].trim()%>   
					                  
					        </TD>	
					 	                
					    </TR>
				        <%
						}
				        %>
				</table>
	  
	 </body>
	</html>
		
