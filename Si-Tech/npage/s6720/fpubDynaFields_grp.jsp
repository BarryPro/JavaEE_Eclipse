<%
/********************
 * version v2.0
 * ������: si-tech
 * update by qidp @ 2009-01-16
 ********************/
%>
<%
/*
	���ƣ���̬�����ֶ�
	�����ⲿ������
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
		String []fieldDefValue=new String[fieldCount];
		String listShow;
	ʹ�÷������ܣ�
		���ļ����ܵ���ʹ�ã���Ҫ�����ļ�include����ļ�
	����OPCODE��3505��3508
	Author:lugz,yinyx
*/
%>
<%
	    		//�����
    			int grpCount_grp = 0;
    			iField = 0;
    			Vector vecGrp_grp = new Vector();
    			Hashtable htGrp_grp= new Hashtable();
    			
    			while(iField<fieldGroupNo.length)
    			{
    			    if(!fieldGroupNo[iField].equals("0"))
    			    {
	    			    if(vecGrp_grp.contains(fieldGroupNo[iField]))
	    			    {
	    			    }
	    			    else
	    			    {
	    			        vecGrp_grp.add(fieldGroupNo[iField]);
	    			        //��no,���
	    			        htGrp_grp.put(fieldGroupNo[iField],new Integer(iField));
	    			        grpCount_grp++;
	    			    }
    			    }
    			  	    iField++;
    			}
	
	String [][]fieldCalcFieldReadOnlys_grp=null;
	//�����б�����
	String[][] fieldParamCodes_grp = new String[][]{};
	String[][] fieldParamSql_grp = new String[][]{};
	String [] paraIn2 = new String[2];
	
	
	HashMap hm_grp = new HashMap();
	if(!hm_grp.containsKey("regionCode"))   hm_grp.put("regionCode",regionCode); 
	if(!hm_grp.containsKey("workNo"))       hm_grp.put("workNo",workNo);
	if(!hm_grp.containsKey("org_code"))     hm_grp.put("org_code",org_code);
	if(!hm_grp.containsKey("districtCode")) hm_grp.put("districtCode",districtCode);
	
%>
<%
	if (nextFlag==2)
	{
%>
<script language="javascript">
function calcFieldValue_grp(calaField)//���ݹ�ʽ���㵥���ֶε�ֵ
{
<%
	
	try
	{
		sqlStr= "select field_code, ref_field_code,ref_field_value, nvl(formula,'')"
				+"  from sUserFieldFormula"
				+" where busi_type = '1000'"
				+"   and user_type =:userType"
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

  			//fieldCalcFieldReadOnlys_grp= (String[][])retArray.get(0);
  			if(retCode1.equals("000000")){
  			    fieldCalcFieldReadOnlys_grp = retArr1;
  			}
        		
		}
	catch(Exception e)
	{
		logger.error("Call sunView is Failed!");
	}
	int iPos=0;

		for(int i = 0; i < fieldCalcFieldReadOnlys_grp.length; i ++)
		{

			if (!fieldCalcFieldReadOnlys_grp[i][0].trim().equals(""))
			{
			    out.println("//Ŀ���ֶ��������ֶ�");
	    		out.println("if(typeof(document.frm.F" +userType+ fieldCalcFieldReadOnlys_grp[i][0] + ".length)==\"undefined\")");
	    		out.println("{");
				out.println("	if ( document.frm.F" +userType+ fieldCalcFieldReadOnlys_grp[i][0] + ".id == calaField.id)");
				out.println("	{");
				if(!fieldCalcFieldReadOnlys_grp[i][1].equals(""))
				{
				out.println("		if (document.frm.F" +userType+ fieldCalcFieldReadOnlys_grp[i][1] + ".value == '" + fieldCalcFieldReadOnlys_grp[i][2] + "')");
				out.println("		{");
				}
				//:12006+(:12002*:12005)
				//eval(frm.F12006.value)+(eval(frm.F12002.value)*eval(frm.F12005.value))
				out.println("		  var length = 1;");
				 String fma =fieldCalcFieldReadOnlys_grp[i][3];
				while(true)
				{
				   
					iPos = fma.indexOf(":");
					if (iPos < 0)
					{
						break;
					}
					out.println("		  var flagN"+fma.substring(iPos+1,iPos+1+5)+" = \"\";");
					
					        //�������������ֶ������ڵ�
					out.println("			if(typeof(document.frm.F" +userType+ fma.substring(iPos+1,iPos+1+5) + ".length)!=\"undefined\")");
					out.println("			{");
					
					out.println("			length = document.frm.F"+userType+fma.substring(iPos+1,iPos+1+5)+".length;");
					out.println("			flagN"+fma.substring(iPos+1,iPos+1+5)+" = \"[n]\";");           
					out.println("			}");
					        //�������������ֶβ������ڵ�
					out.println("			else");
					out.println("			{");
					out.println("	  	      flagN"+fma.substring(iPos+1,iPos+1+5)+" = \"\";");
					          
					
					
					fma = fma.substring(0,iPos)
								+ "eval(eval(\"frm.F" + userType  
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
				if(!fieldCalcFieldReadOnlys_grp[i][1].equals(""))
				{
				out.println("		}");
				}
				out.println("	}");
				out.println("}");
				
				out.println("//Ŀ���ֶ��������ֶ�");
	    		out.println("else{");
	    		out.println("	for(var n = 0 ; n < document.frm.F" +userType+ fieldCalcFieldReadOnlys_grp[i][0] + ".length ; n++)");
	    		out.println("	{");
	    		out.println("		if ( document.frm.F" + userType + fieldCalcFieldReadOnlys_grp[i][0] + "[n].id == calaField.id)");
	 			out.println("		{");
	 			if(!fieldCalcFieldReadOnlys_grp[i][1].equals(""))
				{
	 			out.println("			if (document.frm.F" +userType+ fieldCalcFieldReadOnlys_grp[i][1] + ".value == '" + fieldCalcFieldReadOnlys_grp[i][2] + "')");
				out.println("			{");
				}
				out.println("			var length = 1;");
				
				 fma =fieldCalcFieldReadOnlys_grp[i][3];
				while(true)
				{
					iPos = fma.indexOf(":");
					if (iPos < 0)
					{
						break;
					}
					
					out.println("		  var flagN"+fma.substring(iPos+1,iPos+1+5)+" = \"\";");
					
					        //�������������ֶ������ڵ�
					out.println("			if(typeof(document.frm.F" + userType + fma.substring(iPos+1,iPos+1+5) + ".length)!=\"undefined\")");
					out.println("			{");
					
					out.println("			length = document.frm.F"+ userType + fma.substring(iPos+1,iPos+1+5)+".length;");
					out.println("			flagN"+fma.substring(iPos+1,iPos+1+5)+" = \"[n]\";");           
					out.println("			}");
					        //�������������ֶβ������ڵ�
					out.println("			else");
					out.println("			{");
					out.println("	  	      flagN"+fma.substring(iPos+1,iPos+1+5)+" = \"\";");
					            fma = fma.substring(0,iPos)
								+ "eval(eval(\"frm.F" + userType
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
				if(!fieldCalcFieldReadOnlys_grp[i][1].equals(""))
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

function clearCalcFields_grp(selectId)//�����������仯ʱ,��ռ����ֶ�,������ֵ�����༭���״̬
{
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
					+"	   and a.busi_type = '1000'"
					+"	   and a.FIELD_TYPE = '19'"
					+"	   and b.USER_TYPE =:userType";
		}
		else
		{
			sqlStr= "select a.field_code "
					+"	  from sUserFieldCode a, sUserTypeFieldRela b"
					+"	 where a.busi_type = b.busi_type"
					+"	   and a.field_code = b.FIELD_CODE"
					+"	   and a.busi_type = '1000'"
					+"	   and a.FIELD_TYPE = '19'"
					+"	   and b.USER_TYPE =:userType";
		}
		//retArray = callView.sPubSelect("1",sqlStr);
		
	    paraIn2[0] = sqlStr;    
        paraIn2[1]="userType="+userType;
%>
        <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2" outnum="1" >
        	<wtc:param value="<%=paraIn2[0]%>"/>
        	<wtc:param value="<%=paraIn2[1]%>"/> 
        </wtc:service>
        <wtc:array id="retArr2" scope="end"/>
<%
/*		//TODO �����������
			 String [][]s={
    		         {"10008"},
	    	         {"10004"}         
    		 };
    		  retArray.add(0,s);
	*/		
			//fieldCalcFields = (String[][])retArray.get(0);
        if(retCode2.equals("000000")){
            fieldCalcFields = retArr2;
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
				out.println("document.frm.F" + userType +  fieldCodes[c]+ ".value = ''");
			}
			else
			{
				out.println("for(var n = 0 ; n < document.frm.F" + userType + fieldCodes[c] + ".length ; n++){");
				out.println("document.frm.F" +  userType + fieldCodes[c] + "[n].value = ''");
				out.println("}");
			}
		}
		c++;
	}

	for(int i = 0; i < fieldCalcFields.length; i ++)
	{
		if (!fieldCalcFields[i][0].trim().equals(""))
		{
			out.println("document.frm.F" +  userType + fieldCalcFields[i][0] + ".value = ''");
		}
	}

	//String [][]fieldCalcFieldReadOnlys_grp=null;
	try
	{
		sqlStr= "select ref_field_code,ref_field_value,field_code, nvl(formula,'')"
				+"  from sUserFieldFormula"
				+" where busi_type = '1000'"
				+"   and user_type =:userType"
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
/*			//TODO �����������
			//retArry = 
			String [][]s={
    		       	 {"10010","a","10008",":10005+10"}, 
    		         {"10010","a","10004",":10005*10+:10006"}    
    		 };
    		  retArray.add(0,s);
*/
			//fieldCalcFieldReadOnlys_grp = (String[][])retArray.get(0);
			if(retCode3.equals("000000")){
			    fieldCalcFieldReadOnlys_grp = retArr3;
			}
		}
	catch(Exception e)
	{
		logger.error("Call sunView is Failed!");
	}
	for(int i = 0; i < fieldCalcFieldReadOnlys_grp.length; i ++)
	{
		if (!fieldCalcFieldReadOnlys_grp[i][0].trim().equals(""))
		{
			out.println("if ( document.frm.F" +  userType + fieldCalcFieldReadOnlys_grp[i][0] + ".id == selectId.id)");
			out.println("{");
			out.println("	if (selectId.value == '" + fieldCalcFieldReadOnlys_grp[i][1] + "')");
			out.println("	{");
			out.println("		if(typeof(document.frm.F" +  userType + fieldCalcFieldReadOnlys_grp[i][2] + ".length)!=\"undefined\")");
			out.println("		{");
			out.println("			for(var n = 0 ; n < document.frm.F" +  userType + fieldCalcFieldReadOnlys_grp[i][2] + ".length ; n++)");
			out.println("			{");
			if (fieldCalcFieldReadOnlys_grp[i][3] == null || fieldCalcFieldReadOnlys_grp[i][3].equals(""))
			{
				out.println("		document.frm.F" +  userType + fieldCalcFieldReadOnlys_grp[i][2] + "[n].readOnly=false;");
				out.println("		document.all('blue" +  userType + fieldCalcFieldReadOnlys_grp[i][2] + "')[n].style.display='none';");
			}
			else
			{
				out.println("		document.frm.F" +  userType + fieldCalcFieldReadOnlys_grp[i][2] + "[n].readOnly=true;");
				out.println("		document.all('blue" +  userType +fieldCalcFieldReadOnlys_grp[i][2] + "')[n].style.display='';");
			}
			out.println("			}");
			out.println("		}");
			out.println("		else");
			out.println("		{");
			if (fieldCalcFieldReadOnlys_grp[i][3] == null || fieldCalcFieldReadOnlys_grp[i][3].equals(""))
			{
				out.println("		document.frm.F" +  userType + fieldCalcFieldReadOnlys_grp[i][2] + ".readOnly=false;");
				out.println("		document.all('blue" +  userType +fieldCalcFieldReadOnlys_grp[i][2] + "').style.display='none';");
			}
			else
			{
				out.println("		document.frm.F" +  userType + fieldCalcFieldReadOnlys_grp[i][2] + ".readOnly=true;");
				out.println("		document.all('blue" +  userType +fieldCalcFieldReadOnlys_grp[i][2] + "').style.display='';");
			}
			out.println("		}");
			out.println("	}");
			out.println("}");
		}
	}
%>
}
function calcAllFieldValues_grp()//�������м����ֶε�ֵ
{

	if (!checkDynaFieldValues_grp(false))
		return false;
		
	<%
	int fieldCalcFieldsLen=0;
	fieldCalcFieldsLen = fieldCalcFields.length;

	
	
		for(int i = 0; i < fieldCalcFieldsLen; i ++)
		{
		
		out.println("if(typeof(document.frm.F" +  userType + fieldCalcFields[i][0] + ".length)==\"undefined\"){");
		out.println("if(!calcFieldValue_grp(frm.F" +  userType + fieldCalcFields[i][0] + "))");
		out.println("return false;");
		out.println("}");
		out.println("else{");
		out.println("for(var n = 0 ; n < document.frm.F" +  userType + fieldCalcFields[i][0] + ".length ; n++){");
		out.println("if(!calcFieldValue_grp(frm.F" +  userType + fieldCalcFields[i][0] + "[n]))");
		out.println("return false;");
		out.println("}");
		out.println("}");
		}
	
%>
	return true;
}
function JHshStrLen(sString)//�����ַ�������
{
	var sStr,iCount,i,strTemp ; 
	iCount = 0 ;
	sStr = sString.split("");
	for (i = 0 ; i < sStr.length ; i ++)
	{
		strTemp = escape(sStr[i]); 
		if (strTemp.indexOf("%u",0) == -1) // ��ʾ�Ǻ���
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
function checkDynaFieldValues_grp(haveCalc)//���༭���������Ƿ�Ϸ���haveCalc:�Ƿ�����Լ����ֶεļ��
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
	//����ֶοɿգ���Ϊ�գ�����ȷreturn true ,Y-�ɿ� N-���ɿ�		
			if(fieldCtrlInfos[iLen].equals("Y"))
			{
			%>
			if(frm.F<%=userType%><%=fieldCodes[iLen]%>.value=='')
			checkValues_flag = true;
			<%
			}%>	
			
		if(!checkValues_flag)
		{
		if(typeof(document.frm.F<%=userType%><%=fieldCodes[iLen]%>.length)=="undefined"){
		
			frm.F<%=userType%><%=fieldCodes[iLen]%>.datatype=<%out.println(dataTypes[iLen]);%>;
			
			if (frm.F<%=userType%><%=fieldCodes[iLen]%>.datatype=='10'){//����
				 reta=parseInt(frm.F<%=userType%><%=fieldCodes[iLen]%>.value)==frm.F<%=userType%><%=fieldCodes[iLen]%>.value;
				 if(JHshStrLen(frm.F<%=userType%><%=fieldCodes[iLen]%>.value) > "<%=fieldLengths[iLen]%>"){
					 retb = false;
				   }
					 ret = reta && retb;
				}
			else if (frm.F<%=userType%><%=fieldCodes[iLen]%>.datatype=='11'){//������
				reta=parseFloat(frm.F<%=userType%><%=fieldCodes[iLen]%>.value)==frm.F<%=userType%><%=fieldCodes[iLen]%>.value;
				if(JHshStrLen(frm.F<%=userType%><%=fieldCodes[iLen]%>.value) > "<%=fieldLengths[iLen]%>"){
					 retb = false;
				   }
					ret = reta && retb;
			}
			else if (frm.F<%=userType%><%=fieldCodes[iLen]%>.datatype=='12'){//�ַ���
				//ret=true;
					//var reg = new RegExp(/^(\s)*$/);
					//var flag= reg.test(frm.F<%=userType%><%=fieldCodes[iLen]%>.value);
					flag=frm.F<%=userType%><%=fieldCodes[iLen]%>.value=='';
					reta=!flag;
					if(JHshStrLen(frm.F<%=userType%><%=fieldCodes[iLen]%>.value) > "<%=fieldLengths[iLen]%>"){
					 retb = false;
				 }
					ret = reta && retb;
				}
			else if (frm.F<%=userType%><%=fieldCodes[iLen]%>.datatype=='13'){//���
				ret=parseFloat(frm.F<%=userType%><%=fieldCodes[iLen]%>.value)==frm.F<%=userType%><%=fieldCodes[iLen]%>.value;
			}
			else if (frm.F<%=userType%><%=fieldCodes[iLen]%>.datatype=='14'){//����
				ret=validDate(frm.F<%=userType%><%=fieldCodes[iLen]%>);
			}
			else if (frm.F<%=userType%><%=fieldCodes[iLen]%>.datatype=='15')//����ʱ��
			{
				frm.F<%=userType%><%=fieldCodes[iLen]%>.value = frm.F<%=userType%><%=fieldCodes[iLen]%>.value.substr(0,8)
									+ frm.F<%=userType%><%=fieldCodes[iLen]%>.value.substr(9,2)
									+ frm.F<%=userType%><%=fieldCodes[iLen]%>.value.substr(12,2)
									+ frm.F<%=userType%><%=fieldCodes[iLen]%>.value.substr(15,2)
				ret=validTotalDate(frm.F<%=userType%><%=fieldCodes[iLen]%>);
				frm.F<%=userType%><%=fieldCodes[iLen]%>.value = frm.F<%=userType%><%=fieldCodes[iLen]%>.value.substr(0,8)
									+ " "
									+ frm.F<%=userType%><%=fieldCodes[iLen]%>.value.substr(8,2)
									+":"
									+ frm.F<%=userType%><%=fieldCodes[iLen]%>.value.substr(10,2)
									+":"
									+ frm.F<%=userType%><%=fieldCodes[iLen]%>.value.substr(12,2)
			}
			else if (frm.F<%=userType%><%=fieldCodes[iLen]%>.datatype=='16')//BOOL
				ret=true;
			else if (frm.F<%=userType%><%=fieldCodes[iLen]%>.datatype=='17')//������
				ret=true;
			else if (frm.F<%=userType%><%=fieldCodes[iLen]%>.datatype=='18')//����
				ret=true;
			else if ((frm.F<%=userType%><%=fieldCodes[iLen]%>.datatype=='19')&&(haveCalc))//��ʽ����
				ret=parseFloat(frm.F<%=userType%><%=fieldCodes[iLen]%>.value)==frm.F<%=userType%><%=fieldCodes[iLen]%>.value;
			else if (frm.F<%=userType%><%=fieldCodes[iLen]%>.datatype=='20')//ip��ַ add
			    ret=forIP(frm.F<%=userType%><%=fieldCodes[iLen]%>);//add
			if (!ret)
			{
				rdShowMessageDialog("�����������Ͳ���!");
				//alert("�����������Ͳ���!");
				frm.F<%=userType%><%=fieldCodes[iLen]%>.focus();
				return ret;
			}
		}
		else
		{
			for(var m = 0 ; m < document.frm.F<%=userType%><%=fieldCodes[iLen]%>.length ; m ++){

			//alert(document.frm.F<%=userType%><%=fieldCodes[iLen]%>[m].value);
			frm.F<%=userType%><%=fieldCodes[iLen]%>[m].datatype=<%out.println(dataTypes[iLen]);%>;
			
			if (frm.F<%=userType%><%=fieldCodes[iLen]%>[m].datatype=='10'){//����
				 reta=parseInt(frm.F<%=userType%><%=fieldCodes[iLen]%>[m].value)==frm.F<%=userType%><%=fieldCodes[iLen]%>[m].value;
				 if(JHshStrLen(frm.F<%=userType%><%=fieldCodes[iLen]%>[m].value) > "<%=fieldLengths[iLen]%>"){
					 retb = false;
				   }
					 ret = reta && retb;
				}
			else if (frm.F<%=userType%><%=fieldCodes[iLen]%>[m].datatype=='11'){//������
				reta=parseFloat(frm.F<%=userType%><%=fieldCodes[iLen]%>[m].value)==frm.F<%=userType%><%=fieldCodes[iLen]%>[m].value;
				if(JHshStrLen(frm.F<%=userType%><%=fieldCodes[iLen]%>[m].value) > "<%=fieldLengths[iLen]%>"){
					 retb = false;
				   }
					ret = reta && retb;
			}
			else if (frm.F<%=userType%><%=fieldCodes[iLen]%>[m].datatype=='12'){//�ַ���
				//ret=true;
					//var reg = new RegExp(/^(\s)*$/);
					//var flag= reg.test(frm.F<%=userType%><%=fieldCodes[iLen]%>.value);
					flag=frm.F<%=userType%><%=fieldCodes[iLen]%>[m].value=='';
					reta=!flag;
					if(JHshStrLen(frm.F<%=userType%><%=fieldCodes[iLen]%>[m].value) > "<%=fieldLengths[iLen]%>"){
					 retb = false;
				 }
					ret = reta && retb;
				}
			else if (frm.F<%=userType%><%=fieldCodes[iLen]%>[m].datatype=='13'){//���
				ret=parseFloat(frm.F<%=userType%><%=fieldCodes[iLen]%>[m].value)==frm.F<%=userType%><%=fieldCodes[iLen]%>[m].value;
			}
			else if (frm.F<%=userType%><%=fieldCodes[iLen]%>[m].datatype=='14'){//����
				ret=validDate(frm.F<%=userType%><%=fieldCodes[iLen]%>[m]);
			}
			else if (frm.F<%=userType%><%=fieldCodes[iLen]%>[m].datatype=='15')//����ʱ��
			{
				frm.F<%=userType%><%=fieldCodes[iLen]%>[m].value = frm.F<%=userType%><%=fieldCodes[iLen]%>[m].value.substr(0,8)
									+ frm.F<%=userType%><%=fieldCodes[iLen]%>[m].value.substr(9,2)
									+ frm.F<%=userType%><%=fieldCodes[iLen]%>[m].value.substr(12,2)
									+ frm.F<%=userType%><%=fieldCodes[iLen]%>[m].value.substr(15,2)
				ret=validTotalDate(frm.F<%=userType%><%=fieldCodes[iLen]%>[m]);
				frm.F<%=userType%><%=fieldCodes[iLen]%>[m].value = frm.F<%=userType%><%=fieldCodes[iLen]%>[m].value.substr(0,8)
									+ " "
									+ frm.F<%=userType%><%=fieldCodes[iLen]%>[m].value.substr(8,2)
									+":"
									+ frm.F<%=userType%><%=fieldCodes[iLen]%>[m].value.substr(10,2)
									+":"
									+ frm.F<%=userType%><%=fieldCodes[iLen]%>[m].value.substr(12,2)
			}
			else if (frm.F<%=userType%><%=fieldCodes[iLen]%>[m].datatype=='16')//BOOL
				ret=true;
			else if (frm.F<%=userType%><%=fieldCodes[iLen]%>[m].datatype=='17')//������
				ret=true;
			else if (frm.F<%=userType%><%=fieldCodes[iLen]%>[m].datatype=='18')//����
				ret=true;
			else if ((frm.F<%=userType%><%=fieldCodes[iLen]%>[m].datatype=='19')&&(haveCalc))//��ʽ����
				ret=parseFloat(frm.F<%=userType%><%=fieldCodes[iLen]%>[m].value)==frm.F<%=userType%><%=fieldCodes[iLen]%>[m].value;
			else if (frm.F<%=userType%><%=fieldCodes[iLen]%>[m].datatype=='20')//ip��ַ add
			    ret=forIP(frm.F<%=userType%><%=fieldCodes[iLen]%>[m]);//add
			if (!ret)
			{
				rdShowMessageDialog("�����������Ͳ���!");
				//alert("�����������Ͳ���!");
				frm.F<%=userType%><%=fieldCodes[iLen]%>[m].focus();
				return ret;
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
</script>

        
<script language="javascript">
<%
		
		try
		{
			//��̬�����б�
			sqlStr = "select field_code,param_code,param_name from sUserFieldParamCode where busi_type = '1000' and user_type=:userType and param_code!='99'  order by param_order";
			//retArray = callView.sPubSelect("3",sqlStr);
			
			paraIn2[0] = sqlStr;    
            paraIn2[1]="userType="+userType;
%>
            <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode4" retmsg="retMsg4" outnum="3" >
            	<wtc:param value="<%=paraIn2[0]%>"/>
            	<wtc:param value="<%=paraIn2[1]%>"/> 
            </wtc:service>
            <wtc:array id="retArr4" scope="end"/>
<%
			//fieldParamCodes_grp = (String[][])retArray.get(0);
			if(retCode4.equals("000000")){
			    fieldParamCodes_grp = retArr4;
			}
			//��̬�����б�
			sqlStr = "select field_code,param_sql from sUserFieldParamCode where busi_type = '1000' and user_type=:userType and param_code='99'  order by param_order";
			//retArray = callView.sPubSelect("2",sqlStr);
			
			paraIn2[0] = sqlStr;    
            paraIn2[1]="userType="+userType;
%>
            <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode5" retmsg="retMsg5" outnum="2" >
            	<wtc:param value="<%=paraIn2[0]%>"/>
            	<wtc:param value="<%=paraIn2[1]%>"/> 
            </wtc:service>
            <wtc:array id="retArr5" scope="end"/>
<%
			//fieldParamSql_grp = (String[][])retArray.get(0);
			if(retCode5.equals("000000")){
			    fieldParamSql_grp = retArr5;
			}
		}
		catch(Exception e)
		{
			logger.error("Call sunView is Failed!");
		}
//�м������������ѭ��
for(Iterator i = vecGrp_grp.iterator();i.hasNext();)
{
	String str = (String)i.next();
	int jsi = Integer.parseInt(str);
%>

var index<%=jsi%> = 0;
var varId = 50;
function segmentAdd_grp<%=jsi%>(){
	<%
	htGrp_grp.get(str);
	Vector v = new Vector();
	int ii = ((Integer)htGrp_grp.get(str)).intValue();
	%>
	if(segMentTab_grp<%=jsi%>.rows.length< eval(eval(<%out.print(fieldMaxRows[ii]);%>)+eval(2)))
	{
	segMentTab_grp<%=jsi%>.bgcolor="#FFFFFF";
	var tr1 = "tr"+index<%=jsi%>;
	tr1=segMentTab_grp<%=jsi%>.insertRow();
	tr1.bgcolor="E8E8E8";
	tr1.insertCell().innerHTML = '<td><input class=button type="button" name="del" value="ɾ��" onclick="deleteIt_grp<%=jsi%>(this)"></td>';
	
	while(true){
	<%
		
	int calcButtonFlag=0;
	String a = fieldGroupNo[ii];
   do{
    	 v.add(fieldCodes[ii]);			   
	%>
	tr1.insertCell().innerHTML = '<%
	int colspan = 1;
	if (fieldCount - 1 == ii)
	{
	colspan = 3;
	}
	else
	{
	colspan = 1;
	}
	
	
	//�ж��Ƿ���boolean��
					if (dataTypes[ii].equals("16"))//ѡ���
					{
						out.print("<TD width=\"32%\" colspan="+colspan+"> <select id=\"F"+ userType+ fieldCodes[ii]+"\" name=\"F"+ userType+ fieldCodes[ii]+"\" datatype="+dataTypes[ii]+"><option value=\"Y\" ");
						if (fieldValues[ii].equals("Y"))
							out.print("selected");
						out.print(" >��</option><option value=\"N\">��</option></select> </TD>");
					}
					else if (dataTypes[ii].equals("17"))//������
					{
						out.print("<TD width=\"32%\" colspan="+colspan+"> <select id=\"F"+ userType+ fieldCodes[ii]+"\" name=\"F"+ userType+ fieldCodes[ii]+"\" datatype="+dataTypes[ii]+" onchange=\"clearCalcFields_grp(frm.F"+ userType+ fieldCodes[ii]+");\">");
						for (int j=0; j < fieldParamCodes_grp.length; j++)
						{
							if (fieldParamCodes_grp[j][0].equals(fieldCodes[ii]))
							{
								out.print("<option ");
								if (fieldValues[ii].equals(fieldParamCodes_grp[j][1]))
									out.print("selected");
								out.print(" value=\"" + fieldParamCodes_grp[j][1] + "\">"+fieldParamCodes_grp[j][1]+"--" + fieldParamCodes_grp[j][2]+ "</option>");
							}
						}
						out.print("</select> </TD>");
					}
					else if (dataTypes[ii].equals("19"))//�����ֶ�
					{
						calcButtonFlag=1;
						calcButtonFlag_all=true;
						String [][] formula=null;
						try
						{
							sqlStr = "select formula from sUserFieldFormula where busi_type = '1000' and user_type='"+ userType+ "' and field_code='"+fieldCodes[ii]+"'";
							//retArray = callView.sPubSelect("1",sqlStr);
					%>
							<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode6" retmsg="retMsg6"  outnum="1">
                            	<wtc:sql><%=sqlStr%></wtc:sql>
                            </wtc:pubselect>
                            <wtc:array id="retArr6" scope="end" />
					<%
							//formula = (String[][])retArray.get(0);
							if(retCode6.equals("000000")){
							    formula = retArr6;
							}
						}
						catch(Exception e)
						{
							logger.error("Call sunView is Failed!");
						}
						
						out.print("<TD width=\"32%\" colspan="+colspan+"> <input id=\"F"+ userType+ fieldCodes[ii]+"'+varId+'\" name=\"F"+ userType+ fieldCodes[ii]+"\" class=\"button\" type=\"text\" datatype="+dataTypes[ii]+" maxlength=\""+fieldLengths[ii]+"\" readonly><label name=blue"+ userType +fieldCodes[ii]+" id=blue"+ userType +fieldCodes[ii]+" style=\"display:\"><font color=blue>*</font></label><input style=\"display:none\" name=\"calc"+fieldCodes[ii]+"\" type=button class=\"button\" value=���� onclick=\"calcFieldValue_grp(frm.F"+ userType+ fieldCodes[ii]+");\" value=\""+fieldValues[ii]+"\"></TD>");
					
						
					}
					else if (dataTypes[ii].equals("21"))//��̬SQL������
					{
						out.print("<TD width=\"32%\" colspan="+colspan+"> <select id=\"F"+ userType+ fieldCodes[ii]+"\" name=\"F"+ userType+ fieldCodes[ii]+"\" datatype="+dataTypes[ii]+" onchange=\"clearCalcFields_grp(frm.F"+ userType+ fieldCodes[ii]+");\">");
						for (int j=0; j < fieldParamSql_grp.length; j++)
						{
							if (fieldParamSql_grp[j][0].equals(fieldCodes[ii]))
							{
								String[][] dynParamCodes = new String[][]{};
								sqlStr=fieldParamSql_grp[j][1];
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
                                    if(hm_grp.containsKey(tempName))
                                    	tempValue = (String)hm_grp.get(tempName);
                                    
                                    sqlStr = sqlStr.substring(0,startPos)+tempValue+sqlStr.substring(endPos+1);
                                } 
								System.out.println("sqlStr="+sqlStr);
								//retArray = callView.sPubSelect("2",sqlStr);
    					%>
    							<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode7" retmsg="retMsg7"  outnum="2">
                                	<wtc:sql><%=sqlStr%></wtc:sql>
                                </wtc:pubselect>
                                <wtc:array id="retArr7" scope="end" />
    					<%
								//dynParamCodes = (String[][])retArray.get(0);
								if(retCode7.equals("000000")){
								    dynParamCodes = retArr7;
								}
								
								for(int n=0;n<dynParamCodes.length;n++)
								{
									out.print("<option ");
									if (fieldValues[ii].equals(dynParamCodes[n][0]))
										out.print("selected");
									out.print(" value=\"" + dynParamCodes[n][0] + "\">"+dynParamCodes[n][0]+"--" + dynParamCodes[n][1]+ "</option>");
								}
							}
						}
						out.print("</select> </TD>");
					}
					else {
						out.print("<TD width=\"32%\" colspan="+colspan+"> <input id=\"F"+ userType+ fieldCodes[ii]+"\" name=\"F"+ userType+ fieldCodes[ii]+"\" class=\"button\" type=\"text\" datatype="+dataTypes[ii]+" maxlength=\""+fieldLengths[ii]+"\" value=\""+fieldValues[ii]+"\">");
						if(fieldCtrlInfos[ii].equals("N"))
						{out.print("&nbsp;<font color=\"#FF0000\">*</font></TD>");}
					}
	
	
	
	%>';
			
					<%

	 ii++;
    if(ii>=iField)
    {
    	break;
    }
    }while(!v.contains(fieldCodes[ii])&&a.equals(fieldGroupNo[ii]));%>
    
						varId++;
						break;
						}	
	index<%=jsi%>= eval(index<%=jsi%>)+eval(1);
	}
}

function deleteIt_grp<%=jsi%>(){

var args=deleteIt_grp<%=jsi%>.arguments[0];
var objTD =args.parentElement;
var objTR =objTD.parentElement;
var currRowIndex = objTR.rowIndex;

segMentTab_grp<%=jsi%>.deleteRow(currRowIndex); 

}
<%}%>


function spellList_grp()
{
var nl = "";
var rowno = "";
var nameL = "";
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
	        	  	 //��nei
	        	    if(!fieldGroupNo[len].equals("0"))
	        	    {
	        	    //int num = new Integer(fieldGroupNo[len]).intValue()+1;
	        	    out.println("	for(var n = 0 ; n < eval(segMentTab_grp" +fieldGroupNo[len] + ".rows.length-eval(2)) ; n++)");
		        	out.println("	{");
		        	out.println("		nl=nl+\""+fieldCodes[len]+"\"+\"|\";");
		        	out.println("		nameL=nameL+\""+fieldNames[len]+"\"+\"|\";");
		        	out.println("		rowno=rowno+eval(eval(n)+1)"+"+\"|\";");
		        	out.println("	}");
		        	 }
		        	 //��wai
	        	    else
	        	    {
		        	out.println("		nl=nl+\""+fieldCodes[len]+"\"+\"|\";");
		        	out.println("		nameL=nameL+\""+fieldNames[len]+"\"+\"|\";");
		        	out.println("		rowno=rowno"+"+\"0|\";");
		        	}
		        	v.add(fieldCodes[len]);
	        	}
        	len++;
        	}

%>
document.frm.nameList_grp.value=nl;
document.frm.nameGroupList_grp.value=rowno;
document.frm.fieldNamesList_grp.value = nameL;
	
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
                	<div id="title_zi">ҵ����Ϣ</div>
                </div>
                <%}%>
   	  <TABLE cellSpacing=0 style="display:<%=listShow%>">
<%
	if (nextFlag==2)
	{

		int i=0;
		int colspan = 1;
		int calcButtonFlag=0;
		boolean tableFlag = false;
		boolean trFlag = false;
		Vector tr = new Vector();
		Vector trGrpNo = new Vector();
		Vector vecFieldCodes = new Vector();
		Vector vecGroupNo = new Vector();
		if (resultList != null)
		{
			while(i<fieldCount)
			{
			
				if(tableFlag||i==0)
				{%>
				
				<TABLE id="segMentTab_grp<%=fieldGroupNo[i]%>" cellSpacing=0 style="display:<%=listShow%>">
				<%}
				if(trFlag||i==0)
				{
				
					if(!fieldGroupNo[i].equals("0"))
					{
					//���Ӱ�ť
    				%>
    				<TR bgcolor='E8E8E8'><TD width='100%' colspan=100><b><%=fieldGroupName[i]%></b>&nbsp;&nbsp;�������<%=fieldMaxRows[i]%></TD></TR>
    				<TR bgcolor='E8E8E8'>
    				<TD width='20'><input type="button" name="addSegment<%=fieldGroupNo[i]%>" class="button"  value="����" onclick="segmentAdd_grp<%=fieldGroupNo[i]%>()"></TD>
    				<%
					}
					else
					{
					out.print("<TR bgcolor='E8E8E8'>");
					}
				//��ͬһ����ı�ͷ
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
    				out.println("<TR bgcolor='E8E8E8'>");
    				out.print("<TD width='1%'></TD>");
    			}
    			    					
    			//ͬһ�������ʱ��������
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
	    						      out.println("<TR bgcolor='E8E8E8'>");
	    						      out.print("<TD width='2%'></TD>");
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
    						out.print("<TD width='18%'>"+fieldNames[i]+"</TD>");
    					 }
					}
					//�ж��Ƿ���boolean��
					if (dataTypes[i].equals("16"))//ѡ���
					{
						out.print("<TD width='32%' colspan="+colspan+"> <select id='F"+ userType+ fieldCodes[i]+"' name='F"+ userType+ fieldCodes[i]+"' datatype="+dataTypes[i]+"><option value='Y' ");
						if (fieldValues[i].equals("Y"))
							out.print("selected");
						out.print(" >��</option><option value='N'>��</option></select> </TD>");
					}
					else if (dataTypes[i].equals("17"))//������
					{
						out.print("<TD width='32%' colspan="+colspan+"> <select id='F"+ userType+ fieldCodes[i]+"' name='F"+ userType+ fieldCodes[i]+"' datatype="+dataTypes[i]+" onchange='clearCalcFields_grp(frm.F"+ userType+ fieldCodes[i]+");'>");
						for (int j=0; j < fieldParamCodes_grp.length; j++)
						{
							if (fieldParamCodes_grp[j][0].equals(fieldCodes[i]))
							{
								out.print("<option ");
								if (fieldValues[i].equals(fieldParamCodes_grp[j][1]))
									out.print("selected");
								out.print(" value='" + fieldParamCodes_grp[j][1] + "'>"+fieldParamCodes_grp[j][1]+"--" + fieldParamCodes_grp[j][2]+ "</option>");
							}
						}
						out.print("</select> </TD>");
					}
					else if (dataTypes[i].equals("19"))//�����ֶ�
					{
						calcButtonFlag=1;
						calcButtonFlag_all = true;
						String [][] formula=null;
						try
						{
							sqlStr = "select formula from sUserFieldFormula where busi_type = '1000' and user_type='"+ userType+ "' and field_code='"+fieldCodes[i]+"'";
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
						out.print("<TD width='32%' colspan="+colspan+"> <input id='F"+ userType+ fieldCodes[i]+i+"' name='F"+ userType+ fieldCodes[i]+"' class='button' type='text' datatype="+dataTypes[i]+" maxlength='"+fieldLengths[i]+"'  readonly><label name=blue"+ userType +fieldCodes[i]+" id=blue"+ userType +fieldCodes[i]+" style='display:'><font color=blue>*</font></label><input style='display:none' name='calc"+fieldCodes[i]+"' type=button class='button' value=���� onclick='calcFieldValue_grp(frm.F"+ userType+ fieldCodes[i]+");' value='"+fieldValues[i]+"'></TD>");
					}
					else if (dataTypes[i].equals("21"))//��̬SQL������
					{
						out.print("<TD width=\"32%\" colspan="+colspan+"> <select id=\"F"+ userType+ fieldCodes[i]+"\" name=\"F"+ userType+ fieldCodes[i]+"\" datatype="+dataTypes[i]+" onchange=\"clearCalcFields_grp(frm.F"+ userType+ fieldCodes[i]+");\">");
						for (int j=0; j < fieldParamSql_grp.length; j++)
						{
							if (fieldParamSql_grp[j][0].equals(fieldCodes[i]))
							{
								String[][] dynParamCodes = new String[][]{};
								sqlStr=fieldParamSql_grp[j][1];
								
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
                                    if(hm_grp.containsKey(tempName))
                                    	tempValue = (String)hm_grp.get(tempName);
                                    	
                                    sqlStr = sqlStr.substring(0,startPos)+tempValue+sqlStr.substring(endPos+1);
                                }                                
								System.out.println("sqlStr="+sqlStr);
								
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
					else {
						out.print("<TD width='32%' colspan="+colspan+"> <input id='F"+ userType+ fieldCodes[i]+"' name='F"+ userType+ fieldCodes[i]+"' class='button' type='text' datatype="+dataTypes[i]+" maxlength='"+fieldLengths[i]+"' value='"+fieldDefValue[i]+"'>");
						if(fieldCtrlInfos[i].equals("N"))
						{out.print("&nbsp;<font color=\"#FF0000\">*</font></TD>");}
					}
				
					//������һ���ֶ�
    				if((i+1)<fieldCount)
    				{
						//��ͬһ������
						if(fieldGroupNo[i].equals(fieldGroupNo[i+1]))
						{
							tableFlag = false;
							trFlag = true;
						}
						//����ͬһ����
						else if(!fieldGroupNo[i].equals(fieldGroupNo[i+1]))
						{
							tableFlag = true;
							trFlag = true;
							out.print("</TR>");
							i++;
							break;
						}
					}
					//û����һ���ֶ�
    				else 
    				{
    					out.println("");
    					out.print("</TR>"); 
    					out.print("</TABLE>"); 
    					%>
    					
    					<TABLE cellSpacing=0 style="display:<%=listShow%>">
    					<%
    					i++;
    					break;
    				}
    						
    				i++;	
				}
				}
			}
		}
		
	}
%>

