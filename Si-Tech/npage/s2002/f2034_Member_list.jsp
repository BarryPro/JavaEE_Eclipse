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
  
  String sqlstr= "select decode(OrderSource,'0','省BOSS上传','1','EC上传','2','BBOSS受理'),Member_no,decode(member_type,'0','黑名单','1','签约成员','2','白名单'),nvl(Member_group,' '),to_char(begin_time,'yyyy-mm-dd'), "
               +" decode(Action,'0','删除','1','增加','2','变更成员','3','暂停成员','4','恢复成员'),decode(status,'0','处理中','1','竣工') "
               + "from dproductTaskmemberinfo where  Product_id = \'?\'";
%>

<div id="form">
	<table width="100%" border="0" cellpadding="0" cellspacing="0">
		<form id="bug_form" method="post" action="">
	      <tr>
	      	<!--th width="10%" nowrap>选择</th-->
	        <th width="20%" nowrap>成员号码</th>
	        <th width="20%" nowrap>成员类型</th>
	        <th width="20%" nowrap>生效时间</th>
	        <th width="20%" nowrap>操作类型</th>	
	        <th width="20%" nowrap>当前状态</th>			        
	      </tr>
        <tbody>
<wtc:pubselect name="sPubSelect" outnum="7" routerKey="region" routerValue="<%=regionCode%>">
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
  			  	 a_Ordersource         = "<%=result[i][0]%>"
  			  	 a_MemberNo             = "<%=result[i][1]%>"
  			  	 a_MemberType      = "<%=result[i][2]%>"
  			  	 a_Membergroup  = "<%=result[i][3]%>"
  			  	 a_effdate      ="<%=result[i][4]%>"
  			  	 a_Action       ="<%=result[i][5]%>"
  			  	 a_status       ="<%=result[i][6]%>"
  			  	 a_OperType            = "OLD"
  			  >					  
					  <!--td>    
					  <input type="Checkbox" name= "KeyPersonListChkBox">
					  </td-->    
					  <td>
					  <a class="p_Member" style="cursor: hand;"><%=result[i][1]%></a>						  	
					  </td>
					  <td class="p_Membertype"><%=result[i][2]%>
					  </td>
			      <td class="p_effdate"><%=result[i][4]%>
					  </td>
					  <td class="p_action"><%=result[i][5]%>
					  </td>
					  <td class="p_status"><%=result[i][6]%>
					  </td>
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
function ParameterNumberUpdate(){
	
  var checkTR = $(this).parent().parent();    
 	var ProductOrderCharacter=[
 	  	        $(checkTR).attr("a_Ordersource"),
 	  	        $(checkTR).attr("a_MemberNo"),  	  	       	 	  	       
 	  	        $(checkTR).attr("a_MemberType"), 
 	  	        $(checkTR).attr("a_Membergroup"), 
 	  	        $(checkTR).attr("a_effdate"), 
 	  	        '<%=sProductOrderNumber%>'                           
 	  	        ];
  var retInfo = window.showModalDialog
  (
  'f2034_Member_detail.jsp',
  ProductOrderCharacter,
  'dialogHeight:500px; dialogWidth:700px;scrollbars:yes;resizable:no;location:no;status:no'
  );
  //this.tr.attr赋值
  $(checkTR).attr("a_Ordersource"    , ProductOrderCharacter[0] );
  $(checkTR).attr("a_MemberNo"      , ProductOrderCharacter[1] );
  $(checkTR).attr("a_MemberType"     , ProductOrderCharacter[2] );
  $(checkTR).attr("a_Membergroup" , ProductOrderCharacter[3] );
  $(checkTR).attr("a_effdate" , ProductOrderCharacter[4] );
  
  $('.a_MemberNo',checkTR).text(ProductOrderCharacter[1]);	  	  	  	  	  	  	  	  	  	  
  $('.a_MemberType',checkTR).text(ProductOrderCharacter[2]);
  $('.a_Membergroup',checkTR).text(ProductOrderCharacter[3]);
  
  return true;	  	  	  
}
$(document).ready(function(){
   
	 //注册更新函数
	 $('.p_Member').bind('click', ParameterNumberUpdate);
	 
});
</script>
