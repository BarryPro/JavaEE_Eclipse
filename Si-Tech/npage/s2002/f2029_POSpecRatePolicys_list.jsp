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
  String sPOOrderNumber = request.getParameter("sPOOrderNumber");
  String sPOSpecNumber = request.getParameter("sPOSpecNumber");
  System.out.println("sPOSpecNumber:"+sPOSpecNumber);	 
  System.out.println("sPOOrderNumber:"+sPOOrderNumber);
  
  String p_OperType = WtcUtil.repNull(request.getParameter("p_OperType"));
%>

<div id="form">
	<input type="hidden" id="p_OperType" value="<%=p_OperType%>">
	<table width="100%" border="0" cellpadding="0" cellspacing="0">
		<form id="bug_form" method="post" action="">
	      <tr>
	      	<th width="10%" nowrap>选择</th>
	        <th width="20%" nowrap>资费策略编码</th>
	        <th width="70%" nowrap>资费策略名称</th>		        
	      </tr>
        <tbody>
<wtc:service name="s9102DetQry" outnum="14" routerKey="region" routerValue="<%=regionCode%>">			
	<wtc:param value="<%=sPOOrderNumber%>"/>	
	<wtc:param value="<%=sPOSpecNumber%>"/>
  <wtc:param value="1"/>
</wtc:service>
<wtc:array id="result" start="2" length="12" scope="end" />
<%
if(retCode.equals("000000")){
	if(result.length>0){
		for(int i=0;i<result.length;i++){	
			System.out.println("-----="+result[i][6]);
%>
  			  <tr class="pospecratepolicy_contenttr"
  			  	 a_POSpecRatePolicyID = "<%=result[i][4]%>"
  			  	 a_Name               = "<%=result[i][5]%>"
  			  	 a_POOrderNumber      = "<%=sPOOrderNumber%>"
  			  	 a_POSpecNumber	      = "<%=sPOSpecNumber%>"  			     
  			  	 a_OperType           = "OLD"  
  			  	 a_RatePlansListCheck = "0"  
  			  	 a_AcceptID           = "<%=result[i][6]%>"  			  	  			  	  			  	  			  	  			  	  			  	  			  	  			  	  			  	  			  	
  			  >	
  			 
  			    <td classes="grey"><input type="checkbox" name="DeleteCheckBox2" value="0">
					  </td>			
					  <td>
					  <a class="p_POSpecRatePolicyID" style="cursor: hand;"><%=result[i][4]%></a>						  	
					  </td>
					  <td class="p_Name"><%=result[i][5]%>
					  </td>
	        </tr>
<%
    }
  }
}
%>
          <tr id="pospecratepolicy_buttontr">
	        	<th colspan="5" align="center">
	        		<input type="button" class="b_text" id="POSpecRatePolicyAdd" value="新增">
	        		&nbsp;      
	        		<input type="button" class="b_text" id="POSpecRatePolicyDel" value="删除">      
	          </th>
	        </tr>
	      </tbody>
		</form>
	</table>
</div>
<script>
//隐藏滚动条
$("#wait2").hide();
	 //更新函数
	function POSpecRatePolicyUpdate(){	
			
    var CheckTR = $(this).parent().parent();
	 	var  POSpecRatePolicy=[
	 	  	        $(CheckTR).attr("a_POSpecRatePolicyID"),//0套餐ID
	 	  	        $(CheckTR).attr("a_Name"),              //1套餐内容
	 	  	        '<%=sPOOrderNumber%>',                  //2商品订单号
	 	  	        '<%=sPOSpecNumber%>',                   //3商品规格编号
	 	  	        $(CheckTR).data("a_RatePlansList"),     //4列表数组
	 	  	        $(CheckTR).attr("a_OperType"),          //5是否新增
	 	  	        $("#hiddendate_delete"),                //6主页面缓冲区
	 	  	        $(CheckTR).attr("a_RatePlansListCheck"),//7点击标识
	 	  	        $(CheckTR).attr("a_AcceptID")           ,//8
	 	  	        '<%=p_OperType%>' ,                       //9 操作类型 wuxy alter
	 	  	        '1'
	 	  	        ];
	  var retInfo = window.showModalDialog
	  (
	  'f2029_POSpecRatePolicy_detail.jsp',
	  POSpecRatePolicy,
	  'dialogHeight:500px; dialogWidth:700px;scrollbars:yes;resizable:no;location:no;status:no'
	  );
    if(retInfo){
   	$(CheckTR).attr("a_RatePlansListCheck"       , POSpecRatePolicy[7] );   //7点击标识
    }      
    $(CheckTR).data("a_RatePlansList",POSpecRatePolicy[4]);
    $('.p_POSpecRatePolicyID',CheckTR).text(POSpecRatePolicy[0]);
    $('.p_Name',CheckTR).text(POSpecRatePolicy[1]);    
       
	  return true;
	}
		 //新增函数
	 function POSpecRatePolicyAdd(){
	 	  var pospecnumber='<%=sPOSpecNumber%>';
	 	  if(pospecnumber=="")
	 	  {
	 	  	rdShowMessageDialog("请选择一个商品规格"); 
       	     return;
	 	 }
	 	  
	 	  var POSpecRatePolicy=[
	 	            "",	 	                                  //0套餐ID      
	 	            "",                                     //1套餐内容    
	 	            '<%=sPOOrderNumber%>',                  //2商品订单号  
	 	            '<%=sPOSpecNumber%>',                   //3商品规格编号
	 	            "",                                     //4列表数组
	 	            "NEW",                                  //5是否新增
	 	            $("#hiddendate_delete"),                //6主页面缓冲区
	 	            "0",	 	                                //7点击标识
	 	            "0"  ,                                   //8
	 	            '<%=p_OperType%>' ,                       //9 操作类型 wuxy alter
	 	  	        '2'
	 	         ];
	    var retInfo = window.showModalDialog
	    (
	    "f2029_POSpecRatePolicy_detail.jsp",
	    POSpecRatePolicy,
	    'dialogHeight:550px; dialogWidth:750px;scrollbars:yes;resizable:no;location:no;status:no'
	    );
	    //yuanqs add 2011-3-15 17:07:03 限制资费策略编码不能重复 begin
	    var count = $(".pospecratepolicy_contenttr").size();
		if (count > 0)
		{
			for (var i=0; i<count; i++)
			{
				if ( POSpecRatePolicy[0] == $($(".pospecratepolicy_contenttr").get(i)).attr("a_POSpecRatePolicyID") )
				{
					rdShowMessageDialog("资费策略编码不能重复!");
			  		return;
				}
			}
			
		}
		//yuanqs add 2011-3-15 17:07:38 end
      //点关闭按钮不新增
	    if(retInfo)
	    {
	       var newtrstr =
	            "<tr class=\"pospecratepolicy_contenttr\" "+
  			  	  " a_POSpecRatePolicyID='"+POSpecRatePolicy[0] +"'"+
  			  	  " a_Name              ='"+POSpecRatePolicy[1] +"'"+
  			  	  " a_POOrderNumber     ='"+POSpecRatePolicy[2] +"'"+
  			  	  " a_POSpecNumber      ='"+POSpecRatePolicy[3] +"'"+
  			  	  " a_OperType          ='"+POSpecRatePolicy[5] +"'"+
  			  	  " a_RatePlansListCheck='"+POSpecRatePolicy[7] +"'"+
  			  	  " a_AcceptID='"          +POSpecRatePolicy[8] +"'"+
  			  	  ">"+
						  "<td classes=\"grey\"><input type=\"checkbox\" name=\"DeleteCheckBox2\">"+
					    "</td>"+
				      "<td><a class=\"p_POSpecRatePolicyID\" style=\"cursor: hand;\">"+POSpecRatePolicy[0]+"</a>"+
					    "</td>"+
					    "<td class=p_Name>"+POSpecRatePolicy[1]+
					    "&nbsp</td>"+					    
	            "</tr>";
	       $("#pospecratepolicy_buttontr").before(newtrstr);
	       //为新增行赋数组属性
	       $(".pospecratepolicy_contenttr:last").data("a_RatePlansList",POSpecRatePolicy[4]);
	       //注册更新函数
	       $('.p_POSpecRatePolicyID').bind('click', POSpecRatePolicyUpdate);	       
	 	  }
	 }

	 //删除函数
   function POSpecRatePolicyDel(){
   	 
      $("input[@name='DeleteCheckBox2']").each(function()
      {
      var checkTR = $(this.parentNode.parentNode);
      if($(this).attr("checked")){
      	  if($(checkTR).attr("a_OperType")=="OLD")//如果是数据库中取出的数据，添加到删除缓冲区
      	  {
      	  	  var i  = $("DIV.PospecratePolicy","#hiddendate_delete").size();
      	  		var deletedate=
      	  		"<DIV class='PospecratePolicy' style='display:none'>"+
      	  		"<input type='text' name='tableid_POS"+i+"'              value='1'>" +                                         //
      	  		"<input type='text' name='d_POSpecRatePolicyID_POS"+i+"' value='"+$(checkTR).attr("a_POSpecRatePolicyID")+"'>"+//0 套餐ID           
      	  		"<input type='text' name='d_Name_POS"+i+"'               value='"+$(checkTR).attr("a_Name")+"'>"+              //1 套餐内容         
      	  		"<input type='text' name='d_POOrderNumber_POS"+i+"'      value='"+$(checkTR).attr("a_POOrderNumber")+"'>"+     //2 商品订单号  
      	  		"<input type='text' name='d_POSpecNumber_POS"+i+"'       value='"+$(checkTR).attr("a_POSpecNumber")+"'>"+      //3 商品规格编号
      	  		//"<input type='text' name='d_opertype_POS"+i+"'           value='N'>"+ 
      	  		"<input type='text' name='d_AcceptID_POS"+i+"'           value='"+$(checkTR).attr("a_AcceptID")+"'>"+  
              "</DIV>";
      	  		$("#hiddendate_delete").append(deletedate);  
      	  		
      	  }
       		checkTR.remove();
      }
      });
   }	 
$(document).ready(function(){
	 //注册更新函数
	 $('.p_POSpecRatePolicyID').bind('click', POSpecRatePolicyUpdate);
	 
	 //注册新增函数
	 $('#POSpecRatePolicyAdd').click(function(){
	     POSpecRatePolicyAdd();
	 });	 
	 //注册删除函数
	 $('#POSpecRatePolicyDel').click(function(){
	     POSpecRatePolicyDel();
	 });
	 
	 var p_OperType = "<%=p_OperType%>";
	 if(p_OperType=="1"){
	 	$("#pospecratepolicy_buttontr").hide();	
	 }
	 //rendi add for 选择查询和预销及开通时时按钮都不可见
	 if(p_OperType=="2"){
	 	$("#pospecratepolicy_buttontr").hide();	
	 }
	 if(p_OperType=="3"){
	 	$("#pospecratepolicy_buttontr").hide();	
	 }
});                            
</script>
