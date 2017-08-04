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
 		String work_no = (String)session.getAttribute("workNo");
		String retType=request.getParameter("retType");
	    String billType=request.getParameter("billType");
	    String phoneNo=request.getParameter("phoneNo");
	    String login_accept=request.getParameter("login_accept");
	    String errCode="";
	    String errMsg="";
	    String servOrderId=request.getParameter("servOrderId");//服务定单号
	    System.out.println("retType="+retType);
	    System.out.println("billType="+billType);
		String serverName="";
		if(billType.equals("1")){
			serverName="sCtOEltJPrint";
			System.out.println("$$$$$$$$$$$$$$$$$$$$$$");

		}else if(billType.equals("2")){
			serverName="sCtOBillJPrt";

		}
			System.out.println(billType+"      "+servOrderId+"    "+phoneNo+"$$$$$$$$$$$$$$$$$$$$");
/**-------------------构建参数---------------------*/
UType uBasicInfo=new UType();
	uBasicInfo.setUe("LONG",billType);
	uBasicInfo.setUe("STRING",servOrderId);
	uBasicInfo.setUe("STRING",phoneNo);
/**
 * 免填单合并打印
 * @inparam uInParam
 *         <uInParam>
 *           <uBasicInfo>			 基本信息
 *             print_accept 操作代码 
 *             lBillType 票据类型 
 *             serv_order_id 服务定单子项ID 
 *             sPhoneNo 手机号码 
 *             sLoginNo 操作工号 
 *           </uBasicInfo>
 *         </uInParam>
 * @outparam ctrlInfo
 *		   <uOutParams>
 *			 <uOutInfo>
 *				class_code  字段域代码
 *				content_type  信息类型
 *				row_num  行号
 *				col_num  列号
 *				font_size  字体大小
 *				font_color  字体颜色
 *				is_bold  是否粗体
 *				max_size  最大长度
 *				line_size  每行最大长度
 *				is_wrap  是否自动换行
 *				print_content  打印内容
 *				row_space  行间距
 *				font_name  字体名称
 *			 </uOutInfo>
 *			 ..........
 *		   </uOutParams>
 * @author	wangmq
 * @return uOutParams
 */
%>

	<wtc:utype name="<%=serverName%>" id="retVal" scope="end">
		<wtc:uparam value="<%=uBasicInfo%>" type="UTYPE"/>
	</wtc:utype>
<%

System.out.println("# retCode = "+retVal.getValue(0));
System.out.println("# retMsg  = "+retVal.getValue(1));
	System.out.println("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"+retVal.getSize("2.1"));

%>
	var impResultArr = new Array();	
	var plusResultArr=new Array();
	<%/*--------------获取内容----------------*/
				for(int i=0;i<retVal.getSize("2.1");i++){
	%>
					var temResultArr = new Array();
	<%
					for(int j=0;j<retVal.getSize("2.1."+i);j++){
	%>
						temResultArr[<%=j%>] = "<%=retVal.getValue("2.1."+i+"."+j).replaceAll("\r\n","")%>";
						
	<%				System.out.println(retVal.getValue("2.1."+i+"."+j));
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

