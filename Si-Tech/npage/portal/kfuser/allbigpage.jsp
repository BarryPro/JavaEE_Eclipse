<%
	 /*
	 * 功能: 模块窗口——最大化页面
	 * 版本: 1.0.0
	 * 日期: 2009/02/25
	 * 作者: xingzhan
	 * 版权: sitech
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
   	
   		opName = "话费概况";
   }
   else if("fsource_sel".equals(id)){
   	
   		opName = "评价信息";
   }	
   else if("fbigQuery".equals(id)){
   	
   		opName = "大客户资料信息";
   }	
   else if("fcomplainInfo".equals(id)){
   	
   		opName = "投诉情况";
   }	
   else if("fKFConInfo".equals(id)){
   	
   		opName = "帐户基本资料";
   }	
   else if("fspInfo".equals(id)){
   	
   		opName = "SP退订查询";
   }	
   else if("faccuGetImei".equals(id)){
   	
   		opName = "消费行为&IMEI信息";
   }	
   else if("ffunc_sel".equals(id)){
   	
   		opName = "常用功能";
   }	
   else if("fproduct_sel".equals(id)){
   	
   		opName = "产品信息";
   }	
   else if("fcomAdvice".equals(id)){
   	
   		opName = "投诉建议";
   }	
   else if("fKFOrgInfo".equals(id)){
   	
   		opName = "归属集团资料";
   }	
   else if("fserviceMsg".equals(id)){
   	
   		opName = "服务开通";
   }	
   else if("fPayInfo".equals(id)){
   	
   		opName = "付费信息";
   }	
   else if("faccuSellCust".equals(id)){
   	
   		opName = "营销活动";
   }	
   else if("fgetEvInfo".equals(id)){
   	
   		opName = "新业务订购信息";
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
			     //判断event.altKey是为了Alt+F4关闭的情况；判断event.ctrlKey是为了Ctrl+W关闭的情况 
			     window.opener.big_Opener= null; 
			     //alert("关闭");
			}   
			else{   
			     //alert("刷新");   
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
				<div align = right><input type="button" class="b_foot" value="关闭"  onclick ="myclose();" ></div>
	    </form>
  <%@ include file="/npage/include/footer.jsp"%>
</body>	
</html>	
<script>
 function showPageInfo(tagUrl)
{
	// xingzhan 20090220 ; 改为可以更改窗口大小;
	window.open(tagUrl,'','scrollbars=yes, resizable=yes,location=no,height=100% status=yes' );
}
</script>