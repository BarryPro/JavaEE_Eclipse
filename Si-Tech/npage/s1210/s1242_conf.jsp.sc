 <%
	/********************
	 version v2.0
	开发商: si-tech
	update:anln@2009-02-16 页面改造,修改样式
	********************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

 <%
 	request.setCharacterEncoding("GBK");
 	String opCode = "1242";	
	String opName = "申请备卡";	//header.jsp需要的参数
 	String printAccept=request.getParameter("printAccept");
 	
    	String regionCode= (String)session.getAttribute("regCode");
    	String srv_no=request.getParameter("srv_no");
    	System.out.println("===================srv_no"+srv_no);
	String cus_name=WtcUtil.repNull(request.getParameter("cus_name"));
    	String cus_addr=WtcUtil.repNull(request.getParameter("cus_addr"));

	String cus_id=WtcUtil.repNull(request.getParameter("cus_id"));
	
	String nopass = (String)session.getAttribute("password");	
    	String work_no = (String)session.getAttribute("workNo");
    	String loginName =(String)session.getAttribute("workName");
    	String org_code = (String)session.getAttribute("orgCode");
	String op_code = "1242";
  	String paraStr[]=new String[14];

 	paraStr[0]=op_code;
 	paraStr[1]=work_no;
	paraStr[2]=nopass;
	paraStr[3]=org_code;             
	paraStr[4]=WtcUtil.repNull(request.getParameter("cus_id"));
	paraStr[5]=WtcUtil.repNull(request.getParameter("op_type"));
 	paraStr[6]=WtcUtil.repNull(request.getParameter("t_newsimf"));
 	paraStr[7]=WtcUtil.repNull(request.getParameter("t_simFeef"));
 	String temp=WtcUtil.repNull(request.getParameter("t_handFee"));
 	String totalFee=String.valueOf(Double.parseDouble(((paraStr[7].trim().equals(""))?("0"):(paraStr[7])))+Double.parseDouble(((temp.trim().equals(""))?("0"):(temp))));
	paraStr[8]=totalFee;
	paraStr[9]=WtcUtil.repNull(request.getParameter("t_sys_remark"));
	paraStr[10]=WtcUtil.repSpac(request.getParameter("t_op_remark"));
	paraStr[11]=request.getRemoteAddr();
	paraStr[12]=srv_no;
	String newSimName = WtcUtil.repNull(request.getParameter("newSimName"));//SIM卡类型

  
 	if(Double.parseDouble(totalFee)<0.01)    
     		paraStr[13]="0";
    	else
	{
       	   //comImpl co=new comImpl();
 	   //String prtSql="select to_char(sMaxSysAccept.nextval) from dual";
 	   %>
 	   
 	  <wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="sysAcceptl" /> 
 	   <%
 	   	paraStr[13]=printAccept; 	  
	   // paraStr[13]=(((String[][])co.fillSelect(prtSql))[0][0]).trim();
 	}
 	  	
 	  //S1210Impl im1210=new S1210Impl();     	
     	String paraIn[] = new String[14];
	paraIn[0] = paraStr[13];
		for (int i = 0; i < paraStr.length - 1; i++){
			paraIn[i + 1] = paraStr[i];
			}
%>
	<wtc:service name="s1242Cfm" routerKey="phone" routerValue="<%=srv_no%>" retcode="retCode1" retmsg="retMsg1" outnum="20" >
		<wtc:param value="<%=paraIn[0]%>"/>
		<wtc:param value="<%=paraIn[1]%>"/>
		<wtc:param value="<%=paraIn[2]%>"/>
		<wtc:param value="<%=paraIn[3]%>"/>
		<wtc:param value="<%=paraIn[4]%>"/>
		
		<wtc:param value="<%=paraIn[5]%>"/>
		<wtc:param value="<%=paraIn[6]%>"/>
		<wtc:param value="<%=paraIn[7]%>"/>
		<wtc:param value="<%=paraIn[8]%>"/>
		<wtc:param value="<%=paraIn[9]%>"/>
		
		<wtc:param value="<%=paraIn[10]%>"/>
		<wtc:param value="<%=paraIn[11]%>"/>
		<wtc:param value="<%=paraIn[12]%>"/>
		<wtc:param value="<%=paraIn[13]%>"/>
	</wtc:service>
	<wtc:array id="fg" scope="end"/>	

<%String url ="/npage/contact/upCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+retCode1+"&opName="+opName+"&workNo="+work_no+"&loginAccept="+printAccept+"&pageActivePhone="+srv_no+"&retMsgForCntt="+retMsg1+"&opBeginTime="+opBeginTime; %>
<jsp:include page="<%=url%>" flush="true" /> 
<%
		for(int ii=0;ii<fg.length;ii++){
				for(int jj=0;jj<fg[ii].length;jj++){
					System.out.println("fg["+ii+"]["+jj+"]="+fg[ii][jj]);
				}
		}	
		System.out.println("======================+"+retCode1);
		System.out.println("retMsg1======================+"+retMsg1);
	//String[] fg=im1210.sa242Cfm(paraStr,"phone",srv_no);

   if(Integer.parseInt(retCode1)==0)
   {
 	if(Double.parseDouble(totalFee)<0.01)    
	  {
%>
        <script>
	     rdShowMessageDialog("客户<%=cus_name%>(<%=cus_id%>)申请备卡成功！",2);
             history.go(-1);
<%
	  }
	  else
	  {
%>
        <script>
	     rdShowMessageDialog("客户<%=cus_name%>(<%=cus_id%>)申请备卡成功，下面将打印发票！");
 	     var infoStr="";
	 		/*
	    infoStr+=" "+"|";
        infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	    infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	    infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	    infoStr+="<%=srv_no%>"+"|";
	    infoStr+=" "+"|";
	    infoStr+="<%=cus_name%>"+"|";
        infoStr+="<%=cus_addr%>"+"|";
 	    infoStr+="现金"+"|";
	    infoStr+="<%=totalFee%>"+"|";
	    infoStr+="申请备卡。*手续费："+"<%=temp%>"+"*SIM卡费："+"<%=paraStr[7]%>"+"*流水号："+"<%=fg[0][0]%>"+"|";	 
	    location="chkPrint.jsp?retInfo="+infoStr+"&dirtPage=s1242.jsp"+"&activePhone="+"<%=srv_no%>";
			*/
			var  billArgsObj = new Object();
			$(billArgsObj).attr("10001","<%=work_no%>");
			$(billArgsObj).attr("10002","<%=new java.text.SimpleDateFormat("yyyy",Locale.getDefault()).format(new java.util.Date())%>");
		 	$(billArgsObj).attr("10003","<%=new java.text.SimpleDateFormat("MM",Locale.getDefault()).format(new java.util.Date())%>");
		 	$(billArgsObj).attr("10004","<%=new java.text.SimpleDateFormat("dd",Locale.getDefault()).format(new java.util.Date())%>");
			$(billArgsObj).attr("10005","<%=cus_name%>");
			$(billArgsObj).attr("10006","<%=opName%>");
			$(billArgsObj).attr("10008","<%=srv_no%>");
			$(billArgsObj).attr("10015","<%=totalFee%>");//小写
			$(billArgsObj).attr("10016","<%=totalFee%>");//合计金额(大写) 传小写，公共页转换
			$(billArgsObj).attr("10017","*");//现金
			$(billArgsObj).attr("10030","<%=fg[0][0]%>");//业务流水
			$(billArgsObj).attr("10036","<%=opCode%>");
			$(billArgsObj).attr("10031","<%=loginName%>");//开票人
			$(billArgsObj).attr("10041","SIM卡");//品名规格
			$(billArgsObj).attr("10061","<%=newSimName%>");//型号
			$(billArgsObj).attr("10042","张");//单位
			$(billArgsObj).attr("10043","1");//数量
			$(billArgsObj).attr("10044","<%=paraStr[7]%>");//单价
			$(billArgsObj).attr("10046","<%=totalFee%>");//合计
			$(billArgsObj).attr("10028","");//参与的营销活动名称
			$(billArgsObj).attr("10047","");//活动代码
			
			var printInfo = "";
			var h=210;
			var w=400;
			var t=screen.availHeight/2-h/2;
			var l=screen.availWidth/2-w/2;
			var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 
			var path = "/npage/public/pubBillPrintCfm_YGZ.jsp?dlgMsg=客户<%=cus_name%><%=opName%>已成功，下面将打印发票！";
			var path = path + "&infoStr="+printInfo+"&loginAccept=<%=fg[0][0]%>&opCode=<%=opCode%>&submitCfm=submitCfm";
			var ret = window.showModalDialog(path,billArgsObj,prop); 
			location = "/npage/s1210/s1242.jsp?activePhone=<%=srv_no%>&opCode=1242&opName=申请备卡";
	
	</script>
<%
	  }
   }
   else
   {
%>
     <script>
	   rdShowMessageDialog("服务未能成功，服务代码：<%=retCode1%><br>服务信息：<%=retMsg1%>.请重新操作！",0);
	   history.go(-1);
    </script>
<%
   }
%>       
