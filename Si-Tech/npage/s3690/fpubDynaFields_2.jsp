<%
/********************
 * version v2.0
 * 开发商: si-tech
 * update by qidp @ 2009-01-14
 * include by s3690_1.jsp
 ********************/
%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.sitech.boss.pub.util.*"%>
<%@ page import="com.sitech.boss.login.ejb.*"%>
<%@ page import="com.sitech.boss.login.wrapper.*"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%@ include file="/npage/public/pubSASql.jsp" %>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="com.sitech.boss.pub.*" %>
<%@ page import="com.sitech.boss.pub.util.*"%>
<%@ page import="java.util.*"%>  
<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>
<%
/*
	名称：动态生成字段
	调用外部变量：
		int fieldCount=resultList.length;

		boolean isGroup = true;
		String []fieldCodes=new String[fieldCount];
		String []fieldNames=new String[fieldCount];
		String []fieldPurposes=new String[fieldCount];
		String []fieldValues=new String[fieldCount];
		String []dataTypes=new String[fieldCount];
		String []fieldLengths=new String[fieldCount];
		String []fieldGroupNo=new String[fieldCount];
		String []fieldGroupName=new String[fieldCount];
		String []fieldMaxRows=new String[fieldCount];
		String []fieldMinRows=new String[fieldCount];
		String []fieldCtrlInfos=new String[fieldCount];
		String listShow;
	使用方法介绍：
		该文件不能单独使用，需要其他文件include这个文件
	参照OPCODE：3505、3508
	Author:lugz,yinyx
*/
%>
<%
  String listShow = request.getParameter("listShow");
  String regionCode = request.getParameter("regionCode");
  String workno = request.getParameter("workno");
  String org_code = request.getParameter("org_code");
  String districtCode = request.getParameter("districtCode");
  String userType = request.getParameter("userType");
  String v_isGroup = request.getParameter("isGroup");
  String sqlStr = "";
  String powerRight = request.getParameter("powerRight");
  String addDate = request.getParameter("addDate");
  String openLabel = request.getParameter("openLabel");
  String telNo = request.getParameter("telNo");
  String dateStr = request.getParameter("dateStr");
  String xProductCode = request.getParameter("xProductCode");
  
  String v_fieldCount = request.getParameter("fieldCount");
  String v_nextFlag = request.getParameter("nextFlag");
  String v_iField = request.getParameter("iField");
  
  Boolean Bl = new Boolean(v_isGroup);		
  boolean isGroup = Bl.booleanValue();
  int fieldCount = Integer.parseInt(v_fieldCount);
  int nextFlag = Integer.parseInt(v_nextFlag);
  int iField = Integer.parseInt(v_iField);
  Logger logger = Logger.getLogger("fpubDynaFields_2.jsp");
  
  
  String[] fieldCodes = (String[])request.getAttribute("fieldCodes");
  String[] fieldNames = (String[])request.getAttribute("fieldNames");
  String[] fieldPurposes = (String[])request.getAttribute("fieldPurposes");
  String[] fieldValues = (String[])request.getAttribute("fieldValues");
  String[] dataTypes = (String[])request.getAttribute("dataTypes");
  String[] fieldLengths = (String[])request.getAttribute("fieldLengths");
  String[] fieldGroupNo = (String[])request.getAttribute("fieldGroupNo");
  String[] fieldGroupName = (String[])request.getAttribute("fieldGroupName");
  String[] fieldMaxRows = (String[])request.getAttribute("fieldMaxRows");
  String[] fieldMinRows = (String[])request.getAttribute("fieldMinRows");
  String[] fieldCtrlInfos = (String[])request.getAttribute("fieldCtrlInfos");
  String[] fieldReadOnly = (String[])request.getAttribute("fieldReadOnly");
  String[] openParamFlag = (String[])request.getAttribute("openParamFlag");
  String[][] resultList = (String[][])request.getAttribute("resultList");
  
  String v_regionCode = request.getParameter("v_regionCode");
%>
<%
	    		//组个数
    			int grpCount = 0;
    			iField = 0;
    			Vector vecGrp = new Vector();
    			Hashtable htGrp= new Hashtable();

    			while(iField<fieldGroupNo.length)
    			{
    			    if(!fieldGroupNo[iField].equals("0"))
    			    {
	    			    if(vecGrp.contains(fieldGroupNo[iField]))
	    			    {
	    			    }
	    			    else
	    			    {
	    			        vecGrp.add(fieldGroupNo[iField]);
	    			        //组no,序号
	    			        htGrp.put(fieldGroupNo[iField],new Integer(iField));
	    			        grpCount++;
	    			    }
    			    }
    			  	    iField++;
    			}

	String [][]fieldCalcFieldReadOnlys=null;
	//下拉列表数据
	String[][] fieldParamCodes = new String[][]{};
	String[][] fieldParamSql = new String[][]{};
	String [] paraIn2 = new String[2];

	HashMap hm = new HashMap();
	if(!hm.containsKey("regionCode"))   hm.put("regionCode",regionCode);
	if(!hm.containsKey("workno"))       hm.put("workno",workno);
	if(!hm.containsKey("org_code"))     hm.put("org_code",org_code);
	if(!hm.containsKey("districtCode")) hm.put("districtCode",districtCode);

%>
<%
	if (nextFlag==2)
	{
%>
<script language="javascript">
function calcFieldValue(calaField)//根据公式计算单个字段的值
{
<%

	try
	{
		sqlStr= "select field_code, ref_field_code,ref_field_value, nvl(formula,'')"
				+"  from sUserFieldFormula"
				+" where user_type =:userType"
				+" order by field_code, ref_field_code,ref_field_value";
			//retArray = callView.sPubSelect("4",sqlStr);


			paraIn2[0] = sqlStr;
      paraIn2[1]="userType="+userType;
%>
            <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="4" >
            	<wtc:param value="<%=paraIn2[0]%>"/>
            	<wtc:param value="<%=paraIn2[1]%>"/>
            </wtc:service>
            <wtc:array id="retArr1" scope="end"/>
<%

  			//fieldCalcFieldReadOnlys= (String[][])retArray.get(0);
  			if(retCode1.equals("000000")){
  			    fieldCalcFieldReadOnlys = retArr1;
  			}

		}
	catch(Exception e)
	{
		logger.error("Call sunView is Failed!");
	}
	int iPos=0;

		for(int i = 0; i < fieldCalcFieldReadOnlys.length; i ++)
		{
			if (!fieldCalcFieldReadOnlys[i][0].trim().equals(""))
			{
		    out.println("//目标字段是组外字段");
    		out.println("if(typeof(document.frm.F" + fieldCalcFieldReadOnlys[i][0] + ".length)==\"undefined\")");
    		out.println("{");
				out.println("	if ( document.frm.F" + fieldCalcFieldReadOnlys[i][0] + ".id == calaField.id)");
				out.println("	{");
				if(!fieldCalcFieldReadOnlys[i][1].equals(""))
				{
				out.println("		if (document.frm.F" + fieldCalcFieldReadOnlys[i][1] + ".value == '" + fieldCalcFieldReadOnlys[i][2] + "')");
				out.println("		{");
				}
				//:12006+(:12002*:12005)
				//eval(frm.F12006.value)+(eval(frm.F12002.value)*eval(frm.F12005.value))
				out.println("		  var length = 1;");
				 String fma =fieldCalcFieldReadOnlys[i][3];
				while(true)
				{

					iPos = fma.indexOf(":");
					if (iPos < 0)
					{
						break;
					}
					out.println("		  var flagN"+fma.substring(iPos+1,iPos+1+5)+" = \"\";");

					        //如果参与运算的字段是组内的
					out.println("			if(typeof(document.frm.F" + fma.substring(iPos+1,iPos+1+5) + ".length)!=\"undefined\")");
					out.println("			{");

					out.println("			length = document.frm.F"+fma.substring(iPos+1,iPos+1+5)+".length;");
					out.println("			flagN"+fma.substring(iPos+1,iPos+1+5)+" = \"[n]\";");
					out.println("			}");
					        //如果参与运算的字段不是组内的
					out.println("			else");
					out.println("			{");
					out.println("	  	      flagN"+fma.substring(iPos+1,iPos+1+5)+" = \"\";");



					fma = fma.substring(0,iPos)
								+ "eval(eval(\"frm.F"
								+fma.substring(iPos+1,iPos+1+5)
								+"\"+flagN"+fma.substring(iPos+1,iPos+1+5)+"+\".value\"))"
								+ fma.substring(iPos + 6, fma.length());
					out.println("			}");


				}
				out.println("       		var result = 0;");
				out.println("			if (calaField.readOnly)");
				out.println("			{");
				out.println("				for(var n = 0 ; n < length ; n++)");
	            out.println("				{");
				out.println("				result =result + eval(" + fma + ");");
				out.println("				}");
				out.println("				calaField.value = result;");
				out.println("			}");
				if(!fieldCalcFieldReadOnlys[i][1].equals(""))
				{
				out.println("		}");
				}
				out.println("	}");
				out.println("}");

				out.println("//目标字段是组内字段");
	    		out.println("else{");
	    		out.println("	for(var n = 0 ; n < document.frm.F" + fieldCalcFieldReadOnlys[i][0] + ".length ; n++)");
	    		out.println("	{");
	    		out.println("		if ( document.frm.F" + fieldCalcFieldReadOnlys[i][0] + "[n].id == calaField.id)");
	 			out.println("		{");
	 			if(!fieldCalcFieldReadOnlys[i][1].equals(""))
				{
	 			out.println("			if (document.frm.F" + fieldCalcFieldReadOnlys[i][1] + ".value == '" + fieldCalcFieldReadOnlys[i][2] + "')");
				out.println("			{");
				}
				out.println("			var length = 1;");

				 fma =fieldCalcFieldReadOnlys[i][3];
				while(true)
				{
					iPos = fma.indexOf(":");
					if (iPos < 0)
					{
						break;
					}

					out.println("		  var flagN"+fma.substring(iPos+1,iPos+1+5)+" = \"\";");

					        //如果参与运算的字段是组内的
					out.println("			if(typeof(document.frm.F" + fma.substring(iPos+1,iPos+1+5) + ".length)!=\"undefined\")");
					out.println("			{");

					out.println("			length = document.frm.F"+fma.substring(iPos+1,iPos+1+5)+".length;");
					out.println("			flagN"+fma.substring(iPos+1,iPos+1+5)+" = \"[n]\";");
					out.println("			}");
					        //如果参与运算的字段不是组内的
					out.println("			else");
					out.println("			{");
					out.println("	  	      flagN"+fma.substring(iPos+1,iPos+1+5)+" = \"\";");
					            fma = fma.substring(0,iPos)
								+ "eval(eval(\"frm.F"
								+fma.substring(iPos+1,iPos+1+5)
								+"\"+flagN"+fma.substring(iPos+1,iPos+1+5)+"+\".value\"))"
								+ fma.substring(iPos + 6, fma.length());
					out.println("			}");


				}
				out.println("		 	var result = 0;");
				out.println("			if (calaField.readOnly)");
				out.println("			{");

				out.println("				result =result + eval(" + fma + ");");

				out.println("				calaField.value = result;");
				out.println("			}");
				if(!fieldCalcFieldReadOnlys[i][1].equals(""))
				{
				out.println("			}");
				}
				out.println("		}");
	    		out.println("	}");
				out.println("	}");
			}
		}
		out.println("return true;");

%>
}

function clearCalcFields(selectId)//当下拉框发生变化时,清空计算字段,并且重值各个编辑框的状态
{
	/* begin for 关于在专线开户界面增加统谈专线项目填写元素的函@2014/11/24 */
	if(selectId.value == "01"){
		$("[name=F10774]:checkbox").attr('disabled', true);
		$("[name=F10774]:checkbox").attr('checked', false);
	}else{
		$("[name=F10774]:checkbox").attr('disabled', false);
	}
	/* end for 关于在专线开户界面增加统谈专线项目填写元素的函@2014/11/24 */
<%
	String [][]fieldCalcFields=null;
	try
	{
		if (isGroup)
		{
			sqlStr= "select a.field_code "
					+"	  from sUserFieldCode a, sGrpSmFieldRela b"
					+"	 where a.busi_type = b.busi_type"
					+"	   and a.field_code = b.FIELD_CODE"
					+"	   and a.FIELD_TYPE = '19'"
					+"	   and b.USER_TYPE =:userType";
		}
		else
		{
			sqlStr= "select a.field_code "
					+"	  from sUserFieldCode a, sUserTypeFieldRela b"
					+"	 where a.busi_type = b.busi_type"
					+"	   and a.field_code = b.FIELD_CODE"
					+"	   and a.FIELD_TYPE = '19'"
					+"	   and b.USER_TYPE =:userType";
		}
		//retArray = callView.sPubSelect("1",sqlStr);

		paraIn2[0] = sqlStr;
        paraIn2[1]="userType="+userType;
%>
        <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode22" retmsg="retMsg22" outnum="1" >
        	<wtc:param value="<%=paraIn2[0]%>"/>
        	<wtc:param value="<%=paraIn2[1]%>"/>
        </wtc:service>
        <wtc:array id="retArr22" scope="end"/>
<%

/*		//TODO 虚拟数据填充
			 String [][]s={
    		         {"10008"},
	    	         {"10004"}
    		 };
    		  retArray.add(0,s);
	*/
			//fieldCalcFields = (String[][])retArray.get(0);
        if(retCode22.equals("000000")){
            fieldCalcFields = retArr22;
        }

	}
	catch(Exception e)
	{
		logger.error("Call sunView is Failed!");
	}

	int c = 0;
	while(c<fieldCount)
	{
		if(dataTypes[c].equals("19"))
		{
			if(fieldGroupNo[c].equals("0"))
			{
				out.println("document.frm.F" + fieldCodes[c]+ ".value = ''");
			}
			else
			{
				out.println("for(var n = 0 ; n < document.frm.F" + fieldCodes[c] + ".length ; n++){");
				out.println("document.frm.F" + fieldCodes[c] + "[n].value = ''");
				out.println("}");
			}
		}
		c++;
	}

	for(int i = 0; i < fieldCalcFields.length; i ++)
	{
		if (!fieldCalcFields[i][0].trim().equals(""))
		{
			out.println("document.frm.F" + fieldCalcFields[i][0] + ".value = ''");
		}
	}

	//String [][]fieldCalcFieldReadOnlys=null;
	try
	{
		sqlStr= "select ref_field_code,ref_field_value,field_code, nvl(formula,'')"
				+"  from sUserFieldFormula"
				+" where user_type =:userType"
				+" order by ref_field_code,ref_field_value,field_code";
			//retArray = callView.sPubSelect("4",sqlStr);

			paraIn2[0] = sqlStr;
      paraIn2[1]="userType="+userType;
%>
            <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode3" retmsg="retMsg3" outnum="4" >
            	<wtc:param value="<%=paraIn2[0]%>"/>
            	<wtc:param value="<%=paraIn2[1]%>"/>
            </wtc:service>
            <wtc:array id="retArr3" scope="end"/>
<%

/*			//TODO 虚拟数据填充
			//retArry =
			String [][]s={
    		       	 {"10010","a","10008",":10005+10"},
    		         {"10010","a","10004",":10005*10+:10006"}
    		 };
    		  retArray.add(0,s);
*/
			//fieldCalcFieldReadOnlys = (String[][])retArray.get(0);
			if(retCode3.equals("000000")){
			    fieldCalcFieldReadOnlys = retArr3;
			}
		}
	catch(Exception e)
	{
		logger.error("Call sunView is Failed!");
	}
	for(int i = 0; i < fieldCalcFieldReadOnlys.length; i ++)
	{
		if (!fieldCalcFieldReadOnlys[i][0].trim().equals(""))
		{
			out.println("if ( document.frm.F" + fieldCalcFieldReadOnlys[i][0] + ".id == selectId.id)");
			out.println("{");
			out.println("	if (selectId.value == '" + fieldCalcFieldReadOnlys[i][1] + "')");
			out.println("	{");
			out.println("		if(typeof(document.frm.F" + fieldCalcFieldReadOnlys[i][2] + ".length)!=\"undefined\")");
			out.println("		{");
			out.println("			for(var n = 0 ; n < document.frm.F" + fieldCalcFieldReadOnlys[i][2] + ".length ; n++)");
			out.println("			{");
			if (fieldCalcFieldReadOnlys[i][3] == null || fieldCalcFieldReadOnlys[i][3].equals(""))
			{
				out.println("		document.frm.F" + fieldCalcFieldReadOnlys[i][2] + "[n].readOnly=false;");
				out.println("		document.all('blue" + fieldCalcFieldReadOnlys[i][2] + "')[n].style.display='none';");
			}
			else
			{
				out.println("		document.frm.F" + fieldCalcFieldReadOnlys[i][2] + "[n].readOnly=true;");
				out.println("		document.all('blue" + fieldCalcFieldReadOnlys[i][2] + "')[n].style.display='';");
			}
			out.println("			}");
			out.println("		}");
			out.println("		else");
			out.println("		{");
			if (fieldCalcFieldReadOnlys[i][3] == null || fieldCalcFieldReadOnlys[i][3].equals(""))
			{
				out.println("		document.frm.F" + fieldCalcFieldReadOnlys[i][2] + ".readOnly=false;");
				out.println("		document.all('blue" + fieldCalcFieldReadOnlys[i][2] + "').style.display='none';");
			}
			else
			{
				out.println("		document.frm.F" + fieldCalcFieldReadOnlys[i][2] + ".readOnly=true;");
				out.println("		document.all('blue" + fieldCalcFieldReadOnlys[i][2] + "').style.display='';");
			}
			out.println("		}");
			out.println("	}");
			out.println("}");
		}
	}
%>
}
function calcAllFieldValues()//计算所有计算字段的值
{
	if (!checkDynaFieldValues(false))
		return false;

	<%
	int fieldCalcFieldsLen=0;
	fieldCalcFieldsLen = fieldCalcFields.length;

		for(int i = 0; i < fieldCalcFieldsLen; i ++)
		{

		out.println("if(typeof(document.frm.F" + fieldCalcFields[i][0] + ".length)==\"undefined\"){");
		out.println("if(!calcFieldValue(frm.F" + fieldCalcFields[i][0] + "))");
		out.println("return false;");
		out.println("}");
		out.println("else{");
		out.println("for(var n = 0 ; n < document.frm.F" + fieldCalcFields[i][0] + ".length ; n++){");
		out.println("if(!calcFieldValue(frm.F" + fieldCalcFields[i][0] + "[n]))");
		out.println("return false;");
		out.println("}");
		out.println("}");
		}

%>
	return true;
}
function JHshStrLen(sString)//计算字符串长度
{
	var sStr,iCount,i,strTemp ;
	iCount = 0 ;
	sStr = sString.split("");
	for (i = 0 ; i < sStr.length ; i ++)
	{
		strTemp = escape(sStr[i]);
		if (strTemp.indexOf("%u",0) == -1) // 表示是汉字
		{
		iCount = iCount + 1 ;
		}
		else
		{
		iCount = iCount + 2 ;
		}
	}
	return iCount ;
}
function checkDynaFieldValues(haveCalc)//检查编辑框内数据是否合法，haveCalc:是否包含对计算字段的检查
{

	var ret=true;
	var reta=true;
	var retb=true;
	var checkValues_flag = false;
<%
	int iLen=0;
	while(iLen<fieldCount)
	{
	%>
	checkValues_flag = false;
	<%
			//如果字段可空，且为空，则正确return true ,Y-可空 N-不可空
			if(!fieldCtrlInfos[iLen].equals("N"))
			{
			%>
			if(frm.F<%=fieldCodes[iLen]%>.value==''){
				checkValues_flag = true;
			}
			if($("[name=F10774]:checkbox").attr('disabled')){ //对端结算地市：置灰，不用校验 
				checkValues_flag = true;
			}else{
				var v_checks = "";
				$("[name=F10774]:checkbox").each(function(){
	        if($(this).attr("checked") == true){
	          v_checks += $(this).val();
	        }
      	});
      	if(v_checks != ""){
      		checkValues_flag = true;
      	}
			}
			
			<%
		}else if (fieldMinRows[iLen].equals("0"))//必填，但是组出现的行数最小为0并且行数的确为0	
		{%>
		
			if(typeof(document.frm.F<%=fieldCodes[iLen]%>)=="undefined"){
				checkValues_flag = true;
			}
			
		<%}%>
		if(!checkValues_flag)
		{
		if(typeof(document.frm.F<%=fieldCodes[iLen]%>.length)=="undefined"){

			frm.F<%=fieldCodes[iLen]%>.datatype=<%out.println(dataTypes[iLen]);%>;

			if (frm.F<%=fieldCodes[iLen]%>.datatype=='10'){//整型
				if ("<%=fieldCodes[iLen]%>" == "10603") {	//wanghfa修改 2011-1-12 10:43 移动总机接入BOSS需求
					reta = true;
				} else {
					reta=parseInt(frm.F<%=fieldCodes[iLen]%>.value)==frm.F<%=fieldCodes[iLen]%>.value;
				}
				if(JHshStrLen(frm.F<%=fieldCodes[iLen]%>.value) > "<%=fieldLengths[iLen]%>"){
					retb = false;
				}
				// add by wanglm 2010-01-12 专线条数不能等于0
				if(<%=fieldCodes[iLen]%> == "10019"){
					if(parseInt(frm.F<%=fieldCodes[iLen]%>.value) == 0  ){
						retb = false;
					}
				}
				// add by wanglm 2010-01-12 专线条数不能等于0
				ret = reta && retb;
			}
			else if (frm.F<%=fieldCodes[iLen]%>.datatype=='11'){//浮点型
				reta=parseFloat(frm.F<%=fieldCodes[iLen]%>.value)==frm.F<%=fieldCodes[iLen]%>.value;
				if(JHshStrLen(frm.F<%=fieldCodes[iLen]%>.value) > "<%=fieldLengths[iLen]%>"){
					 retb = false;
				   }
					ret = reta && retb;
			}
			else if (frm.F<%=fieldCodes[iLen]%>.datatype=='12'){//字符型
				flag=frm.F<%=fieldCodes[iLen]%>.value=='';
				reta=!flag;  //有值
				if(JHshStrLen(frm.F<%=fieldCodes[iLen]%>.value) > "<%=fieldLengths[iLen]%>"){
				 retb = false;
			 }
				ret = reta && retb;
			}
				/*gaopeng 2014/01/17 14:45:17 加入30和31的校验方法 start*/
				else if (frm.F<%=fieldCodes[iLen]%>.datatype=='30'){//字母和数字的组合
					ret=forNumChar(frm.F<%=fieldCodes[iLen]%>);
				}
				else if (frm.F<%=fieldCodes[iLen]%>.datatype=='31'){//中国移动手机号码
					ret=formobilesPhone(frm.F<%=fieldCodes[iLen]%>);
				}
				/*gaopeng 2014/01/17 14:45:17 加入30和31的校验方法 end*/
			else if (frm.F<%=fieldCodes[iLen]%>.datatype=='13'){//金额
				
				ret=forMoney(frm.F<%=fieldCodes[iLen]%>);
			}
			else if (frm.F<%=fieldCodes[iLen]%>.datatype=='14'){//日期
				ret=forDate(frm.F<%=fieldCodes[iLen]%>);
			}
			else if (frm.F<%=fieldCodes[iLen]%>.datatype=='15')//日期时间
			{
				frm.F<%=fieldCodes[iLen]%>.value = frm.F<%=fieldCodes[iLen]%>.value.substr(0,8)
									+ frm.F<%=fieldCodes[iLen]%>.value.substr(9,2)
									+ frm.F<%=fieldCodes[iLen]%>.value.substr(12,2)
									+ frm.F<%=fieldCodes[iLen]%>.value.substr(15,2)
				ret=forTotalDate(frm.F<%=fieldCodes[iLen]%>);
				frm.F<%=fieldCodes[iLen]%>.value = frm.F<%=fieldCodes[iLen]%>.value.substr(0,8)
									+ " "
									+ frm.F<%=fieldCodes[iLen]%>.value.substr(8,2)
									+":"
									+ frm.F<%=fieldCodes[iLen]%>.value.substr(10,2)
									+":"
									+ frm.F<%=fieldCodes[iLen]%>.value.substr(12,2)
			}
			else if (frm.F<%=fieldCodes[iLen]%>.datatype=='16')//BOOL
				ret=true;
			else if (frm.F<%=fieldCodes[iLen]%>.datatype=='17')//下拉框
				ret=true;
			else if (frm.F<%=fieldCodes[iLen]%>.datatype=='18')//其他
				ret=true;
			else if ((frm.F<%=fieldCodes[iLen]%>.datatype=='19')&&(haveCalc))//公式计算
				ret=parseFloat(frm.F<%=fieldCodes[iLen]%>.value)==frm.F<%=fieldCodes[iLen]%>.value;
			else if (frm.F<%=fieldCodes[iLen]%>.datatype=='20')//ip地址 add
			    ret=forIP(frm.F<%=fieldCodes[iLen]%>);//add
			/*** begin add by diling for 关于申请云视频监控和会议两项业务BOSS侧改造支撑的函 @2014/3/7 ***/
			else if (frm.F<%=fieldCodes[iLen]%>.datatype=='22'){//密码 字母和数字的组合
				ret=forNumChar(frm.F<%=fieldCodes[iLen]%>);
			}
			/*** end add by diling @2014/3/7 ***/
			else if (frm.F<%=fieldCodes[iLen]%>.datatype=='33') {
				if ("<%=fieldCodes[iLen]%>" == "10604") {	//wanghfa修改 2011-1-12 10:43 移动总机接入BOSS需求
					var patrn=/^[a-zA-Z0-9]{6,12}$/;
					if(frm.F<%=fieldCodes[iLen]%>.value.search(patrn) == -1){
						ret = false;
					}
				}
			}
			if (!ret)
			{
				rdShowMessageDialog("<%=fieldNames[iLen]%>数据输入类型不对!",0);
				//alert("数据输入类型不对!");
				frm.F<%=fieldCodes[iLen]%>.focus();
				return ret;
			}
			if(!checkValues_flag)
		    {
    			if(frm.F<%=fieldCodes[iLen]%>!=null && frm.F<%=fieldCodes[iLen]%>.value==''){
    			    rdShowMessageDialog("<%=fieldNames[iLen]%>不能为空!",0);
    			    frm.F<%=fieldCodes[iLen]%>.focus();
    			    return false;
    			}
			}
		}
		else
		{
			for(var m = 0 ; m < document.frm.F<%=fieldCodes[iLen]%>.length ; m ++){

		
			frm.F<%=fieldCodes[iLen]%>[m].datatype=<%out.println(dataTypes[iLen]);%>;

			if (frm.F<%=fieldCodes[iLen]%>[m].datatype=='10'){//整型
				 reta=parseInt(frm.F<%=fieldCodes[iLen]%>[m].value)==frm.F<%=fieldCodes[iLen]%>[m].value;
				 if(JHshStrLen(frm.F<%=fieldCodes[iLen]%>[m].value) > "<%=fieldLengths[iLen]%>"){
					 retb = false;
				   }
					 ret = reta && retb;
				}
			else if (frm.F<%=fieldCodes[iLen]%>[m].datatype=='11'){//浮点型
				reta=parseFloat(frm.F<%=fieldCodes[iLen]%>[m].value)==frm.F<%=fieldCodes[iLen]%>[m].value;
				if(JHshStrLen(frm.F<%=fieldCodes[iLen]%>[m].value) > "<%=fieldLengths[iLen]%>"){
					 retb = false;
				   }
					ret = reta && retb;
			}
			else if (frm.F<%=fieldCodes[iLen]%>[m].datatype=='12'){//字符型
			
					flag=frm.F<%=fieldCodes[iLen]%>[m].value=='';
					reta=!flag;
					if(JHshStrLen(frm.F<%=fieldCodes[iLen]%>[m].value) > "<%=fieldLengths[iLen]%>"){
					 retb = false;
				 }
					ret = reta && retb;
				}
				/*gaopeng 2014/01/17 14:45:17 加入30和31的校验方法 start*/
				else if (frm.F<%=fieldCodes[iLen]%>.datatype=='30'){//字母和数字的组合
					ret=forNumChar(frm.F<%=fieldCodes[iLen]%>);
				}
				else if (frm.F<%=fieldCodes[iLen]%>.datatype=='31'){//中国移动手机号码
					ret=formobilesPhone(frm.F<%=fieldCodes[iLen]%>);
				}
				/*gaopeng 2014/01/17 14:45:17 加入30和31的校验方法 end*/
			else if (frm.F<%=fieldCodes[iLen]%>[m].datatype=='13'){//金额
				// ret=parseFloat(frm.F<%=fieldCodes[iLen]%>[m].value)==frm.F<%=fieldCodes[iLen]%>[m].value;
				ret=forMoney(frm.F<%=fieldCodes[iLen]%>[m]);
			}
			else if (frm.F<%=fieldCodes[iLen]%>[m].datatype=='14'){//日期
				ret=forDate(frm.F<%=fieldCodes[iLen]%>[m]);
			}
			else if (frm.F<%=fieldCodes[iLen]%>[m].datatype=='15')//日期时间
			{
				frm.F<%=fieldCodes[iLen]%>[m].value = frm.F<%=fieldCodes[iLen]%>[m].value.substr(0,8)
									+ frm.F<%=fieldCodes[iLen]%>[m].value.substr(9,2)
									+ frm.F<%=fieldCodes[iLen]%>[m].value.substr(12,2)
									+ frm.F<%=fieldCodes[iLen]%>[m].value.substr(15,2)
				ret=forTotalDate(frm.F<%=fieldCodes[iLen]%>[m]);
				frm.F<%=fieldCodes[iLen]%>[m].value = frm.F<%=fieldCodes[iLen]%>[m].value.substr(0,8)
									+ " "
									+ frm.F<%=fieldCodes[iLen]%>[m].value.substr(8,2)
									+":"
									+ frm.F<%=fieldCodes[iLen]%>[m].value.substr(10,2)
									+":"
									+ frm.F<%=fieldCodes[iLen]%>[m].value.substr(12,2)
			}
			else if (frm.F<%=fieldCodes[iLen]%>[m].datatype=='16')//BOOL
				ret=true;
			else if (frm.F<%=fieldCodes[iLen]%>[m].datatype=='17')//下拉框
				ret=true;
			else if (frm.F<%=fieldCodes[iLen]%>[m].datatype=='18')//其他
				ret=true;
			else if ((frm.F<%=fieldCodes[iLen]%>[m].datatype=='19')&&(haveCalc))//公式计算
				ret=parseFloat(frm.F<%=fieldCodes[iLen]%>[m].value)==frm.F<%=fieldCodes[iLen]%>[m].value;
			else if (frm.F<%=fieldCodes[iLen]%>[m].datatype=='20')//ip地址 add
			    ret=forIP(frm.F<%=fieldCodes[iLen]%>[m]);//add
			/*** begin add by diling for 关于申请云视频监控和会议两项业务BOSS侧改造支撑的函 @2014/3/7 ***/
			else if (frm.F<%=fieldCodes[iLen]%>.datatype=='22'){//密码 字母和数字的组合
				ret=forNumChar(frm.F<%=fieldCodes[iLen]%>);
			}
			/*** end add by diling @2014/3/7 ***/
      if (!ret)
			{
				rdShowMessageDialog("<%=fieldNames[iLen]%>数据输入类型不对!",0);
				//alert("数据输入类型不对!");
				frm.F<%=fieldCodes[iLen]%>[m].focus();
				return ret;
			}
			if(!checkValues_flag)
		    {
    			if(frm.F<%=fieldCodes[iLen]%>[m]!=null && frm.F<%=fieldCodes[iLen]%>[m].value==''){
    			    rdShowMessageDialog("<%=fieldNames[iLen]%>不能为空!",0);
    			    frm.F<%=fieldCodes[iLen]%>[m].focus();
    			    return false;
    			}
			}
			}
		}
			}//end if(!checkValues_flag)
<%

		iLen++;
	}//end while
%>

	return true;
}
//wangzn add 2011/6/3 10:42:37
$(document).ready(function(){

  	$("#F01200").val($("#unit_id").val());//没有F01200也不报错，可以这么用
  	$("#F02000").val($("#unit_id").val());
  	$("#F03000").val($("#unit_id").val());
	//$(".groupTab").css({ OVERFLOW: "scroll", background: "blue" });  
	//$(".groupTab").width(20); 
	
	$(".groupTab").each(function(){
		
		//$(this).width(919);
		//alert($(this).width());
	}); 
	//wangzn add 2012/2/19 16:21:27 初始化级联
	$("select").each(function(){
		
		if($(this).attr("datatype")=="08")
		{
			cascadeFields($(this));
		}
	}); 
  	//wangzn add 2012/8/20 17:32:42 融合总机的 集团总机主号码和融合总机话务台号码的值要相同
  	$("#F03300").change(function(){
  		$("#F03400").val($(this).val());
  	});
  	$("#F03300").keyup(function(){
  		$("#F03400").val($(this).val());
  	});
  	
  	$("#F03400").change(function(){
  		$("#F03300").val($(this).val());
  	});
  	$("#F03400").keyup(function(){
  		$("#F03300").val($(this).val());
  	});
  	
  	
  	$("#F03500").val(10);
  	$("#F03500").attr("readOnly",true);
  	
	$("#F10623").attr("readOnly",true);
	$("#F10623").addClass("InputGrey");

		
	$("#F00022").change(function(){
		if($("#F00022").val()=="01"){ //计费类型00022 如果值为01 则业务类型00025的值必须是1，否则其他可选
			$("#F00025 option").each(function(){
	      if($(this).val()=="1"){
	        $(this).attr("selected",true);
	        $("#F00025").attr("disabled",true);
	      }
	    });
		}else{
    	$("#F00025").attr("disabled",false);
    }
	});

}); 

function cascadeFields(obj){
	var subCode =document.getElementById($(obj).find('option:selected').attr("subFieldCode"));
	//alert($(obj).find('option:selected').attr("subFieldValues"));
	var subValues =  $(obj).find('option:selected').attr("subFieldValues");
	var subValArr = eval(subValues);

	
	subCode.options.length=0;

	$(subValArr).each(function(){
		subCode.options.add(new Option(this[0]+'--'+this[1],this[0])); 
	});
	
	
}
</script>


<script language="javascript">
<%

		try
		{
			//静态下拉列表
			if("AD".equals(userType) || "ML".equals(userType) || "MA".equals(userType) ||"CT".equals(userType)||"hj".equals(userType)||"hl".equals(userType) ||"RH".equals(userType)){
			    sqlStr = "select param_code,config_code,config_name,substr(config_sql,1,INSTR(config_sql,'|')-1),substr(config_sql,INSTR(config_sql,'|')+1,LENGTH(config_sql)) from sbizparamconfig where config_code != '99' and param_code != '10741'";
			    paraIn2[0] = sqlStr;
          paraIn2[1]="userType="+userType;
			}else{
			  /*begin diling add for 合作类物联网业务BOSS功能开发及经分报表需求 @2012/8/6 */
			  if("HW".equals(userType)){
			    String iSmCodeHiddenHW = WtcUtil.repNull((String)request.getParameter("smCodeHidden"));
          String iBizTypeLHiddenHW = WtcUtil.repNull((String)request.getParameter("bizTypeLHidden"));
          String iBizTypeSHiddenHW = WtcUtil.repNull((String)request.getParameter("bizTypeSHidden"));
			    String inParams_HW [] = new String[2];
			    String sqlstr_HW = "SELECT e.external_code "
                          +" FROM CGRPSMLIMIT D, SBIZTYPECODE E "
                          +" WHERE D.SM_CODE = E.SM_CODE "
                          +" AND trim(D.LIMIT_VALUE) = E.EXTERNAL_CODE "
                          +" AND D.LIMIT_TYPE = '11' "
                          +" AND D.LIMIT_FLAG = 'Y' "
                          +" AND D.SM_CODE = :vsmCode "
                          +" AND E.BIZTYPE = :vbizTypeS "
                          +" AND E.MAIN_TYPE = :vbizTypeL";
          inParams_HW[0]=sqlstr_HW;
          inParams_HW[1]="vsmCode="+iSmCodeHiddenHW+",vbizTypeL="+iBizTypeLHiddenHW+",vbizTypeS="+iBizTypeSHiddenHW;
%>
          <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCodeHW" retmsg="retMsgHW" outnum="1" >
          <wtc:param value="<%=inParams_HW[0]%>"/>
          <wtc:param value="<%=inParams_HW[1]%>"/> 
          </wtc:service>
          <wtc:array id="retArr_HW" scope="end"/>
<%
            if("000000".equals(retCodeHW)){
              if(retArr_HW.length>0){
                if(retArr_HW[0][0]!=""){
                  sqlStr = "select field_code,param_code,param_name,'','' from sUserFieldParamCode where user_type=:userType and param_code!='99' and param_code != '10741'";
                  paraIn2[0] = sqlStr;
                  paraIn2[1]="userType="+retArr_HW[0][0];
                }
              }
            }else{
              sqlStr = "select field_code,param_code,param_name,'','' from sUserFieldParamCode where user_type=:userType and param_code!='99' and param_code != '10741'";
              paraIn2[0] = sqlStr;
              paraIn2[1]="userType="+userType;
            }
            /*end diling add @2012/8/6*/
			  }else{
			    sqlStr = "select field_code,param_code,param_name,'','' from sUserFieldParamCode where user_type=:userType and param_code!='99' and param_code != '10741'";
			    paraIn2[0] = sqlStr;
          paraIn2[1]="userType="+userType;
			  }
			}
			System.out.println(sqlStr );
			//retArray = callView.sPubSelect("3",sqlStr);

			
%>
            <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode4" retmsg="retMsg4" outnum="5" >
            	<wtc:param value="<%=paraIn2[0]%>"/>
            	<wtc:param value="<%=paraIn2[1]%>"/>
            </wtc:service>
            <wtc:array id="retArr4" scope="end"/>
<%
			//fieldParamCodes = (String[][])retArray.get(0);
			if(retCode4.equals("000000")){
			    fieldParamCodes = retArr4;
			}
			//动态下拉列表
			sqlStr = "select field_code,param_sql from sUserFieldParamCode where user_type='"+userType+"' and param_code='99' and param_code != '10741'";
			System.out.println(sqlStr );
			//retArray = callView.sPubSelect("2",sqlStr);

			paraIn2[0] = sqlStr;
            paraIn2[1]="userType="+userType;
%>
            <wtc:service name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode5" retmsg="retMsg5" outnum="2" >
            	<wtc:param value="<%=paraIn2[0]%>"/>
            </wtc:service>
            <wtc:array id="retArr5" scope="end"/>
<%
			//fieldParamSql = (String[][])retArray.get(0);
			if(retCode5.equals("000000")){
			    fieldParamSql = retArr5;
			}
			System.out.println("----------------------->>>>>"+fieldParamSql[0][1]);
		}
		catch(Exception e)
		{
			logger.error("Call sunView is Failed!");
		}
//有几个组就做几次循环
for(Iterator i = vecGrp.iterator();i.hasNext();)
{
	String str = 	(String)i.next();
	int jsi = Integer.parseInt(str);
%>

var index<%=jsi%> = 0;
var varId = 50;



function segmentAdd_<%=jsi%>(){
<%
	String readOnlyFlag_ ="";	//yuanqs add 2011/5/24 15:00:38 readonly 标识符

	htGrp.get(str);
	
	Vector v = new Vector();
	
	int ii = ((Integer)htGrp.get(str)).intValue();
	
%>
	var tr1 = "";
	if (segMentTab<%=jsi%>.rows.length<= eval(eval(<%out.print(fieldMaxRows[ii]);%>)+eval(2))) {
		
		segMentTab<%=jsi%>.bgcolor="#FFFFFF";
		
		
		
		tr1 = tr1+'<td width="30"><input class=button type="button" name="del" value="删除" onclick="deleteIt<%=jsi%>(this)"></td>';
		
		while (true){
<%	
			int calcButtonFlag=0;
			
			String a = fieldGroupNo[ii];
			
			do {
					
				v.add(fieldCodes[ii]);	
		    	 
				System.out.println("=========fieldCodes[ii]=====" + fieldCodes[ii]);	
				System.out.println("====yuanqs=====fieldReadOnly["+ii+"]=====" + fieldReadOnly[ii]);	
				
				/* yuanqs add 2011/5/24 14:59:53 */
				if ("Y".equals(fieldReadOnly[ii])) {
				
					readOnlyFlag_ = "readonly";
					
				}else{
					readOnlyFlag_ = "";
				}
				
				System.out.println("====yuanqs=====readOnlyFlag_=====" + readOnlyFlag_);	
								
%>			
				tr1 = tr1+'<%
				
				int colspan = 1;
				
				if (fieldCount - 1 == ii) {
					
					colspan = 3;
				
				} else {
				
					colspan = 1;
				
				}
				
				//判断是否是boolean型//选择框
				if (dataTypes[ii].equals("16")) {
					
					out.print("<TD width=\"32%\" colspan="+colspan+"> <select id=\"F"+fieldCodes[ii]+"\" name=\"F"+fieldCodes[ii]+"\" datatype="+dataTypes[ii]+"><option value=\"Y\" ");
					
					if (fieldValues[ii].equals("Y"))
					
						out.print("selected");
						
					out.print(" >是</option><option value=\"N\">否</option></select> </TD>");
				
				//下拉框	
				} else if (dataTypes[ii].equals("17")) {
					
					out.print("<TD width=\"32%\" colspan="+colspan+"> <select  id=\"F"+fieldCodes[ii]+"\" name=\"F"+fieldCodes[ii]+"\" datatype="+dataTypes[ii]+" onchange=\"clearCalcFields(frm.F"+fieldCodes[ii]+");\">");
					
					for (int j=0; j < fieldParamCodes.length; j++) {
					
						if (fieldParamCodes[j][0].equals(fieldCodes[ii])) {
							
							out.print("<option ");
							
							if (fieldValues[ii].equals(fieldParamCodes[j][1]))
							
								out.print("selected");
							
							out.print(" value=\"" + fieldParamCodes[j][1] + "\">"+fieldParamCodes[j][1]+"--" + fieldParamCodes[j][2]+ "</option>");
						}
					}
					
					out.print("</select>");
					if("00048".equals(fieldCodes[ii])){
						out.print("&nbsp;<font color=\"#FF0000\">");
						out.print("[只针对永久白名单业务有效]");
						out.print("</font>");
					}
					out.print("</TD>");
					//wangzn add 2011/8/3 9:59:47
					if ("Y".equals(fieldReadOnly[ii])) {
						out.print("<SCRIPT type=text/javascript>$(\"#F"+fieldCodes[ii]+"\").find(\"option:not(:selected)\").remove();</script>");						
					}
					
				} 
				/* begin for 关于在专线开户界面增加统谈专线项目填写元素的函@2014/11/24 */
				else if (dataTypes[ii].equals("39"))//多选框
				{
					out.print("<TD width='32%' colspan="+colspan+"> ");
					for (int j=0; j < fieldParamCodes.length; j++) {
						if (fieldParamCodes[j][0].equals(fieldCodes[ii])) {
							out.print("<input type='checkbox' id='F"+fieldCodes[ii]+"' name='F"+fieldCodes[ii]+"' value='"+fieldParamCodes[j][1]+"' />"+fieldParamCodes[j][2]);
						}
					}
					out.print("</TD>");
				}
				/* end for 关于在专线开户界面增加统谈专线项目填写元素的函@2014/11/24 */
				else if (dataTypes[ii].equals("08")) {//级联下拉列表
					out.print("<TD width=\"32%\" colspan="+colspan+"> <select id=\"F"+fieldCodes[ii]+"\" name=\"F"+fieldCodes[ii]+"\" datatype="+dataTypes[ii]+" onchange=\"cascadeFields(this);\">");
					
					for (int j=0; j < fieldParamCodes.length; j++) {
						
					
						if (fieldParamCodes[j][0].equals(fieldCodes[ii])) {
							
							
							out.print("<option ");
							
							if (fieldValues[ii].equals(fieldParamCodes[j][1]))
								out.print("selected");
							%>
							<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode10" retmsg="retMsg10" outnum="2" >
						    	<wtc:sql>select config_code,config_name from sbizparamconfig where config_code != '99' and config_code IN(<%=fieldParamCodes[j][4]%>) and param_code = '<%=fieldParamCodes[j][3]%>' order by config_order  </wtc:sql>
						    </wtc:pubselect>
						    <wtc:array id="retArr10" scope="end"/>
						    <%
							String[][] subFieldValues  = new String[][]{};
							String subFieldValue = "";
							if("000000".equals(retCode10)){
								subFieldValues = (String[][])retArr10;
								for(int k = 0 ;k < subFieldValues.length;k++)
								{
									subFieldValue = subFieldValue + "[\""+subFieldValues[k][0] +"\",\"" + subFieldValues[k][1]+"\"]" ;
									if(k < subFieldValues.length -1)
									{
									 subFieldValue = subFieldValue + ",";
									}
								}
							}
							
							
							out.print(" value=\"" + fieldParamCodes[j][1] + "\"  subFieldCode=F"+fieldParamCodes[j][3]+" subFieldValues=\"["+subFieldValue+"]\"  >"+fieldParamCodes[j][1]+"--" + fieldParamCodes[j][2]+ "</option>");
						}
					}
					
					out.print("</select> </TD>");
					//wangzn add 2011/8/3 9:59:47
					if ("Y".equals(fieldReadOnly[ii])) {
						out.print("<SCRIPT type=text/javascript>$(\"#F"+fieldCodes[ii]+"\").find(\"option:not(:selected)\").remove();</script>");
					}	
				}else if (dataTypes[ii].equals("19")){//计算字段

					calcButtonFlag=1;
					
					String [][] formula=null;
					
					try {
						
						sqlStr = "select formula from sUserFieldFormula where user_type='"+ userType+ "' and field_code='"+fieldCodes[ii]+"'";
						
						//retArray = callView.sPubSelect("1",sqlStr);
%>
						<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode6" retmsg="retMsg6"  outnum="1">
						
							<wtc:sql><%=sqlStr%></wtc:sql>
						
						</wtc:pubselect>
						
						<wtc:array id="retArr6" scope="end" />
<%
						//formula = (String[][])retArray.get(0);
						
						if(retCode6.equals("000000")) {
						
							formula = retArr6;
							
						}
					} catch(Exception e) {
						
						logger.error("Call sunView is Failed!");
					
					}
					
					out.print("<TD width=\"32%\" colspan="+colspan+"> <input id=\"F"+fieldCodes[ii]+"'+varId+'\" name=\"F"+fieldCodes[ii]+"\" class=\"button\" type=\"text\" datatype="+dataTypes[ii]+" maxlength=\""+fieldLengths[ii]+"\" readonly><label name=blue"+fieldCodes[ii]+" id=blue"+fieldCodes[ii]+" style=\"display:\"><font color=blue>*</font></label><input style=\"display:none\" name=\"calc"+fieldCodes[ii]+"\" type=button class=\"button\" value=计算 onclick=\"calcFieldValue(frm.F"+fieldCodes[ii]+");\" value=\""+fieldValues[ii]+"\"></TD>");
				
				//动态SQL下拉框
				} else if (dataTypes[ii].equals("21")) {
					
					out.print("<TD width=\"32%\" colspan="+colspan+"> <select id=\"F"+fieldCodes[ii]+"\" name=\"F"+fieldCodes[ii]+"\" datatype="+dataTypes[ii]+" onchange=\"clearCalcFields(frm.F"+fieldCodes[ii]+");\">");
					
					for (int j=0; j < fieldParamSql.length; j++) {
						
						if (fieldParamSql[j][0].equals(fieldCodes[ii])) {
							String[][] dynParamCodes = new String[][]{};
							
							sqlStr=fieldParamSql[j][1];
							
							System.out.println("DYN sqlStr==== "+sqlStr);
							
							while (true) {
	              				
	              				int startPos = sqlStr.indexOf('<');
	              
	              				if(startPos<0)
	                  		
	                  				break;
	                  
	              				int endPos = sqlStr.indexOf('>');
	              				
	              				if(endPos<0)
	              					
	              					break;
	              
	              				String tempName = sqlStr.substring(startPos+1,endPos);
	              				
	              				String tempValue = "";
	              				
	              				if(hm.containsKey(tempName))
	              				
	              				tempValue = (String)hm.get(tempName);
	              
	              				sqlStr = sqlStr.substring(0,startPos)+tempValue+sqlStr.substring(endPos+1);
	          				
	          				} 
							//retArray = callView.sPubSelect("2",sqlStr);
%>
							<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode7" retmsg="retMsg7"  outnum="2">
		                    
		                    	<wtc:sql><%=sqlStr%></wtc:sql>
		                    
		                    </wtc:pubselect>
		                    
		                    <wtc:array id="retArr7" scope="end" />
<%
							//dynParamCodes = (String[][])retArray.get(0);
							
							if(retCode7.equals("000000")) {
							
								dynParamCodes = retArr7;
							    
							}
								
							for(int n=0;n<dynParamCodes.length;n++) {
								
								out.print("<option ");
								
								if (fieldValues[ii].equals(dynParamCodes[n][0]))
								
									out.print("selected");
								
								out.print(" value=\"" + dynParamCodes[n][0] + "\">"+dynParamCodes[n][0]+"--" + dynParamCodes[n][1]+ "</option>");
							
							}
						}
					}
					
					out.print("</select> </TD>");
				
				//密码输入框
				} else if (dataTypes[ii].equals("22")) {
					
					out.print("<TD width=\"32%\" colspan="+colspan+"> <input id=\"F"+fieldCodes[ii]+"\" name=\"F"+fieldCodes[ii]+"\" class=\"button\" type=\"password\" datatype="+dataTypes[ii]+" maxlength=\""+fieldLengths[ii]+"\" value=\""+fieldValues[ii]+"\">");
					
					if(fieldCtrlInfos[ii].equals("N")) {
					
						out.print("&nbsp;<font color=\"#FF0000\">*</font></TD>");
					
					}	
				
				} else if(dataTypes[ii].equals("12")){//文本框
					out.print("<TD width=\"32%\" colspan="+colspan+"> <input id=\"F"+fieldCodes[ii]+"\" name=\"F"+fieldCodes[ii]+"\" class=\"button\" type=\"text\" datatype="+dataTypes[ii]+" maxlength=\""+fieldLengths[ii]+"\" "+readOnlyFlag_+" value=\""+fieldValues[ii]+"\">");
					if(fieldCtrlInfos[ii].equals("N")) {
						out.print("&nbsp;<font color=\"#FF0000\">*");
						if("81028".equals(fieldCodes[ii])){
							out.print("&nbsp;[20位数字]");
						}
						out.print("</font></TD>");
					}
				}
				else {
					
					/* yuanqs add 2011/5/24 15:02:54 增加 readOnlyFlag_ */
					out.print("<TD width=\"32%\" colspan="+colspan+"> <input id=\"F"+fieldCodes[ii]+"\" name=\"F"+fieldCodes[ii]+"\" class=\"button\" type=\"text\" datatype="+dataTypes[ii]+" maxlength=\""+fieldLengths[ii]+"\" "+readOnlyFlag_+" value=\""+fieldValues[ii]+"\">");
					
					if(fieldCtrlInfos[ii].equals("N")) {
						
						out.print("&nbsp;<font color=\"#FF0000\">*</font></TD>");
					
					}
				}
%>';
<%
				ii++;
				
				if(ii>=iField) {
				
					break;
					
				}
			} while (!v.contains(fieldCodes[ii])&&a.equals(fieldGroupNo[ii]));
%>
			varId++;
			
			break;
		}
		tr1 = "<tr>"+tr1+"</tr>";
		$("#segMentTabLast<%=jsi%>").before(tr1); 			
		index<%=jsi%>= eval(index<%=jsi%>)+eval(1);
	}
}

function deleteIt<%=jsi%>(){

var args=deleteIt<%=jsi%>.arguments[0];
var objTD =args.parentElement;
var objTR =objTD.parentElement;
var currRowIndex = objTR.rowIndex;

segMentTab<%=jsi%>.deleteRow(currRowIndex);

}
<%}%>


function spellList()
{
var nl = "";
var rowno = "";
var nameL = "";
var openFlag = "";
<%
int len=0;



        	Vector v = new Vector();

        	while(len<fieldCount)
        	{

	        	if(v.contains(fieldCodes[len]))
	        	{

	        	}
	        	else
	        	{
	        	  	 //组nei
	        	    if(!fieldGroupNo[len].equals("0"))
	        	    {
	        	    //int num = new Integer(fieldGroupNo[len]).intValue()+1;
	        	    out.println("	for(var n = 0 ; n < eval(segMentTab" +fieldGroupNo[len] + ".rows.length-eval(3)) ; n++)");
		        	out.println("	{");
		        	out.println("		nl=nl+\""+fieldCodes[len]+"\"+\"|\";");
		        	out.println("		nameL=nameL+\""+fieldNames[len]+"\"+\"|\";");
		        	out.println("		rowno=rowno+eval(eval(n)+1)"+"+\"|\";");
		        	out.println("       openFlag=openFlag+\""+openParamFlag[len]+"\"+\"|\";");
		        	out.println("	}");
		        	 }
		        	 //组wai
	        	    else
	        	    {
		        	out.println("		nl=nl+\""+fieldCodes[len]+"\"+\"|\";");
		        	out.println("		nameL=nameL+\""+fieldNames[len]+"\"+\"|\";");
		        	out.println("		rowno=rowno"+"+\"0|\";");
		        	out.println("		openFlag=openFlag+\""+openParamFlag[len]+"\"+\"|\";");
		        	}
		        	v.add(fieldCodes[len]);
	        	}
        	len++;
        	}

%>
document.frm.nameList.value=nl;
document.frm.nameGroupList.value=rowno;
document.frm.fieldNamesList.value = nameL;
document.frm.openFlagList.value = openFlag;
}
</script>
<%
	}//end if nextFlag==2
	if (nextFlag==2)
	{
%>

		</div>
		<div id="Operation_Table">
		<div class="title">
		<div id="title_zi">产品信息</div>
		</div>
<%
	}
%>
	<TABLE cellSpacing=0 style="display:<%=listShow%>" >
		<tr id="smsInfoTR" style="display:none"><td colspan='4'><span id="smsInfo"></span></td></tr>
	
<%
	if (nextFlag==2)
	{
/*			String[][] fieldParamCodes = new String[][]{};
		try
		{
			sqlStr = "select field_code,param_code,param_name from sUserFieldParamCode where user_type='"+ userType+ "'";
			
			retArray = callView.sPubSelect("3",sqlStr);
			fieldParamCodes = (String[][])retArray.get(0);
		}
		catch(Exception e)
		{
			logger.error("Call sunView is Failed!");
		}
	*/	
		int i=0;
		int colspan = 1;
		int calcButtonFlag=0;
		boolean tableFlag = false;
		boolean trFlag = false;
		Vector tr = new Vector();
		Vector trGrpNo = new Vector();
		Vector vecFieldCodes = new Vector();
		Vector vecGroupNo = new Vector();
		
		String readOnlyFlag = "";	//yuanqs add 2011/5/24 15:17:25 增加readonly
		if (resultList != null)
		{
			while(i<fieldCount)
			{

				System.out.println("@:***fieldCodes["+i+"]***"+fieldCodes[i]+"***");
				System.out.println("@:***fieldReadOnly["+i+"]***"+fieldReadOnly[i]+"***");
				/* yuanqs add 2011/5/24 15:18:52 */
				if ("Y".equals(fieldReadOnly[i])) {
				
					readOnlyFlag = "readOnly";
					
				}else{
					readOnlyFlag = "";
				}
				
				if(tableFlag||i==0)
				{
					%></table><div style="OVERFLOW: scroll;overflow-y:hidden;overflow-x:auto;padding: 0px;" id="Operation_Table">
					<TABLE id="segMentTab<%=fieldGroupNo[i]%>" class="groupTab" cellSpacing=0 style="display:<%=listShow%>">
					<%
				}
				if(trFlag||i==0)
				{
				
					if(!fieldGroupNo[i].equals("0"))
					{
						//增加按钮
	    				%>
	    				<TR><TD colspan=100><span id = "title_zi"><b><%=fieldGroupName[i]%></b></span>&nbsp;&nbsp;最大行数<%=fieldMaxRows[i]%></TD></TR>
	    				<TR>
	    				<TD><input type="button" name="addSegment<%=fieldGroupNo[i]%>" class="b_text"  value="增加" onclick="segmentAdd_<%=fieldGroupNo[i]%>()"></TD>
	    				<%
					}
					else
					{
						out.print("<TR>");
					}
					//画同一个组的表头
	    			int k=i;
	    			if(!fieldGroupNo[k].equals("0"))
	    			{
	    				do{
	    					 if(trGrpNo.contains(fieldCodes[k]))
	    					 {
	        					break;
	    					 }
	        				 else
	        				 {
	        					trGrpNo.add(fieldCodes[k]);
	        					if (fieldPurposes[k].equals("10"))
								{
									out.print("<TD width='18%'><font color=green>"+fieldNames[k]+"</font></TD>");
								}
								else
								{
	        						 out.print("<TD width='18%'>"+fieldNames[k]+"</TD>");
	        					}
	    					     k++;
	        				 }
	    				  }
	    				while(k<fieldCount&&fieldGroupNo[k-1].equals(fieldGroupNo[k]));
	    				
	    				out.print("</TR>");
	    				if(!"0".equals(fieldMinRows[i])){
		    				out.println("<TR>");
		    				out.print("<TD width='1%'></TD>");
		    			}
	    			}
    			    					
	    			//同一个组分行时计数变量
	    			int trGrpi = 0;
	    			int trGrpk = 0;
					for (int colNum = 0; (colNum < 2) && (i < fieldCount)||!fieldGroupNo[i].equals("0"); colNum ++)
					{
						if (fieldCount - 1 == i)
						{
							colspan = 3;
						}
						else
						{
							colspan = 1;
						}
						
						if (fieldPurposes[i].equals("10")&&fieldGroupNo[i].equals("0"))
						{
							out.print("<TD width='18%'><font color=green>"+fieldNames[i]+"</font></TD>");
						}
						else
						{
							if(!fieldGroupNo[i].equals("0"))
							{
								if(tr.contains(fieldCodes[i]))
								{
									trGrpk++;
									if(trGrpk==trGrpi+1||trGrpk-1==0)
									{
										out.println("</TR>");
										if(!"0".equals(fieldMinRows[i])){
											out.println("<TR>");
											out.print("<TD width='2%'></TD>");
										}
									}
								}
								else
								{
								  trGrpi++;
								  tr.add(fieldCodes[i]);
								}
							}
							else
							{

	    						out.print("<TD class=blue width='18%'>"+fieldNames[i]+"</TD>");
							}
						}
					if(!"0".equals(fieldMinRows[i])){	
						System.out.println("@:***fieldCodes["+i+"]***"+fieldCodes[i]+"***");
						System.out.println("@:***fieldReadOnly["+i+"]***"+fieldReadOnly[i]+"***");
						/* yuanqs add 2011/5/24 15:18:52 */
						if ("Y".equals(fieldReadOnly[i])) {
						
							readOnlyFlag = "readOnly";
							
						}else{
							readOnlyFlag = "";
						}
						
						//判断是否是boolean型
						if (dataTypes[i].equals("16"))//选择框
						{
							out.print("<TD width='32%' colspan="+colspan+"> <select id='F"+fieldCodes[i]+"' name='F"+fieldCodes[i]+"' datatype="+dataTypes[i]+"><option value='Y' ");
							if (fieldValues[i].equals("Y"))
								out.print("selected");
							out.print(" >是</option><option value='N'>否</option></select> </TD>");
						}
						else if (dataTypes[i].equals("17"))//下拉框
						{
							out.print("<TD width='32%' colspan="+colspan+"> <select id='F"+fieldCodes[i]+"' name='F"+fieldCodes[i]+"' datatype="+dataTypes[i]+" onchange='clearCalcFields(frm.F"+fieldCodes[i]+");'>");
							
							boolean atLeastOne = true;
							for (int x=0; x < fieldParamCodes.length; x++){
    								if (fieldParamCodes[x][0].equals(fieldCodes[i])){
    									if (fieldValues[i].equals(fieldParamCodes[x][1])){
    									    atLeastOne = true;
    									}
    								}
    						}
    						
    					  String productProgessSql = "select param_code,config_code,config_name from sbizparamconfig where param_code = '10741' order by PARAM_CODE";
    					  %>
    					  <wtc:service name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="proRetCode" retmsg="proRetMsg" outnum="3" >
                	<wtc:param value="<%=productProgessSql%>"/>
                </wtc:service>
                <wtc:array id="productProgress" scope="end"/>
    					  <%
    					  if ("000000".equals(proRetCode)){
      					  if ("10741".equals(fieldCodes[i])){
          					  for (int x=0; x < productProgress.length; x++){
          								if (productProgress[x][0].equals(fieldCodes[i])){
          									if (fieldValues[i].equals(productProgress[x][1])){
          									    atLeastOne = true;
          									}
          								}
          						}
      						}
      					}
      					System.out.println(" zhouby atLeastOne " + atLeastOne);
    						if (atLeastOne){
    							for (int j=0; j < fieldParamCodes.length; j++)
    							{
    								if (fieldParamCodes[j][0].equals(fieldCodes[i]))
    								{
    									/*begin add 展示当前工号所对应的“营销区域”内容 for 在CRM系统增加“营销区域”字段的需求@2015/4/22 */
    									if("10818".equals(fieldCodes[i])){
    										String v_sub_fieldParamCodes = fieldParamCodes[j][1].substring(0,2);
    										if(v_regionCode.equals(v_sub_fieldParamCodes)){
    											out.print("<option ");
    											out.print(" value='" + fieldParamCodes[j][1] + "'>"+fieldParamCodes[j][1]+"--" + fieldParamCodes[j][2]+ "</option>");
    										}
    									}else{
    										out.print("<option ");
	    									if (fieldValues[i].equals(fieldParamCodes[j][1])){
	    									    out.print("selected");
	    									}
    										out.print(" value='" + fieldParamCodes[j][1] + "'>"+fieldParamCodes[j][1]+"--" + fieldParamCodes[j][2]+ "</option>");
    									}
    									/*end add 展示当前工号所对应的“营销区域”内容 for 在CRM系统增加“营销区域”字段的需求@2015/4/22 */
    								}
    							}
    							if ("10741".equals(fieldCodes[i])){
    								  for (int x = 0; x < productProgress.length; x++){
      								  out.print("<option ");
      								  if (fieldValues[i].equals(productProgress[x][1])){
      									    out.print("selected");
      									}
      									System.out.println(" zhouby1 " + productProgress[x][2]);
          							out.print(" value=\"" + productProgress[x][1] + "\">"+productProgress[x][1]+"--" + productProgress[x][2]+ "</option>");
          						}
    								}
    						}else{
    						    out.print("<option value=''></option>");
    						}
							out.print("</select>");
							if("00048".equals(fieldCodes[i])){
								out.print("&nbsp;<font color=\"#FF0000\">");
								out.print("[只针对永久白名单业务有效]");
								out.print("</font>");
							}
							out.print("</TD>");
							//wangzn add 2011/8/3 9:59:47 支撑下拉列表的只读
							if ("Y".equals(fieldReadOnly[i])) {
								out.print("<SCRIPT type=text/javascript>$(\"#F"+fieldCodes[i]+"\").find(\"option:not(:selected)\").remove();</script>");						
							}
						}
						else if (dataTypes[i].equals("08"))//级联下拉列表
							{
								out.print("<TD width='32%' colspan="+colspan+"> <select id='F"+fieldCodes[i]+"' name='F"+fieldCodes[i]+"' datatype="+dataTypes[i]+" onchange='cascadeFields(this);'>");
								for (int j=0; j < fieldParamCodes.length; j++)
								{
									if (fieldParamCodes[j][0].equals(fieldCodes[i]))
									{
										out.print("<option ");
										if (fieldValues[i].equals(fieldParamCodes[j][1])){
										    out.print("selected");
										}
										%>
											<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode11" retmsg="retMsg11" outnum="2" >
										    	<wtc:sql>select config_code,config_name from sbizparamconfig where config_code != '99' and config_code IN(<%=fieldParamCodes[j][4]%>) and param_code = '<%=fieldParamCodes[j][3]%>' order by config_order </wtc:sql>
										    </wtc:pubselect>
										    <wtc:array id="retArr11" scope="end"/>
									    <%
										String[][] subFieldValues  = new String[][]{};
										String subFieldValue = "";
										if("000000".equals(retCode11)){
											subFieldValues = (String[][])retArr11;
											for(int l = 0 ;l < subFieldValues.length;l++)
											{
												subFieldValue = subFieldValue + "['"+subFieldValues[l][0] +"','" + subFieldValues[l][1]+"']" ;
												if(l < subFieldValues.length -1)
												{
													subFieldValue = subFieldValue + ",";
												}
											}
										}
										out.print(" value='" + fieldParamCodes[j][1] + "'  subFieldCode=F"+fieldParamCodes[j][3]+" subFieldValues=\"["+subFieldValue+"]\" >"+fieldParamCodes[j][1]+"--" + fieldParamCodes[j][2]+ "</option>");
									}
								}
								out.print("</select> </TD>");
								//wangzn add 2011/8/3 9:59:47 支撑下拉列表的只读
								if ("Y".equals(fieldReadOnly[i])) {
									out.print("<SCRIPT type=text/javascript>$(\"#F"+fieldCodes[i]+"\").find(\"option:not(:selected)\").remove();</script>");						
								}
							}
						else if (dataTypes[i].equals("19"))//计算字段
						{
							calcButtonFlag=1;
							String [][] formula=null;
							try
							{
								sqlStr = "select formula from sUserFieldFormula where user_type='"+ userType+ "' and field_code='"+fieldCodes[i]+"'";
								//retArray = callView.sPubSelect("1",sqlStr);
								%>
								<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode8" retmsg="retMsg8"  outnum="1">
	                            	<wtc:sql><%=sqlStr%></wtc:sql>
	                            </wtc:pubselect>
	                            <wtc:array id="retArr8" scope="end" />
	                   	 		<%
								//formula = (String[][])retArray.get(0);
								if(retCode8.equals("000000")){
								    formula = retArr8;
								}
							}
							catch(Exception e)
							{
								logger.error("Call sunView is Failed!");
							}
							out.print("<TD width='32%' colspan="+colspan+"> <input id='F"+fieldCodes[i]+i+"' name='F"+fieldCodes[i]+"' class='button' type='text' datatype="+dataTypes[i]+" maxlength='"+fieldLengths[i]+"' readonly><label name=blue"+fieldCodes[i]+" id=blue"+fieldCodes[i]+" style='display:'><font color=blue>*</font></label><input style='display:none' name='calc"+fieldCodes[i]+"' type=button class='button' value=计算 onclick='calcFieldValue(frm.F"+fieldCodes[i]+");' value='"+fieldValues[i]+"'></TD>");
						}
						else if (dataTypes[i].equals("21"))//动态SQL下拉框
						{
							out.print("<TD width=\"32%\" colspan="+colspan+"> <select id=\"F"+fieldCodes[i]+"\" name=\"F"+fieldCodes[i]+"\" datatype="+dataTypes[i]+" onchange=\"clearCalcFields(frm.F"+fieldCodes[i]+");\">");
							for (int j=0; j < fieldParamSql.length; j++)
							{
								if (fieldParamSql[j][0].equals(fieldCodes[i]))
								{
									String[][] dynParamCodes = new String[][]{};
									sqlStr=fieldParamSql[j][1];
									System.out.println("sqlStr===="+sqlStr);
									while(true)
	                                {
	                                    int startPos = sqlStr.indexOf('<');
	                                    if(startPos<0)
	                                        break;
	                                        
	                                    int endPos = sqlStr.indexOf('>');
	                                    if(endPos<0)
	                                    	break;
	                                    
	                                    String tempName = sqlStr.substring(startPos+1,endPos);
	                                    String tempValue = "";
	                                    if(hm.containsKey(tempName))
	                                    	tempValue = (String)hm.get(tempName);
	                                    	
	                                    sqlStr = sqlStr.substring(0,startPos)+tempValue+sqlStr.substring(endPos+1);
	                                }                                
									
									//retArray = callView.sPubSelect("2",sqlStr);
									%>
	                                	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode9" retmsg="retMsg9"  outnum="2">
	                                    	<wtc:sql><%=sqlStr%></wtc:sql>
	                                    </wtc:pubselect>
	                                    <wtc:array id="retArr9" scope="end" />
	                                <%
									//dynParamCodes = (String[][])retArray.get(0);
									if(retCode9.equals("000000")){
									    dynParamCodes = retArr9;
									}
									
									for(int n=0;n<dynParamCodes.length;n++)
									{
										out.print("<option ");
										if (fieldValues[i].equals(dynParamCodes[n][0]))
											out.print("selected");
										out.print(" value=\"" + dynParamCodes[n][0] + "\">"+dynParamCodes[n][0]+"--" + dynParamCodes[n][1]+ "</option>");
									}
								}
							}
							out.print("</select> </TD>");
						}
						else if (dataTypes[i].equals("22"))//密码输入框
						{
							out.print("<TD width='32%' colspan="+colspan+"> <input id='F"+fieldCodes[i]+"' name='F"+fieldCodes[i]+"' class='button' type='password' datatype="+dataTypes[i]+" maxlength='"+fieldLengths[i]+"' value='"+fieldValues[i]+"'>");
							if(fieldCtrlInfos[i].equals("N"))
							{out.print("&nbsp;<font color=\"#FF0000\">*</font></TD>");}
						}	
						else if (dataTypes[i].equals("32"))//彩铃业务中管理员帐户带校验按钮
						{
							out.print("<TD width='32%' colspan="+colspan+"> <input id='F"+fieldCodes[i]+"' name='F"+fieldCodes[i]+"' type='text' datatype="+dataTypes[i]+" maxlength='"+fieldLengths[i]+"' value='"+fieldValues[i]+"'>&nbsp;<input class='b_text' name='check_Mng_user' type='button' onClick='check_mnguser()' size='30' value=校验>");
							if(fieldCtrlInfos[i].equals("N"))
							{out.print("&nbsp;<font class=\"orange\">*</font></TD>");}
						}
						else if (dataTypes[i].equals("33"))//彩铃业务中帐户密码带默认值，且只能是数字
						{
							//wanghfa修改 2010-12-1 15:45 需求：移动总机接入BOSS系统 start
							if ("10604".equals(fieldCodes[i])) {
								out.print("<TD width='32%' colspan="+colspan+"> <input id='F"+fieldCodes[i]+"' name='F"+fieldCodes[i]+"' type='password' datatype="+dataTypes[i]+" v_minlength=6 maxlength='"+fieldLengths[i]+"' pwdlengthth='6' value='111111'>&nbsp;(6-12位数字、字母或组合)");
							} else {
								out.print("<TD width='32%' colspan="+colspan+"> <input id='F"+fieldCodes[i]+"' name='F"+fieldCodes[i]+"' type='password' v_type='0_9' v_minlength=6 maxlength=6 pwdlengthth='6' value='111111'>&nbsp;(6位数字)");
							}
							//wanghfa修改 2010-12-1 15:45 需求：移动总机接入BOSS系统 end
							
							if(fieldCtrlInfos[i].equals("N"))
							{
								out.print("&nbsp;<font class=\"orange\">*</font></TD>");
							}
						}
						/* begin for 关于在专线开户界面增加统谈专线项目填写元素的函@2014/11/24 */
						else if (dataTypes[i].equals("39"))//多选框
						{
							out.print("<TD width='32%' colspan="+colspan+"> ");
							for (int j=0; j < fieldParamCodes.length; j++) {
								if (fieldParamCodes[j][0].equals(fieldCodes[i])) {
									out.print("<input type='checkbox' id='F"+fieldCodes[i]+"' name='F"+fieldCodes[i]+"' value='"+fieldParamCodes[j][1]+"' />"+fieldParamCodes[j][2]);
								}
							}
							out.print("</TD>");
						}
						/* end for 关于在专线开户界面增加统谈专线项目填写元素的函@2014/11/24 */
						else if (dataTypes[i].equals("09"))//BOSS侧VPMN中集团主费率或集团可选费率下拉框动态获取
						{
							out.print("<TD width='32%' colspan="+colspan+"> <select id='F"+fieldCodes[i]+"' name='F"+fieldCodes[i]+"' v_must=0 v_type='string' index='10' ");
							if("10001".equals(fieldCodes[i])){
							    out.print(" MULTIPLE='TRUE' ");						
							}
							out.print(" >");
	                            String[][] result33 = null;
								
							try
							{
							    String mode_type_tmp = "";
								if("10000".equals(fieldCodes[i])){
								    mode_type_tmp = "VpM0";
								}else if("10001".equals(fieldCodes[i])){
								    mode_type_tmp = "VpA0";
								}else{
								    
								}
								/*anxh改*/
								/* modify by qidp @ 2009-10-21 for 改TlsPubSelCrm为sPubSelect */
								String[] inParams = new String[2];
								inParams[0] = "select a.offer_id,a.offer_id || '->' || a.offer_name"
								+"  from product_offer a,region b ,sregioncode c"
								+" where c.region_code = '"+regionCode+"'"
								+"   and a.offer_id = b.offer_id"
								+"   and b.group_id = c.group_id"
								+"   and a.offer_attr_type = '"+mode_type_tmp+"'"
								+" and a.exp_date>=sysdate and b.right_limit<='"+powerRight+"'";
								inParams[1] = "org_code="+org_code+",mode_type="+mode_type_tmp+",powerRight="+powerRight;
			
								%>
						            <wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode444" retmsg="retMsg444"  outnum="2">
						            	<wtc:sql><%=inParams[0]%></wtc:sql>
						            </wtc:pubselect>
						            <wtc:array id="resultTemp" scope="end"/>
						        <%
								result33 = resultTemp;
							}
							catch(Exception e)
							{
								System.out.println("取集团可选费率信息出错!");
							}
							if (result33 != null && result33.length>0)
							{
								System.out.println("result33.length"+result33.length);
								for(int xcott=0; xcott < result33.length; xcott ++)
								{
									out.println("<option value='" + result33[xcott][0] + "'>" + result33[xcott][1] + "</option>");
								}
							}
									
							out.print("</select>");
							if(fieldCtrlInfos[i].equals("N"))
							{
								out.print("&nbsp;<font class=\"orange\">*</font></TD>");
							}
						}
						else if (dataTypes[i].equals("40"))//VPMN中业务区号带默认值
						{
							out.print("<TD width='32%' colspan="+colspan+">");
	                        String[][] result33 = null;
	                        String agentProvCode = "";
	                        String servArea = "";
	                        try
	        				{
				                String sqlStr40 = "select AGENT_PROV_CODE from sprovinceCode where run_flag = 'Y'";
				                //retArray = callView.sPubSelect("1",sqlStr);
				                %>
	                
								<wtc:pubselect name="sPubSelect" outnum="1" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
								<wtc:sql><%=sqlStr40%></wtc:sql>
								</wtc:pubselect>
								<wtc:array id="result_tu4" scope="end"/>             
	                            
	                            <%
	                            if (result_tu4.length <= 0)
	                            {
	                            	logger.error("查询省代码出错失败!");
	                            }
	                            agentProvCode = result_tu4[0][0];
							}catch(Exception e){
			                    	logger.error("查询集团省区号失败!");
							}
	        
	                        try
	                        {
	                            String sqlStr40 = "select trim(toll_no) from sRegionCode where region_code = '" + regionCode + "'";
	                            
	                            %>
	                            
									<wtc:pubselect name="sPubSelect" outnum="1" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
									<wtc:sql><%=sqlStr40%></wtc:sql>
									</wtc:pubselect>
									<wtc:array id="result_tu5" scope="end"/>              
	                            
	                            <%
	                            result33 = result_tu5;
	                            int tollNum = result33.length;
	                            if (tollNum <= 0)
	                            {
	                            	logger.error("查询业务区号失败!");
	                            }
	                			servArea = agentProvCode + "0" + result33[0][0] + "01";
	                        }catch(Exception e){
	                                logger.error("查询业务区号失败!");
	                        }
	                							
							
							out.print("<input  type='text' id='F"+fieldCodes[i]+"' name='F"+fieldCodes[i]+"' size='20'  value='"+servArea+"' onKeyPress='return isKeyNumberdot(0)' v_must=1 v_type='0_9' index='12' readonly  Class='InputGrey'>");
							if(fieldCtrlInfos[i].equals("N"))
							{
								out.print("&nbsp;<font class=\"orange\">*</font></TD>");
							}
						}
						
						else if (dataTypes[i].equals("42"))//VPMN中SCP号带默认值
						{
							out.print("<TD width='32%' colspan="+colspan+">");
	                        String[][] result33 = null;
	                        
	                        try																			
	                        {
	                            sqlStr ="select scp_id from  svpmnscp Where region_code='" + regionCode + "'"; 
	                           //retArray = callView.sPubSelect("1",sqlStr);
	                            %>
	                                
								<wtc:pubselect name="sPubSelect" outnum="1" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
								<wtc:sql><%=sqlStr%></wtc:sql>
								</wtc:pubselect>
								<wtc:array id="result_tu6" scope="end"/>                
	                                
	                                
	                            <%
	                            result33 = result_tu6;
	                        }catch(Exception e){
	                                logger.error("Call sunView is Failed!");
	                        }                        
	                							
							
							out.print("<input  type='text' id='F"+fieldCodes[i]+"' name='F"+fieldCodes[i]+"'  size='20' onKeyPress='return isKeyNumberdot(0)' value='"+result33[0][0]+"' v_must=1 v_type='0_9' index='13'> (各地市不同)");
							if(fieldCtrlInfos[i].equals("N"))
							{out.print("&nbsp;<font class=\"orange\">*</font></TD>");}
						}
						else if (dataTypes[i].equals("43"))//VPMN中集团类型下拉框静态获取
						{
							out.print("<TD width='32%' colspan="+colspan+">");
	                        
	                        out.print("<select id='F"+fieldCodes[i]+"' name='F"+fieldCodes[i]+"'>");
	                        
	                        if(workno.equals("aavg21")){
	
									out.print("<option value='0' selected >0->本地集团</option>");
	                                out.print("<option value='1'>1->全省集团</option>");
	                                out.print("<option value='2'>2->全国集团</option>");
	                                out.print("<option value='3'>3->本地化省级集团</option>");
	
								}else{
	
	                                out.print("<option value='0' selected >0->本地集团</option>");
	                            }
	                        out.print("</select>");
							if(fieldCtrlInfos[i].equals("N"))
							{out.print("&nbsp;<font class=\"orange\">*</font></TD>");}
						}
						else if (dataTypes[i].equals("45"))//VPMN中用户功能集带默认值带按钮
						{
							out.print("<TD width='32%' colspan="+colspan+">");
	                        
	                        out.print("<input type='text' id='F"+fieldCodes[i]+"' name='F"+fieldCodes[i]+"' size='36' value='220000221110100000010100000000000000' readonly  Class='InputGrey'>");
	                        
							out.print("<input type='button' class='b_text' name='updateFlsg'  value='修改' onclick='call_flags()' v_must=1 v_type='string'>");
							if(fieldCtrlInfos[i].equals("N"))
							{out.print("&nbsp;<font class=\"orange\">*</font></TD>");}
						}
						else if (dataTypes[i].equals("47"))//VPMN中网内费率索引下拉框动态获取
						{
							out.print("<TD width='32%' colspan="+colspan+">");
	                        
	                        out.print("<select id='F"+fieldCodes[i]+"' name='F"+fieldCodes[i]+"' v_must=1 v_type='0_9'>");
	                        String[][] result33 = null;
	                         //wangzn 2010/10/29 19:48:04 begin
                        String dateStr1SqlStr33 = new java.text.SimpleDateFormat("yyyy-MM-dd-HH-mm").format(new java.util.Date());//diling add 增加分
			            String strTime[] = new String[5];//diling update
		                    strTime = dateStr1SqlStr33.split("-");
		                    StringBuffer sqlBufSqlStr33 = new StringBuffer();
							try
	                        {
                        		/* yuanqs add 2011/6/10 10:27:26 修改下拉框数据 */
								sqlBufSqlStr33.append( " select a.offer_id,a.offer_id||'-->'||a.offer_name from product_offer a ,region d,sregioncode e where a.offer_id != 0  and a.offer_attr_type='VpJ0' and a.offer_id=d.offer_id and d.group_id=e.group_id and e.region_code='"+regionCode+"' and a.exp_date>=sysdate ");
								sqlBufSqlStr33.append( "  and a.eff_date<=sysdate  ");
								sqlBufSqlStr33.append( "  and ( to_number(d.right_limit)<="+powerRight+")  ");
								sqlBufSqlStr33.append( "  and (  ");
								sqlBufSqlStr33.append( "  exists (select 1 from svpmnfeeindexconfig b  where ( to_number('"+strTime[0]+"')>=to_number(b.start_year) or (b.start_year is null))  ");
								sqlBufSqlStr33.append( "  and ( to_number('"+strTime[0]+"')<=to_number(b.end_year) or (b.end_year is null))  ");
								sqlBufSqlStr33.append( "  and ( to_number('"+strTime[1]+"')>=to_number(b.start_month) or (b.start_month is null))  ");
								sqlBufSqlStr33.append( "  and ( to_number('"+strTime[1]+"')<=to_number(b.end_month) or (b.end_month is null))  ");
								sqlBufSqlStr33.append( "  and ( to_number('"+strTime[2]+"')>=to_number(b.start_day) or (b.start_day is null))  ");
								sqlBufSqlStr33.append( "  and ( to_number('"+strTime[2]+"')<=to_number(b.end_day) or (b.end_day is null))  ");
								sqlBufSqlStr33.append( "  and ( to_number('"+strTime[3]+"')>=to_number(b.start_hours) or (b.start_hours is null))  ");
								sqlBufSqlStr33.append( "  and ( to_number('"+strTime[3]+"')<=to_number(b.end_hours) or (b.end_hours is null))  ");
								sqlBufSqlStr33.append( "  and ( to_number('"+strTime[4]+"')>=to_number(b.start_minute) or (b.start_minute is null) ) ");
								sqlBufSqlStr33.append( "  and ( to_number('"+strTime[4]+"')<to_number(b.end_minute) or (b.end_minute is null) ) ");
								sqlBufSqlStr33.append( "  and a.offer_id = b.feeindex and b.region_code = e.region_code ) ");
								sqlBufSqlStr33.append( "  or not exists (select 1 from svpmnfeeindexconfig f where a.offer_id = f.feeindex and f.region_code  = e.region_code ) ");
								sqlBufSqlStr33.append( "  )order by a.offer_id ");

								/*
								sqlBufSqlStr33.append( "select a.FEEINDEX,a.FEEINDEX||'-->'||a.FEEINDEX_NAME from  svpmnfeeindex a ,svpmnfeeindexconfig b where a.feeindex > 0 and a.region_code='"+regionCode+"' and a.stop_time>=sysdate and a.power_right<="+powerRight+"");
								sqlBufSqlStr33.append(" and ( to_number('"+strTime[0]+"')>=to_number(b.start_year) or (b.start_year is null) )");
								sqlBufSqlStr33.append(" and ( to_number('"+strTime[0]+"')<=to_number(b.end_year) or (b.end_year is null) )");
								
								sqlBufSqlStr33.append(" and ( to_number('"+strTime[1]+"')>=to_number(b.start_month) or (b.start_month is null) )");
								sqlBufSqlStr33.append(" and ( to_number('"+strTime[1]+"')<=to_number(b.end_month) or (b.end_month is null) )");
								
								sqlBufSqlStr33.append(" and ( to_number('"+strTime[2]+"')>=to_number(b.start_day) or (b.start_day is null) )");
								sqlBufSqlStr33.append(" and ( to_number('"+strTime[2]+"')<=to_number(b.end_day) or (b.end_day is null) )");
								
								sqlBufSqlStr33.append(" and ( to_number('"+strTime[3]+"')>=to_number(b.start_hours) or (b.start_hours is null) )");
								sqlBufSqlStr33.append(" and ( to_number('"+strTime[3]+"')<to_number(b.end_hours) or (b.end_hours is null) )");
								
								
								sqlBufSqlStr33.append(" and a.feeindex = b.feeindex(+) and a.region_code = b.region_code(+)");
								sqlBufSqlStr33.append(" order by to_number(a.feeindex)");
									*/
									String sqlStr33 = sqlBufSqlStr33.toString();
									System.out.println("sqlStr33="+sqlStr33);
								//wangzn 2010/10/29 19:48:22 end
	                            %>
	                            
								<wtc:pubselect name="sPubSelect" outnum="2" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
								<wtc:sql><%=sqlStr33%></wtc:sql>
								</wtc:pubselect>
								<wtc:array id="result_tu7" scope="end"/>               
	                            
	                            <%
	                           
	                            result33 = result_tu7;
	                            int recordNum = result33.length;
	                            for(int xCoTt=0;xCoTt<recordNum;xCoTt++){
	                                    out.println("<option class='button' value='" + result33[xCoTt][0] + "'>" + result33[xCoTt][1] + "</option>");
	                            }
	                        }catch(Exception e){
	                                logger.error("Call sunView is Failed!");
                        }

                        out.print("</select>");
						if(fieldCtrlInfos[i].equals("N"))
						{out.print("&nbsp;<font class=\"orange\">*</font></TD>");}
					}
					/* yuanqs add 2011/6/10 10:32:38 网外 */
						else if (dataTypes[i].equals("78"))//VPMN中网外费率索引下拉框动态获取
						{
							out.print("<TD width='32%' colspan="+colspan+">");

	                        out.print("<select id='F"+fieldCodes[i]+"' name='F"+fieldCodes[i]+"' v_must=1 v_type='0_9'>");
	                        String[][] result33 = null;
	                         //wangzn 2010/10/29 19:48:04 begin
	                        String dateStr1SqlStr33 = new java.text.SimpleDateFormat("yyyy-MM-dd-HH-mm").format(new java.util.Date());
				            String strTime[] = new String[5];
		                    strTime = dateStr1SqlStr33.split("-");
		                    StringBuffer sqlBufSqlStr33 = new StringBuffer();
							try
	                        {
								sqlBufSqlStr33.append( " select a.offer_id,a.offer_id||'-->'||a.offer_name from product_offer a ,region d,sregioncode e where a.offer_id != 0  and a.offer_attr_type='VpW0' and a.offer_id=d.offer_id and d.group_id=e.group_id and e.region_code='"+regionCode+"' and a.exp_date>=sysdate ");
								sqlBufSqlStr33.append( "  and a.eff_date<=sysdate  ");
								sqlBufSqlStr33.append( "  and ( to_number(d.right_limit)<="+powerRight+")  ");
								sqlBufSqlStr33.append( "  and (  ");
								sqlBufSqlStr33.append( "  exists (select 1 from svpmnfeeindexconfig b  where ( to_number('"+strTime[0]+"')>=to_number(b.start_year) or (b.start_year is null))  ");
								sqlBufSqlStr33.append( "  and ( to_number('"+strTime[0]+"')<=to_number(b.end_year) or (b.end_year is null))  ");
								sqlBufSqlStr33.append( "  and ( to_number('"+strTime[1]+"')>=to_number(b.start_month) or (b.start_month is null))  ");
								sqlBufSqlStr33.append( "  and ( to_number('"+strTime[1]+"')<=to_number(b.end_month) or (b.end_month is null))  ");
								sqlBufSqlStr33.append( "  and ( to_number('"+strTime[2]+"')>=to_number(b.start_day) or (b.start_day is null))  ");
								sqlBufSqlStr33.append( "  and ( to_number('"+strTime[2]+"')<=to_number(b.end_day) or (b.end_day is null))  ");
								sqlBufSqlStr33.append( "  and ( to_number('"+strTime[3]+"')>=to_number(b.start_hours) or (b.start_hours is null))  ");
								sqlBufSqlStr33.append( "  and ( to_number('"+strTime[3]+"')<=to_number(b.end_hours) or (b.end_hours is null))  ");
								sqlBufSqlStr33.append( "  and ( to_number('"+strTime[4]+"')>=to_number(b.start_minute) or (b.start_minute is null) ) ");
								sqlBufSqlStr33.append( "  and ( to_number('"+strTime[4]+"')<to_number(b.end_minute) or (b.end_minute is null) ) ");
								sqlBufSqlStr33.append( "  and a.offer_id = b.feeindex and b.region_code = e.region_code ) ");
								sqlBufSqlStr33.append( "  or not exists (select 1 from svpmnfeeindexconfig f where a.offer_id = f.feeindex and f.region_code  = e.region_code ) ");
								sqlBufSqlStr33.append( "  )order by a.offer_id ");
								String sqlStr33 = sqlBufSqlStr33.toString();
								System.out.println("====sqlStr33====wangwai-----" + sqlStr33);
								//wangzn 2010/10/29 19:48:22 end
	                            %>

								<wtc:pubselect name="sPubSelect" outnum="2" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
								<wtc:sql><%=sqlStr33%></wtc:sql>
								</wtc:pubselect>
								<wtc:array id="result_tu7" scope="end"/>

	                            <%

	                            result33 = result_tu7;
	                            int recordNum = result33.length;
	                            System.out.println("====recordNum====-----" + recordNum);
	                            for(int xCoTt=0;xCoTt<recordNum;xCoTt++){
	                                    out.println("<option class='button' value='" + result33[xCoTt][0] + "'>" + result33[xCoTt][1] + "</option>");
	                            }
	                        }catch(Exception e){
	                                logger.error("Call sunView is Failed111!");
	                        }
	
	                        out.print("</select>");
							if(fieldCtrlInfos[i].equals("N"))
							{out.print("&nbsp;<font class=\"orange\">*</font></TD>");}
						}
						else if (dataTypes[i].equals("48"))//只读文本框带静态默认值
						{
							out.print("<TD width='32%' colspan="+colspan+">");
	                        
	                        out.print("<input type='text' id='F"+fieldCodes[i]+"' name='F"+fieldCodes[i]+"' size='20' value='"+fieldValues[i]+"' readonly  Class='InputGrey' onKeyPress='return isKeyNumberdot(0)' v_must=0 v_type='0_9'>");
							if(fieldCtrlInfos[i].equals("N"))
							{out.print("&nbsp;<font class=\"orange\">*</font></TD>");}
						}
						else if (dataTypes[i].equals("60"))//VPMN中资费套餐生效日期带默认值动态获取
						{
							out.print("<TD width='32%' colspan="+colspan+">");
	                    	
	                    	out.print("<input type='text'  id='F"+fieldCodes[i]+"' name='F"+fieldCodes[i]+"' readOnly class='InputGrey' v_must=0 v_type='date' onKeyPress='return isKeyNumberdot(0)' value='"+addDate+"' size='20' >");
							if(fieldCtrlInfos[i].equals("N"))
							{out.print("&nbsp;<font class=\"orange\">*</font></TD>");}
						}
						
						else if (dataTypes[i].equals("70"))//ADC业务业务接入号带默认值动态获取
						{
							out.print("<TD width='32%' colspan="+colspan+">");
	                    	
	                    	out.print("<input type='text' id='F"+fieldCodes[i]+"' name='F"+fieldCodes[i]+"' v_type='0_9' v_must='1' v_maxlength='128' ");
	                    	
	                    	if(openLabel!=null && openLabel.equals("link")){
	                    	    out.print(" readOnly class='InputGrey' onblur='hiddenTip(this);' ");
	                        }else{
	                        	out.print(" value='"+ telNo +"' ");
	                    	}
	                    	out.print(" >");
	                    	
							if(fieldCtrlInfos[i].equals("N"))
							{out.print("&nbsp;<font class=\"orange\">*</font></TD>");}
						}
						else if (dataTypes[i].equals("71"))//ADC业务不允许下发时间段列表带弹出窗口设置
						{
							out.print("<TD width='32%' colspan="+colspan+">");
	                    	
	                    	out.print("<input type='text' id='F"+fieldCodes[i]+"' name='F"+fieldCodes[i]+"' maxlength='128' value='' size='30' readOnly>");
	                    	out.print("&nbsp;<input type='button' name='setTimeBtn1' class='b_text' value='设置' onClick='setTime()' >&nbsp;");
	                    	
							if(fieldCtrlInfos[i].equals("N"))
							{out.print("&nbsp;<font class=\"orange\">*</font></TD>");}
						}
						else if (dataTypes[i].equals("72"))//ADC业务上行业务指令带弹出窗口设置
						{
							out.print("<TD width='32%' colspan="+colspan+">");
	                    	
	                    	out.print("<input type='text' id='F"+fieldCodes[i]+"' name='F"+fieldCodes[i]+"' maxlength='128' size='30' readOnly>");
	                    	out.print("&nbsp;<input type='button' class='b_text' name='setMOBtn1' value='设置' onClick='setMO()' >&nbsp;");
	                    	
							if(fieldCtrlInfos[i].equals("N"))
							{out.print("&nbsp;<font class=\"orange\">*</font></TD>");}
						}
						else if (dataTypes[i].equals("14"))//日期
						{
						String datestrss="";
						String vmuststr="";
							if("10835".equals(fieldCodes[i])) {
								datestrss="";
							}else {
								datestrss=dateStr;
							}
							if(fieldCtrlInfos[i].equals("N"))
							{
								 vmuststr="v_must=1";
							}else {
								 vmuststr="v_must=0";
							}	
							out.print("<TD width='32%' colspan="+colspan+">");
							out.print("<input id='F"+fieldCodes[i]+"' name='F"+fieldCodes[i]+"' type='text' onKeyPress='return isKeyNumberdot(0)' value='"+datestrss+"' size='20' maxlength='8' "+vmuststr+" v_type='date' v_format='yyyyMMdd'>");
							if(fieldCtrlInfos[i].equals("N"))
							{out.print("&nbsp;<font class=\"orange\">*</font></TD>");}
						}
						else if (dataTypes[i].equals("74"))//个性化行业应用 PAY_SI
						{
							out.print("<TD width='32%' colspan="+colspan+">");
	                    	
	                    	out.print("<input v_type='0_9' id='F"+fieldCodes[i]+"' name='F"+fieldCodes[i]+"' maxlength=20 onkeyup='if(event.keyCode==13)getSi();' index='60'>");
	                    	out.print("&nbsp;<input name=siQuery type=button id='siQuery' class='b_text' onclick='getSi();' style='cursor:hand' value=查询>&nbsp;");
	                    	
							if(fieldCtrlInfos[i].equals("N"))
							{out.print("&nbsp;<font class=\"orange\">*</font></TD>");}
						}
						else if (dataTypes[i].equals("65"))//M2M
						{
							out.print("<TD width='32%' colspan="+colspan+"> <select id='F"+fieldCodes[i]+"' name='F"+fieldCodes[i]+"' datatype="+dataTypes[i]+" onchange='ctrlF10340(frm.F"+fieldCodes[i]+");' >");
							for (int j=0; j < fieldParamCodes.length; j++)
							{
								if (fieldParamCodes[j][0].equals(fieldCodes[i]))
								{
									out.print("<option ");
									if (fieldValues[i].equals(fieldParamCodes[j][1]))
										out.print("selected");
									out.print(" value='" + fieldParamCodes[j][1] + "'>"+fieldParamCodes[j][1]+"--" + fieldParamCodes[j][2]+ "</option>");
								}
							}
							out.print("</select> </TD>");
						}
						else if (dataTypes[i].equals("66"))//M2M
						{
	
							out.print("<TD width='32%' colspan="+colspan+"> <div name ='divF10340' id='divF10340'><input id='F"+fieldCodes[i]+"' name='F"+fieldCodes[i]+"'  class='button' type='hidden' datatype="+dataTypes[i]+" maxlength='"+fieldLengths[i]+"' value='0'>&nbsp;");
							out.print("</div></TD>");
						}
						else if (dataTypes[i].equals("67"))//M2M
						{
							out.print("<TD width='32%' colspan="+colspan+"> <div name ='divF10341' id='divF10341'><input id='F"+fieldCodes[i]+"' name='F"+fieldCodes[i]+"'  class='button' type='hidden' datatype="+dataTypes[i]+" maxlength='"+fieldLengths[i]+"' value='0' >&nbsp;");
							out.print("</div></TD>");
						}	
						else if (dataTypes[i].equals("10"))//整型
						{
						System.out.println("ningtn_fpub 3690 1828{"+fieldCodes[i]+"}");
							//wanghfa修改 2010-12-1 15:45 需求：移动总机接入BOSS系统 start
							if ("10603".equals(fieldCodes[i])) {
								out.print("<TD width='32%' colspan="+colspan+"> <input id='F"+fieldCodes[i]+"' name='F"+fieldCodes[i]+"' style='ime-mode:disabled' onKeyPress='return isKeyNumberdot(0)' class='button' type='text' datatype="+dataTypes[i]+" maxlength='"+fieldLengths[i]+"' value='"+fieldValues[i]+"'>&nbsp;(前四位区号+号码)");
							} else {
								out.print("<TD width='32%' colspan="+colspan+"> <input id='F"+fieldCodes[i]+"' name='F"+fieldCodes[i]+"' style='ime-mode:disabled' onKeyPress='return isKeyNumberdot(0)' class='button' type='text' datatype="+dataTypes[i]+" maxlength='"+fieldLengths[i]+"' value='"+fieldValues[i]+"'  "+readOnlyFlag+"  >");
							}
							//wanghfa修改 2010-12-1 15:45 需求：移动总机接入BOSS系统 end
							
							if(fieldCtrlInfos[i].equals("N"))
							{out.print("&nbsp;<font class=\"orange\">*</font></TD>");}
						}
						else if (dataTypes[i].equals("83"))//动力100包手续费
						{
						    String sql44 = "select offer_attr_value from product_offer_attr where offer_id = '"+xProductCode+"' and offer_attr_seq = 3636";
						    System.out.println("######## sql44 = "+sql44);
						    %>
	                            <wtc:pubselect name="sPubSelect" retcode="retCode74" retmsg="retMsg74" outnum="1" routerKey="region" routerValue="<%=regionCode%>">
	                            	<wtc:sql><%=sql44%></wtc:sql>
	                            </wtc:pubselect>
	                            <wtc:array id="retArr" scope="end"/>
	                        <%
	                        String DL100PkgFee = "";
	                        if("000000".equals(retCode74)){
	                            if(retArr.length>0){
	                                DL100PkgFee = retArr[0][0];
	                            }else{
	                                DL100PkgFee = "";
	                            }
	                        }
							out.print("<TD width='32%' colspan="+colspan+"> <input id='F"+fieldCodes[i]+"' name='F"+fieldCodes[i]+"' class='InputGrey' readOnly type='text' datatype="+dataTypes[i]+" maxlength='"+fieldLengths[i]+"' value='"+DL100PkgFee+"'>");
							if(fieldCtrlInfos[i].equals("N"))
							{out.print("&nbsp;<font class=\"orange\">*</font></TD>");}
						}
						else if (dataTypes[i].equals("75"))//销售代理商带查询按钮
						{
							out.print("<TD width='32%' colspan="+colspan+">");
	                    	
	                    	out.print("<input type='text' id='F"+fieldCodes[i]+"' name='F"+fieldCodes[i]+"' maxlength='128' size='20' readOnly>");
	                    	out.print("&nbsp;<input type='button' class='b_text' id='selSalesBtn' name='selSalesBtn' value='查询' onClick='selSales()' >&nbsp;");
	                    	
							if(fieldCtrlInfos[i].equals("N"))
							{out.print("&nbsp;<font class=\"orange\">*</font></TD>");}
						}
						else if (dataTypes[i].equals("79"))//交换机端口号带查询按钮
						{
							out.print("<TD width='32%' colspan="+colspan+">");
	                    	
	                    	out.print("<input type='text' id='F"+fieldCodes[i]+"' name='F"+fieldCodes[i]+"' maxlength='128' size='20' readOnly>");
	                    	out.print("&nbsp;<input type='button' class='b_text' id='selExchgPortBtn' name='selExchgPortBtn' value='查询' onClick='selExchgPorts()' >&nbsp;");
	                    	
							if(fieldCtrlInfos[i].equals("N"))
							{out.print("&nbsp;<font class=\"orange\">*</font></TD>");}
						}else if(dataTypes[i].equals("12")){ //文本框
							out.print("<TD width='32%' colspan="+colspan+"> <input id='F"+fieldCodes[i]+"' name='F"+fieldCodes[i]+"' type='text' datatype="+dataTypes[i]+" maxlength='"+fieldLengths[i]+"' "+readOnlyFlag+" value='"+fieldValues[i]+"'>");
							if(fieldCtrlInfos[i].equals("N"))
							{	
								out.print("&nbsp;<font class=\"orange\">*");
								if("81028".equals(fieldCodes[i])){
									out.print("&nbsp;[20位数字]");
								}
								out.print("</font></TD>");
							}
						}
						else {
							/* yuanqs add 2011/5/24 15:26:24 增加 readOnlyFlag */
							out.print("<TD width='32%' colspan="+colspan+"> <input id='F"+fieldCodes[i]+"' name='F"+fieldCodes[i]+"' type='text' datatype="+dataTypes[i]+" maxlength='"+fieldLengths[i]+"' "+readOnlyFlag+" value='"+fieldValues[i]+"'>");
							if(fieldCtrlInfos[i].equals("N"))
							{out.print("&nbsp;<font class=\"orange\">*</font></TD>");}
						}
					}
						//还有下一个字段
	    				if((i+1)<fieldCount)
	    				{
							//在同一个表中
							if(fieldGroupNo[i].equals(fieldGroupNo[i+1]))
							{
								tableFlag = false;
								trFlag = true;
							}
							//不再同一表中
							else if(!fieldGroupNo[i].equals(fieldGroupNo[i+1]))
							{
								tableFlag = true;
								trFlag = true;
								out.print("</TR><tr id='segMentTabLast"+fieldGroupNo[i]+"'><td colspan=100>&nbsp</td></tr></table></div>");//wangzn modify 2011/6/3 13:08:57
								i++;
								break;
							}
						}
						//没有下一个字段
	    				else 
	    				{
	    					out.println("");
	    					out.print("</TR>"); 
	    					out.print("<tr id='segMentTabLast"+fieldGroupNo[i]+"'><td colspan=100>&nbsp</td></tr></TABLE></div>"); 
	    					%>
							</div>
	    					<%
	    					i++;
	    					break;
	    				}
	    						
	    				i++;	
					}
				}
			}
		}
		%>
			<div id="Operation_Table">
            <div class="title">
            	<div id="title_zi">业务信息</div>
            </div>
			<TABLE cellSpacing=0 style="display:<%=listShow%>">
		<%
		if (calcButtonFlag==1)//如果有计算字段则显示计算按钮
		{
%> 

			<TR>
				<TD colspan="4" align="center">
					<input value="计算蓝色星号的值" name=calcAll type=button id="calcAll" class="b_text" onMouseUp="calcAllFieldValues();" onKeyUp="if(event.keyCode==13)calcAllFieldValues();" style="cursor：hand">
				</TD>
			</TR>
<%
		}
	}
%>

