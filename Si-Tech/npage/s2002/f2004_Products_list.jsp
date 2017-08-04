<%
   /*
   * 功能: 问题反馈
　 * 版本: v1.0
　 * 日期: 2008年10月25日
　 * 作者: piaoyi
　 * 版权: sitech
   * 修改历史
   * 修改日期      修改人      修改目的
 　*/
%>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%@ page contentType= "text/html;charset=GBK" %>
<%
  String workNo = (String)session.getAttribute("workNo");
  String org_code = (String)session.getAttribute("orgCode");
  String regionCode=org_code.substring(0,2);
  String sPOSpecNumber = request.getParameter("sPOSpecNumber");
  System.out.println("sPOSpecNumber:"+sPOSpecNumber);	 
%>

<div id="form">
	<table width="100%" border="0" cellpadding="0" cellspacing="0">
		<form id="bug_form" method="post" action="">
	      <tr>
	        <th width="25%" nowrap>产品规格编号</th>
	        <th width="75%" nowrap>产品规格名称</th>	        
	      </tr>
        <tbody>
<wtc:service name="s9100DetQry" outnum="8" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:param value="<%=sPOSpecNumber%>"/>
	<wtc:param value="5"/>
</wtc:service>
<wtc:array id="result" start="2" length="5" scope="end" />
<%  
	if(retCode.equals("000000")){				   
		if(result.length>0){
			for(int i=0;i<result.length;i++){			  
%>
  			  <tr 
  			  	a_ProductSpecNumber="<%=result[i][0]%>"
  			  	a_ProductSpecName  ="<%=result[i][1]%>"
  			  	a_ProductType      ="<%=result[i][2]%>"
  			  	a_Status           ="<%=result[i][3]%>"
  			  	a_Description      ="<%=result[i][4]%>"  			  	  			  	
  			  	>
				    <td><a class="a_ProductSpecNumber" style="cursor: hand;"><%=result[i][0]%></a>
					  &nbsp;</td>
					  <td class="a_ProductSpecName"><%=result[i][1]%>					  	
					  &nbsp;</td>					 					 					 					 
	        </tr>
<%
       }
     }
  }
%>
	      </tbody>
		</form>
	</table>
</div>
<script>


//隐藏滚动条
$("#wait2").hide();
	 //更新函数
	 function ProductInfoUpdate(){	 	  
      var ProductInfoTR = $(this).parent().parent();
	 	  ProductInfo=[
	 	  	        $(ProductInfoTR).attr("a_ProductSpecNumber"),//0
	 	  	        $(ProductInfoTR).attr("a_ProductSpecName"  ),//1
	 	  	        $(ProductInfoTR).attr("a_ProductType"      ),//2
	 	  	        $(ProductInfoTR).attr("a_Status"           ),//3
	 	  	        $(ProductInfoTR).attr("a_Description"      ),//4
	 	  	        '<%=sPOSpecNumber%>'
	 	  	        ];
      
	    var retInfo = window.showModalDialog
	    (
	    'f2004_Product_detail.jsp',	     
	    ProductInfo,
	    'dialogHeight:500px; dialogWidth:800px;scrollbars:yes;resizable:no;location:no;status:no'
	    );
	    return true;                                                           
	 }
$(document).ready(function(){ 
	 //注册更新函数
	 $('.a_ProductSpecNumber').bind('click', ProductInfoUpdate);	
});
</script>
