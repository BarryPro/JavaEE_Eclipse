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
  String sRatePlanID = request.getParameter("sRatePlanID");
  String sCheckFlag = request.getParameter("sCheckFlag");
  String sParAcceptID = request.getParameter("sParAcceptID"); 
  System.out.println("  sParAcceptID="+sParAcceptID);
  String p_OperType = WtcUtil.repNull(request.getParameter("p_OperType"));    //wuxy add                                                   
%>
<input type="hidden" id="p_POSpecNumber" value="<%=sPOSpecNumber%>">
<input type="hidden" id="p_POOrderNumber" value="<%=sPOOrderNumber%>">
<input type="hidden" id="p_POSpecRatePolicyID" value="<%=sPOSpecRatePolicyID%>">
<input type="hidden" id="p_RatePlanID" value="<%=sRatePlanID%>">
<input type="hidden" id="p_ParAcceptID" value="<%=sParAcceptID%>">
<div id="form">
	<table width="100%" border="0" cellpadding="0" cellspacing="0">
		<form id="bug_form" method="post" action="">
	      <tr>
	      	<th width="15%" nowrap>选择</th>
	        <th width="25%" nowrap>参数编码</th>
	        <th width="30%" nowrap>参数名</th>
	        <th width="30%" nowrap>参数值</th>
	      </tr>
        <tbody>
<wtc:service name="s9102DetQry" outnum="14" routerKey="region" routerValue="<%=regionCode%>">	
	<wtc:param value="<%=sPOOrderNumber%>"/>
	<wtc:param value="<%=sParAcceptID%>"/>
    <wtc:param value="3"/>  
    	<wtc:param value="<%=sRatePlanID%>"/>	
</wtc:service>
<wtc:array id="result" start="2" length="12" scope="end" />
<%
if(sCheckFlag.equals("0")){
   
	if(retCode.equals("000000")){
		if(result.length>0){
			for(int i=0;i<result.length;i++){			
%>
  			  <tr class="poicb_contenttr"
  			  	 a_ParameterNumber    = "<%=result[i][4]%>"
  			  	 a_ParameterName      = "<%=result[i][5]%>"
  			  	 a_ParameterValue     = "<%=result[i][6]%>"
  			  	 a_POSpecNumber       = "<%=sPOSpecNumber%>"
  			  	 a_POOrderNumber      = "<%=sPOOrderNumber%>"
  			  	 a_POSpecRatePolicyID = "<%=sPOSpecRatePolicyID%>"
  			  	 a_RatePlanID         = "<%=sRatePlanID%>"
  			  	 a_OperType           = "OLD" 
  			  	 a_ParAcceptID        = "<%=sParAcceptID%>"
  			  	 a_AcceptID           = "<%=result[i][7]%>" 			  	 
  			  >
  			    <td classes="grey"><input type="checkbox" name="DeleteCheckBox" value="0">  			    
					  </td>
					  <td><%=result[i][4]%>
					  &nbsp;</td>
					  <td class=p_ParameterName><%=result[i][5]%>
					  &nbsp;</td>
					  <td class=p_ParameterValue><%=result[i][6]%>
					 &nbsp; </td>
	        </tr>
<%
    	}
  	}
	}
}
%>
	        <tr id="poicb_buttontr">
	        	<th colspan="5" align="center">
	        		<input type="button" class="b_text" id="POICBAdd" value="新增">
	        		&nbsp;
	        		<input type="button" class="b_text" id="POICBDel" value="删除">
	          </th>
	        </tr>
	      </tbody>
		</form>
	</table>
</div>
<script>
//隐藏滚动条
$("#wait2").hide();

//新增函数
function POICBAdd(){
	
 	var  POICB=[
 	  	        '',                          //0
 	  	        '',                          //1
 	  	        '',                          //2
 	  	        '<%=sPOSpecNumber%>',        //3
 	  	        '<%=sPOOrderNumber%>',       //4
 	  	        '<%=sPOSpecRatePolicyID%>',  //5
 	  	        '<%=sRatePlanID%>',          //6
 	  	        'NEW',                       //7
 	  	        '<%=sParAcceptID%>',         //8
 	  	        '' ,                          //9
 	  	        '<%=p_OperType%>',           //10
 	  	        '2'
 	  	        ];
   var retInfo = window.showModalDialog
   (
   "f2029_POICB_detail.jsp",
   POICB,
   'dialogHeight:550px; dialogWidth:750px;scrollbars:yes;resizable:no;location:no;status:no'
   );
	//yuanqs add 2011-3-15 9:55:58 限制ICB值不能重复 begin
	var count = $(".poicb_contenttr").size();
	if (count > 0)
	{
		for (var i=0; i<count; i++)
		{
			if ( POICB[0] == $($(".poicb_contenttr").get(i)).attr("a_ParameterNumber") )
			{
				rdShowMessageDialog("ICB值不能重复!");
		  		return;
			}
		}
		
	}
	//yuanqs add 2011-3-15 10:41:17 end
   //点关闭按钮不新增
   if(retInfo)
   {
      var newtrstr =
          "<tr class=\"poicb_contenttr\" "+
		  	  " a_ParameterNumber='"       +POICB[0] +"'"+     //0 
		  	  " a_ParameterName='"         +POICB[1] +"'"+     //1 
		  	  " a_ParameterValue='"        +POICB[2] +"'"+     //2 
		  	  " a_POSpecNumber='"          +POICB[3] +"'"+     //3 
		  	  " a_POOrderNumber='"         +POICB[4] +"'"+     //4 
		  	  " a_POSpecRatePolicyID='"    +POICB[5] +"'"+     //5 
		  	  " a_RatePlanID='"            +POICB[6] +"'"+     //6 
		  	  " a_OperType='NEW'"+                             //7 
		  	  " a_ParAcceptID='"           +POICB[8] +"'"+     //8 
		  	  " a_AcceptID='"              +POICB[9] +"'"+     //9 
		  	  ">"+
				  "<td classes=\"grey\"><input type=\"checkbox\" name=\"DeleteCheckBox\">"+
			    "</td>"+
		      "<td><a class=\"p_ParameterNumber\" style=\"cursor: hand;\">"+POICB[0]+"</a>"+
			    "&nbsp</td>"+
			    "<td class=p_ParameterName>"+POICB[1]+
			    "&nbsp</td>"+
			    "<td class=p_ParameterValue>"+POICB[2]+
			    "&nbsp</td>"+
          "</tr>";
      $("#poicb_buttontr").before(newtrstr);
      //注册更新函数
      $('.p_ParameterNumber').bind('click', POICBUpdate);
	  }
}

//更新函数
function POICBUpdate(){
  var RatePlanUpdateTR = $(this).parent().parent();
 	var  POICB=[
 	  	        $(RatePlanUpdateTR).attr("a_ParameterNumber"), //0
 	  	        $(RatePlanUpdateTR).attr("a_ParameterName"),   //1
 	  	        $(RatePlanUpdateTR).attr("a_ParameterValue"),  //2
 	  	        '<%=sPOSpecNumber%>',                          //3
 	  	        '<%=sPOOrderNumber%>',                         //4
 	  	        '<%=sPOSpecRatePolicyID%>',                    //5
 	  	        '<%=sRatePlanID%>',                            //6
 	  	        $(RatePlanUpdateTR).attr("a_OperType"),        //7
 	  	        $(RatePlanUpdateTR).attr("a_ParAcceptID"),     //8
 	  	        $(RatePlanUpdateTR).attr("a_AcceptID") ,        //9
 	  	        '<%=p_OperType%>',                             //10
 	  	        '1'
 	  	        ];
  var retInfo = window.showModalDialog
  (
  'f2029_POICB_detail.jsp',
  POICB,
  'dialogHeight:500px; dialogWidth:700px;scrollbars:yes;resizable:no;location:no;status:no'
  );

  $(RatePlanUpdateTR).attr("a_ParameterNumber"   , POICB[0] );//
  $(RatePlanUpdateTR).attr("a_ParameterName"     , POICB[1] );//
  $(RatePlanUpdateTR).attr("a_ParameterValue"    , POICB[2] );//
  $(RatePlanUpdateTR).attr("a_POSpecNumber"      , POICB[3] );//
  $(RatePlanUpdateTR).attr("a_POOrderNumber"     , POICB[4] );//
  $(RatePlanUpdateTR).attr("a_POSpecRatePolicyID", POICB[5] );//
  $(RatePlanUpdateTR).attr("a_RatePlanID"        , POICB[6] );//
  $(RatePlanUpdateTR).attr("a_OperType"          , POICB[7] );// 
  $(RatePlanUpdateTR).attr("a_ParAcceptID"       , POICB[8] );
  $(RatePlanUpdateTR).attr("a_AcceptID"          , POICB[9] );

  $('.p_ParameterNumber',RatePlanUpdateTR).text(POICB[0]);
  $('.p_ParameterName',RatePlanUpdateTR).text(POICB[1]);
  $('.p_ParameterValue',RatePlanUpdateTR).text(POICB[2]);

  return true;
}


//删除函数
function POICBDel(){
   $("input[@name='DeleteCheckBox']").each(function()
   {
   var checkTR = $(this.parentNode.parentNode);
   if($(this).attr("checked")){
   	  if($(checkTR).attr("a_OperType")=="OLD")//如果是数据库中取出的数据，添加到删除缓冲区
   	  {
   	  	  var i  = $("DIV.POICBs",RatePlan[7]).size();
   	  		var deletedate=
   	  		"<DIV class='POICBs' style='display:none'>"+
   	  		"<input type='text' name='tableid_POICB"+i+"'              value='3'>" +
   	  		"<input type='text' name='d_ParameterNumber_POICB"+i+"'    value='"+$(checkTR).attr("a_ParameterNumber")+"'>"+
   	  		"<input type='text' name='d_ParameterName_POICB"+i+"'      value='"+$(checkTR).attr("a_ParameterName")+"'>"+
   	  		"<input type='text' name='d_ParameterValue_POICB"+i+"'     value='"+$(checkTR).attr("a_ParameterValue")+"'>"+
   	  		"<input type='text' name='d_POSpecNumber_POICB"+i+"'       value='"+$(checkTR).attr("a_POSpecNumber")+"'>"+
   	  		"<input type='text' name='d_POOrderNumber_POICB"+i+"'      value='"+$(checkTR).attr("a_POOrderNumber")+"'>"+
          "<input type='text' name='d_POSpecRatePolicyID_POICB"+i+"' value='"+$(checkTR).attr("a_POSpecRatePolicyID")+"'>"+
          "<input type='text' name='d_RatePlanID_POICB"+i+"'         value='"+$(checkTR).attr("a_RatePlanID")+"'>"+
   	  		"<input type='text' name='d_optype_POICB"+i+"'             value='"+$(checkTR).attr("a_OperType")+"'>"+
   	  		"<input type='text' name='d_ParAcceptID_POICB"+i+"'        value='"+$(checkTR).attr("a_ParAcceptID")+"'>"+
   	  		"<input type='text' name='d_AcceptID_POICB"+i+"'           value='"+$(checkTR).attr("a_AcceptID")+"'>"+
           "</DIV>";
   	  		$(RatePlan[7]).append(deletedate);

   	  }
    	checkTR.remove();
   }
   });
}

$(document).ready(function(){
	 //注册新增函数
	 $('#POICBAdd').click(function(){
	     POICBAdd();
	 });
	 //注册更新函数
	 $('.p_ParameterNumber').bind('click', POICBUpdate);
	 //注册删除函数
	 $('#POICBDel').click(function(){
	     POICBDel();
	 });
	 
	 if(RatePlan[8]=="1"){
	 		var POICBArrayList = RatePlan[6];
	 		if(POICBArrayList){	 			
	 		  $.each(POICBArrayList, function(i){	 		  	
  	       var POICB = POICBArrayList[i];//行数据数组,传递给详细信息页面
  	        var newtrstr =
  	        "<tr"+
  	        " class=\"poicb_contenttr\""+
  	        " a_ParameterNumber=" +  "'"+POICB[0]+"'"+
  	        " a_ParameterName=" +    "'"+POICB[1]+"'"+
  	        " a_ParameterValue="+    "'"+POICB[2]+"'"+
  	        " a_POSpecNumber="  +    "'"+POICB[3]+"'"+
  	        " a_POOrderNumber=" +    "'"+POICB[4]+"'"+
  	        " a_POSpecRatePolicyID="+"'"+POICB[5]+"'"+
  	        " a_RatePlanID="+        "'"+POICB[6]+"'"+
  	        " a_OperType="+          "'"+POICB[7]+"'"+
  	        " a_ParAcceptID="+       "'"+POICB[8]+"'"+
  	        " a_AcceptID="+          "'"+POICB[9]+"'"+
  	        ">"+
  	        "<td classes=\"grey\">"+
  	        "<input type=\"Checkbox\" name=\"DeleteCheckBox\">"+
  	        "</td>"+
  	        "<td>"+
  	        "<a class=\"p_ParameterNumber\" style=\"cursor: hand;\">"+POICB[0]+
  	        "</a>"+
  	        "</td>"+
  	        "<td class=\"p_ParameterName\">"+POICB[1]+
  	        "</td>"+
  	        "<td class=\"p_ParameterValue\">"+POICB[2]+
  	        "</td>"+
  	        "</tr>";
            $("#poicb_buttontr").before(newtrstr);  
            //注册更新函数
            $('.p_ParameterNumber').bind('click', POICBUpdate);         
	 		  });
	 		}
	 	}else{
	 			RatePlan[8]="1";	 		
	  }
	  
	  //wuxy add
	 var p_OperType = "<%=p_OperType%>";
	 if(p_OperType=="1"){
	 	$("#poicb_buttontr").hide();	
	 } 
	  
	  
});
</script>
