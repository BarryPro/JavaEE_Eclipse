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
  String sProductOrderNumber = request.getParameter("sProductOrderNumber");
  
  String sqlstr= "select PRODUCT_ORDER_ID,CHARACTER_NUMBER,CHARACTER_VALUE,PRIACCESS_NUMBER,nvl(to_char(CharacterGroup), '  ') "
               + "from DPRODUCTTASKOTHERINFO where  PRODUCT_ORDER_ID = \'?\'";
%>

<div id="form">
	<table width="100%" border="0" cellpadding="0" cellspacing="0">
		<form id="bug_form" method="post" action="">
	      <tr>
	      	<!--th width="10%" nowrap>选择</th-->
	        <th width="15%" nowrap>产品属性组</th>
	        <th width="15%" nowrap>产品属性代码</th>
	        <th width="20%" nowrap>属性名</th>
	        <th width="50%" nowrap>属性值</th>
	      </tr>
        <tbody>
<wtc:pubselect name="sPubSelect" outnum="5" routerKey="region" routerValue="<%=regionCode%>">
<wtc:sql><%=sqlstr%>
</wtc:sql>
<wtc:param value="<%=sProductOrderNumber%>"/>
</wtc:pubselect>
<wtc:array id="result" scope="end" />
<%
if(retCode.equals("000000")){
	if(result.length>0){
		for(int i=0;i<result.length;i++){
%>
  			  <tr class="keyperson_contenttr"
  			  	 a_CharacterGroup      = "<%=result[i][4]%>"
  			  	 a_ParameterNumber     = "<%=result[i][1]%>"
  			  	 a_ParameterName       = "<%=result[i][3]%>"
  			  	 a_ParameterValue      = "<%=result[i][2]%>"
  			  	 a_ProductOrderNumber  = "<%=result[i][0]%>"
  			  	 a_OperType            = "OLD"
  			  >					  
					  <!--td>
					  <input type="Checkbox" name= "KeyPersonListChkBox">
					  </td-->
						<td>
							<input type="text" name="p_CharacterGroup" id="p_CharacterGroup" v_maxlength="4" maxlength="4" size="10" value="<%=result[i][4]%>">
							
						</td>
					  <td>
						  <a class="p_ParameterNumber" style="cursor: hand;"><%=result[i][1]%></a>
							<input type="hidden" name="p_ParameterNumber" v_maxlength="4" maxlength="4" size="10" value="<%=result[i][1]%>">
					  </td>
					  <td class="p_ParameterName">
					  	<%=result[i][3]%>
							<input type="hidden" name="p_ParameterName" v_maxlength="4" maxlength="4" size="10" value="<%=result[i][3]%>">
					  </td>
						<td class="p_ParameterValue">
							<input type="text" name="p_ParameterValue" v_must="1" v_maxlength="50" maxlength="50" size="40" value="<%=result[i][2]%>">
						</td>
	        </tr>
<%
    }
  }
}
%>
	         <!--tr id="keyPerson_buttontr">
	        	<th colspan="5" align="center">
	        		<input type="button" class="b_text" id="ParameterNumberAdd" value="新增">
	        		&nbsp;
	        		<input type="button" class="b_text" id="ParameterNumberDel" value="删除">
	          </th>
	        </tr-->
	      </tbody>
		</form>
	</table>
</div>
<script>
//隐藏滚动条
$("#wait2").hide();
//更新函数
function ParameterNumberUpdate(){
	
  var checkTR = $(this).parent().parent();    
 	var ProductOrderCharacter=[
 	  	        $(checkTR).attr("a_ParameterNumber"),
 	  	        $(checkTR).attr("a_ParameterName"),  	  	       	 	  	       
 	  	        $(checkTR).attr("a_ParameterValue"), 
 	  	        '<%=sProductOrderNumber%>'                           
 	  	        ];
  var retInfo = window.showModalDialog
  (
  'f2034_ProductOrderCharacter_detail.jsp',
  ProductOrderCharacter,
  'dialogHeight:500px; dialogWidth:700px;scrollbars:yes;resizable:no;location:no;status:no'
  );
  //this.tr.attr赋值
  $(checkTR).attr("a_ParameterNumber"    , ProductOrderCharacter[0] );
  $(checkTR).attr("a_ParameterName"      , ProductOrderCharacter[1] );
  $(checkTR).attr("a_ParameterValue"     , ProductOrderCharacter[2] );
  $(checkTR).attr("a_ProductOrderNumber" , ProductOrderCharacter[3] );
  
  $('.a_ParameterNumber',checkTR).text(ProductOrderCharacter[1]);	  	  	  	  	  	  	  	  	  	  
  $('.a_ParameterName',checkTR).text(ProductOrderCharacter[2]);
  $('.a_ParameterValue',checkTR).text(ProductOrderCharacter[3]);
  
  return true;	  	  	  
}
//新增函数
function ParameterNumberAdd(){
	
	 var ParameterNumber = new Array(4);
	 ParameterNumber=[
	            "",                       
	            "",                       
	            "",                       
	            '<%=sProductOrderNumber%>'
	            ]
   var retInfo = window.showModalDialog
   (
   'f2023_ProductOrderCharacter_detail.jsp',
   ParameterNumber,
   'dialogHeight:550px; dialogWidth:750px;scrollbars:yes;resizable:no;location:no;status:no'
   );
   if(retInfo=="Y"){//点关闭按钮不新增
      var newtrstr =
      "<tr class=\"keyperson_contenttr\"  "+
	   	" a_ParameterNumber="+    "'"+ParameterNumber[0] +"'"+
	   	" a_ParameterName="+      "'"+ParameterNumber[1] +"'"+
	   	" a_ParameterValue="+     "'"+ParameterNumber[2] +"'"+  
	   	" a_ProductOrderNumber="+ "'"+ParameterNumber[3] +"'"+ 			  	
	   	" a_OperType=\"new\""+
	   	">"+
	 		"<td classes=\"grey\"><input type=\"Checkbox\" name=\"KeyPersonListChkBox\">"+
	 	  "</td>"+
	     "<td><a class=\"p_ParameterNumber\" style=\"cursor: hand;\">"+ParameterNumber[0]+"</a>"+
	 	  "</td>"+
	 	  "<td class=p_ParameterName>"+ParameterNumber[1]+
	 	  "</td>"+
	 	  "<td class=p_ParameterValue>"+ParameterNumber[2]+
	 	  "</td>"+
         "</tr>";
      $("#keyPerson_buttontr").before(newtrstr);
      //注册更新函数
      $('.p_ParameterNumber').bind('click', KeyPersonUpdate);
   }
}
//删除函数
function ParameterNumberDel(){
	  
   $("input[@name='KeyPersonListChkBox']").each(function()
   {
   var checkTR = $(this.parentNode.parentNode);
   if($(this).attr("checked")){
   	  if($(checkTR).attr("a_OperType")=="OLD")//如果是数据库中取出的数据，添加到删除缓冲区
   	  {         	  	  
   	  	  var ii  = $("DIV.ProductOrderCharacter","#hiddendate_delete").size();
   	  		var deletedate=
   	  		"<DIV class='ProductOrderCharacter'>" +
   	  		"<input type='text' name='tableid"+ii+"'              value='1'>" +
   	  		"<input type='text' name='opertype"+ii+"'             value='N'>" +
   	  		"<input type='text' name='d_ParameterNumber"+ii+"'    value='"+$(checkTR).attr("a_ParameterNumber")+"'>"+       
   	  		"<input type='text' name='d_ParameterName"+ii+"'      value='"+$(checkTR).attr("a_ParameterName")+"'>"+  
          "<input type='text' name='d_ParameterValue"+ii+"'     value='"+$(checkTR).attr("a_ParameterValue")+"'>"+             	  		
          "<input type='text' name='d_ProductOrderNumber"+ii+"' value='"+$(checkTR).attr("a_ProductOrderNumber")+"'>"+             	  		
          "</DIV>";                                                                                                            
   	  		$("#hiddendate_delete").append(deletedate);                                                                          
   	  }          
    		checkTR.remove();
   }
   })
}
$(document).ready(function(){
   //注册新增函数
	 $('#ParameterNumberAdd').click(function(){
	     ParameterNumberAdd(); 
	     });
	 //注册更新函数
	 $('.p_ParameterNumber').bind('click', ParameterNumberUpdate);
	 //注册删除函数
	 $('#ParameterNumberDel').click(function(){
	     ParameterNumberDel();
	 });
});
</script>
