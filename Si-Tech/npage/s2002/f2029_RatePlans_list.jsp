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
  String sPOOrderNumber = request.getParameter("sPOOrderNumber");
  String sPOSpecRatePolicyID = request.getParameter("sPOSpecRatePolicyID");
  String sCheckFlag = request.getParameter("sCheckFlag");
  String sParAcceptID = request.getParameter("sParAcceptID"); 
  System.out.println("sParAcceptID="+sParAcceptID); 
  String p_OperType = WtcUtil.repNull(request.getParameter("p_OperType"));
%>

<div id="form">
	<table width="100%" border="0" cellpadding="0" cellspacing="0">
		<form id="bug_form" method="post" action="">
	      <tr>
	        <th width="15%" nowrap>选择</th>
	        <th width="25%" nowrap>资费计划标识</th>
	        <th width="60%" nowrap>资费描述</th>
	      </tr>
        <tbody>
<%if(sCheckFlag.equals("0"))
{
%>
<wtc:service name="s9102DetQry" outnum="14" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:param value="<%=sParAcceptID%>"/>
	<wtc:param value="<%=sPOOrderNumber%>"/>
  <wtc:param value="2"/>
</wtc:service>
<wtc:array id="result" start="2" length="12" scope="end" />
<%
if(retCode.equals("000000")){
	if(result.length>0){	  
		for(int i=0;i<result.length;i++){		
%>
  			  <tr class="RatePlans_contenttr"
  			  	 a_RatePlanID         = "<%=result[i][4]%>"
  			  	 a_Description        = "<%=result[i][5]%>"
  			  	 a_POOrderNumber      = "<%=sPOOrderNumber%>"
             a_POSpecNumber       = "<%=sPOSpecNumber%>"
             a_POSpecRatePolicyID = "<%=sPOSpecRatePolicyID%>"
             a_OperType           = "OLD"
             a_POICBListCheck     = "0"
             a_ParAcceptID        = "<%=sParAcceptID%>"
             a_AcceptID           = "<%=result[i][6]%>"
  			  >
  			    <td classes="grey"><input type="checkbox" name="DeleteCheckBox" value="0">
					  </td>
					  <td>
					  <a class="p_RatePlanID" style="cursor: hand;"><%=result[i][4]%></a>
					  </td>
					  <td class=p_Description><%=result[i][5]%>
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
    var RatePlanUpdateTR = $(this).parent().parent();
	 	var RatePlanUpdate=[
	 	  	        $(RatePlanUpdateTR).attr("a_RatePlanID"),    //0
	 	  	        $(RatePlanUpdateTR).attr("a_Description"),   //1
	 	  	        '<%=sPOOrderNumber%>',                       //2
	 	  	        '<%=sPOSpecNumber %>',                       //3
	 	  	        '<%=sPOSpecRatePolicyID%>',                  //4
	 	  	        $(RatePlanUpdateTR).attr("a_OperType"),      //5操作类型
	 	  	        $(RatePlanUpdateTR).data("a_POICBList"),     //6数组列表
	 	  	        POSpecRatePolicy[6],                         //7缓冲区
	 	  	        $(RatePlanUpdateTR).attr("a_POICBListCheck"),//8点击标识
	 	  	        $(RatePlanUpdateTR).attr("a_ParAcceptID")   ,//9
	 	  	        $(RatePlanUpdateTR).attr("a_AcceptID")      , //10
	 	  	        '<%=p_OperType%>'  ,                          //11 wuxy alter 
	 	  	        '1'
	 	  	        ];
	  var retInfo = window.showModalDialog
	  (
	  'f2029_RatePlan_detail.jsp',
	  RatePlanUpdate,
	  'dialogHeight:500px; dialogWidth:700px;scrollbars:yes;resizable:no;location:no;status:no'
	  );
	  $(RatePlanUpdateTR).attr("a_RatePlanID"              , RatePlanUpdate[0] );   //0
    $(RatePlanUpdateTR).attr("a_Description"             , RatePlanUpdate[1] );   //1
    $(RatePlanUpdateTR).attr("a_POOrderNumber_RatePlans" , RatePlanUpdate[2] );   //2
    $(RatePlanUpdateTR).attr("a_POSpecNumber_RatePlans"  , RatePlanUpdate[3] );   //3
    $(RatePlanUpdateTR).attr("a_POSpecRatePolicyID"      , RatePlanUpdate[4] );   //4
    $(RatePlanUpdateTR).attr("a_OperType"                , RatePlanUpdate[5] );   //5
    $(RatePlanUpdateTR).data("a_POICBList"               , RatePlanUpdate[6] );   //6 
    $(RatePlanUpdateTR).attr("a_ParAcceptID"             , RatePlanUpdate[9] );   //6 
    $(RatePlanUpdateTR).attr("a_AcceptID"                , RatePlanUpdate[10] );   //6 
    if(retInfo){    
      $(RatePlanUpdateTR).attr("a_POICBListCheck", RatePlanUpdate[8] );   //8
    } 
    $('.p_RatePlanID',RatePlanUpdateTR).text(RatePlanUpdate[0]);
	  $('.p_Description',RatePlanUpdateTR).text(RatePlanUpdate[1]);
	  return true;
	}   
      
		 //新增函数
	 function POSpecRatePolicyAdd(){
	 	
	 	  var ratepolicy='<%=sPOSpecRatePolicyID%>';
	 	  
	 	  var RatePlan=[
	 	            "",	 	                                  //0套餐ID
	 	            "",                                     //1套餐内容
	 	            '<%=sPOOrderNumber%>',                  //2商品订单号
	 	            '<%=sPOSpecNumber%>',                   //3商品规格编号
	 	            '<%=sPOSpecRatePolicyID%>',             //4列表数组
	 	            "",                                     //5操作类型
	 	            "",                                     //6数组列表
	 	            "",                                     //7主页面缓冲区
	 	            "0",  	 	                              //8点击标识
	 	            '<%=sParAcceptID%>',                    //9
	 	            "0"  ,                                   //10
	 	            '<%=p_OperType%>'  ,                          //11 wuxy alter 
	 	            '2'
	 	         ];
	    var retInfo = window.showModalDialog
	    (
	    "f2029_RatePlan_detail.jsp",
	    RatePlan,
	    'dialogHeight:550px; dialogWidth:750px;scrollbars:yes;resizable:no;location:no;status:no'
	    );
		//yuanqs add 2011-3-15 10:50:39 商品级资费计划不能重复 begin
		var count = $(".RatePlans_contenttr").size();
		if (count > 0)
		{
			for (var i=0; i<count; i++)
			{
				if ( RatePlan[0] == $($(".RatePlans_contenttr").get(i)).attr("a_RatePlanID") )
				{
					rdShowMessageDialog("商品级资费计划不能重复!");
			  		return;
				}
			}
			
		}
		//yuanqs add 2011-3-15 10:50:55 end
      //点关闭按钮不新增
	    if(retInfo)
	    {
	       var newtrstr =
	            "<tr class=\"RatePlans_contenttr\" "+
  			  	  " a_RatePlanID='"              +RatePlan[0]  +"'"+
  			  	  " a_Description='"             +RatePlan[1]  +"'"+
  			  	  " a_POOrderNumber='"           +RatePlan[2]  +"'"+
  			  	  " a_POSpecNumber='"            +RatePlan[3]  +"'"+
  			  	  " a_POSpecRatePolicyID='"      +RatePlan[4]  +"'"+
  			  	  " a_OperType='"                +RatePlan[5]  +"'"+
  			  	  " a_POICBListCheck='"          +RatePlan[8]  +"'"+
  			  	  " a_ParAcceptID='"             +RatePlan[9]  +"'"+
  			  	  " a_AcceptID='"                +RatePlan[10] +"'"+
  			  	  ">"+
						  "<td classes=\"grey\"><input type=\"checkbox\" name=\"DeleteCheckBox\">"+
					    "</td>"+
				      "<td><a class=\"p_RatePlanID\" style=\"cursor: hand;\">"+RatePlan[0]+"</a>"+
					    "</td>"+
					    "<td class=a_Description>"+RatePlan[1]+
					    "</td>"+
	            "</tr>";
	       $("#buttontr").before(newtrstr);
	       //为新增行赋数组属性
	       $(".RatePlans_contenttr:last").data("a_POICBList",RatePlan[6]);
	       //注册更新函数
	       $('.p_RatePlanID').bind('click', POSpecRatePolicyUpdate);
	       //新增时标记点击标志为1
	       //RatePlan[]
	 	  }
	 }


	 //删除函数
   function POSpecRatePolicyDel(){
      $("input[@name='DeleteCheckBox']").each(function()
      {
      var checkTR = $(this.parentNode.parentNode);
      if($(this).attr("checked")){
      	  if($(checkTR).attr("a_OperType")=="OLD")//如果是数据库中取出的数据，添加到删除缓冲区
      	  {
      	  	  var i  = $("DIV.RatePlans","#hiddendate_delete").size();
      	  		var deletedate=
      	  		"<DIV class='RatePlans' style='display:none'>"+
      	  		"<input type='text' name='tableid_POSRP"+i+"'              value='2'>" +
      	  		"<input type='text' name='d_RatePlanID_POSRP"+i+"'         value='"+$(checkTR).attr("a_RatePlanID")+"'>"+
      	  		"<input type='text' name='d_Description_POSRP"+i+"'        value='"+$(checkTR).attr("a_Description")+"'>"+
      	  		"<input type='text' name='d_POOrderNumber_POSRP"+i+"'      value='"+$(checkTR).attr("a_POOrderNumber")+"'>"+
      	  		"<input type='text' name='d_POSpecNumber_POSRP"+i+"'       value='"+$(checkTR).attr("a_POSpecNumber")+"'>"+
      	  		"<input type='text' name='d_POSpecRatePolicyID_POSRP"+i+"' value='"+$(checkTR).attr("a_POSpecRatePolicyID")+"'>"+
      	  		//"<input type='text' name='opertype_POSRP"+i+"'             value='N'>"+
      	  		"<input type='text' name='d_ParAcceptID_POSRP"+i+"'        value='"+$(checkTR).attr("a_ParAcceptID")+"'>"+
      	  		"<input type='text' name='d_AcceptID_POSRP"+i+"'           value='"+$(checkTR).attr("a_AcceptID")+"'>"+
              "</DIV>";
      	  		$(POSpecRatePolicy[6]).append(deletedate);
      	  }
       		checkTR.remove();
      }
      });
   }

$(document).ready(function(){

	 //如果列表页面加载过，从数组中生成列表	 
	 if(POSpecRatePolicy[7]=="1"){
	 	  if(POSpecRatePolicy[4]){	 	  	
	 		  $.each(POSpecRatePolicy[4], function(i){
	 		  	var RatePlan = POSpecRatePolicy[4][i];//行数据数组,传递给详细信息页面	 		  	 
	   	  	 var newtrstr =
	   	  	 "<tr"+
	   	  	 " class=\"RatePlans_contenttr\""+
	   	  	 " a_RatePlanID="+        "'"+RatePlan[0]+"'"+
	   	  	 " a_Description="+       "'"+RatePlan[1]+"'"+
	   	  	 " a_POOrderNumber="+     "'"+RatePlan[2]+"'"+
	   	  	 " a_POSpecNumber="+      "'"+RatePlan[3]+"'"+
	   	  	 " a_POSpecRatePolicyID="+"'"+RatePlan[4]+"'"+
	   	  	 " a_OperType="          +"'"+RatePlan[5]+"'"+
	   	  	 " a_POICBListCheck="    +"'"+RatePlan[8]+"'"+
	   	  	 " a_ParAcceptID="       +"'"+RatePlan[9]+"'"+
	   	  	 " a_AcceptID="          +"'"+RatePlan[10]+"'"+
	   	  	 ">"+
	   	  	 "<td classes=\"grey\">"+
	   	  	 "<input type=\"Checkbox\" name=\"DeleteCheckBox\">"+
	   	  	 "</td>"+
	   	  	 "<td>"+
	   	  	 "<a class=\"p_RatePlanID\" style=\"cursor: hand;\">"+RatePlan[0]+
	   	  	 "</a>"+
	   	  	 "</td>"+
	   	  	 "<td class=\"a_Description\">"+RatePlan[1]+
	   	  	 "</td>"+
	   	  	 "</tr>";
	 		    $("#buttontr").before(newtrstr);
	 		    $(".RatePlans_contenttr:last").data("a_POICBList",RatePlan[6]);
	 		  });
	 	  }
	 }else{
	 		POSpecRatePolicy[7]="1";
	 }

	 //注册更新函数
	 $('.p_RatePlanID').bind('click', POSpecRatePolicyUpdate);

	 //注册新增函数
	 $('#POSpecRatePolicyAdd').click(function(){
	     POSpecRatePolicyAdd();
	 });
	 //注册删除函数
	 $('#POSpecRatePolicyDel').click(function(){
	     POSpecRatePolicyDel();
	 });
	 //wuxy add
	 var p_OperType = "<%=p_OperType%>";
	 if(p_OperType=="1"){
	 	$("#buttontr").hide();	
	 }

});
</script>
