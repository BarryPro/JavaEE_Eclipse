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
	 String sCustomerProvinceNumber = request.getParameter("sCustomerProvinceNumber");
	 String sNeedOpButton = request.getParameter("sNeedOpButton");
	 String sp_Action= request.getParameter("sp_Action");
	 System.out.println("sNeedOpButton = "+sNeedOpButton);
%>


<div id="form">
	<input type="hidden" id=p_Action value="<%=sp_Action%>">
	<table width="100%" border="0" cellpadding="0" cellspacing="0">
		<form id="bug_form" method="post" action="">
	      <tr>
	        <th width="10%" nowrap>选择</th>
	        <th width="25%" nowrap>IT部门名称</th>
	        <th width="25%" nowrap>是否有IT部门</th>
	        <th width="25%" nowrap>是否有专属资费方案</th>
	        <th width="25%" nowrap>资费套餐内容</th>
	      </tr>
        <tbody>
<wtc:service name="s9101DetQry" outnum="26" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:param value="1"/>
	<wtc:param value="<%=sCustomerProvinceNumber%>"/>
</wtc:service>
<wtc:array id="result" start="2" length="24" scope="end" />

 
 	
<%
if(retCode.equals("000000")){
	if(result.length>0){
		for(int i=0;i<result.length;i++){
		%>
		<!--循环取流水 -->
 		<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="01"  id="seq"/>
		<%
		System.out.println("gaopengSeeLogExtInfoList===seq======"+seq);
		System.out.println("result["+i+"][21]:"+result[i][21]);
%>
  			  <tr class="extinfo_contenttr"
  			  	  a_HasITDept="<%=result[i][1]%>"
  			  	  a_ITDeptName="<%=result[i][2]%>"
  			  	  a_FeeCase="<%=result[i][3]%>"
  			  	  a_FeeCaseInfo="<%=result[i][4]%>"
  			  	  a_ARPU="<%=result[i][5]%>"
  			  	  a_DataARPU="<%=result[i][6]%>"
  			  	  a_AvgFee="<%=result[i][7]%>"
  			  	  a_Quota="<%=result[i][8]%>"
  			  	  a_RewardType="<%=result[i][9]%>"
  			  	  a_UnicomTone="<%=result[i][10]%>"
  			  	  a_UnicomData="<%=result[i][11]%>"
  			  	  a_Trends="<%=result[i][12]%>"
  			  	  a_MobileUser="<%=result[i][13]%>"
  			  	  a_MobileRate="<%=result[i][14]%>"
  			  	  a_Informationize="<%=result[i][15]%>"
  			  	  a_Intergration="<%=result[i][16]%>"
  			  	  a_Terminal="<%=result[i][17]%>"
  			  	  a_TransProv="<%=result[i][18]%>"
  			  	  a_SinglePay="<%=result[i][19]%>"
  			  	  a_Mas="<%=result[i][20]%>"
  			  	  a_CustomerProvinceNumber="<%=result[i][0]%>"
  			  	  a_ExtInfoAcceptID="<%=result[i][21]%>"
  			  	  a_CMCCPrdListCheck="0"
  			  	  a_OperType="OLD"
  			  	  a_ExtInfoAcceptID_NEW="<%=seq%>"
  			  	  a_button_open_flag="<%=seq%>false"
  			  	  
  			  	>
  			  	
						<td classes="grey"><input type="checkbox" name="ExtInfoListChkBox" value="0">
					  </td>
				    <td><a class="p_ITDeptName" style="cursor: hand;"><%=result[i][2]%>&nbsp;</a>
					  </td>
					  <td class=p_HasITDept><%=result[i][22]%>&nbsp;
					  &nbsp;</td>
					  <td class=p_FeeCase><%=result[i][23]%>&nbsp;
					  &nbsp;</td>
					  <td class=p_FeeCaseInfo><%=result[i][4]%>&nbsp;
					  &nbsp;</td>
	        </tr>
<%
    }
  }
}
%>

<%
if("1".equals(sNeedOpButton))
{
%>
          <tr id="extinfo_buttontr">

	        	<th colspan="5" align="center">
	        		<input type="button" class="b_text" id="ExtInfoAdd" value="新增">
	        		&nbsp;
	        		<input type="button" class="b_text" id="ExtInfoDel" value="删除">
	          </th>
	        </tr>
<%
}
%>
	      </tbody>
		</form>
	</table>
</div>

<script>
   $("#wait2").hide();
   $(document).ready(function(){
   //注册新增函数
	 $('#ExtInfoAdd').click(function(){
	     ExtInfoAdd();
	 });
	 //注册更新函数
	 $('.p_ITDeptName').bind('click', ExtInfoUpdate);
	 //注册删除函数
	 $('#ExtInfoDel').click(function(){
	     ExtInfoDel();
	 });
	 //新增函数
	 function ExtInfoAdd(){	 	  
	 	  var extInfo=[
	 	            "",	 	                                        // 0是否有IT部门
	 	            "",                                           // 1IT部门名称
	 	            "",                                           // 2是否有专属资费方案
	 	            "",                                           // 3资费套餐内容
	 	            "",                                           // 4平均收入
	 	            "",                                           // 5平均数据业务收入
	 	            "",                                           // 6员工月平均话费
	 	            "",                                           // 7话费月报销额度
	 	            "",                                           // 8话费报销方式
	 	            "",                                           // 9是否使用联通话音业务
	 	            "",                                           //10是否使用联通数据业务
	 	            "",                                           //11未来变化趋势
	 	            "",                                           //12中国移动手机数
	 	            "",                                           //13中国移动手机用户比例
	 	            "",                                           //14对信息化的需求程度
	 	            "",                                           //15对信息化集成的需求程度
	 	            "",                                           //16对行业终端定制的需求程度
	 	            "",                                           //17对跨省一体化实施能力的需求
	 	            "",                                           //18对一点账单结算的需求
	 	            "",                                           //19对MAS的需求程度
	 	            $("#p_CustomerProvinceNumber").val(),         //20集团归属省编码
	 	            "0",                                          //21信息化产品流水
	 	            "0",                                          //22列表点击标识
	 	            "" ,                                          //23列表数组
	 	            "NEW",                                         //24是否新增
	 	            $("#p_Action").val()                            //25  操作类型
	 	         ];
	    var retInfo = window.showModalDialog
	    (
	    "f2002_ExtInfo_detail.jsp",
	    extInfo,
	    'dialogHeight:550px; dialogWidth:750px;scrollbars:yes;resizable:no;location:no;status:no'
	    );
      //点关闭按钮不新增
	    if(retInfo)
	    {

	    	 var p_HasITDept_tmp;
         if(extInfo[0]=="1"){
         		p_HasITDept_tmp="有";
         }else if(extInfo[0]=="2"){
         		p_HasITDept_tmp="没有";
         }else if(extInfo[0]=="3"){
         		p_HasITDept_tmp="未知/不详";
         }

         var p_FeeCase_tmp;
         if(extInfo[2]=="1"){
         		p_FeeCase_tmp="有";
         }else if(extInfo[2]=="2"){
         		p_FeeCase_tmp="没有";
         }else if(extInfo[2]=="3"){
         		p_FeeCase_tmp="未知/不详";
         }

	       var newtrstr =
	            "<tr class=\"extinfo_contenttr\" "+
  			  	  " a_HasITDept="+                 "'"+extInfo[0] +"'"+
  			  	  " a_ITDeptName="+                "'"+extInfo[1] +"'"+
  			  	  " a_FeeCase="+                   "'"+extInfo[2] +"'"+
  			  	  " a_FeeCaseInfo="+               "'"+extInfo[3] +"'"+
  			  	  " a_ARPU="+                      "'"+extInfo[4] +"'"+
  			  	  " a_DataARPU="+                  "'"+extInfo[5] +"'"+
  			  	  " a_AvgFee="+                    "'"+extInfo[6] +"'"+
  			  	  " a_Quota="+                     "'"+extInfo[7] +"'"+
  			  	  " a_RewardType="+                "'"+extInfo[8] +"'"+
  			  	  " a_UnicomTone="+                "'"+extInfo[9] +"'"+
  			  	  " a_UnicomData="+                "'"+extInfo[10]+"'"+
  			  	  " a_Trends="+                    "'"+extInfo[11]+"'"+
  			  	  " a_MobileUser="+                "'"+extInfo[12]+"'"+
  			  	  " a_MobileRate="+                "'"+extInfo[13]+"'"+
  			  	  " a_Informationize="+            "'"+extInfo[14]+"'"+
  			  	  " a_Intergration="+              "'"+extInfo[15]+"'"+
  			  	  " a_Terminal="+                  "'"+extInfo[16]+"'"+
  			  	  " a_TransProv="+                 "'"+extInfo[17]+"'"+
  			  	  " a_SinglePay="+                 "'"+extInfo[18]+"'"+
  			  	  " a_Mas="+                       "'"+extInfo[19]+"'"+
  			  	  " a_CustomerProvinceNumber="+    "'"+extInfo[20]+"'"+
  			  	  " a_ExtInfoAcceptID="+           "'"+extInfo[21]+"'"+
  			  	  " a_CMCCPrdListCheck="+          "'"+extInfo[22]+"'"+
  			  	  " a_CMCCPrdList=''"+
  			  	  " a_OperType='NEW'"+
  			  	  ">"+
						  "<td classes=\"grey\"><input type=\"checkbox\" name=\"ExtInfoListChkBox\">"+
					    "</td>"+
				      "<td><a class=\"p_ITDeptName\" style=\"cursor: hand;\">"+extInfo[1]+"</a>"+
					    "&nbsp</td>"+
					    "<td class=p_HasITDept>"+p_HasITDept_tmp+
					    "&nbsp</td>"+
					    "<td class=p_FeeCase>"+p_FeeCase_tmp+
					    "&nbsp</td>"+
					    "<td class=p_FeeCaseInfo>"+extInfo[3]+
					    "&nbsp</td>"+
	            "</tr>";
	       $("#extinfo_buttontr").before(newtrstr);
	       //为新增行赋数组属性
	       $(".extinfo_contenttr:last").data("a_CMCCPrdList",extInfo[23]);
	       //注册更新函数
	       $('.p_ITDeptName').bind('click', ExtInfoUpdate);
	       //var deleteCMCCPrdArray=retInfo[1];
	       //if(deleteCMCCPrdArray){
	       //   $.each(deleteCMCCPrdArray, function(i){
	       //   	 var deleteCMCCPrd=new Array(5);
	       //   	 deleteCMCCPrd=deleteCMCCPrdArray[i];	          	 	          	 
	       //   	 if(deleteCMCCPrd[4]=="OLD"){
         //          var ii  = $("DIV.CMCCPrdInfo","#hiddendate_delete").size();
      	 //    	     var deletedate=
      	 //    	     "<DIV class='CMCCPrd'>" +
      	 //    	     "<input type='hidden' name='tableid"+ii+"'                           value='2'>" +
      	 //    	     "<input type='hidden' name='opertype"+ii+"'                          value='N'>" +
      	 //    	     "<input type='hidden' name='d_CMCCPrd"+ii+"'                         value='"+deleteCMCCPrd[0]+"'>"+
      	 //    	     "<input type='hidden' name='d_CustomerProvinceNumber_CMCCPrd"+ii+"' value='"+deleteCMCCPrd[1]+"'>"+
      	 //    	     "<input type='hidden' name='d_CMCCAcceptID"+ii+"'           value='"+deleteCMCCPrd[2]+"'>"+
      	 //    	     "<input type='hidden' name='d_ExtInfoAcceptID_CMCCPrd"+ii+"'        value='"+deleteCMCCPrd[3]+"'>"+
      	 //    	     "<input type='hidden' name='d_OperType"+ii+"'                        value='"+deleteCMCCPrd[4]+"'>"+
         //          "</DIV>";
      	 //    	     $("#hiddendate_delete").append(deletedate);
      	 //    	  }
	       //   });
	       //}
	 	  }
	 }

	 //更新函数 IT部门名称点击事件
	 function ExtInfoUpdate(){
      var extInfoTR = $(this).parent().parent();
      var extInfo=[
  	  	        $(extInfoTR).attr("a_HasITDept"             ),  // 0    是否有IT部门
  	  	        $(extInfoTR).attr("a_ITDeptName"            ),  // 1    IT部门名称
  	  	        $(extInfoTR).attr("a_FeeCase"               ),  // 2    是否有专属资费方案
  	  	        $(extInfoTR).attr("a_FeeCaseInfo"           ),  // 3    资费套餐内容
  	  	        $(extInfoTR).attr("a_ARPU"                  ),  // 4    平均收入
  	  	        $(extInfoTR).attr("a_DataARPU"              ),  // 5    平均数据业务收入
  	  	        $(extInfoTR).attr("a_AvgFee"                ),  // 6    员工月平均话费
  	  	        $(extInfoTR).attr("a_Quota"                 ),  // 7    话费月报销额度
  	  	        $(extInfoTR).attr("a_RewardType"            ),  // 8    话费报销方式
  	  	        $(extInfoTR).attr("a_UnicomTone"            ),  // 9    是否使用联通话音业务
  	  	        $(extInfoTR).attr("a_UnicomData"            ),  //10    是否使用联通数据业务
  	  	        $(extInfoTR).attr("a_Trends"                ),  //11    未来变化趋势
  	  	        $(extInfoTR).attr("a_MobileUser"            ),  //12    中国移动手机数
  	  	        $(extInfoTR).attr("a_MobileRate"            ),  //13    中国移动手机用户比例
  	  	        $(extInfoTR).attr("a_Informationize"        ),  //14    对信息化的需求程度
  	  	        $(extInfoTR).attr("a_Intergration"          ),  //15    对信息化集成的需求程度
  	  	        $(extInfoTR).attr("a_Terminal"              ),  //16    对行业终端定制的需求程度
  	  	        $(extInfoTR).attr("a_TransProv"             ),  //17    对跨省一体化实施能力的需求
  	  	        $(extInfoTR).attr("a_SinglePay"             ),  //18    对一点账单结算的需求
  	  	        $(extInfoTR).attr("a_Mas"                   ),  //19    对MAS的需求程度
  	  	        $(extInfoTR).attr("a_CustomerProvinceNumber"),  //20    集团归属省编码
  	  	        $(extInfoTR).attr("a_ExtInfoAcceptID"       ),  //21    信息化产品流水
  	  	        $(extInfoTR).attr("a_CMCCPrdListCheck"      ),  //22    列表点击标识  	  	        
  	  	        $(extInfoTR).data("a_CMCCPrdList")           ,  //23    列表数组
  	  	        $(extInfoTR).attr("a_OperType"              ),   //24    是否新增
								$("#p_Action").val(),                             //25  操作类型
								$(extInfoTR).attr("a_ExtInfoAcceptID_NEW"       ),//26 新增的流水
								$(extInfoTR).attr("a_button_open_flag"       )//27 确认按钮是否点击
								
								
								
  	  	        ];
     var retInfo = window.showModalDialog
     (
     "f2002_ExtInfo_detail.jsp",
     extInfo,
     'dialogHeight:550px; dialogWidth:750px;scrollbars:yes;resizable:no;location:no;status:no'
     );
      //this.tr.attr赋值
      $(extInfoTR).attr("a_HasITDept"             , extInfo[0]) ;   // 0    是否有IT部门
      $(extInfoTR).attr("a_ITDeptName"            , extInfo[1]) ;   // 1    IT部门名称
      $(extInfoTR).attr("a_FeeCase"               , extInfo[2]) ;   // 2    是否有专属资费方案
      $(extInfoTR).attr("a_FeeCaseInfo"           , extInfo[3]) ;   // 3    资费套餐内容
      $(extInfoTR).attr("a_ARPU"                  , extInfo[4]) ;   // 4    平均收入
      $(extInfoTR).attr("a_DataARPU"              , extInfo[5]) ;   // 5    平均数据业务收入
      $(extInfoTR).attr("a_AvgFee"                , extInfo[6]) ;   // 6    员工月平均话费
      $(extInfoTR).attr("a_Quota"                 , extInfo[7]) ;   // 7    话费月报销额度
      $(extInfoTR).attr("a_RewardType"            , extInfo[8]) ;   // 8    话费报销方式
      $(extInfoTR).attr("a_UnicomTone"            , extInfo[9]) ;   // 9    是否使用联通话音业务
      $(extInfoTR).attr("a_UnicomData"            , extInfo[10]);   //10    是否使用联通数据业务
      $(extInfoTR).attr("a_Trends"                , extInfo[11]);   //11    未来变化趋势
      $(extInfoTR).attr("a_MobileUser"            , extInfo[12]);   //12    中国移动手机数
      $(extInfoTR).attr("a_MobileRate"            , extInfo[13]);   //13    中国移动手机用户比例
      $(extInfoTR).attr("a_Informationize"        , extInfo[14]);   //14    对信息化的需求程度
      $(extInfoTR).attr("a_Intergration"          , extInfo[15]);   //15    对信息化集成的需求程度
      $(extInfoTR).attr("a_Terminal"              , extInfo[16]);   //16    对行业终端定制的需求程度
      $(extInfoTR).attr("a_TransProv"             , extInfo[17]);   //17    对跨省一体化实施能力的需求
      $(extInfoTR).attr("a_SinglePay"             , extInfo[18]);   //18    对一点账单结算的需求
      $(extInfoTR).attr("a_Mas"                   , extInfo[19]);   //19    对MAS的需求程度
      $(extInfoTR).attr("a_CustomerProvinceNumber", extInfo[20]);   //20    集团归属省编码
      $(extInfoTR).attr("a_ExtInfoAcceptID"       , extInfo[21]);   //21    信息化产品流水
      if(extInfo){
      	$(extInfoTR).attr("a_CMCCPrdListCheck"      , extInfo[22]);   //22    列表点击标识
      }      
      $(extInfoTR).data("a_CMCCPrdList",extInfo[23]);               //23    列表数组
      $(extInfoTR).attr("a_ExtInfoAcceptID_NEW"       , extInfo[26]);   //21    信息化产品流水
      $(extInfoTR).attr("a_button_open_flag"       , extInfo[27]);   //21    信息化产品流水
      
      
      //为新增行赋数组属性
      $('.p_ITDeptName',extInfoTR).text(extInfo[1]);
      if(extInfo[0]=="1"){
      	$('.p_HasITDept',extInfoTR).text("有");
      }else if(extInfo[0]=="2"){
      	$('.p_HasITDept',extInfoTR).text("没有");
      }else if(extInfo[0]=="3"){
      	$('.p_HasITDept',extInfoTR).text("未知/不详");
      }

      if(extInfo[2]=="1"){
      	$('.p_FeeCase',extInfoTR).text("有");
      }else if(extInfo[2]=="2"){
      	$('.p_FeeCase',extInfoTR).text("没有");
      }else if(extInfo[2]=="3"){
      	$('.p_FeeCase',extInfoTR).text("未知/不详");
      }

      $('.p_FeeCaseInfo',extInfoTR).text(extInfo[3]);

      if(retInfo)
      {
      	 var deleteCMCCPrdArray=retInfo[1];
      	 if(deleteCMCCPrdArray){
           $.each(deleteCMCCPrdArray, function(i){
           	 var deleteCMCCPrd=new Array(5);
           	 deleteCMCCPrd=deleteCMCCPrdArray[i]; 
           	 if(deleteCMCCPrd[4]=="OLD"){
                var i  = $("DIV.CMCCPrdInfo","#hiddendate_delete").size();
      	     	  var deletedate=
      	     		"<DIV class='CMCCPrdInfo'>" +
      	     		"<input type='text' name='tableid"+i+"'                           value='2'>" +
      	     		"<input type='text' name='opertype"+i+"'                          value='N'>" +
      	     		"<input type='text' name='d_CMCCPrd"+i+"'                         value='"+deleteCMCCPrd[0]+"'>"+
      	     		"<input type='text' name='d_CustomerProvinceNumber_CMCCPrd"+i+"'  value='"+deleteCMCCPrd[1]+"'>"+      	     		                          
      	     		"<input type='text' name='d_ExtInfoAcceptID_CMCCPrd"+i+"'         value='"+deleteCMCCPrd[2]+"'>"+
      	     		"<input type='text' name='d_CMCCPrdAcceptID"+i+"'                 value='"+deleteCMCCPrd[3]+"'>"+
      	     		"<input type='text' name='d_OperType"+i+"'                        value='"+deleteCMCCPrd[4]+"'>"+
                "</DIV>";
      	     		$("#hiddendate_delete").append(deletedate);
      	     }
           });
         }
      }
	 }

	 //删除函数
   function ExtInfoDel(){
      $("input[@name='ExtInfoListChkBox']").each(function()
      {
      var checkTR = $(this.parentNode.parentNode);
      if($(this).attr("checked")){
      	  if($(checkTR).attr("a_OperType")=="OLD")//如果是数据库中取出的数据，添加到删除缓冲区
      	  {
      	  	  var i  = $("DIV.ExtInfo","#hiddendate_delete").size();
      	  		var deletedate=
      	  		"<DIV class='ExtInfo'>" +
      	  		"<input type='text' name='tableid"+i+"'                          value='1'>" +                                                           //操作表 0-集团客户关键人信息 1-集团客户扩展信息 2-移动信息化产品 3-集团客户基本信息
      	  		"<input type='text' name='opertype"+i+"'                         value='N'>" +                                                           //操作类型 Y-新增或修改 N-删除(0,1,2)
      	  		"<input type='text' name='d_ITDeptName"+i+"'                     value='"+$(checkTR).attr("a_ITDeptName")+"'>"+                          //是否有IT部门
      	  		"<input type='text' name='d_HasITDept"+i+"'                      value='"+$(checkTR).attr("a_HasITDept")+"'>"+                           //IT部门名称
      	  		"<input type='text' name='d_FeeCase"+i+"'                        value='"+$(checkTR).attr("a_FeeCase")+"'>"+                             //是否有专属资费方案
      	  		"<input type='text' name='d_FeeCaseInfo"+i+"'                    value='"+$(checkTR).attr("a_FeeCaseInfo")+"'>"+                         //资费套餐内容
      	  		"<input type='text' name='d_ARPU"+i+"'                           value='"+$(checkTR).attr("a_ARPU")+"'>"+                                //平均收入
      	  		"<input type='text' name='d_DataARPU"+i+"'                       value='"+$(checkTR).attr("a_DataARPU")+"'>"+                            //平均数据业务收入
      	  		"<input type='text' name='d_AvgFee"+i+"'                         value='"+$(checkTR).attr("a_AvgFee")+"'>"+                              //员工月平均话费
      	  		"<input type='text' name='d_Quota"+i+"'                          value='"+$(checkTR).attr("a_Quota")+"'>"+                               //话费月报销额度
      	  		"<input type='text' name='d_RewardType"+i+"'                     value='"+$(checkTR).attr("a_RewardType")+"'>"+                          //话费报销方式
              "<input type='text' name='d_UnicomTone"+i+"'                     value='"+$(checkTR).attr("a_UnicomTone")+"'>"+                          //是否使用联通话音业务
              "<input type='text' name='d_UnicomData"+i+"'                     value='"+$(checkTR).attr("a_UnicomData")+"'>"+                          //是否使用联通数据业务
              "<input type='text' name='d_Trends"+i+"'                         value='"+$(checkTR).attr("a_Trends")+"'>"+                              //未来变化趋势
              "<input type='text' name='d_MobileUser"+i+"'                     value='"+$(checkTR).attr("a_MobileUser")+"'>"+                          //中国移动手机数
              "<input type='text' name='d_MobileRate"+i+"'                     value='"+$(checkTR).attr("a_MobileRate")+"'>"+                          //中国移动手机用户比例
              "<input type='text' name='d_Informationize"+i+"'                 value='"+$(checkTR).attr("a_Informationize")+"'>"+                      //对信息化的需求程度
              "<input type='text' name='d_Intergration"+i+"'                   value='"+$(checkTR).attr("a_Intergration")+"'>"+                        //对信息化集成的需求程度
              "<input type='text' name='d_Terminal"+i+"'                       value='"+$(checkTR).attr("a_Terminal")+"'>"+                            //对行业终端定制的需求程度
              "<input type='text' name='d_TransProv"+i+"'                      value='"+$(checkTR).attr("a_TransProv")+"'>"+                           //对跨省一体化实施能力的需求
              "<input type='text' name='d_SinglePay"+i+"'                      value='"+$(checkTR).attr("a_SinglePay")+"'>"+                           //对一点账单结算的需求
              "<input type='text' name='d_Mas"+i+"'                            value='"+$(checkTR).attr("a_Mas")+"'>"+                                 //对MAS的需求程度
              "<input type='text' name='d_CustomerProvinceNumber_ExtInfo"+i+"' value='"+$(checkTR).attr("a_CustomerProvinceNumber")+"'>"+              //集团归属省编码
              "<input type='text' name='d_ExtInfoAcceptID"+i+"'                value='"+$(checkTR).attr("a_ExtInfoAcceptID")+"'>"+                     //扩展信息流水
              "</DIV>";
      	  		$("#hiddendate_delete").append(deletedate);
      	  }
       		checkTR.remove();
      }
      });
   }
});
</script>
