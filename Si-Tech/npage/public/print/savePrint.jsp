<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UtypeUtil"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UElement"%>
<%@ include file="splitStr.jsp" %>
<% 

System.out.println("------------------------------------savePrint.jsp------------------------------------------------");
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", 0);
	String work_no = (String)session.getAttribute("workNo");
	String work_name = (String)session.getAttribute("workName");
	String org_code = (String)session.getAttribute("orgCode");
	

	String opCode=request.getParameter("opCode");
	String retArray[]=null;//返回结果序列

	String servOrderId=request.getParameter("servOrderId");
	String DlgMsg = request.getParameter("DlgMsg");
	String countNum=request.getParameter("countNum");
	String regionCode=request.getParameter("regionCode");
	String orderArrayId=request.getParameter("orderArrayId");//服务定单号
	String printInfo = request.getParameter("printInfo");
	String pType = request.getParameter("pType");
	String billType = request.getParameter("billType");
	String serverName="";
	if(billType.equals("1")){
		serverName="sCtOEltCreat";
	}else if(billType.equals("2")){
		serverName="sCtOBillCrt";
	}
	String SphoneNo = request.getParameter("SphoneNo");
	String EphoneNo = request.getParameter("EphoneNo");
	String submitCfm = request.getParameter("submitCfm");
	
	String mode_code = request.getParameter("mode_code");  //资费代码 如果没有值 前台传过来的就是字符串 null
	String fav_code = request.getParameter("fav_code");    //特服代码 如果没有值 前台传过来的就是字符串 null
	String area_code = request.getParameter("area_code");  //小区代码 如果没有值 前台传过来的就是字符串 null
	String[] mode_list = null;
	String[] fav_list  = null;
	String[] area_list = new String[1];
	if(mode_code!="null"){
		mode_list = mode_code.split("~");
	}else{
		mode_list=new String[0];
	}
	if(fav_code!="null"){
		fav_list = fav_code.split("\\|");
	}else{
		fav_list=new String[0];
	}
	if(area_code!="null"){
		area_list[0] = area_code;
	}
	String login_accept="";
	String disabledFlag="";
	
	System.out.println("====out====");
	String classsql="";
	if(billType.equals("1")){
		classsql="select print_content_desc,class_code from dborderadm.sprintmodeldet where bill_type=1 and print_model_id=1";
	}else{
		classsql="select  print_content_desc,class_code from  dborderadm.sPrintModelDet WHERE print_model_id=8 AND bill_type=2";
	}
%>
		<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=org_code.substring(0,2)%>" outnum="2">
			<wtc:sql><%=classsql%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="result" scope="end" />
		<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=org_code.substring(0,2)%>" outnum="1">
			<wtc:sql>
				select region_name from sregioncode where region_code='?'
			</wtc:sql>
			<wtc:param value="<%=org_code.substring(0,2)%>" />
		</wtc:pubselect>
		<wtc:array id="c1" scope="end" />
<%
		HashMap hm=new HashMap();
		for(int i=0;i<result.length;i++){
			System.out.println("&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&"+result[i][0]+"     "+result[i][1]);
			hm.put(result[i][0],result[i][1]);
		}
		String [][] retInfo=null;
		if(billType.equals("1")){
			retInfo=getParamIn(c1[0][0],orderArrayId,printInfo,work_name,hm);	
		}else if(billType.equals("2")){
			retInfo=getParamInForBill(c1[0][0],printInfo,work_no,work_name,hm);		
		}

 /**---------------------------------------------
 *                   构建参数
 *-----------------------------------------------
 */

 
/**
 * 发票的创建服务
 * @inparam uInParam
 *         <uInParam>
 *           <uBasicInfo>							用户基本信息
 *             sOpCode 操作代码 
 *             lBillType 票据类型 
 *             sLoginNo 操作工号 
 *             lLongAccept 操作流水 
 *             sPhoneNo 手机号码 
 *           </uBasicInfo>
 *           <uClassInfos>						打印项的内容。
 *             <uClassInfo>						打印项的明细。
 *               sClassCode 域代码 
 *               sClassRed 域序号 
 *               sClassValue 域值 
 *             </uClassInfo>
 *             ...
 *           </uClassInfos>						
 *           <uModeInfos>						套餐信息。
 *             <uModeInfo>						套餐信息的明细。
 *               mode_code 套餐代码 
 *             </uModeInfo>
 *             ...
 *           </uModeInfos>						
 *           <uFuncInfos>						套餐信息。
 *             <uFuncInfo>						套餐信息的明细。
 *               func_code 特服代码 
 *             </uFuncInfo>
 *             ...
 *           </uFuncInfos>						
 *           <uAreaInfos>						套餐信息。
 *             <uAreaInfo>						套餐信息的明细。
 *               area_code 小区代码 
 *             </uAreaInfo>
 *             ...
 *           </uAreaInfos>
 *         </uInParam>
 * @outparam ctrlInfo
 * @author	wangmq
 * @return NULL
 */
System.out.println("构建参数--------------------------------------------"+billType);
		UType uBasicInfo=new UType();
			uBasicInfo.setUe("STRING",opCode);
			uBasicInfo.setUe("LONG",billType);

			uBasicInfo.setUe("STRING",work_no);
			uBasicInfo.setUe("LONG","0");
			uBasicInfo.setUe("STRING",SphoneNo);
			uBasicInfo.setUe("STRING",orderArrayId);
			uBasicInfo.setUe("INT",countNum);
			uBasicInfo.setUe("STRING",regionCode);
			System.out.println(opCode+"    "+ billType+"    "+ work_no+"    "+ login_accept+"    "+  SphoneNo+"  end");
		UType uClassInfos=new UType();
			UType uClassInfo=null;
			for(int i=0;i<retInfo[0].length;i++){
				uClassInfo=new UType();
				uClassInfo.setUe("STRING",retInfo[0][i]);//域代码
				uClassInfo.setUe("STRING",retInfo[1][i]);//域序号
				uClassInfo.setUe("STRING",retInfo[2][i]);//域值
				uClassInfo.setUe("STRING",retInfo[3][i]);//其他
				uClassInfos.setUe(uClassInfo);
				uClassInfo=null;
				System.out.println(retInfo[0][i]+"      "+retInfo[1][i]+"     "+retInfo[2][i]+"     "+retInfo[3][i]+"          ####AAA");
			}
				
		UType uModeInfos=new UType();//套餐代码
		UType uFuncInfos=new UType();//特服代码
		UType uAreaInfos=new UType();//小区代码
		UType uModeInfo=null;
		UType uFuncInfo=null;
		UType uAreaInfo=null;
		for(int i=0;i<mode_list.length;i++){
			uModeInfo=new UType();
			uModeInfo.setUe("STRING",mode_list[i]);
			uModeInfos.setUe(uModeInfo);
			uModeInfo=null;

			uFuncInfo=new UType();
			uFuncInfo.setUe("STRING",fav_list[i]);
			uFuncInfos.setUe(uFuncInfo);
			uFuncInfo=null;

			uAreaInfo=new UType();
			uAreaInfo.setUe("STRING",area_list[0]);
			uAreaInfos.setUe(uAreaInfo);
			uAreaInfo=null;

			System.out.println(mode_list[i]+"        "+fav_list[i]+"         "+area_list[0]+"       ####BBB");
		}

%>

	<wtc:utype name="<%=serverName%>" id="retVal" scope="end">
		<wtc:uparam value="<%=uBasicInfo%>" type="UTYPE"/>
		<wtc:uparam value="<%=uClassInfos%>" type="UTYPE"/>
		<wtc:uparam value="<%=uModeInfos%>" type="UTYPE"/>
		<wtc:uparam value="<%=uFuncInfos%>" type="UTYPE"/>
		<wtc:uparam value="<%=uAreaInfos%>" type="UTYPE"/>
	</wtc:utype>



	var response = new AJAXPacket();
	var a="<%=retVal.getValue(0)%>";
	var b="<%=retVal.getValue(1)%>";
alert(a + "#" + b);

	<%
	
	System.out.println("@@@@@@@@@@@@@@");
		if(retVal.getSize("2")>0){
			if(retVal.getValue(0).equals("0")){
	%>
				response.data.add("retVal","<%=retVal.getValue("2.0")%>");
	<%
			}
		}else{
	%>
		a="f_1010";
		b="错误：得不到流水号";
		response.data.add("retVal","0");
	<%
		}
	%>
	response.data.add("retCode",a);
	response.data.add("retMsg",b);
	core.ajax.receivePacket(response);

