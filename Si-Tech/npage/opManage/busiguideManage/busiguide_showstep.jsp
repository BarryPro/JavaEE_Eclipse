<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<head>
	<title>步骤预览</title>
	<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
	<link href="<%=request.getContextPath()%>/nresources/<%=cssPath%>/css/busiguide.css" rel="stylesheet"type="text/css">

</head>
<body>
<%
    String workNo = (String)session.getAttribute("workNo");
    String orgCode = (String)session.getAttribute("orgCode");
    String opName = "步骤预览";
		String regionCode = orgCode.substring(0,2);
		String sql = "";
		String param = "";
		//业务向导进入
		String busiguide_seq = request.getParameter("busiguide_seq")==null?"":request.getParameter("busiguide_seq").trim();
		if(!"".equals(busiguide_seq)){
		 	sql = "select '['||trim(b.op_code)||']'||trim(c.function_name) function_name,a.step_seq||'、'||a.step_name step from dbusiguidetemp a,dbusiguidemsg b,sfunccodenew c where a.template_id=b.template_id and b.op_code=c.function_code and b.seq=:busiguide_seq order by a.step_seq ";
		 	param = "busiguide_seq="+busiguide_seq;
		}
		
		//业务向导模板进入
		String temp_id = request.getParameter("template_id")==null?"":request.getParameter("template_id").trim();
		if(!"".equals(temp_id)){
			sql = " select a.template_name template_name,a.step_seq||'、'||a.step_name step from dbusiguidetemp a where a.template_id=:temp_id order by a.step_seq ";
			param = "temp_id="+temp_id;
		}
		System.out.println(sql);
		System.out.println(param);
%>
<wtc:service name="TlsPubSelCrm" outnum="2" routerKey="region" routerValue="<%=regionCode %>">
	<wtc:param value="<%=sql%>" />
	<wtc:param value="<%=param%>" />
</wtc:service>
<wtc:array id="stepList" scope="end"/>		
			
		<%
		if("000000".equals(retCode)){
			if(stepList.length>0){
				%>
				 
				<div id="busiguide"  class="busiguide" style="width:350px;">		
					<div id="title">
						<img src="<%=request.getContextPath()%>/nresources/<%=cssPath%>/images/arrow_left.gif" /><%=stepList[0][0]%>
					</div>
					<br>
					<div id="step" style="float:0px;padding-left:0px;width:300px;">
					<%
					for(int i=0;i<stepList.length;i++){
						if(i==0){
						%>
							<div id="step_1" name="step_1"   style="float:0px;padding-left:30px;width:300px;" class="running"><img src="<%=request.getContextPath()%>/nresources/<%=cssPath%>/images/icon_nav.gif"/><%=stepList[i][1].trim()%></div>
						<%
						}else{
						%>
							<div id="step_<%=(i+1)%>" name="step_<%=(i+1)%>"    style="float:0px;padding-left:30px;width:300px;"   class="fresh"><img src="<%=request.getContextPath()%>/nresources/<%=cssPath%>/images/arrow_link_blue.gif"/><%=stepList[i][1]%></div>
						<%
						}
					}
					%>
					
					</div>
				</div>
				<%
			}
		}
		%>

	<br><br><br><br><br><br><br><br><br><br>
 
<div align="center">
 	<input name="prevStep" class="b_foot" type="button" value="上一步" onclick="prevStep('1100')"/>&nbsp; &nbsp; 
 	<input name="nextStep" class="b_foot" type="button" value="下一步" onclick="nextStep('1100')"/>&nbsp; &nbsp; 
 	<input name="nclose" class="b_foot" type="button" value="关  闭" onclick="window.close()"/>
</div>
</body>
</html>

<script type="text/javascript">

function prevStep(opcode){
	$("#step").children("div").each(
      function(){
         if($(this).hasClass('running')){
             if($(this).prev('div').html()){
	             $(this).removeClass('running');
	             $(this).addClass('fresh');
				 $(this).children("img").attr("src","<%=request.getContextPath()%>/nresources/<%=cssPath%>/images/arrow_link_blue.gif");
				 $(this).prev('div').children("img").remove();
				 $(this).prev('div').prepend("<img src=\"<%=request.getContextPath()%>/nresources/<%=cssPath%>/images/icon_nav.gif\"/>");
	             $(this).prev('div').removeClass('finish');
	             $(this).prev('div').addClass('running');
             }
         }
      }
  );
}

function nextStep(opcode){
	var flag=0; //元素向下循环
	$("#step").children("div").each(
      function(){
         if($(this).hasClass('running')){
             if($(this).next('div').html()&&flag==0 ){
	             $(this).removeClass('running');
	             $(this).addClass('finish');
				 $(this).children("img").attr("src","<%=request.getContextPath()%>/nresources/<%=cssPath%>/images/arrow_link_blue.gif");
				 $(this).append("<img src=\"<%=request.getContextPath()%>/nresources/<%=cssPath%>/images/icon_ok.gif\" style=\" margin-left:10px\" width=\"15\" height=\"15\"/>");
				 $(this).next('div').children("img").attr("src","<%=request.getContextPath()%>/nresources/<%=cssPath%>/images/icon_nav.gif");
	             $(this).next('div').removeClass('fresh');
	             $(this).next('div').addClass('running');
				  		 flag=1;
             }
         }
      }
  );
}

var has_busiGuide = false;
function showBusiGuideStep(opcode,step){
	if(typeof(step) !== 'undefined'||step==""){
		step=1;
	}
	
	if(step==1){
			//调用 getBusiguide.jsp，若有值 has_busiGuide =true  
		 getBusiguide(opcode);
	}
	
	$("#step").children("div").each(
      function(i){
         if((i+1)==Number(step)){//选中步骤变为正在进行状态
         	 	 $(this).removeClass();
         	 	 if($(this).children("img").size()>=2){
         	 	 		$(this).children("img:last").remove();
         	 	 }
         		 $(this).addClass('running');
         		 $(this).children("img:first").attr("src","<%=request.getContextPath()%>/nresources/<%=cssPath%>/images/icon_nav.gif");
         }  
         	//alert("i="+i);
         	if((i+1)>Number(step)){//选中步骤后的变为未完成状态
             //下一个全部变为fresh--未进行时
						 $(this).children("img:first").attr("src","<%=request.getContextPath()%>/nresources/<%=cssPath%>/images/arrow_link_blue.gif");
	           $(this).removeClass();
	           $(this).addClass('fresh');
	           if($(this).children("img").size()>=2){
	           			$(this).children("img:last").remove();
	           }
					}
					
					if((i+1)<Number(step)){//选中之前的步骤变为完成状态
						 //之前的都变成--finish
						 $(this).removeClass();
	           $(this).addClass('finish');
	           $(this).children("img:first").attr("src","<%=request.getContextPath()%>/nresources/<%=cssPath%>/images/arrow_link_blue.gif");

						 if($(this).children("img").size()<2){
						 	  $(this).append("<img src=\"<%=request.getContextPath()%>/nresources/<%=cssPath%>/images/icon_ok.gif\" style=\" margin-left:10px\" width=\"15\" height=\"15\"/>");
	         	 }
     		}
     }
  );
  
}
</script>