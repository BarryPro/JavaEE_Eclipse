<%
	 /*
	 * ����: ģ�鴰�ڡ������ҳ��
	 * �汾: 1.0.0
	 * ����: 2009/02/25
	 * ����: xingzhan
	 * ��Ȩ: sitech
	 * update:
	 */
%>
<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_name.jsp"%>
<%@ page import="javax.servlet.http.HttpServletRequest,com.sitech.crmpd.core.wtc.util.*,java.util.*,java.io.OutputStream,com.sitech.boss.util.excel.*,java.text.SimpleDateFormat"%>

		

          
<% 
	 String opCode = "";
   String opName = "";
  	
   String id = request.getParameter("id");
   
   String uil = "npage/portal/kfuser/fKF_AllFee.jsp";
   
   if("fKF_AllFee".equals(id)){
   	
   		opName = "���Ѹſ�";
   }
   else if("fsource_sel".equals(id)){
   	
   		opName = "������Ϣ";
   }	
   else if("fbigQuery".equals(id)){
   	
   		opName = "��ͻ�������Ϣ";
   }	
   else if("fcomplainInfo".equals(id)){
   	
   		opName = "Ͷ�����";
   }	
   else if("fKFConInfo".equals(id)){
   	
   		opName = "�ʻ���������";
   }	
   else if("fspInfo".equals(id)){
   	
   		opName = "SP�˶���ѯ";
   }	
   else if("faccuGetImei".equals(id)){
   	
   		opName = "������Ϊ&IMEI��Ϣ";
   }	
   else if("ffunc_sel".equals(id)){
   	
   		opName = "���ù���";
   }	
   else if("fproduct_sel".equals(id)){
   	
   		opName = "��Ʒ��Ϣ";
   }	
   else if("fcomAdvice".equals(id)){
   	
   		opName = "Ͷ�߽���";
   }	
   else if("fKFOrgInfo".equals(id)){
   	
   		opName = "������������";
   }	
   else if("fserviceMsg".equals(id)){
   	
   		opName = "����ͨ";
   }	
   else if("fPayInfo".equals(id)){
   	
   		opName = "������Ϣ";
   }	
   else if("faccuSellCust".equals(id)){
   	
   		opName = "Ӫ���";
   }	
   else if("fgetEvInfo".equals(id)){
   	
   		opName = "��ҵ�񶩹���Ϣ";
   }		 
   	 
%>
  	 
<html>
	<head>
		<title></title>
		<script language=javascript>
			
		
			function window.onbeforeunload()   
			{   
			if(event.clientX>document.body.clientWidth&&event.clientY<0||event.altKey||event.ctrlKey)   
			{   
			     //�ж�event.altKey��Ϊ��Alt+F4�رյ�������ж�event.ctrlKey��Ϊ��Ctrl+W�رյ���� 
			     window.opener.big_Opener= null; 
			     //alert("�ر�");
			}   
			else{   
			     //alert("ˢ��");   
			}   
			} 
			function myclose()   
			{   
			     window.opener.big_Opener= null; 
			     window.close();
			} 
			
			

		</script>
	</head>
<body onload="window.focus();">
 <%@ include file="/npage/include/header.jsp"%>
	    <form name="sitechform" id="sitechform">
		    <div id="Operation_Table">
				<div class="title">
					
				</div>
				<%
				if("fKF_AllFee".equals(id)){
   			%>
   	   <jsp:include flush="true" page="/npage/portal/kfuser/fKF_AllFee.jsp"></jsp:include>
   	    <%
        }
        %>
        
        <%
				if("fsource_sel".equals(id)){
   			%>
   	   <jsp:include flush="true" page="/npage/portal/kfuser/fsource_sel.jsp"></jsp:include>
   	    <%
        }
        %>
        
        <%
				if("fbigQuery".equals(id)){
   			%>
   	   <jsp:include flush="true" page="/npage/portal/kfuser/fbigQuery.jsp"></jsp:include>
   	    <%
        }
        %>
        
        <%
				if("fcomplainInfo".equals(id)){
   			%>
   	   <jsp:include flush="true" page="/npage/portal/kfuser/fcomplainInfo.jsp"></jsp:include>
   	    <%
        }
        %>
        
        <%
				if("fKFConInfo".equals(id)){
   			%>
   	   <jsp:include flush="true" page="/npage/portal/kfuser/fKFConInfo.jsp"></jsp:include>
   	    <%
        }
        %>
        
        <%
				if("fspInfo".equals(id)){
   			%>
   	   <jsp:include flush="true" page="/npage/portal/kfuser/fspInfo.jsp"></jsp:include>
   	    <%
        }
        %>
        
        <%
				if("faccuGetImei".equals(id)){
   			%>
   	   <jsp:include flush="true" page="/npage/portal/kfuser/faccuGetImei.jsp"></jsp:include>
   	    <%
        }
        %>
        
        <%
				if("ffunc_sel".equals(id)){
   			%>
   	   <jsp:include flush="true" page="/npage/portal/kfuser/ffunc_sel.jsp"></jsp:include>
   	    <%
        }
        %>
        
        <%
				if("fproduct_sel".equals(id)){
   			%>
   	   <jsp:include flush="true" page="/npage/portal/kfuser/fproduct_sel.jsp"></jsp:include>
   	    <%
        }
        %>
        
        <%
				if("fcomAdvice".equals(id)){
   			%>
   	   <jsp:include flush="true" page="/npage/portal/kfuser/fcomAdvice.jsp"></jsp:include>
   	    <%
        }
        %>
        
        <%
				if("fserviceMsg".equals(id)){
   			%>
   	   <jsp:include flush="true" page="/npage/portal/kfuser/fserviceMsg.jsp"></jsp:include>
   	    <%
        }
        %>
        
        <%
				if("fPayInfo".equals(id)){
   			%>
   	   <jsp:include flush="true" page="/npage/portal/kfuser/fPayInfo.jsp"></jsp:include>
   	    <%
        }
        %>
        
        <%
				if("faccuSellCust".equals(id)){
   			%>
   	   <jsp:include flush="true" page="/npage/portal/kfuser/faccuSellCust.jsp"></jsp:include>
   	    <%
        }
        %>
        
        <%
				if("fgetEvInfo".equals(id)){
   			%>
   	   <jsp:include flush="true" page="/npage/portal/kfuser/fgetEvInfo.jsp"></jsp:include>
   	    <%
        }
        %>
        
        
         <%
				if("fKFOrgInfo".equals(id)){
   			%>
   	   <jsp:include flush="true" page="/npage/portal/kfuser/fKFOrgInfo.jsp"></jsp:include>
   	    <%
        }
        %>
       
        
       
  
				</div>
				<div align = right><input type="button" class="b_foot" value="�ر�"  onclick ="myclose();" ></div>
	    </form>
  <%@ include file="/npage/include/footer.jsp"%>
</body>	
</html>	
<script>
 function showPageInfo(tagUrl)
{
	// xingzhan 20090220 ; ��Ϊ���Ը��Ĵ��ڴ�С;
	window.open(tagUrl,'','scrollbars=yes, resizable=yes,location=no,height=100% status=yes' );
}
</script>