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
String checkflag = request.getParameter("checkflag");//页面是否加载过
String sCustomerProvinceNumber = request.getParameter("sCustomerProvinceNumber");
String sExtInfoAcceptID = request.getParameter("sExtInfoAcceptID");

String sp_Action = request.getParameter("sp_Action");
%>
<div id="form">
	<input type="hidden" id=p_Action value="<%=sp_Action%>" >
	<input type="hidden" id=p_ExtInfoAcceptID value="<%=sExtInfoAcceptID%>" >
	<table width="100%" border="0" cellpadding="0" cellspacing="0">
		<form id="bug_form" method="post" action="">
	      <tr>
	        <th width="10%" nowrap>选择</th>
	        <th width="90%" nowrap>中国移动信息化产品</th>
	      </tr>
      
<%
if("0".equals(checkflag)){
%>
<wtc:service name="s9101DetQry" outnum="6" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:param value="2"/>
	<wtc:param value="<%=sExtInfoAcceptID%>"/>
</wtc:service>
<wtc:array id="result" start="2" length="4" scope="end" />
<%
	if(retCode.equals("000000")){
		if(result.length>0){
			 for(int i=0;i<result.length;i++){
			 System.out.println("result[i][0]|"+result[i][0]);
%>
			 <tr class="cmcc_contenttr" 
			 	   a_CMCCPrd="<%=result[i][1]%>" 
			 	   a_CustomerProvinceNumber="<%=result[i][0]%>" 
			 	   a_ExtInfoAcceptID="<%=result[i][2]%>" 
			 	   a_CMCCPrdAcceptID="<%=result[i][3]%>" 
			 	   a_OperType="OLD">
			 		<td classes="grey">
			 			<input type="Checkbox" name="CMCCPrdListChkBox">
			 		</td>
			 		<td>
			 			<a class="p_CMCCPrd" style="cursor: hand;"><%=result[i][1]%>
			 			</a>
			 		</td>
			 </tr>
<%
	     }
	  }
	}
}
%>

        <tr id="buttontr">
	      	<th colspan="5" align="center">
	      		<%
if(!"3".equals(sp_Action))
{
%>
	      		<input type="button" class="b_text" id="CMCCPrdAdd" value="新增">
	      		&nbsp;
	      		<input type="button" class="b_text" id="CMCCPrdDel" value="删除">
	<%
}
%>	      		
	        </th>
	      </tr>
	      
		</form>
	</table>

</div>
<script>

$("#wait2").hide();

//新增函数
function CMCCPrdAdd(){
	  var CMCCPrdTR;
	  
	  var CMCCPrd=[
	      "",                                    //0 中国移动信息化产品
	      $("#p_CustomerProvinceNumber").val(),  //1 集团归属省编码
	      $("#p_ExtInfoAcceptID").val(),         //2 扩展信息流水
	      "0",                                   //3 产品流水
	      "NEW" ,                                 //4 创建标识
	      $("#p_Action").val()                    //5 操作类型
	    ];	 	    
   var retInfo = window.showModalDialog
   (
   'f2002_CMCCPrd_detail.jsp',
   CMCCPrd,
   'dialogHeight:550px; dialogWidth:750px;scrollbars:yes;resizable:no;location:no;status:no'
   );
   if(retInfo=="Y"){//点关闭按钮不新增	 	    	 
   	 var CMCCPrd0 = CMCCPrd[0];
   	 var CMCCPrd1 = CMCCPrd[1];
   	 var CMCCPrd2 = CMCCPrd[2];
   	 var CMCCPrd3 = CMCCPrd[3];
   	 var CMCCPrd4 = CMCCPrd[4]; 	    	 	    	 	    	 	    	 	    	 	    	 
  		 var newtrstr =
  		 "<tr"+
  		 " class=\"cmcc_contenttr\""+
  		 " a_CMCCPrd="+                  "'"+CMCCPrd0+"'"+
  		 " a_CustomerProvinceNumber="+   "'"+CMCCPrd1+"'"+
  		 " a_ExtInfoAcceptID="+          "'"+CMCCPrd2+"'"+
  		 " a_CMCCPrdAcceptID="+          "'"+CMCCPrd3+"'"+
  		 " a_OperType="+                 "'"+CMCCPrd4+"'"+
  		 ">"+
  		 "<td classes=\"grey\">"+
  		 "<input type=\"Checkbox\" name=\"CMCCPrdListChkBox\">"+
  		 "</td>"+
  		 "<td>"+
  		 "<a class=\"p_CMCCPrd\" style=\"cursor: hand;\">"+CMCCPrd0+
  		 "</a>"+
  		 "</td>"+
  		 "</tr>";
  		 $("#buttontr").before(newtrstr);
	     //注册更新函数
      $('.p_CMCCPrd').bind('click', CMCCPrdUpdate);
	  }
}
//更新函数
function CMCCPrdUpdate(){
   var CMCCPrdTR = $(this).parent().parent();
   var CMCCPrd = new Array(5);//行数据数组,传递给详细信息页面
	  CMCCPrd=[
	  	        $(CMCCPrdTR).attr("a_CMCCPrd"),
	  	        $(CMCCPrdTR).attr("a_CustomerProvinceNumber"),
	  	        $(CMCCPrdTR).attr("a_ExtInfoAcceptID"),
	  	        $(CMCCPrdTR).attr("a_CMCCPrdAcceptID"),
	  	        $(CMCCPrdTR).attr("a_OperType"),
	  	        $("#p_Action").val()                    //5 操作类型
	  	      ];	 	   	  	      
   var retInfo = window.showModalDialog
   (
   "f2002_CMCCPrd_detail.jsp",
   CMCCPrd,
   'dialogHeight:550px; dialogWidth:750px;scrollbars:yes;resizable:no;location:no;status:no'
   );	    
   //this.tr.attr赋值
   $(CMCCPrdTR).attr("a_CMCCPrd", CMCCPrd[0]);
   $(CMCCPrdTR).attr("a_CustomerProvinceNumber", CMCCPrd[1]);
   $(CMCCPrdTR).attr("a_ExtInfoAcceptID", CMCCPrd[2]);
   $(CMCCPrdTR).attr("a_CMCCPrdAcceptID", CMCCPrd[3]);
   $(CMCCPrdTR).attr("a_OperType", CMCCPrd[4]);
   $('.p_CMCCPrd',CMCCPrdTR).text(CMCCPrd[0]);
}


//删除函数
function CMCCPrdDel(){
   var deleteArrayTmp;//合并多次操作临时数组
	 deleteArrayTmp=new Array($("input[@name='CMCCPrdListChkBox']:checked").size());
   $("input[@name='CMCCPrdListChkBox']:checked").each(function(i)
   {
      var checkTR = $(this.parentNode.parentNode);      
      //if($(checkTR).attr("a_OperType")=="OLD")//如果是数据库中取出的数据，添加到删除缓冲区
      //{
         var deltr = new Array(5);
         deltr[0]=$(checkTR).attr("a_CMCCPrd");
         deltr[1]=$(checkTR).attr("a_CustomerProvinceNumber");
         deltr[2]=$(checkTR).attr("a_ExtInfoAcceptID");
         deltr[3]=$(checkTR).attr("a_CMCCPrdAcceptID");
         deltr[4]=$(checkTR).attr("a_OperType");
         deleteArrayTmp[i]=deltr;
      //}
      checkTR.remove();
   });   
   if(deleteArray)
   {
   	  deleteArray=deleteArray.concat(deleteArrayTmp);
   }else{
   	  deleteArray=deleteArrayTmp;
   }   
}
   
$(document).ready(function(){
	 //如果列表页面加载过，从数组中生成列表	 
	 if(extInfo[22]=="1"){
	 	  if(CMCCPrdListArray){
	 		  $.each(CMCCPrdListArray, function(i){
	 		  	var CMCCPrd = CMCCPrdListArray[i];//行数据数组,传递给详细信息页面
	   	  	 var newtrstr =
	   	  	 "<tr"+
	   	  	 " class=\"cmcc_contenttr\""+
	   	  	 " a_CMCCPrd="+                  "'"+CMCCPrd[0]+"'"+
	   	  	 " a_CustomerProvinceNumber="+   "'"+CMCCPrd[1]+"'"+
	   	  	 " a_ExtInfoAcceptID="+          "'"+CMCCPrd[2]+"'"+
	   	  	 " a_CMCCPrdAcceptID="+          "'"+CMCCPrd[3]+"'"+
	   	  	 " a_OperType="+                 "'"+CMCCPrd[4]+"'"+
	   	  	 ">"+
	   	  	 "<td classes=\"grey\">"+
	   	  	 "<input type=\"Checkbox\" name=\"CMCCPrdListChkBox\">"+
	   	  	 "</td>"+
	   	  	 "<td>"+
	   	  	 "<a class=\"p_CMCCPrd\" style=\"cursor: hand;\">"+CMCCPrd[0]+
	   	  	 "</a>"+
	   	  	 "</td>"+
	   	  	 "</tr>";
        
	 		    $("#buttontr").before(newtrstr);
	 		  });
	 	  }
	 }else{
	 		extInfo[22]="1";
	 }	 	 	 	 
   //注册新增函数
	 $('#CMCCPrdAdd').click(function(){
	     CMCCPrdAdd();
	 });
	 //注册更新函数
	 $('.p_CMCCPrd').bind('click', CMCCPrdUpdate);
	 //注册删除函数
	 $('#CMCCPrdDel').click(function(){
	     CMCCPrdDel();
	 });  
});
</script>
