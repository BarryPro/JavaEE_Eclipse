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
  String sProductOrderNumber = request.getParameter("sProductOrderNumber");
  String sRatePlanID = request.getParameter("sRatePlanID");
  String sCheckFlag = request.getParameter("sCheckFlag");
  String sParAcceptID = request.getParameter("sParAcceptID");
  String busi_req_type = request.getParameter("busi_req_type");
	String a_OperType = request.getParameter("a_OperType");
	System.out.println("====liujian====sRatePlanID="+sRatePlanID);
  System.out.println("====wanghfa====sCheckFlag="+sCheckFlag);
  System.out.println("====wanghfa====sParAcceptID="+sParAcceptID);
  System.out.println("====wanghfa====sProductOrderNumber="+sProductOrderNumber);
  System.out.println("====wanghfa====busi_req_type="+busi_req_type);
  String sProductSpecNumber = request.getParameter("sProductSpecNumber");
  String p_OperType = WtcUtil.repNull(request.getParameter("p_OperType"));    //wuxy add  
   String product_OperType = WtcUtil.repNull(request.getParameter("product_OperType"));  //lusc add
   String is_add = WtcUtil.repNull(request.getParameter("is_add"));  //lusc add
  String in_ChanceId = WtcUtil.repNull((String)request.getParameter("in_ChanceId"));
%>

<div id="form">

	<table width="100%" border="0" cellpadding="0" cellspacing="0">
		<form id="bug_form" method="post" action="">
	      <tr>
	      	<th width="10%" nowrap>请选择</th>
	        <th width="20%" nowrap>参数编码</th>
	        <th width="20%" nowrap>参数名</th>
	        <th width="50%" nowrap>参数值</th>
	      </tr>
        <tbody>
<wtc:service name="s9102DetQry" outnum="14" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:param value="<%=sParAcceptID%>"/>
	<wtc:param value="<%=sProductOrderNumber%>"/>	
  	<wtc:param value="5"/>
	<%
	if (("01".equals(busi_req_type) || "02".equals(busi_req_type)||"06".equals(busi_req_type)||"03".equals(busi_req_type)) && !"6".equals(p_OperType)) {
		%>
	  <wtc:param value="<%=in_ChanceId%>"/>
	  <wtc:param value="<%=sRatePlanID%>"/>
		<%
	}
	%>
</wtc:service>
<wtc:array id="result" start="2" length="12" scope="end" />
<%
if(sCheckFlag.equals("0")){
  if(retCode.equals("000000")){
  	if(result.length>0){
  		for(int i=0;i<result.length;i++){  		
%>
  		  <tr class="poicb_contenttr1"
  		  	 a_ParameterNumber    = "<%=result[i][4]%>"
  		  	 a_ParameterName      = "<%=result[i][5]%>"
  		  	 a_ParameterValue     = "<%=result[i][6]%>"
  		  	 a_POSpecNumber       = "<%=sPOSpecNumber%>"
  		  	 a_POOrderNumber      = "<%=sPOOrderNumber%>"
  		  	 a_ProductOrderNumber = "<%=sProductOrderNumber%>"
  		  	 a_RatePlanID         = "<%=sRatePlanID%>"
  		  	 a_OperType           = "<%=a_OperType%>"
  		  	 a_ProductSpecNumber  = "<%=sProductSpecNumber%>"
  		  	 a_ParAcceptID        = "<%=sParAcceptID%>"
  		  	 a_AcceptID           = "<%=result[i][7]%>"
  		  >
  		    <td classes="grey"><input type="checkbox" name="DeleteCheckBox" value="0">
				  </td>					  	
				  <td>
				  <a class="p_ParameterNumber" style="cursor: hand;"><%=result[i][4]%></a>
				  &nbsp;</td>
				  <td class=p_ParameterName><%=result[i][5]%>
				  &nbsp;</td>
				  <td class=p_ParameterValue><%=result[i][6]%>
				  &nbsp;</td>
	       </tr>
<%
      }
    }
  }
}
%>
	        <tr id="buttontrcode">
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
//更新函数
function POICBUpdate(){
  var POICBUpdateTR = $(this).parent().parent();
 	var  POICB=[
 	  	        $(POICBUpdateTR).attr("a_ParameterNumber")  ,
 	  	        $(POICBUpdateTR).attr("a_ParameterName")    ,
 	  	        $(POICBUpdateTR).attr("a_ParameterValue")   ,
 	  	        '<%=sPOSpecNumber%>'                        ,
 	  	        '<%=sPOOrderNumber%>'                       ,
 	  	        '<%=sProductOrderNumber%>'                  ,
 	  	        '<%=sRatePlanID%>'                          ,
 	  	        $(POICBUpdateTR).attr("a_OperType")         ,
 	  	        $(POICBUpdateTR).attr("a_ProductSpecNumber"),
 	  	        $(POICBUpdateTR).attr("a_ParAcceptID")      ,
 	  	        $(POICBUpdateTR).attr("a_AcceptID") ,         //10
 	  	        '<%=p_OperType%>',                            //11
 	  	        '1'                                           //12
 	  	        ];
 	  	        
 	  	        

  var retInfo = window.showModalDialog
  (
  'f2029_ProductOrderICB_detail.jsp',
  POICB,
  'dialogHeight:500px; dialogWidth:700px;scrollbars:yes;resizable:no;location:no;status:no'
  );
  $(POICBUpdateTR).attr("a_ParameterNumber"   ,POICB[0] );
  $(POICBUpdateTR).attr("a_ParameterName"     ,POICB[1] );
  $(POICBUpdateTR).attr("a_ParameterValue"    ,POICB[2] );
  $(POICBUpdateTR).attr("a_POSpecNumber"      ,POICB[3] );
  $(POICBUpdateTR).attr("a_POOrderNumber"     ,POICB[4] );
  $(POICBUpdateTR).attr("a_ProductOrderNumber",POICB[5] );
  $(POICBUpdateTR).attr("a_RatePlanID"        ,POICB[6] );
  $(POICBUpdateTR).attr("a_OperType"          ,POICB[7] ); 
  $(POICBUpdateTR).attr("a_ProductSpecNumber" ,POICB[8] );
  $(POICBUpdateTR).attr("a_ParAcceptID"       ,POICB[9] );
  $(POICBUpdateTR).attr("a_AcceptID"          ,POICB[10]);
  
  
   
  $('.p_ParameterNumber' ,POICBUpdateTR).text(POICB[0]);                 
  $('.p_ParameterName',POICBUpdateTR).text(POICB[1]);   
  $('.p_ParameterValue',POICBUpdateTR).text(POICB[2]); 
    
  return true;
}
//新增函数                                                                                    
function POICBAdd(){                                                                 
	var POICB=[ 
	            "",                        //0
	  	        "",                        //1
	  	        "",                        //2
	  	        '<%=sPOSpecNumber%>',     //3
	  	        '<%=sPOOrderNumber%>',      //4
	  	        '<%=sProductOrderNumber%>',//5
	  	        '<%=sRatePlanID%>',        //6
	  	        "NEW",                     //7
	  	        "<%=sProductSpecNumber%>", //8
	  	        '<%=sParAcceptID%>',       //9
	  	        ""    ,                     //10
	  	        '<%=p_OperType%>',                            //11
 	  	        '2'                                           //12	  	        
	  	        ];                                        
   var retInfo = window.showModalDialog                                                         
   (                                                                                            
   "f2029_ProductOrderICB_detail.jsp",                                                                 
   POICB,                                                                                    
   'dialogHeight:550px; dialogWidth:750px;scrollbars:yes;resizable:no;location:no;status:no'    
   );          
	//yuanqs add 2011-3-15 17:19:46 限制ICB值不能重复 begin
	var count = $(".poicb_contenttr1").size();
	if (count > 0)
	{
		for (var i=0; i<count; i++)
		{
			if ( POICB[0] == $($(".poicb_contenttr1").get(i)).attr("a_ParameterNumber") )
			{
				rdShowMessageDialog("ICB值不能重复!");
		  		return;
			}
		}
		
	}
	//yuanqs add 2011-3-15 17:20:05 end                                                                                                                
   if(retInfo)                                                                                  
   {
   	 
      var newtrstr =                                                                            
           "<tr class=\"poicb_contenttr1\" "+                                                
		  	  " a_ParameterNumber='"           +POICB[0] +"'"+                                    
		  	  " a_ParameterName='"             +POICB[1] +"'"+
		  	  " a_ParameterValue='"            +POICB[2] +"'"+ 
		  	  " a_POSpecNumber='"              +POICB[3] +"'"+ 
		  	  " a_POOrderNumber='"             +POICB[4] +"'"+
		  	  " a_ProductOrderNumber='"        +POICB[5] +"'"+  
		  	  " a_RatePlanID='"                +POICB[6] +"'"+ 
		  	  " a_OperType='"                  +POICB[7] +"'"+
		  	  " a_ProductSpecNumber='"         +POICB[8] +"'"+
					" a_ParAcceptID='"               +POICB[9] +"'"+
					" a_AcceptID='"                  +POICB[10]+"'"+
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
      $("#buttontrcode").before(newtrstr);                                                                                   
      //注册更新函数                                                                            
      $('.a_ParameterNumber').bind('click', POICBUpdate);	                               
	  }
}

//删除函数
function POICBDel(){
   $("input[@name='DeleteCheckBox']").each(function()
   {
   var checkTR = $(this.parentNode.parentNode);
   if($(this).attr("checked")){
   	  if($(checkTR).attr("a_OperType")=="OLD")//如果是数据库中取出的数据，添加到删除缓冲区
   	  { 	  	 
   	  	  var i  = $("DIV.ProductOrderPOICB","#hiddendate_delete").size();
   	  		var deletedate=
   	  		    "<DIV class='ProductOrderPOICB' style='display:none'>"+
   	  		    "<input type='text' name='tableid_PrdOrdPOICB"+i              +"'value='5'>" +
   	  		    "<input type='text' name='d_ParameterNumber_PrdOrdPOICB"+i    +"'value='"+$(checkTR).attr("a_ParameterNumber")+"'>"+                          
   	  		    "<input type='text' name='d_ParameterName_PrdOrdPOICB"+i      +"'value='"+$(checkTR).attr("a_ParameterName")+"'>"+            
   	  		    "<input type='text' name='d_ParameterValue_PrdOrdPOICB"+i     +"'value='"+$(checkTR).attr("a_ParameterValue")+"'>"+
   	  		    "<input type='text' name='d_POSpecNumber_PrdOrdPOICB"+i       +"'value='"+$(checkTR).attr("a_POSpecNumber")+"'>"+
   	  		    "<input type='text' name='d_POOrderNumber_PrdOrdPOICB"+i      +"'value='"+$(checkTR).attr("a_POOrderNumber")+"'>"+
   	  		    "<input type='text' name='d_ProductOrderNumber_PrdOrdPOICB"+i +"'value='"+$(checkTR).attr("a_ProductOrderNumber")+"'>"+
   	  		    "<input type='text' name='d_RatePlanID_PrdOrdPOICB"+i         +"'value='"+$(checkTR).attr("a_RatePlanID")+"'>"+
   	  		    "<input type='text' name='d_ProductSpecNumber_PrdOrdPOICB"+i  +"'value='"+$(checkTR).attr("a_ProductSpecNumber")+"'>"+
   	  		    "<input type='text' name='d_ParAcceptID_PrdOrdPOICB"+i        +"'value='"+$(checkTR).attr("a_ParAcceptID")+"'>"+
   	  		    "<input type='text' name='d_AcceptID_PrdOrdPOICB"+i           +"'value='"+$(checkTR).attr("a_AcceptID")+"'>"+
   	  		    "</DIV>";   	  		    
   	  		RatePlan[7].append(deletedate);
   	  }
      checkTR.remove();
   }
   });
} 	
$(document).ready(function(){
   if(RatePlan[5]=="1"){
 
   		if(RatePlan[6]){
   			$.each(RatePlan[6], function(i){ 
   				 var POICB=RatePlan[6][i];
           var newtrstr =                                                                          
              "<tr class=\"poicb_contenttr1\" "+                                                  
		       	  " a_ParameterNumber='"           +POICB[0] +"'"+                                 
		       	  " a_ParameterName='"             +POICB[1] +"'"+                                 
		       	  " a_ParameterValue='"            +POICB[2] +"'"+                                 
		       	  " a_POSpecNumber='"              +POICB[3] +"'"+                                 
		       	  " a_POOrderNumber='"             +POICB[4] +"'"+                                 
		       	  " a_ProductOrderNumber='"        +POICB[5] +"'"+                                 
		       	  " a_RatePlanID='"                +POICB[6] +"'"+                                 
		       	  " a_OperType='"                  +POICB[7] +"'"+	
		       	  " a_ProductSpecNumber='"         +POICB[8] +"'"+	
		       	  " a_ParAcceptID='"               +POICB[9] +"'"+	
		       	  " a_AcceptID='"                  +POICB[10]+"'"+	  	                                                            
		       	  ">"+                                                                                
			     	  "<td classes=\"grey\"><input type=\"checkbox\" name=\"DeleteCheckBox\">"+           
			        "</td>"+                                                                            
		          "<td><a class=\"p_ParameterNumber\" style=\"cursor: hand;\">"+POICB[0]+"</a>"+   
			        "</td>"+                                                                            
			        "<td class=p_ParameterName>"+POICB[1]+                                           
			        "</td>"+	                                                                          
			        "<td class=p_ParameterValue>"+POICB[2]+                                          
			        "</td>"+			    				    					                                            
              "</tr>";                                                               
           $("#buttontrcode").before(newtrstr);
           //注册更新函数                                     
	         //$('.p_ParameterNumber').bind('click', POICBUpdate);
                                       		  	
   		  });    		    		
   		}    		    		    		    		    		
   }else{
   		RatePlan[5]="1";
   }   
	 //注册更新函数
	 //$('.p_ParameterNumber').bind('click', POICBUpdate);

	 //注册新增函数
	 $('#POICBAdd').click(function(){
	     POICBAdd();
	 });	 
	 //注册删除函数
	 $('#POICBDel').click(function(){
	     POICBDel();
	 });
	 
	 //wuxy add
	 var p_OperType = "<%=p_OperType%>";
	 if(p_OperType=="1"){
	 	$("#buttontrcode").hide();	
	 } 	
	 //lusc add 
	 var product_OperType="<%=product_OperType%>";
	 if(p_OperType=="4"){
	 	if(product_OperType.match("5")==null)
	 		$("#buttontrcode").hide();	
	 } 	var is_add="<%=is_add%>";
	 if(is_add=="1")
	 $("#buttontrcode").show();	
 	 
});
</script>














