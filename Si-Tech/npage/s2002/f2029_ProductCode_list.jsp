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
  System.out.println("sParAcceptID="+sParAcceptID);
  String sProductSpecNumber = request.getParameter("sProductSpecNumber");
  String p_OperType = WtcUtil.repNull(request.getParameter("p_OperType"));    //wuxy add  
   String product_OperType = WtcUtil.repNull(request.getParameter("product_OperType"));  //lusc add
  String is_add = WtcUtil.repNull(request.getParameter("is_add"));  //lusc add
  String countSql="select a.offer_id,a.offer_name,";
  countSql+="a.offer_comments,decode(b.product_status,'1','正常','2','取消','3','暂停','4','恢复','5','预销')";
  countSql+=" from product_offer a,dproductorderdet  b ,dgrpusermsg c ";
  countSql+=" where a.offer_id =c.product_code and b.id_no=c.id_no and b.Product_order_id="+sProductOrderNumber;
  
  
  String in_ChanceId = WtcUtil.repNull(request.getParameter("in_ChanceId"));  
  String in_BatchNo = WtcUtil.repNull(request.getParameter("in_BatchNo"));  
  String busi_req_type = WtcUtil.repNull(request.getParameter("busi_req_type"));  
  String in_productspec_number = WtcUtil.repNull(request.getParameter("in_productspec_number"));  
  if("05".equals(busi_req_type)){
      countSql = "SELECT A.OFFER_ID, A.OFFER_NAME, A.OFFER_COMMENTS, '' FROM PRODUCT_OFFER a , dbsalesadm.dmktchanceprodrel b WHERE a.offer_id = b.prodprcid  AND b.chance_id = '"+in_ChanceId+"' and batch_no = '"+in_BatchNo+"'";
  }
  
  System.out.println("countSql="+countSql);
  System.out.println("sRatePlanID="+sRatePlanID);
%>

<div id="form">

	<table width="100%" border="0" cellpadding="0" cellspacing="0">
		<form id="bug_form" method="post" action="">
	      <tr>
	      	<th width="10%" nowrap>请选择</th>
	        <th width="20%" nowrap>产品代码</th>
	        <th width="20%" nowrap>产品名称</th>
	        <th width="40%" nowrap>产品描述</th>
	        <th width="10%" nowrap>生效标志</th>
	      </tr>
        <tbody>
<wtc:pubselect name="sPubSelect" outnum="4" routerKey="region" routerValue="<%=regionCode%>">
		    <wtc:sql><%=countSql%></wtc:sql>
</wtc:pubselect>
<wtc:array id="result" scope="end"/>
<%
if(sCheckFlag.equals("0")){
  if(retCode.equals("000000")){
  	if(result.length>0){
  		for(int i=0;i<result.length;i++){  		
%>
  		  <tr class="ProductCode_contenttr"
  		  	 a_ProductCode		  = "<%=result[i][0]%>"
  		  	 a_ProductName        = "<%=result[i][1]%>"
  		  	 a_ProductValue       = "<%=result[i][2]%>"
  		  	 a_POSpecNumber       = "<%=sPOSpecNumber%>"
  		  	 a_POOrderNumber      = "<%=sPOOrderNumber%>"
  		  	 a_ProductOrderNumber = "<%=sProductOrderNumber%>"
  		  	 a_RatePlanID         = "<%=sRatePlanID%>"
  		  	 a_OperType           = "OLD"
  		  	 a_ProductSpecNumber  = "<%=sProductSpecNumber%>"
  		  	 a_ParAcceptID        = "<%=sParAcceptID%>"
  		  	 a_DealFlag           = "<%=result[i][3]%>"
  		  >
  		    <td classes="grey"><input type="checkbox" name="DeleteCheckBox" value="0">
				  </td>					  	
				  <td>
				  <a class="a_ProductCode" style="cursor: hand;"><%=result[i][0]%></a>
				  &nbsp;</td>
				  <td class=a_ProductName><%=result[i][1]%>
				  &nbsp;</td>
				  <td class=a_ProductValue><%=result[i][2]%>
				  &nbsp;</td>
				  <td class=a_DealFlag><%=result[i][3]%>
				  &nbsp;</td>
	       </tr>
<%
      }
    }
  }
}
%>
			<input type="hidden" value="" id="bargain" name="bargain" /> 
	        <tr id="buttontr">
	        	<th colspan="5" align="center">
	        		<input type="button" class="b_text" id="getProductCode" value="新增">
	        		&nbsp;
	        		<input type="button" class="b_text" id="PRODUCTDel" value="删除">
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
function PRODUCTUpdate(){
  var POCODEUpdateTR = $(this).parent().parent();
 	var  PRODUCTARR=[
 	  	        $(POCODEUpdateTR).attr("a_ProductCode")  ,
 	  	        $(POCODEUpdateTR).attr("a_ProductName")    ,
 	  	        $(POCODEUpdateTR).attr("a_ProductValue")   ,
 	  	        '<%=sPOSpecNumber%>'                        ,
 	  	        '<%=sPOOrderNumber%>'                       ,
 	  	        '<%=sProductOrderNumber%>'                  ,
 	  	        '<%=sRatePlanID%>'                          ,
 	  	        $(POCODEUpdateTR).attr("a_OperType")         ,
 	  	        $(POCODEUpdateTR).attr("a_ProductSpecNumber"),
 	  	        $(POCODEUpdateTR).attr("a_ParAcceptID")      ,
 	  	        $(POCODEUpdateTR).attr("a_DealFlag") ,         //10
 	  	        '<%=p_OperType%>',                            //11
 	  	        '1'                                           //12
 	  	        ];
 	  	        
 	  	        

 /* var retInfo = window.showModalDialog
  (
  'f2029_ProductCode_detail.jsp',
  PRODUCTARR,
  'dialogHeight:500px; dialogWidth:700px;scrollbars:yes;resizable:no;location:no;status:no'
  );
  */
  $(POCODEUpdateTR).attr("a_ProductCode"   ,PRODUCTARR[0] );
  $(POCODEUpdateTR).attr("a_ProductName"     ,PRODUCTARR[1] );
  $(POCODEUpdateTR).attr("a_ProductValue"    ,PRODUCTARR[2] );
  $(POCODEUpdateTR).attr("a_POSpecNumber"      ,PRODUCTARR[3] );
  $(POCODEUpdateTR).attr("a_POOrderNumber"     ,PRODUCTARR[4] );
  $(POCODEUpdateTR).attr("a_ProductOrderNumber",PRODUCTARR[5] );
  $(POCODEUpdateTR).attr("a_RatePlanID"        ,PRODUCTARR[6] );
  $(POCODEUpdateTR).attr("a_OperType"          ,PRODUCTARR[7] ); 
  $(POCODEUpdateTR).attr("a_ProductSpecNumber" ,PRODUCTARR[8] );
  $(POCODEUpdateTR).attr("a_ParAcceptID"       ,PRODUCTARR[9] );
  $(POCODEUpdateTR).attr("a_DealFlag"          ,PRODUCTARR[10]);
  alert(POCODEUpdateTR+"------rendi");
  
   
  $('.a_ProductCode' ,POCODEUpdateTR).text(PRODUCTARR[0]);                 
  $('.a_ProductName',POCODEUpdateTR).text(PRODUCTARR[1]);   
  $('.a_ProductValue',POCODEUpdateTR).text(PRODUCTARR[2]); 
    
  return true;
}
//删除函数
function PRODUCTDel(){
   $("input[@name='DeleteCheckBox']").each(function()
   {
   var checkTR = $(this.parentNode.parentNode);
   if($(this).attr("checked")){
   	  //if($(checkTR).attr("a_OperType")=="OLD")//如果是数据库中取出的数据，添加到删除缓冲区
   	  //{ 	  	 
   	  //	  var i  = $("DIV.ProductOrderPOICB","#hiddendate_delete").size();
   	  //		var deletedate=
   	  //		    "<DIV class='ProductCodeICB' style='display:none'>"+
   	  //		    "<input type='text' name='tableid_ProductCodeICB"+i              +"'value='5'>" +
   	  //		    "<input type='text' name='d_ProductCode_ProductCodeICB"+i    +"'value='"+$(checkTR).attr("a_ProductCode")+"'>"+                          
   	  //		    "<input type='text' name='d_ProductName_ProductCodeICB"+i      +"'value='"+$(checkTR).attr("a_ProductName")+"'>"+            
   	  //		    "<input type='text' name='d_ProductValue_ProductCodeICB"+i     +"'value='"+$(checkTR).attr("a_ProductValue")+"'>"+
   	  //		    "<input type='text' name='d_POSpecNumber_ProductCodeICB"+i       +"'value='"+$(checkTR).attr("a_POSpecNumber")+"'>"+
   	  //		    "<input type='text' name='d_POOrderNumber_ProductCodeICB"+i      +"'value='"+$(checkTR).attr("a_POOrderNumber")+"'>"+
   	  //		    "<input type='text' name='d_ProductOrderNumber_ProductCodeICB"+i +"'value='"+$(checkTR).attr("a_ProductOrderNumber")+"'>"+
   	  //		    "<input type='text' name='d_RatePlanID_ProductCodeICB"+i         +"'value='"+$(checkTR).attr("a_RatePlanID")+"'>"+
   	  //		    "<input type='text' name='d_ProductSpecNumber_ProductCodeICB"+i  +"'value='"+$(checkTR).attr("a_ProductSpecNumber")+"'>"+
   	  //		    "<input type='text' name='d_ParAcceptID_ProductCodeICB"+i        +"'value='"+$(checkTR).attr("a_ParAcceptID")+"'>"+
   	  //		    "<input type='text' name='d_DealFlag_PrdOrdPOICB"+i           +"'value='"+$(checkTR).attr("a_DealFlag")+"'>"+
   	  //		    "</DIV>";   	  		    
   	  //		RatePlan[7].append(deletedate);
   	  //}
      checkTR.remove();
   }
   });
} 	
$(document).ready(function(){
   if(RatePlan[5]=="1"){
 
   		if(RatePlan[14]){
   			$.each(RatePlan[14], function(i){ 
   				 var PRODUCTARR=RatePlan[14][i];
           var newtrstr =                                                                          
              "<tr class=\"ProductCode_contenttr\" "+                                                  
		       	  " a_ProductCode='"           +PRODUCTARR[0] +"'"+                                 
		       	  " a_ProductName='"             +PRODUCTARR[1] +"'"+                                 
		       	  " a_ProductValue='"            +PRODUCTARR[2] +"'"+                                 
		       	  " a_POSpecNumber='"              +PRODUCTARR[3] +"'"+                                 
		       	  " a_POOrderNumber='"             +PRODUCTARR[4] +"'"+                                 
		       	  " a_ProductOrderNumber='"        +PRODUCTARR[5] +"'"+                                 
		       	  " a_RatePlanID='"                +PRODUCTARR[6] +"'"+                                 
		       	  " a_OperType='"                  +PRODUCTARR[7] +"'"+	
		       	  " a_ProductSpecNumber='"         +PRODUCTARR[8] +"'"+	
		       	  " a_ParAcceptID='"               +PRODUCTARR[9] +"'"+	
		       	  " a_DealFlag='"                  +PRODUCTARR[10]+"'"+	  	                                                            
		       	  ">"+                                                                                
			     	  "<td classes=\"grey\"><input type=\"checkbox\" name=\"DeleteCheckBox\">"+           
			        "</td>"+                                                                            
		          "<td><a class=\"a_ProductCode\" style=\"cursor: hand;\">"+PRODUCTARR[0]+"</a>"+   
			        "</td>"+                                                                            
			        "<td class=a_ProductName>"+PRODUCTARR[1]+                                           
			        "</td>"+	                                                                          
			        "<td class=a_ProductValue>"+PRODUCTARR[2]+                                          
			        "</td>"+
			        "<td class=a_DealFlag>"+PRODUCTARR[10]+                                          
			        "</td>"+			    				    					                                            
              "</tr>";       
                                                                          
           //alert(newtrstr);
           $("#buttontr").before(newtrstr);
           //注册更新函数                                     
	         //$('.a_ProductCode').bind('click', PRODUCTUpdate);
                                       		  	
   		  });    		    		
   		}    		    		    		    		    		
   }else{
   		RatePlan[5]="1";
   }   
	 //注册更新函数
	 //$('.a_ProductCode').bind('click', PRODUCTUpdate);

	 //注册新增函数
	 $('#getProductCode').click(function(){
	     getProductCode();
	 });	 
	 //注册删除函数
	 $('#PRODUCTDel').click(function(){
	     PRODUCTDel();
	 });
	 
	 //wuxy add
	 var p_OperType = "<%=p_OperType%>";
	 if(p_OperType=="1"){
	 	$("#buttontr").hide();	
	 } 	
	 if(p_OperType=="8"){
	 	$("#buttontr").hide();	
	 } 
	 //add by rendi
	  var p_OperType = "<%=p_OperType%>";
	 if(p_OperType=="2"){
	 	$("#buttontr").hide();	
	 } 
	  //lusc add 
	 var product_OperType="<%=product_OperType%>";
	 if(p_OperType=="4"){
	 	if(product_OperType.match("5")==null)
	 		$("#buttontr").hide();	
	 	var is_add="<%=is_add%>";
	 	if(is_add=="1"){
	 		$("#buttontr").show();
	 	}
	 } 	
 	 
});
//rendi新增
function getProductCode(){
	if($(".ProductCode_contenttr").size()!="0"){
  		rdShowMessageDialog("已申请集团产品，请删除后在增加!"); 
  		return; 	
	}	  
	var pageTitle = "";
    var fieldName = "产品代码|产品名称|产品描述|";
    var sqlStr = "";
    var selType = "S";    //'S'单选；'M'多选
    var retQuence = "3|0|1|2|";

    var retToField = "p_ParameterNumber|p_ParameterValue|p_ParameterName|";

    var path = "<%=request.getContextPath()%>/npage/s2002/f2029_ProductCode_detail.jsp?";
    path = path + "&fieldName="+fieldName;
    path = path + "&selType="+selType;
    path = path + "&retQuence="+retQuence;
    path = path + "&retToField="+retToField;
    path = path + "&workNo=<%=workNo%>";
    path = path + "&orgCode=<%=org_code%>";
    path = path + "&sProductSpecNumber=<%=sProductSpecNumber%>";  
    path = path + "&sPOSpecNumber=<%=sPOSpecNumber%>";
    path = path + "&sRatePlanID=<%=sRatePlanID%>";    

    
    retInfo = window.open(path,
                          "newwindow",
                          "height=400, width=900,top=300,left=350,scrollbars=yes, resizable=no,location=no, status=yes");
    return true;
}
function getProductCodeRtn(retInfo)
{
    var s1="";
    var s2="";
    var s3="";
    s1=retInfo.split("|")[0];
    s2=retInfo.split("|")[1];
    s3=retInfo.split("|")[2];
    PrdCodeAdd(s1,s2,s3);
}
function PrdCodeAdd(s1,s2,s3){	
	                                            
	var PrdOrderChar=[
	            s1                        ,//0	
	  	        s2                        ,//1	  	        	  	        
	  	        s3                        ,//2
	  	        '<%=sPOOrderNumber%>'     ,//3 
	  	        '<%=sPOSpecNumber%>'      ,//4
	  	        '<%=sProductOrderNumber%>',//5
	  	        "NEW"                     ,//6
	  	        "<%=sProductSpecNumber%>" ,//7
              "<%=sParAcceptID%>"	    ,//8
              "0"	,                       //9   
              '<%=p_OperType%>',	         	  	         	  	//10
                '未生效'                         	
	  	        ];                                            	                                                                                       
      var newtrstr =                                                                            
           "<tr class=\"ProductCode_contenttr\" "+                                                
		  	  " a_ProductCode='" +PrdOrderChar[0] +"'"+                                    
		  	  " a_ProductName='"                       +PrdOrderChar[1] +"'"+
		  	  " a_ProductValue='"             +PrdOrderChar[2] +"'"+
		  	  " a_POOrderNumber='"              +PrdOrderChar[3] +"'"+ 
		  	  " a_POSpecNumber='"               +PrdOrderChar[4] +"'"+ 
		  	  " a_ProductOrderNumber='"         +PrdOrderChar[5] +"'"+
		  	  " a_OperType='"                   +PrdOrderChar[6] +"'"+
		  	  " a_ProductSpecNumber='"          +PrdOrderChar[7] +"'"+
		  	  " a_ParAcceptID='"                +PrdOrderChar[8] +"'"+
		  	  " a_DealFlag='"                   +PrdOrderChar[11] +"'"+                                                                         
		  	  ">"+                                                                                 
				  "<td classes=\"grey\"><input type=\"checkbox\" name=\"DeleteCheckBox\">"+            
			    "</td>"+                                                                             
		      "<td class=\"a_ProductCode\" >"+PrdOrderChar[0]+
			    "&nbsp;</td>"+                                                           
			    "<td class=a_ProductName>"+PrdOrderChar[1]+                                              
			    "&nbsp;</td>"+
			    "<td class=a_ProductValue>"+PrdOrderChar[2]+                                              
			    "&nbsp;</td>"+
			    "<td class=a_DealFlag>"+PrdOrderChar[11]+                                              
			    "&nbsp;</td>"+				    				    					                                                                   
          "</tr>";                                                                               
      $("#buttontr").before(newtrstr);                                                                                                                                                      
      //注册更新函数                                                                            
      $('.a_ProductCode').bind('click', PRODUCTUpdate);	                               
}
function getBargainRtn(value) {
	$('#bargain').val(value);	
}
</script>














