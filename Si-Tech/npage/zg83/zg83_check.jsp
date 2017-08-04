<%
/********************
 version v2.0
开发商: si-tech
*
*update:zhanghonga@2008-08-15 页面改造,修改样式
*
********************/
%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page contentType="text/html; charset=GBK" %>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%
		String regionCode= (String)session.getAttribute("regCode"); 
	
	  String card_no = request.getParameter("card_no");
	  
		//String remark = request.getParameter("remark");	  
			  	  	  	  

		String[] inParam0 = new String[2];
		inParam0[0]="	 select to_char(count(card_no)) from dchncardres where card_status=2 and card_no = :card_no";
		inParam0[1]="card_no="+card_no;
		String count="0";
		String count1="0";		
		String count2="0";	
		String checkresult="";
		String checkMsg="";
%>
	//先校验充值卡是否已销售	
	<wtc:service name="TlsPubSelCrm"  outnum="6" >
	<wtc:param value="<%=inParam0[0]%>"/>
	<wtc:param value="<%=inParam0[1]%>"/>
	</wtc:service>
	<wtc:array id="checkArr" scope="end" />
<%
		if(checkArr!=null&&checkArr.length>0){
			count=checkArr[0][0];
			count="1";
		}
		System.out.println("----- 先校验充值卡是否已销售--- "+count);
		if(count.equals("1"))
		{		
			//如果已销售，则继续校验卡号是否新建的一张表中（crm提供表名dbcustadm.dWrongCard），如果是则下一步校验
		  String[] inParam1 = new String[2];
			inParam1[0]="	SELECT to_char(count(card_no)) FROM dbcustadm.dWrongCard where card_no = :card_no";
			inParam1[1]="card_no="+card_no;	  
%>
			<wtc:service name="TlsPubSelCrm"  outnum="6" >
			<wtc:param value="<%=inParam1[0]%>"/>
			<wtc:param value="<%=inParam1[1]%>"/>
			</wtc:service>
			<wtc:array id="checkArr1" scope="end" />
<%
			if(checkArr1!=null&&checkArr1.length>0){
				count1=checkArr1[0][0];
				count1="1";
			}
			System.out.println("----- 校验卡号是否新建表中--- "+count1);
			if(count1.equals("1")){
			//经过校验，在表中，进行下一步验证
%>
				<wtc:service name="bs_zg82Init" routerKey="regionCode" routerValue="<%=regionCode%>"  retcode="scode" retmsg="sret" outnum="3">
					<wtc:param value="<%=card_no%>"/> 
				</wtc:service>
				<wtc:array id="result" scope="end" /> 
<%
				if(result!=null&&result.length>0){
					count2=result[0][2];
					count2="1";
				}
				if(count2.equals("1")){ //1未激活，可继续操作；0激活，停止操作
					checkresult="Y";
				}else{
					
					checkresult="N";
					checkMsg="该充值卡为已未激活状态！";
				}
			}else{
				checkresult="N";
				checkMsg="该充值卡卡号在dbcustadm.dWrongCard表中不存在！";
			}
		}
		else
		{
			checkresult="N";
			checkMsg="该充值卡未销售！";
		}
	%>
var response = new AJAXPacket();
var checkresult =   "<%=checkresult%>";
var checkMsg =   "<%=checkMsg%>";
response.data.add("checkresult",checkresult); 
response.data.add("checkMsg",checkMsg); 
core.ajax.receivePacket(response);



 
