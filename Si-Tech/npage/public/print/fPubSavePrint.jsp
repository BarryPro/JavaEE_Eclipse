<%
/********************
 version v2.0
开发商: si-tech
*
*update:zhanghonga@2008-08-19 页面改造,修改样式
*1270,1219,2266等模块中使用的页面.
********************/
%>

<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UtypeUtil"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UElement"%>

<%	
		/***用户手机号	phone_no**操作工号	login_no**票据类型	bill_type*/
 
		String workNo =  WtcUtil.getParameter("workNo",request);
		String opCode=request.getParameter("opCode");
		String login_accept=request.getParameter("login_accept");
		String retType=request.getParameter("retType");
	    String billType=request.getParameter("billType");
	    String phoneNo=request.getParameter("phoneNo");
		String arrayOrderId=request.getParameter("arrayOrderId");//服务定单号
		String region_code=request.getParameter("region_code");
		String time=request.getParameter("time");
		if(time==null) time="0";

	    String errCode="";
	    String errMsg="";

		String serverName="";
		if(billType.equals("1")){
			serverName="sCtOEltPrint";
		}else if(billType.equals("2")){
			serverName="sCtOBillPrt";
		}
		System.out.println(login_accept+"    "+billType+"    "+phoneNo+"    "+arrayOrderId+"   "+opCode+"   "+serverName);
/**----------------构建参数----------------*/
UType uBasicInfo=new UType();
	uBasicInfo.setUe("STRING",opCode);
	uBasicInfo.setUe("LONG",billType);
	uBasicInfo.setUe("STRING",arrayOrderId);
	uBasicInfo.setUe("STRING",phoneNo);
	uBasicInfo.setUe("LONG",login_accept);
	if(billType.equals("2")){
		uBasicInfo.setUe("STRING",region_code);
	}else if(billType.equals("1")){
		uBasicInfo.setUe("STRING",time);
	}
%>
<%
/**
 * 免填单打印服务
 * @inparam uInParam
 *         <uInParam>
 *           <uBasicInfo>			 基本信息
 *             sOpCode 操作代码 
 *             lBillType 票据类型 
 *             serv_order_id 操作流水 
 *             sPhoneNo 手机号码 
 *           </uBasicInfo>
 *         </uInParam>
 * @outparam ctrlInfo
 *		   <uOutParams>
 *			 <uOutInfo>
 *				0class_code  字段域代码
 *				1content_type  信息类型
 *				2row_num  行号
 *				3col_num  列号
 *				4font_size  字体大小
 *				5font_color  字体颜色
 *				6is_bold  是否粗体
 *				7max_size  最大长度
 *				8line_size  每行最大长度
 *				9is_wrap  是否自动换行
 *				10print_content  打印内容
 *				11row_space  行间距
 *				12font_name  字体名称
 *			 </uOutInfo>
 *			 ..........
 *		   </uOutParams>
 * @author	wangmq
 * @return uOutParams
 */
//sCtOEltPrint
 %>

	<wtc:utype name="<%=serverName%>" id="retVal" scope="end">
		<wtc:uparam value="<%=uBasicInfo%>" type="UTYPE"/>
	</wtc:utype>

var impResultArr = new Array();	
var plusResultArr=new Array();
	<%
				for(int i=0;i<retVal.getSize("2.1");i++){
	%>
					var temResultArr = new Array();
	<%
					for(int j=0;j<retVal.getSize("2.1."+i);j++){
	%>
						
						temResultArr[<%=j%>] = "<%=retVal.getValue("2.1."+i+"."+j).replaceAll("\r\n","")%>";
	<%				
					}
	%>
					impResultArr[<%=i%>]=temResultArr;
	<%
				}	
	%>
	<%/*---------------获取头尾信息------------------*/
				for(int i=0;i<retVal.getSize("2.0");i++){
	%>
					var temResultArr2 = new Array();
	<%
					for(int j=0;j<retVal.getSize("2.0."+i);j++){
	%>
						temResultArr2[<%=j%>] = "<%=retVal.getValue("2.0."+i+"."+j).replaceAll("\r\n","")%>";
	<%				
					}
	%>
					plusResultArr[<%=i%>]=temResultArr2;
	<%
				}	
	%>

	
<%

String retCode=retVal.getValue(0);
String retMsg=retVal.getValue(1);
System.out.println("#  return  # - "+retCode+" | "+retMsg);
if(retCode.equals("0")){   
	if(retVal.getSize(2)>0)
	{
		 errCode="000000";
     errMsg="工单打印成功！";
	}
	else{
		 errCode="000001";
     errMsg="打印内容为空！";
	}



}else{ 
   errCode=retCode;
   errMsg=retMsg;
	}

%>
var response = new AJAXPacket();
var retType = "";
var errCode = ""
var errMsg = "";
retType = "<%=retType%>";
errCode = "<%=errCode%>";
errMsg = "<%=errMsg%>";
response.data.add("retType",retType);
response.data.add("errCode",errCode);
response.data.add("errMsg",errMsg);
response.data.add("impResultArr",impResultArr);
response.data.add("plusResultArr",plusResultArr);
core.ajax.receivePacket(response);

