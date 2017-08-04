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
	String password = (String)session.getAttribute("password");
	String org_code = (String)session.getAttribute("orgCode");
	String regionCode=org_code.substring(0,2);
	String sPOOrderNumber = request.getParameter("sPOOrderNumber");
	String sPOSpecNumber = request.getParameter("sPOSpecNumber");
	String sProductOrderNumber = request.getParameter("sProductOrderNumber");
	String sCheckFlag3 = request.getParameter("sCheckFlag3"); 
	String sParAcceptID = request.getParameter("sParAccpetID");
	String sProductSpecNumber = request.getParameter("sProductSpecNumber");
	System.out.println("sProductSpecNumber="+sProductSpecNumber);
	String p_OperType = WtcUtil.repNull(request.getParameter("p_OperType"));    //wuxy add  
	String product_OperType = WtcUtil.repNull(request.getParameter("product_OperType"));  //lusc add
	String product_add_flag=WtcUtil.repNull(request.getParameter("product_add_flag"));  //lusc add
	
	System.out.println("product_OperType="+product_OperType);
	System.out.println("p_OperType="+p_OperType);
	
	String in_ChanceId = WtcUtil.repNull(request.getParameter("in_ChanceId"));  
	String in_BatchNo =  WtcUtil.repNull(request.getParameter("in_BatchNo"));
	String busi_req_type = WtcUtil.repNull(request.getParameter("busi_req_type"));
	String poorder_type = WtcUtil.repNull(request.getParameter("poorder_type"));
	
	String[][] chanceArray  = null;
	String[][] resArray  = null;
%>

<div id="form">
	<table width="100%" border="0" cellpadding="0" cellspacing="0">
		<form id="bug_form" method="post" action="">
			<input type="hidden" id="prpValue" name="prpValue" />
      <tr>
      	<th nowrap>选择</th>
        <th nowrap>产品属性代码</th>
        <th nowrap>属性名</th>
        <th nowrap>属性值</th>	  
        <th nowrap>产品属性序号</th>      	 
        <th>属性归属组</th>          	        		        
      </tr>
      <tbody>

<wtc:service name="s9102ChaInit" outnum="21" retcode="retCode1" retmsg="retMsg1" routerKey="region" routerValue="<%=regionCode%>">		
	<wtc:param value="0"/>
	<wtc:param value="01"/>
	<wtc:param value="2029"/>
	<wtc:param value="<%=workNo%>"/>
	<wtc:param value="<%=password%>"/>
	<wtc:param value=""/>
	<wtc:param value=""/>
	<wtc:param value="<%=busi_req_type%>"/>
	<wtc:param value="<%=poorder_type%>"/>
	<wtc:param value="<%=in_ChanceId%>"/>
	<wtc:param value="<%=sPOSpecNumber%>"/>
	<wtc:param value="<%=sProductSpecNumber%>"/>
	<wtc:param value="<%=in_BatchNo%>"/>
	<wtc:param value="<%=sProductOrderNumber%>"/>
</wtc:service>
<wtc:array id="result" start="2" length="12" scope="end" />
<wtc:array id="result2" start="14" length="7" scope="end" />
<%
if (!"000000".equals(retCode1)) {
	%>
	<script language="JavaScript">
		rdShowMessageDialog("s9102ChaInit初始化错误！<%=retCode1%>，<%=retMsg1%>");
		return;
	</script>
	<%
	return;
}
System.out.println("====wanghfa==== result.length = " + result.length);
System.out.println("====wanghfa==== result2.length = " + result2.length);
resArray = (String[][] )result;
chanceArray = (String [][])result2;
if(result2.length>0){
		  for(int i=0;i<result2.length;i++){
		  System.out.print(result2[i][0]+"---");
		  System.out.print(result2[i][1]+"---");
		  System.out.print(result2[i][2]+"---");
		  System.out.print(result2[i][3]+"---");
		  System.out.print(result2[i][4]+"---");
		  System.out.print(result2[i][5]+"---");
		  System.out.print(result2[i][6]+"<br>");
		  
		  int vcontinue = 0;
		  for(int jj = 0;jj<resArray.length;jj++){
		  	if(result2[i][1].equals(resArray[jj][1])&&result2[i][3].equals(resArray[jj][3])&&"g".equals(poorder_type)){
		  		System.out.print("@:************"+result2[i][1]+"***********"+result2[i][3]+"\n");
		  		vcontinue = 1;
		  	}else if(("02".equals(busi_req_type)||"03".equals(busi_req_type)||"06".equals(busi_req_type))&&(result2[i][1].equals(resArray[jj][1])&&result2[i][3].equals(resArray[jj][3]))){
		  		System.out.print("@:************"+result2[i][1]+"***********"+result2[i][3]+"\n");
		  		vcontinue = 1;	
		  	}
		  }
		  if(vcontinue == 1){
		  	continue;
		  }
		  
		
	
		  	String dis_flag="";
		//	if(result2[i][1].equals("4115057017")||result2[i][1].equals("4115011201")||result2[i][1].equals("4115061201")||result2[i][1].equals("4115057023")||result2[i][1].equals("4115057021"))
		//		dis_flag="disabled";
		  System.out.println(result2[i][0]);
		  
		  if("1".equals(result2[i][6])){
		  	dis_flag="disabled";
		  }
		  
		  if("".equals(result2[i][3].trim())){
		  	System.out.println("====wanghfa====");
		     continue;
		  }
%>
  			  <tr class="ProductOrderChar_contenttr"
  			  	  a_ProductSpecCharacterNumber= "<%=result2[i][1]%>"
  			  	  a_Name                      = "<%=result2[i][2]%>"
  			  	  a_CharacterValue            = "<%=result2[i][3]%>"  			  	  
  			  	  a_POOrderNumber             = "<%=sPOOrderNumber%>"
              a_POSpecNumber              = "<%=sPOSpecNumber%>"             
              a_ProductOrderNumber        = "<%=sProductOrderNumber%>"
              a_OperType                  = "NEW"
              a_ProductSpecNumber         = "<%=sProductSpecNumber%>"
              a_ParAcceptID               = "<%=sParAcceptID%>"	
              a_AcceptID                  = "<%=result2[i][4]%>"		
              a_POOrderseriNum            = "<%=result2[i][4]%>"	  
              a_CharacterGroup	  	      = "<%=result2[i][5]%>"	  
  			  >		
  			    <td classes="grey"><input type="checkbox" name="DeleteCheckBox" value="0" <%=dis_flag%> class='group<%=result2[i][5]%>' onclick="checkGroup(this,'<%=result2[i][5]%>')" ><!--wangzn 2010-4-15 15:42:21-->
					  </td>	  			  		
					  <td class="p_ProductSpecCharacterNumber"><%=result2[i][1]%>  
					  &nbsp;</td>
					  <td class="p_Name"><%=result2[i][2]%>
					  &nbsp;</td>
				    <td class="p_CharacterValue"><%=result2[i][3]%>
					  &nbsp;</td>
					   <td class="p_POOrderseriNum"><%=result2[i][4]%>&nbsp;</td>
					   <td class="p_CharacterGroup"><%=result2[i][5]%>&nbsp;</td>
			   
	        </tr>
<%
      }
    }
if(sCheckFlag3.equals("0")){
System.out.println("result.length="+result.length);
	  if(result.length>0){
		  for(int i=0;i<result.length;i++){
		  //yuanqs add 2010/8/27 23:12:54 400改造需求 begin
		  if("4115017032".equals(result[i][1].trim())) {
		  %><script language="JavaScript">
		   	document.getElementById("prpValue").value="<%=result[i][3]%>";
		  </script>
		  <%
		  }
			//yuanqs add 2010/8/27 23:12:54 400改造需求 end
		  System.out.print(result[i][0]+"---");
		  System.out.print(result[i][1]+"---");
		  System.out.print(result[i][2]+"---");
		  System.out.print(result[i][3]+"---");
		  System.out.print(result[i][4]+"---");
		  System.out.print(result[i][5]+"---");
		  System.out.print(result[i][6]+"<br>");
		
	
		  	String dis_flag="";
		  	
		//	if(result[i][1].equals("4115057017")||result[i][1].equals("4115011201")||result[i][1].equals("4115061201")||result[i][1].equals("4115057023")||result[i][1].equals("4115057021"))
		//		dis_flag="disabled";
		  System.out.println(result[i][0]);
		  
		  if("1".equals(result[i][6])){
		  	dis_flag="disabled";
		  }
		  
		  
		  String check_flag = "";
		  
		  if("01".equals(busi_req_type)&&"y".equals(poorder_type)){
			check_flag = "checked";
		  }else if("02".equals(busi_req_type)&&"y".equals(poorder_type)){
		  	for(int ii = 0;ii<chanceArray.length;ii++){
		  		if(result[i][1].equals(chanceArray[ii][1])&&!result[i][3].equals(chanceArray[ii][3])){
		  			check_flag = "checked";
		  			System.out.print("@:************"+result[i][1]+"******"+result[i][3]+"*****"+chanceArray[ii][3]+"\n");
		  		}
		  	}
		  	
		  		
		  }
		  System.out.println("====wanghfa==== check_flag = " + check_flag);
		  	
%>
  			  <tr class="ProductOrderChar_contenttr"
  			  	  a_ProductSpecCharacterNumber= "<%=result[i][1]%>"
  			  	  a_Name                      = "<%=result[i][2]%>"
  			  	  a_CharacterValue            = "<%=result[i][3]%>"  			  	  
  			  	  a_POOrderNumber             = "<%=sPOOrderNumber%>"
              a_POSpecNumber              = "<%=sPOSpecNumber%>"             
              a_ProductOrderNumber        = "<%=sProductOrderNumber%>"
              a_OperType                  = "OLD"
              a_ProductSpecNumber         = "<%=sProductSpecNumber%>"
              a_ParAcceptID               = "<%=sParAcceptID%>"	
              a_AcceptID                  = "<%=result[i][4]%>"		
              a_POOrderseriNum            = "<%=result[i][4]%>"	  
              a_CharacterGroup	  	      = "<%=result[i][5]%>"	  
  			  >		
  			    <td classes="grey">
  			    	<input type='checkbox' name='DeleteCheckBox' value='0' <%=dis_flag%> <%=check_flag%>  class='group<%=result[i][5]%>' onclick="checkGroup(this,'<%=result[i][5]%>')" ><!--wangzn 2010-4-15 15:42:21-->
					  </td>	  			  		
					  <td class="p_ProductSpecCharacterNumber"><%=result[i][1]%>  
					  &nbsp;</td>
					  <td class="p_Name"><%=result[i][2]%>
					  &nbsp;</td>
				    <td class="p_CharacterValue"><%=result[i][3]%>
					  &nbsp;</td>
					   <td class="p_POOrderseriNum"><%=result[i][4]%>&nbsp;</td>
					   <td class="p_CharacterGroup"><%=result[i][5]%>&nbsp;</td>
			   
	        </tr>
<%
      }
    }
}
%>
          <tr id="buttontr3">
	        	<th colspan="6" align="center">
	        		<input type="button" class="b_text" id="getProductOrderCharacter" value="新增">
	        		&nbsp;      
	        		<input type="button" class="b_text" id="PrdOrderCharDel" value="删除">      
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
function PrdOrderCharUpdate(){
	
	
	var PrdOrderCharTR = $(this).parent();
  
 	var PrdOrderCharTRUpdate=[
		$(PrdOrderCharTR).attr("a_ProductSpecCharacterNumber"), 
		$(PrdOrderCharTR).attr("a_ProductName"),  
		$(PrdOrderCharTR).attr("a_ProductValue"),
		'<%=sPOOrderNumber%>',
		'<%=sPOSpecNumber%>', 
		'<%=sProductOrderNumber%>',
		$(PrdOrderCharTR).attr("a_OperType"),
		$(PrdOrderCharTR).attr("a_ProductSpecNumber"),
		$(PrdOrderCharTR).attr("a_ParAcceptID"),
		$(PrdOrderCharTR).attr("a_AcceptID")  ,            //9
		'<%=p_OperType%>',	         	  	         	  	//10
		'1'                                                //11
	];
 	
	var retInfo = window.showModalDialog
	(
		'f2029_ProductOrderCharacter_detail.jsp',
		PrdOrderCharTRUpdate,
		'dialogHeight:500px; dialogWidth:700px;scrollbars:yes;resizable:no;location:no;status:no'
	);
	
	$(PrdOrderCharTR).attr("a_ProductSpecCharacterNumber" ,PrdOrderCharTRUpdate[0] );//0 
	$(PrdOrderCharTR).attr("a_Name"                       ,PrdOrderCharTRUpdate[1] );//1         
	$(PrdOrderCharTR).attr("a_CharacterValue"             ,PrdOrderCharTRUpdate[2] );//2
	$(PrdOrderCharTR).attr("a_POOrderNumber"              ,PrdOrderCharTRUpdate[3] );//3         
	$(PrdOrderCharTR).attr("a_POSpecNumber"               ,PrdOrderCharTRUpdate[4] );//4         
	$(PrdOrderCharTR).attr("a_ProductOrderNumber"         ,PrdOrderCharTRUpdate[5] );//5         
	$(PrdOrderCharTR).attr("a_OperType"                   ,PrdOrderCharTRUpdate[6] );//6
	$(PrdOrderCharTR).attr("sProductSpecNumber"           ,PrdOrderCharTRUpdate[7] );//7
	$(PrdOrderCharTR).attr("a_ParAcceptID"                ,PrdOrderCharTRUpdate[8] );//8
	$(PrdOrderCharTR).attr("a_AcceptID"                   ,PrdOrderCharTRUpdate[9] );//9
	$('.p_ProductSpecCharacterNumber',PrdOrderCharTR).text(PrdOrderCharTRUpdate[0]);
	$('.p_Name' ,PrdOrderCharTR).text(PrdOrderCharTRUpdate[1]);
	$('.p_CharacterValue' ,PrdOrderCharTR).text(PrdOrderCharTRUpdate[2]); 	  	  
	return true;
 
}	
	
//新增函数
//rendi修改满足可以选择多项并返回                                                                                    
function PrdOrderCharAdd(s1,s2,s3,s5,s6){	
	var flag = "";
	
	if(('<%=p_OperType%>'!=4)&&(s6=="必填" || s6=="必空")){
		flag = "disabled";
	}              
	var PrdOrderChar=[
	            s1                        ,//0	
	  	        s2                        ,//1	  	        	  	        
	  	        s3                        ,//2
	  	        '<%=sPOOrderNumber%>'     ,//3 
	  	        '<%=sPOSpecNumber%>'      ,//4
	  	        '<%=sProductOrderNumber%>',//5
	  	        "NEW"                     ,//6
	  	        "<%=sProductSpecNumber%>" ,//7
              "<%=sParAcceptID%>"	      ,//8
              "0"						  ,//9   
              '<%=p_OperType%>'           ,//10
                '1'                       ,//11                         	
                s5						  ,//12
                s6                         //13是否必填
	  	        ];    
                                     	                                                                                       
      var newtrstr =                                                                            
           "<tr class=\"ProductOrderChar_contenttr\" "+                                                
		  	  " a_ProductSpecCharacterNumber='" +PrdOrderChar[0] +"'"+                                    
		  	  " a_Name='"                       +PrdOrderChar[1] +"'"+
		  	  " a_CharacterValue='"             +PrdOrderChar[2] +"'"+
		  	  " a_POOrderNumber='"              +PrdOrderChar[3] +"'"+ 
		  	  " a_POSpecNumber='"               +PrdOrderChar[4] +"'"+ 
		  	  " a_ProductOrderNumber='"         +PrdOrderChar[5] +"'"+
		  	  " a_OperType='"                   +PrdOrderChar[6] +"'"+
		  	  " a_ProductSpecNumber='"          +PrdOrderChar[7] +"'"+
		  	  " a_ParAcceptID='"                +PrdOrderChar[8] +"'"+
		  	  " a_AcceptID='"                   +PrdOrderChar[9] +"'"+ 
		  	  " a_POOrderseriNum='"             +PrdOrderChar[9] +"'"+    
		  	  " a_CharacterGroup='"             +PrdOrderChar[12] +"'"+   
		  	  " a_bt='"                         +PrdOrderChar[13] +"'"+   
		  	  ">"+                                                                                 
				  "<td classes=\"grey\"><input type=\"checkbox\" "+flag+" name=\"DeleteCheckBox\" class=\"group"+PrdOrderChar[12]+"\" onclick='checkGroup(this,\""+PrdOrderChar[12]+"\")' >"+            
			    "</td>"+                                                                             
		      "<td class=\"p_ProductSpecCharacterNumber\" >"+PrdOrderChar[0]+
			    "&nbsp;</td>"+                                                           
			    "<td class=p_Name>"+PrdOrderChar[1]+                                              
			    "&nbsp;</td>"+
			    "<td class=p_CharacterValue>"+PrdOrderChar[2]+                                              
			    "&nbsp;</td>"+
			    "<td class=p_POOrderseriNum>等待生成"+                                              
			    "&nbsp;</td>"+	
			    "<td class=p_POOrderseriNum>"+PrdOrderChar[12]+                                              
			    "&nbsp;</td>"+				    		    				    					                                                                   
          "</tr>";                                                                               
      $("#buttontr3").before(newtrstr);                                                                                                                                                      
      //注册更新函数                                                                            
      //$('.p_ProductSpecCharacterNumber').bind('click', PrdOrderChar);	                               
}

var i = 0;
function PrdOrderCharDel(){
   var deletedate;
   $("input[@name='DeleteCheckBox']").each(function()
   {
   var checkTR = $(this.parentNode.parentNode);
   if($(this).attr("checked")){
   	  if($(checkTR).attr("a_OperType")=="OLD")//如果是数据库中取出的数据，添加到删除缓冲区
   	  { 	  	 // style='display:none'
   	  		 
   	  		 deletedate=deletedate+
   	  		    "<DIV class='ProductOrderChara'>"+
   	  		    "<input type='text' id='tableid_ProOrdChara"                     +i+"' value='6'>" +
   	  		    "<input type='text' id='d_ProductSpecCharacterNumber_ProOrdChara"+i+"' value='"+$(checkTR).attr("a_ProductSpecCharacterNumber")+"'>"+                          
   	  		    "<input type='text' id='d_Name_ProOrdChara"                      +i+"' value='"+$(checkTR).attr("a_Name")+"'>"+            
   	  		    "<input type='text' id='d_CharacterValue_ProOrdChara"            +i+"' value='"+$(checkTR).attr("a_CharacterValue")+"'>"+
   	  		    "<input type='text' id='d_POOrderNumber_ProOrdChara"             +i+"' value='"+$(checkTR).attr("a_POOrderNumber")+"'>"+
   	  		    "<input type='text' id='d_POSpecNumber_ProOrdChara"              +i+"' value='"+$(checkTR).attr("a_POSpecNumber")+"'>"+   	  		    
   	  		    "<input type='text' id='d_ProductOrderNumber_ProOrdChara"        +i+"' value='"+$(checkTR).attr("a_ProductOrderNumber")+"'>"+
   	  		    "<input type='text' id='d_ProductSpecNumber_ProOrdChara"         +i+"' value='"+$(checkTR).attr("a_ProductSpecNumber")+"'>"+
   	  		    "<input type='text' id='d_ParAcceptID_ProOrdChara"               +i+"' value='"+$(checkTR).attr("a_ParAcceptID")+"'>"+
   	  		    "<input type='text' id='d_AcceptID_ProOrdChara"                  +i+"' value='"+$(checkTR).attr("a_AcceptID")+"'>"+
   	  		    "<input type='text' id='d_POOrderSeriNum_ProOrdChara"            +i+"' value='"+$(checkTR).attr("a_POOrderseriNum")+"'>"+
   	  		    "<input type='text' id='d_CharacterGroup"                      +i+"' value='"+$(checkTR).attr("a_CharacterGroup")+"'>"+
   	  		    "</DIV>";
   	  		i++;
   	  		//alert(deletedate);
   	  }
      checkTR.remove();
   }
   });
   $("#buttontr3").before(deletedate); 
}

$(document).ready(function(){
	
 
//alert("@:***busi_req_type[<%=busi_req_type%>]***poorder_type[<%=poorder_type%>]");
   if(ProductOrder[19]=="1"){
   		if(ProductOrder[15]){   			 
   			 $.each(ProductOrder[15], function(i){   			 	
   			 	   var ProductOrderChar = ProductOrder[15][i];//行数据数组,传递给详细信息页面	
   			     var newtrstr =                                                                            
             "<tr class=\"ProductOrderChar_contenttr\""  +                                                
		  	     " a_ProductSpecCharacterNumber='"  +ProductOrderChar[0] +"'"+                                    
		  	     " a_Name='"                        +ProductOrderChar[1] +"'"+
		  	     " a_CharacterValue='"              +ProductOrderChar[2] +"'"+ 
		  	     " a_POOrderNumber='"               +ProductOrderChar[3] +"'"+ 
		  	     " a_POSpecNumber='"                +ProductOrderChar[4] +"'"+
		  	     " a_ProductOrderNumber='"          +ProductOrderChar[5] +"'"+
		  	     " a_OperType='"                    +ProductOrderChar[6] +"'"+
		  	     " a_ProductSpecNumber='"           +ProductOrderChar[7] +"'"+	  	                                                                           
		  	     " a_ParAcceptID='"                 +ProductOrderChar[8] +"'"+
		  	     " a_AcceptID='"                    +ProductOrderChar[9] +"'"+
 				 " a_CharacterGroup='"              +ProductOrderChar[11] +"'"+  
		  	     ">"+                                                                                 
				     "<td classes=\"grey\"><input type=\"checkbox\" name=\"DeleteCheckBox\">"+            
			       "</td>"+                                                                             
		         "<td class=\"p_ProductSpecCharacterNumber\">"+ProductOrderChar[0]+       
			       "</td>"+                                                           
			       "<td class=p_Name>"+ProductOrderChar[1]+                                              
			       "</td>"+	
			       "<td class=p_CharacterValue>"+ProductOrderChar[2]+                                              
			       "</td>"+
			       "<td class=p_POOrderseriNum>"+ProductOrderChar[9]+                                              
			       "</td>"+
			    	"<td class=p_CharacterGroup>"+ProductOrderChar[11]+                                              
			       "</td>"+
             "</tr>";                             
             $("#buttontr3").before(newtrstr);                          
             //注册更新函数
             //$('.p_ProductSpecCharacterNumber').bind('click', PrdOrderCharUpdate);
   			 });
   			
   			
   		}
   }else{   	  
   	  ProductOrder[19]="1"   	  
   }   
   //注册更新函数
	 //$('.p_ProductSpecCharacterNumber').bind('click', PrdOrderCharUpdate);	 
	 //注册新增函数
	 $('#getProductOrderCharacter').click(function(){
	     //PrdOrderCharAdd();
	     getProductOrderCharacter();
	 });
	 //注册删除函数
	 $('#PrdOrderCharDel').click(function(){
	     PrdOrderCharDel();
	 });
	 //wuxy add
	 var p_OperType = "<%=p_OperType%>";
	 if(p_OperType=="1"){
	 	$("#buttontr3").hide();	
	 } 
	 //add by rendi
	 if(p_OperType=="2"){
	 	$("#buttontr3").show();	
	 }
	 if(p_OperType=="3"){
	 	$("#buttontr3").hide();	
	 } 
	if(p_OperType=="8"){
	 	$("#buttontr3").hide();	
	} 	 		 	 
	var product_OperType="<%=product_OperType%>";
	if(p_OperType=="4"){
		if(product_OperType.match("9")==null&&product_OperType.match("5")==null){
			$("#buttontr3").hide();	
		}
		var flag="<%=product_add_flag%>";
			if(flag=="1"){
			$("#buttontr3").show();	
		}
	}	  
    $('#PrdOrderCharDel').click();
});
//rendi新增
function getProductOrderCharacter(){	
 // alert(dataConsult);  //wangzn 090927
	var pageTitle = "";
    var fieldName = "产品属性代码|属性值|属性名|流水|属性归属组|";
    var sqlStr = "";
    var selType = "S";    //'S'单选；'M'多选
    var retQuence = "6|0|3|1|2|4|5|";

    var retToField = "p_ParameterNumber|p_ParameterValue|p_ParameterName|p_AcceptID|";
    var max="0";
    //wuxy add 20090908
    var rowlength=$(".ProductOrderChar_contenttr").length;
	$(".ProductOrderChar_contenttr").each(function(i){
			//alert("["+$(this).attr("a_CharacterGroup")/1+"]");  wangzn 类型转换 20091029
			if(i==0){
	 			max = $(this).attr("a_CharacterGroup")/1;
	 		}else{
	 			var x = $(this).attr("a_CharacterGroup")/1;
	 			//wuxy alter 20090910 应该是数值型比较
	 			if(parseInt(x)>parseInt(max)){
	 				max=x;
	 			}
	 			
	 		}
	 });
	 
	 	//yuanqs add 2010/8/27 23:17:27 400改造需求
		var prpValue = $("#prpValue").val();
    var path = "<%=request.getContextPath()%>/npage/s2002/f2029_getProductCharacter_list.jsp?";
    path = path + "&fieldName="+fieldName;
    path = path + "&selType="+selType;
    path = path + "&retQuence="+retQuence;
    path = path + "&retToField="+retToField;
    path = path + "&workNo=<%=workNo%>";
    path = path + "&orgCode=<%=org_code%>";
    path = path + "&sProductSpecNumber=<%=sProductSpecNumber%>";  
    path = path + "&sPOSpecNumber=<%=sPOSpecNumber%>";
    path = path + "&product_OperType=<%=product_OperType%>";     
		path = path + "&maxgroup="+max;
		path = path + "&p_OperType=<%=p_OperType%>";
		path=  path + "&rowlength="+rowlength;
		path=  path + "&dataConsult="+dataConsult; //wangzn 090927
		path=  path + "&prpValue="+prpValue;//yuanqs add 2010/8/27 23:17:16 400改造需求
		path= path + "&product_add_flag=<%=product_add_flag%>";
    
   // alert('['+path.length+']');
    retInfo = window.open(path,
                          "newwindow",
                          "height=400, width=900,top=300,left=350,scrollbars=yes, resizable=no,location=no, status=yes");
    return true;
}
function getProductOrderCharacterRtn(retInfo)
{
    var retValue = retInfo.split("^");
    var s1="";
    var s2="";
    var s3="";
    var s4="";
    var s5="";
    for(i=0;i<(retInfo.split("^")).length-1;i++)
    {
    	s1=retValue[i].split("|")[0];
    	s2=retValue[i].split("|")[1];
    	s3=retValue[i].split("|")[2];
    	s4=retValue[i].split("|")[3];
    	s5=retValue[i].split("|")[4];
    	
    	s6=retValue[i].split("|")[5];//是否必填
    	PrdOrderCharAdd(s1,s3,s2,s5,s6);
    }
}
//wangzn 2010-4-15 15:42:07
function checkGroup(obj,classId){
  
	flag = obj.checked;
	if(classId.trim()=='0'||classId.trim()=='') return;
	var group = "group"+classId;
	
	$("."+group).each(function(i){
		 
			this.checked = flag;
			
	});
	
}
</script>
