<%
/*****************************
 * version v2.0
 * ������: si-tech
 * update by qidp @ 2009-01-14
 *****************************/
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
		String listShow;
	ʹ�÷������ܣ�
		���ļ����ܵ���ʹ�ã���Ҫ�����ļ�include����ļ�
	����OPCODE��3505��3508
	Author:lugz,yinyx
*/
%>
<%
	    		//�����
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
	    			        //��no,���
	    			        htGrp.put(fieldGroupNo[iField],new Integer(iField));
	    			        grpCount++;
	    			    }
    			    }
    			  	    iField++;
    			}
	
	String [][]fieldCalcFieldReadOnlys=null;
	//�����б�����
	String[][] fieldParamCodes = new String[][]{};
	String[][] fieldParamSql = new String[][]{};
	String [] paraIn2 = new String[2];
    String dateStr1 = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
    int iDate1 = Integer.parseInt(dateStr1);
    String addDate1 = Integer.toString(iDate1);	
	HashMap hm = new HashMap();
	if(!hm.containsKey("regionCode"))   hm.put("regionCode",regionCode); 
	if(!hm.containsKey("workno"))       hm.put("workno",workNo);
	if(!hm.containsKey("org_code"))     hm.put("org_code",orgCode);
	if(!hm.containsKey("districtCode")) hm.put("districtCode",districtCode);
	
%>
<%
	if ("2".equals(nextFlag))
	{
%>
<script language="javascript">
function calcFieldValue(calaField)//���ݹ�ʽ���㵥���ֶε�ֵ
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
            paraIn2[1]="userType="+iSmCode;
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
		System.out.println("Call sunView is Failed!");
	}
	int iPos=0;

		for(int i = 0; i < fieldCalcFieldReadOnlys.length; i ++)
		{

			if (!fieldCalcFieldReadOnlys[i][0].trim().equals(""))
			{
			    out.println("//Ŀ���ֶ��������ֶ�");
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
					
					        //�������������ֶ������ڵ�
					out.println("			if(typeof(document.frm.F" + fma.substring(iPos+1,iPos+1+5) + ".length)!=\"undefined\")");
					out.println("			{");
					
					out.println("			length = document.frm.F"+fma.substring(iPos+1,iPos+1+5)+".length;");
					out.println("			flagN"+fma.substring(iPos+1,iPos+1+5)+" = \"[n]\";");           
					out.println("			}");
					        //�������������ֶβ������ڵ�
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
				
				out.println("//Ŀ���ֶ��������ֶ�");
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
					
					        //�������������ֶ������ڵ�
					out.println("			if(typeof(document.frm.F" + fma.substring(iPos+1,iPos+1+5) + ".length)!=\"undefined\")");
					out.println("			{");
					
					out.println("			length = document.frm.F"+fma.substring(iPos+1,iPos+1+5)+".length;");
					out.println("			flagN"+fma.substring(iPos+1,iPos+1+5)+" = \"[n]\";");           
					out.println("			}");
					        //�������������ֶβ������ڵ�
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

function clearCalcFields(selectId)//�����������仯ʱ,��ռ����ֶ�,������ֵ�����༭���״̬
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
        paraIn2[1]="userType="+iSmCode;
%>
        <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode22" retmsg="retMsg22" outnum="1" >
        	<wtc:param value="<%=paraIn2[0]%>"/>
        	<wtc:param value="<%=paraIn2[1]%>"/> 
        </wtc:service>
        <wtc:array id="retArr22" scope="end"/>
<%

/*		//TODO �����������
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
      paraIn2[1]="userType="+iSmCode;
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
function calcAllFieldValues()//�������м����ֶε�ֵ
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
function checkDynaFieldValues(haveCalc)//���༭���������Ƿ�Ϸ���haveCalc:�Ƿ�����Լ����ֶεļ��
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
			if(!fieldCtrlInfos[iLen].equals("N"))
			{
			%>
			if(frm.F<%=fieldCodes[iLen]%>.value=='')
			checkValues_flag = true;
			<%
			}%>
			
		if(!checkValues_flag)
		{
		if(typeof(document.frm.F<%=fieldCodes[iLen]%>.length)=="undefined"){
		
			frm.F<%=fieldCodes[iLen]%>.datatype=<%out.println(dataTypes[iLen]);%>;
			
			if (frm.F<%=fieldCodes[iLen]%>.datatype=='10'){//����
				 reta=parseInt(frm.F<%=fieldCodes[iLen]%>.value)==frm.F<%=fieldCodes[iLen]%>.value;
				 if(JHshStrLen(frm.F<%=fieldCodes[iLen]%>.value) > "<%=fieldLengths[iLen]%>"){
					 retb = false;
				   }
					 ret = reta && retb;
				}
			else if (frm.F<%=fieldCodes[iLen]%>.datatype=='11'){//������
				reta=parseFloat(frm.F<%=fieldCodes[iLen]%>.value)==frm.F<%=fieldCodes[iLen]%>.value;
				if(JHshStrLen(frm.F<%=fieldCodes[iLen]%>.value) > "<%=fieldLengths[iLen]%>"){
					 retb = false;
				   }
					ret = reta && retb;
			}
			else if (frm.F<%=fieldCodes[iLen]%>.datatype=='12'){//�ַ���
				//ret=true;
					//var reg = new RegExp(/^(\s)*$/);
					//var flag= reg.test(frm.F<%=fieldCodes[iLen]%>.value);
					flag=frm.F<%=fieldCodes[iLen]%>.value=='';
					reta=!flag;
					if(JHshStrLen(frm.F<%=fieldCodes[iLen]%>.value) > "<%=fieldLengths[iLen]%>"){
					 retb = false;
				 }
					ret = reta && retb;
				}
			else if (frm.F<%=fieldCodes[iLen]%>.datatype=='13'){//���
				ret=parseFloat(frm.F<%=fieldCodes[iLen]%>.value)==frm.F<%=fieldCodes[iLen]%>.value;
			}
			else if (frm.F<%=fieldCodes[iLen]%>.datatype=='14'){//����
				ret=validDate(frm.F<%=fieldCodes[iLen]%>);
			}
			else if (frm.F<%=fieldCodes[iLen]%>.datatype=='15')//����ʱ��
			{
				frm.F<%=fieldCodes[iLen]%>.value = frm.F<%=fieldCodes[iLen]%>.value.substr(0,8)
									+ frm.F<%=fieldCodes[iLen]%>.value.substr(9,2)
									+ frm.F<%=fieldCodes[iLen]%>.value.substr(12,2)
									+ frm.F<%=fieldCodes[iLen]%>.value.substr(15,2)
				ret=validTotalDate(frm.F<%=fieldCodes[iLen]%>);
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
			else if (frm.F<%=fieldCodes[iLen]%>.datatype=='17')//������
				ret=true;
			else if (frm.F<%=fieldCodes[iLen]%>.datatype=='18')//����
				ret=true;
			else if ((frm.F<%=fieldCodes[iLen]%>.datatype=='19')&&(haveCalc))//��ʽ����
				ret=parseFloat(frm.F<%=fieldCodes[iLen]%>.value)==frm.F<%=fieldCodes[iLen]%>.value;
			else if (frm.F<%=fieldCodes[iLen]%>.datatype=='20')//ip��ַ add
			    ret=forIp(frm.F<%=fieldCodes[iLen]%>);//add
			if (!ret)
			{
				rdShowMessageDialog("'<%=fieldNames[iLen]%>'�����������Ͳ���!");
				//alert("�����������Ͳ���!");
				frm.F<%=fieldCodes[iLen]%>.focus();
				return ret;
			}
		}
		else
		{
			for(var m = 0 ; m < document.frm.F<%=fieldCodes[iLen]%>.length ; m ++){

			//alert(document.frm.F<%=fieldCodes[iLen]%>[m].value);
			frm.F<%=fieldCodes[iLen]%>[m].datatype=<%out.println(dataTypes[iLen]);%>;
			
			if (frm.F<%=fieldCodes[iLen]%>[m].datatype=='10'){//����
				 reta=parseInt(frm.F<%=fieldCodes[iLen]%>[m].value)==frm.F<%=fieldCodes[iLen]%>[m].value;
				 if(JHshStrLen(frm.F<%=fieldCodes[iLen]%>[m].value) > "<%=fieldLengths[iLen]%>"){
					 retb = false;
				   }
					 ret = reta && retb;
				}
			else if (frm.F<%=fieldCodes[iLen]%>[m].datatype=='11'){//������
				reta=parseFloat(frm.F<%=fieldCodes[iLen]%>[m].value)==frm.F<%=fieldCodes[iLen]%>[m].value;
				if(JHshStrLen(frm.F<%=fieldCodes[iLen]%>[m].value) > "<%=fieldLengths[iLen]%>"){
					 retb = false;
				   }
					ret = reta && retb;
			}
			else if (frm.F<%=fieldCodes[iLen]%>[m].datatype=='12'){//�ַ���
				//ret=true;
					//var reg = new RegExp(/^(\s)*$/);
					//var flag= reg.test(frm.F<%=fieldCodes[iLen]%>.value);
					flag=frm.F<%=fieldCodes[iLen]%>[m].value=='';
					reta=!flag;
					if(JHshStrLen(frm.F<%=fieldCodes[iLen]%>[m].value) > "<%=fieldLengths[iLen]%>"){
					 retb = false;
				 }
					ret = reta && retb;
				}
			else if (frm.F<%=fieldCodes[iLen]%>[m].datatype=='13'){//���
				ret=parseFloat(frm.F<%=fieldCodes[iLen]%>[m].value)==frm.F<%=fieldCodes[iLen]%>[m].value;
			}
			else if (frm.F<%=fieldCodes[iLen]%>[m].datatype=='14'){//����
				ret=validDate(frm.F<%=fieldCodes[iLen]%>[m]);
			}
			else if (frm.F<%=fieldCodes[iLen]%>[m].datatype=='15')//����ʱ��
			{
				frm.F<%=fieldCodes[iLen]%>[m].value = frm.F<%=fieldCodes[iLen]%>[m].value.substr(0,8)
									+ frm.F<%=fieldCodes[iLen]%>[m].value.substr(9,2)
									+ frm.F<%=fieldCodes[iLen]%>[m].value.substr(12,2)
									+ frm.F<%=fieldCodes[iLen]%>[m].value.substr(15,2)
				ret=validTotalDate(frm.F<%=fieldCodes[iLen]%>[m]);
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
			else if (frm.F<%=fieldCodes[iLen]%>[m].datatype=='17')//������
				ret=true;
			else if (frm.F<%=fieldCodes[iLen]%>[m].datatype=='18')//����
				ret=true;
			else if ((frm.F<%=fieldCodes[iLen]%>[m].datatype=='19')&&(haveCalc))//��ʽ����
				ret=parseFloat(frm.F<%=fieldCodes[iLen]%>[m].value)==frm.F<%=fieldCodes[iLen]%>[m].value;
			else if (frm.F<%=fieldCodes[iLen]%>[m].datatype=='20')//ip��ַ add
			    ret=forIP(frm.F<%=fieldCodes[iLen]%>[m]);//add
			if (!ret)
			{
				rdShowMessageDialog("'<%=fieldNames[iLen]%>'�����������Ͳ���!");
				//alert("�����������Ͳ���!");
				frm.F<%=fieldCodes[iLen]%>[m].focus();
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
			sqlStr = "select field_code,param_code,param_name from sUserFieldParamCode where user_type=:userType and param_code!='99' order by field_code,param_code asc";
			System.out.println(sqlStr );
			//retArray = callView.sPubSelect("3",sqlStr);
			
			paraIn2[0] = sqlStr;    
            paraIn2[1]="userType="+iUserType;
%>
            <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode4" retmsg="retMsg4" outnum="3" >
            	<wtc:param value="<%=paraIn2[0]%>"/>
            	<wtc:param value="<%=paraIn2[1]%>"/> 
            </wtc:service>
            <wtc:array id="retArr4" scope="end"/>
<%
			//fieldParamCodes = (String[][])retArray.get(0);
			if(retCode4.equals("000000")){
			    fieldParamCodes = retArr4;
			}
			//��̬�����б�
			sqlStr = "select field_code,param_sql from sUserFieldParamCode where user_type=:userType and param_code='99'";
			System.out.println(sqlStr );
			//retArray = callView.sPubSelect("2",sqlStr);
			
			paraIn2[0] = sqlStr;    
            paraIn2[1]="userType="+iUserType;
%>
            <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode5" retmsg="retMsg5" outnum="2" >
            	<wtc:param value="<%=paraIn2[0]%>"/>
            	<wtc:param value="<%=paraIn2[1]%>"/> 
            </wtc:service>
            <wtc:array id="retArr5" scope="end"/>
<%
			//fieldParamSql = (String[][])retArray.get(0);
			if(retCode5.equals("000000")){
			    fieldParamSql = retArr5;
			}
		}
		catch(Exception e)
		{
			logger.error("Call sunView is Failed!");
		}
//�м������������ѭ��
for(Iterator i = vecGrp.iterator();i.hasNext();)
{
	String str = 	(String)i.next();
	int jsi = Integer.parseInt(str);
%>

var index<%=jsi%> = 0;
var varId = 50;
function segmentAdd<%=jsi%>(){
	<%
	htGrp.get(str);
	Vector v = new Vector();
	int ii = ((Integer)htGrp.get(str)).intValue();
	%>
	if(segMentTab<%=jsi%>.rows.length< eval(eval(<%out.print(fieldMaxRows[ii]);%>)+eval(2)))
	{
	segMentTab<%=jsi%>.bgcolor="#FFFFFF";
	var tr1 = "tr"+index<%=jsi%>;
	tr1=segMentTab<%=jsi%>.insertRow();
	tr1.bgcolor="E8E8E8";
	tr1.insertCell().innerHTML = '<td width="30"><input class=button type="button" name="del" value="ɾ��" onclick="deleteIt<%=jsi%>(this)"></td>';
	
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
						out.print("<TD width=\"32%\" colspan="+colspan+"> <select id=\"F"+fieldCodes[ii]+"\" name=\"F"+fieldCodes[ii]+"\" datatype="+dataTypes[ii]+"><option value=\"Y\" ");
						if (fieldValues[ii].equals("Y"))
							out.print("selected");
						out.print(" >��</option><option value=\"N\">��</option></select> </TD>");
					}
					else if (dataTypes[ii].equals("17"))//������
					{
						out.print("<TD width=\"32%\" colspan="+colspan+"> <select id=\"F"+fieldCodes[ii]+"\" name=\"F"+fieldCodes[ii]+"\" datatype="+dataTypes[ii]+" onchange=\"clearCalcFields(frm.F"+fieldCodes[ii]+");\">");
						for (int j=0; j < fieldParamCodes.length; j++)
						{
							if (fieldParamCodes[j][0].equals(fieldCodes[ii]))
							{
								out.print("<option ");
								if (fieldValues[ii].equals(fieldParamCodes[j][1]))
									out.print("selected");
								out.print(" value=\"" + fieldParamCodes[j][1] + "\">"+fieldParamCodes[j][1]+"--" + fieldParamCodes[j][2]+ "</option>");
							}
						}
						out.print("</select> </TD>");
					}
					else if (dataTypes[ii].equals("19"))//�����ֶ�
					{
						calcButtonFlag=1;
						String [][] formula=null;
						try
						{
							sqlStr = "select formula from sUserFieldFormula where user_type='"+ iSmCode+ "' and field_code='"+fieldCodes[ii]+"'";
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
						
						out.print("<TD width=\"32%\" colspan="+colspan+"> <input id=\"F"+fieldCodes[ii]+"'+varId+'\" name=\"F"+fieldCodes[ii]+"\" class=\"button\" type=\"text\" datatype="+dataTypes[ii]+" maxlength=\""+fieldLengths[ii]+"\" readonly><label name=blue"+fieldCodes[ii]+" id=blue"+fieldCodes[ii]+" style=\"display:\"><font color=blue>*</font></label><input style=\"display:none\" name=\"calc"+fieldCodes[ii]+"\" type=button class=\"button\" value=���� onclick=\"calcFieldValue(frm.F"+fieldCodes[ii]+");\" value=\""+fieldValues[ii]+"\"></TD>");
					
						
					}
					else if (dataTypes[ii].equals("21"))//��̬SQL������
					{
						out.print("<TD width=\"32%\" colspan="+colspan+"> <select id=\"F"+fieldCodes[ii]+"\" name=\"F"+fieldCodes[ii]+"\" datatype="+dataTypes[ii]+" onchange=\"clearCalcFields(frm.F"+fieldCodes[ii]+");\">");
						for (int j=0; j < fieldParamSql.length; j++)
						{
							if (fieldParamSql[j][0].equals(fieldCodes[ii]))
							{
								String[][] dynParamCodes = new String[][]{};
								sqlStr=fieldParamSql[j][1];
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
								System.out.println("----------http://www.xlogin.com.cn/-------sqlStr="+sqlStr);
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
					else if (dataTypes[ii].equals("22"))//���������
					{
						out.print("<TD width=\"32%\" colspan="+colspan+"> <input id=\"F"+fieldCodes[ii]+"\" name=\"F"+fieldCodes[ii]+"\" class=\"button\" type=\"password\" datatype="+dataTypes[ii]+" maxlength=\""+fieldLengths[ii]+"\" value=\""+fieldValues[ii]+"\">");
						if(fieldCtrlInfos[ii].equals("N"))
						{out.print("&nbsp;<font color=\"#FF0000\">*</font></TD>");}
					}
					else if (dataTypes[ii].equals("60"))//�����������ڴ�Ĭ��ֵ��̬��ȡ
					{
						System.out.println("rendi testing 111111111111111111111111,"+addDate1);
						out.print("<TD width='32%' colspan="+colspan+">");
                    	out.print("<input type='text'  id='F"+fieldCodes[ii]+"' name='F"+fieldCodes[ii]+"' v_must=0 v_type='date' onKeyPress='return isKeyNumberdot(0)' value='"+addDate1+"' size='20' >");
						if(fieldCtrlInfos[ii].equals("N"))
						{out.print("&nbsp;<font class=\"orange\">*</font></TD>");}
					}
					else {
						out.print("<TD width=\"32%\" colspan="+colspan+"> <input id=\"F"+fieldCodes[ii]+"\" name=\"F"+fieldCodes[ii]+"\" class=\"button\" type=\"text\" datatype="+dataTypes[ii]+" maxlength=\""+fieldLengths[ii]+"\" value=\""+fieldValues[ii]+"\">");
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
	        	    out.println("	for(var n = 0 ; n < eval(segMentTab" +fieldGroupNo[len] + ".rows.length-eval(2)) ; n++)");
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
document.frm.nameList.value=nl;
document.frm.nameGroupList.value=rowno;
document.frm.fieldNamesList.value = nameL;
	
}
</script>        
<%
	}//end if nextFlag==2
	if ("2".equals(nextFlag))
	{
%>

                <div id="Operation_Table">
                <div class="title">
                	<div id="title_zi">��Ա������Ϣ</div>
                </div>
                <%}%>
   	  <TABLE cellSpacing=0 style="display:<%=listShow%>">
<%
	if ("2".equals(nextFlag))
	{
/*			String[][] fieldParamCodes = new String[][]{};
		try
		{
			sqlStr = "select field_code,param_code,param_name from sUserFieldParamCode where user_type='"+ iSmCode+ "'";
			
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
		if (resultList != null)
		{
			while(i<fieldCount)
			{
			
				if(tableFlag||i==0)
				{%>

				<TABLE id="segMentTab<%=fieldGroupNo[i]%>" cellSpacing=0 style="display:<%=listShow%>">
				<%}
				if(trFlag||i==0)
				{
				
					if(!fieldGroupNo[i].equals("0"))
					{
					//���Ӱ�ť
    				%>
    				<TR><TD colspan=100><b><%=fieldGroupName[i]%></b>&nbsp;&nbsp;�������<%=fieldMaxRows[i]%></TD></TR>
    				<TR>
    				<TD><input type="button" name="addSegment<%=fieldGroupNo[i]%>" class="b_text"  value="����" onclick="segmentAdd<%=fieldGroupNo[i]%>()"></TD>
    				<%
					}
					else
					{
						/* yuanqs add 2011/6/10 15:01:38 ���������ײ����� */
						if (dataTypes[i].equals("80")&&("80004".equals(fieldCodes[i])||"80006".equals(fieldCodes[i])) ) {
							out.print("<TR style='display:none'>");
						} else {
							out.print("<TR>");
						}
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
    				out.println("<TR>");
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
	    						      out.println("<TR>");
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
    						out.print("<TD class=blue width='18%'>"+fieldNames[i]+"</TD>");
    					 }
					}
					//�ж��Ƿ���boolean��
					if (dataTypes[i].equals("16"))//ѡ���
					{
						out.print("<TD width='32%' colspan="+colspan+"> <select id='F"+fieldCodes[i]+"' name='F"+fieldCodes[i]+"' datatype="+dataTypes[i]+"><option value='Y' ");
						if (fieldValues[i].equals("Y"))
							out.print("selected");
						out.print(" >��</option><option value='N'>��</option></select> </TD>");
					}
					else if (dataTypes[i].equals("17"))//������
					{
						out.print("<TD width='32%' colspan="+colspan+"> <select id='F"+fieldCodes[i]+"' name='F"+fieldCodes[i]+"' datatype="+dataTypes[i]+" onchange='clearCalcFields(frm.F"+fieldCodes[i]+");'>");
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
					else if (dataTypes[i].equals("19"))//�����ֶ�
					{
						calcButtonFlag=1;
						String [][] formula=null;
						try
						{
							sqlStr = "select formula from sUserFieldFormula where user_type='"+ iSmCode+ "' and field_code='"+fieldCodes[i]+"'";
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
						out.print("<TD width='32%' colspan="+colspan+"> <input id='F"+fieldCodes[i]+i+"' name='F"+fieldCodes[i]+"' class='button' type='text' datatype="+dataTypes[i]+" maxlength='"+fieldLengths[i]+"' readonly><label name=blue"+fieldCodes[i]+" id=blue"+fieldCodes[i]+" style='display:'><font color=blue>*</font></label><input style='display:none' name='calc"+fieldCodes[i]+"' type=button class='button' value=���� onclick='calcFieldValue(frm.F"+fieldCodes[i]+");' value='"+fieldValues[i]+"'></TD>");
					}
					else if (dataTypes[i].equals("21"))//��̬SQL������
					{
						out.print("<TD width=\"32%\" colspan="+colspan+"> <select id=\"F"+fieldCodes[i]+"\" name=\"F"+fieldCodes[i]+"\" datatype="+dataTypes[i]+" onchange=\"clearCalcFields(frm.F"+fieldCodes[i]+");\">");
						for (int j=0; j < fieldParamSql.length; j++)
						{
							if (fieldParamSql[j][0].equals(fieldCodes[i]))
							{
								String[][] dynParamCodes = new String[][]{};
								sqlStr=fieldParamSql[j][1];
								
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
					else if (dataTypes[i].equals("22"))//���������
					{
						out.print("<TD width='32%' colspan="+colspan+"> <input id='F"+fieldCodes[i]+"' name='F"+fieldCodes[i]+"' class='button' type='password' datatype="+dataTypes[i]+" maxlength='"+fieldLengths[i]+"' value='"+fieldValues[i]+"'>");
						if(fieldCtrlInfos[i].equals("N"))
						{out.print("&nbsp;<font color=\"#FF0000\">*</font></TD>");}
					}
					else if (dataTypes[i].equals("60"))//VPMN���ʷ��ײ���Ч���ڴ�Ĭ��ֵ��̬��ȡ
					{
						out.print("<TD width='32%' colspan="+colspan+">");
                    	
                    	out.print("<input type='text'  id='F"+fieldCodes[i]+"' name='F"+fieldCodes[i]+"' v_must=0 v_type='date' onKeyPress='return isKeyNumberdot(0)' value='"+addDate1+"' size='20' >");
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
						if(fieldCtrlInfos[i].equals("N"))
						{out.print("&nbsp;<font color=\"#FF0000\">*</font>");}
						out.print("</div></TD>");
					}
					else if (dataTypes[i].equals("67"))//M2M
					{
						out.print("<TD width='32%' colspan="+colspan+"> <div name ='divF10341' id='divF10341'><input id='F"+fieldCodes[i]+"' name='F"+fieldCodes[i]+"'  class='button' type='hidden' datatype="+dataTypes[i]+" maxlength='"+fieldLengths[i]+"' value='0' >&nbsp;");
						if(fieldCtrlInfos[i].equals("N"))
						{out.print("&nbsp;<font class=\"orange\">*</font>");}
						out.print("</div></TD>");
					}	
					
					//TD-���񱦣������������ͣ�������
					//Add by shengzd @ 20090518	
					else if (dataTypes[i].equals("71"))
					{
						out.print("<TD width='32%' colspan="+colspan+"> <select id='F"+fieldCodes[i]+"' name='F"+fieldCodes[i]+"' datatype="+dataTypes[i]+" onchange='ctrlF10342(frm.F"+fieldCodes[i]+");' >");
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
					
					//TD-���񱦣������������ͣ��ı���  
					//Add by shengzd @ 20090518
					else if (dataTypes[i].equals("72"))
					{
						out.print("<TD width='32%' colspan="+colspan+"> <div name ='divF10344' id='divF10344'><input id='F"+fieldCodes[i]+"' name='F"+fieldCodes[i]+"'  class='button' type='text' datatype="+dataTypes[i]+" maxlength='"+fieldLengths[i]+"' value=''>&nbsp;");
						if(fieldCtrlInfos[i].equals("N"))
						{
						 out.print("&nbsp;<font color=\"#FF0000\">*</font>");
						}
					   out.print("</div></TD>");
					}
					
					else if (dataTypes[i].equals("45"))//VPMN���û����ܼ���Ĭ��ֵ����ť
					{
						out.print("<TD width='32%' colspan="+colspan+">");
                        
                        out.print("<input type='text' id='F"+fieldCodes[i]+"' name='F"+fieldCodes[i]+"' size='36' value='220000221111000001001020020000000000' readonly  Class='InputGrey'>");
                        
						out.print("<input type='button' class='b_text' name='updateFlsg'  value='�޸�' onclick='call_flags()' v_must=1 v_type='string'>");
						if(fieldCtrlInfos[i].equals("N"))
						{out.print("&nbsp;<font class=\"orange\">*</font></TD>");}
					}
					
                    else if (dataTypes[i].equals("80"))//vp - �����ײ�����
					{
						out.print("<TD width='32%' colspan="+colspan+">");
						/* yuanqs add 2011/7/8 15:20:46 */
						%>
							<script type="text/javascript">
								function changeOutValue<%=i%>() {
									var selectId = 'F<%=fieldCodes[i]%>';
									var F80003Val = document.getElementById("F80003").value;
									document.getElementById("F80004").value = F80003Val;	
								}
							</script>
						<%
                        out.print("<select id='F"+fieldCodes[i]+"' name='F"+fieldCodes[i]+"' onchange=changeOutValue"+i+"()>");
                        String[][] result73 = null;
                        String dateStr1SqlStr73 = new java.text.SimpleDateFormat("yyyy-MM-dd-HH").format(new java.util.Date());
				        String strTime[] = new String[4];
		                strTime = dateStr1SqlStr73.split("-");
                        StringBuffer sqlBufSqlStr73 = new StringBuffer();
						try
                        {
                          	System.out.println(powerRight);
                            //String sqlStr73 ="select trim(pkg_code),trim(pkg_code)||'-->'||trim(pkg_name) from svpmnpkgcode where region_code='"+regionCode+"' and stop_time>=sysdate and " + powerRight + " >= power_Right order by to_number(pkg_code)";
                            /* yuanqs add 2011/7/8 15:19:23 */
                            sqlBufSqlStr73.append( " select trim(a.offer_id),trim(a.offer_id)||'-->'||trim(a.offer_name) from product_offer a,svpmnpkgcodeconfig b,region d,sregioncode e ");
							sqlBufSqlStr73.append( " where a.offer_attr_type='VpG0' and a.offer_id=d.offer_id and d.group_id=e.group_id ");
							sqlBufSqlStr73.append( " and e.region_code='"+regionCode+"' and a.exp_date>=sysdate and a.eff_date<=sysdate ");
							sqlBufSqlStr73.append( " and d.right_limit <= '"+ powerRight +"' ");
							sqlBufSqlStr73.append( " and ( to_number('"+strTime[0]+"')>=to_number(b.start_year) or (b.start_year is null) ) ");
							sqlBufSqlStr73.append( " and ( to_number('"+strTime[0]+"')<=to_number(b.end_year) or (b.end_year is null) ) ");
							sqlBufSqlStr73.append( " and ( to_number('"+strTime[1]+"')>=to_number(b.start_month) or (b.start_month is null) ) ");
							sqlBufSqlStr73.append( " and ( to_number('"+strTime[1]+"')<=to_number(b.end_month) or (b.end_month is null) ) ");
							sqlBufSqlStr73.append( " and ( to_number('"+strTime[2]+"')>=to_number(b.start_day) or (b.start_day is null) ) ");
							sqlBufSqlStr73.append( " and ( to_number('"+strTime[2]+"')<=to_number(b.end_day) or (b.end_day is null) ) ");
							sqlBufSqlStr73.append( " and ( to_number('"+strTime[3]+"')>=to_number(b.start_hours) or (b.start_hours is null) ) ");
							sqlBufSqlStr73.append( " and ( to_number('"+strTime[3]+"')<to_number(b.end_hours) or (b.end_hours is null) ) ");
							sqlBufSqlStr73.append( " and a.offer_id = b.pkg_code(+)  order by a.offer_id ");
                            String sqlStr73 = sqlBufSqlStr73.toString();
                            %>
                                <wtc:service name="sPkgCodeQry" outnum="2" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
                                    <wtc:param value=""/>
                                    <wtc:param value=""/>
                                    <wtc:param value=""/>
                                    <wtc:param value="<%=%>"/>
                                    <wtc:param value=""/>
                                    <wtc:param value=""/>
                                    <wtc:param value=""/>
                                    <wtc:param value="<%=regionCode%>"/>
                                    <wtc:param value="<%=powerRight%>"/>
                                </wtc:service>
                                <wtc:array id="result_tu73" scope="end"/>               
                            <%
                            /* yuanqs add 2011/7/8 15:16:34 */
                            out.println("<option class='button' value='0'>0 --> ��ʼֵ</option>");
                            /*chendx 20100727 Ϊ�������ų�Ա���ר���ʷ�*/
                            if("1".equals(arcFlag)){
                            	result73 = result_tu73;
	                            int recordNum = result73.length;
	                            for(int the7ii=0;the7ii<recordNum;the7ii++){    
									System.out.println("result73["+the7ii+"][0]="+result73[the7ii][0]);
									out.println("<option class='button' value='" + result73[the7ii][0] + "'>" + result73[the7ii][1] + "</option>");			
	                          }
                            }else{
                            	result73 = null;
	                            result73 = result_tu73;
	                            int recordNum = result73.length;
	                            for(int the7ii=0;the7ii<recordNum;the7ii++){    
								if(!"155".equals(result73[the7ii][0])){
									out.println("<option class='button' value='" + result73[the7ii][0] + "'>" + result73[the7ii][1] + "</option>");
								}
	                          }
                            }
                            /*chendx 20100727 end*/
                        }catch(Exception e){
                            logger.error("Call sunView is Failed!");
                        }
                        out.print("</select>");
						if(fieldCtrlInfos[i].equals("N"))
						{out.print("&nbsp;<font class=\"orange\">*</font></TD>");}
					}
					
					else if (dataTypes[i].equals("81"))//ap - �ն�����
					{
						out.print("<TD width='32%' colspan="+colspan+">");
                        out.print("<select id='F"+fieldCodes[i]+"' name='F"+fieldCodes[i]+"'>");
                        String[][] result81 = null;
						try
                        {
                            String sqlStr81 ="SELECT terminal_type,terminal_name from sTermType WHERE region_code='"+regionCode+"' and sm_code='ap' AND valid_flag = 'Y'";
                            %>
                                <wtc:pubselect name="sPubSelect" outnum="2" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
                                    <wtc:sql><%=sqlStr81%></wtc:sql>
                                </wtc:pubselect>
                                <wtc:array id="result_tu81" scope="end"/>               
                            <%
                            result81 = result_tu81;
                            int recordNum = result81.length;
                            for(int the7ii=0;the7ii<recordNum;the7ii++){
                                out.println("<option class='button' value='" + result81[the7ii][0] + "'>" + result81[the7ii][1] + "</option>");
                            }
                        }catch(Exception e){
                            logger.error("Call sunView is Failed!");
                        }
                        out.print("</select>");
						if(fieldCtrlInfos[i].equals("N"))
						{out.print("&nbsp;<font class=\"orange\">*</font></TD>");}
					}
					
					else if (dataTypes[i].equals("82"))//ap - ��������
					{
						out.print("<TD width='32%' colspan="+colspan+">");
                        out.print("<select id='F"+fieldCodes[i]+"' name='F"+fieldCodes[i]+"'>");
                        String[][] result82 = null;
						try
                        {
                            String sqlStr82 ="SELECT roam_type,roam_name from sDdnRoamType WHERE region_code='"+regionCode+"' and sm_code='ap' AND valid_flag = 'Y'";
                            %>
                                <wtc:pubselect name="sPubSelect" outnum="2" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
                                    <wtc:sql><%=sqlStr82%></wtc:sql>
                                </wtc:pubselect>
                                <wtc:array id="result_tu82" scope="end"/>               
                            <%
                            result82 = result_tu82;
                            int recordNum = result82.length;
                            for(int the7ii=0;the7ii<recordNum;the7ii++){
                                out.println("<option class='button' value='" + result82[the7ii][0] + "'>" + result82[the7ii][1] + "</option>");
                            }
                        }catch(Exception e){
                            logger.error("Call sunView is Failed!");
                        }
                        out.print("</select>");
						if(fieldCtrlInfos[i].equals("N"))
						{out.print("&nbsp;<font class=\"orange\">*</font></TD>");}
					}
					
					else {
						out.print("<TD width='32%' colspan="+colspan+"> <input id='F"+fieldCodes[i]+"' name='F"+fieldCodes[i]+"' class='button' type='text' datatype="+dataTypes[i]+" maxlength='"+fieldLengths[i]+"' value='"+fieldValues[i]+"'>");
						if(fieldCtrlInfos[i].equals("N"))
						{
						    out.print("&nbsp;<font color=\"#FF0000\">*</font></TD>");
						}
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
    					out.print("</div>");
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

